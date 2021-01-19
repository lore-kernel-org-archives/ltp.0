From: Sandeep Patil <sspatil@android.com>
Date: Tue, 19 Jan 2021 11:56:52 -0800
Subject: [LTP] [PATCH v3 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <20210119160316.4776-2-pvorel@suse.cz>
References: <20210119160316.4776-1-pvorel@suse.cz>
 <20210119160316.4776-2-pvorel@suse.cz>
Message-ID: <YAc5hMnHm0GIQJ96@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jan 19, 2021 at 05:03:15PM +0100, Petr Vorel wrote:
> BusyBox modprobe implementation does not support -n switch.
> 
> It does support -D, which could be used, *but* unless is busybox binary
> configured with CONFIG_MODPROBE_SMALL=y (IMHO the default).
> 
> We could use modinfo and grep output for 'filename:', but we agreed on
> ML that having our own implementation will be the best as it also
> does not require modinfo as external dependency.
> 
> Implementation searches for for module presence in /lib/modules/$(uname
> -r)/modules.{dep,builtin}. On Android expect files in /system/lib/modules
> directory.
> 
> Also treat '-' and '_' in module name as the same (follow kmod implementation).
> 
> On Android still assume all drivers are available because modules.* files might
> not be available. We could search modules in /system/lib/modules, but to
> to determine built-in drivers we need modules.builtin (it's required
> also by Busybox mod{info,probe} implementation).
> 
> This fixes many tests on BusyBox, e.g. *all* network tests (tests using
> tst_net.sh) after 305a78e4c ("tst_net.sh: Require veth for netns").
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/tst_kernel.c | 99 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 87 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
> index 57fa4b2be..279c8936c 100644
> --- a/lib/tst_kernel.c
> +++ b/lib/tst_kernel.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (c) 2020-2021 Petr Vorel <pvorel@suse.cz>
>   *
>   * This program is free software: you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -17,8 +18,11 @@
>  
>  #include <sys/personality.h>
>  #include <sys/utsname.h>
> +#include <limits.h>
> +
>  #include "test.h"
>  #include "tst_kernel.h"
> +#include "old_safe_stdio.h"
>  
>  static int get_kernel_bits_from_uname(struct utsname *buf)
>  {
> @@ -81,20 +85,91 @@ int tst_kernel_bits(void)
>  	return kernel_bits;
>  }
>  
> -int tst_check_driver(const char *name)
> +int tst_search_driver(const char *driver, const char *file)
>  {
> -#ifndef __ANDROID__
> -	const char * const argv[] = { "modprobe", "-n", name, NULL };
> -	int res = tst_cmd_(NULL, argv, "/dev/null", "/dev/null",
> -			       TST_CMD_PASS_RETVAL);
> -
> -	/* 255 - it looks like modprobe not available */
> -	return (res == 255) ? 0 : res;
> -#else
> -	/* Android modprobe may not have '-n', or properly installed
> -	 * module.*.bin files to determine built-in drivers. Assume
> -	 * all drivers are available.
> +	struct stat st;
> +	char *path = NULL, *search = NULL;
> +	char buf[PATH_MAX], module[PATH_MAX];
> +	FILE *f;
> +
> +	struct utsname uts;
> +
> +	if (uname(&uts)) {
> +		tst_brkm(TBROK | TERRNO, NULL, "uname() failed");
> +		return -1;
> +	}
> +	SAFE_ASPRINTF(NULL, &path, "/lib/modules/%s/%s", uts.release, file);

This is just the ramdisk location, the on-disk location is
/vendor/lib/modules/. I also think that the ramdisk one goes away after we
switch over 2nd stage init. Is there a test I can run that uses these
functions now to make sure this works?

Also, unfortunately (and sadly) we may have to do something Android specific
downstream as the /vendor/lib/modules and /lib/modules only started to appear
as of android 11 :(.

Once you share how I can test, I'm happy to test and add my Tested-by for
Android.

+cc: kernel-team@android.com
> +
> +	if (stat(path, &st) || !(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))) {
> +		tst_resm(TWARN, "expected file %s does not exist or not a file", path);
> +		return -1;
> +	}
> +
> +	if (access(path, R_OK)) {
> +		tst_resm(TWARN, "file %s cannot be read", path);
> +		return -1;
> +	}
> +
> +	SAFE_ASPRINTF(NULL, &search, "/%s.ko", driver);
> +
> +	f = SAFE_FOPEN(NULL, path, "r");
> +
> +	while (fgets(buf, sizeof(buf), f)) {
> +		if (sscanf(buf, "%s", module) != 1)
> +			continue;
> +
> +		if (strstr(module, search) != NULL) {
> +			SAFE_FCLOSE(NULL, f);
> +			return 0;
> +		}
> +	}
> +
> +	SAFE_FCLOSE(NULL, f);
> +
> +	return -1;
> +}
> +
> +int tst_check_driver_(const char *driver)
> +{
> +	if (!tst_search_driver(driver, "modules.dep") ||
> +		!tst_search_driver(driver, "modules.builtin"))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +int tst_check_driver(const char *driver)
> +{
> +#ifdef __ANDROID__
> +	/*
> +	 * Android may not have properly installed modules.* files. We could
> +	 * search modules in /system/lib/modules, but to to determine built-in

the appropriate location would be /lib/modules OR /vendor/lib/modules.
> +	 * drivers we need modules.builtin. Therefore assume all drivers are
> +	 * available.
>  	 */
>  	return 0;
>  #endif
> +
> +	if (!tst_check_driver_(driver))
> +		return 0;
> +
> +	if (strrchr(driver, '-') || strrchr(driver, '_')) {
> +		char *driver2 = strdup(driver);
> +		char *ix = driver2;
> +		char find = '-', replace = '_';
> +
> +		if (strrchr(driver, '_')) {
> +			find = '_';
> +			replace = '-';
> +		}
> +
> +		while ((ix = strchr(ix, find)) != NULL) {
> +			*ix++ = replace;
> +		}
> +
> +		if (!tst_check_driver_(driver2))
> +			return 0;
> +	}
> +
> +	return 1;
>  }
> -- 
> 2.30.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
