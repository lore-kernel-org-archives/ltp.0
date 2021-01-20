From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Jan 2021 15:14:25 +0100
Subject: [LTP] [PATCH v3 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <20210119160316.4776-2-pvorel@suse.cz>
References: <20210119160316.4776-1-pvorel@suse.cz>
 <20210119160316.4776-2-pvorel@suse.cz>
Message-ID: <YAg6wTVc6AB28smR@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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

What is the point in the sscanf() here?

Why can't we just strstr(buf, search) here?

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

Just:
		while ((ix = strchr(ix, find))
			*ix++ = replace;

> +		if (!tst_check_driver_(driver2))

free(driver2) ?

> +			return 0;
> +	}
> +
> +	return 1;
>  }
> -- 
> 2.30.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
