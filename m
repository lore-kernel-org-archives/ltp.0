From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jan 2021 14:31:21 +0100
Subject: [LTP] [PATCH v2 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <20210118161308.30771-1-pvorel@suse.cz>
References: <20210118161308.30771-1-pvorel@suse.cz>
Message-ID: <YAbfKSZhZ35peObS@yuki.lan>
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
> @@ -81,20 +85,79 @@ int tst_kernel_bits(void)
>  	return kernel_bits;
>  }
>  
> -int tst_check_driver(const char *name)
> +#ifndef __ANDROID__
> +# define MODULES_DIR "/lib/modules"
> +#else
> +# define MODULES_DIR "/system/lib/modules"
> +#endif
> +
> +
> +int tst_search_driver(const char *driver, const char *file)
>  {
> +	struct stat st;
> +	char *path = NULL;
> +	char buf[PATH_MAX], module[PATH_MAX], search[PATH_MAX] = "/";
> +	FILE *f;
> +
>  #ifndef __ANDROID__
> -	const char * const argv[] = { "modprobe", "-n", name, NULL };
> -	int res = tst_cmd_(NULL, argv, "/dev/null", "/dev/null",
> -			       TST_CMD_PASS_RETVAL);
> +	struct utsname uts;
>  
> -	/* 255 - it looks like modprobe not available */
> -	return (res == 255) ? 0 : res;
> +	if (uname(&uts)) {
> +		tst_brkm(TBROK | TERRNO, NULL, "uname() failed");
> +		return -1;
> +	}
> +	SAFE_ASPRINTF(NULL, &path, "%s/%s/%s", MODULES_DIR, uts.release, file);
>  #else
> -	/* Android modprobe may not have '-n', or properly installed
> -	 * module.*.bin files to determine built-in drivers. Assume
> -	 * all drivers are available.
> +	SAFE_ASPRINTF(NULL, &path, "%s/%s", MODULES_DIR, file);
> +#endif
> +
> +	if (stat(path, &st) || !(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))) {
> +#ifndef __ANDROID__
> +		tst_resm(TWARN, "expected file %s does not exist or not a file", path);
> +#endif
> +		return -1;
> +	}
> +
> +	if (access(path, R_OK)) {
> +#ifndef __ANDROID__
> +		tst_resm(TWARN, "file %s cannot be read", path);
> +#endif
> +		return -1;
> +	}
> +
> +	strcat(search, driver);
> +	strcat(search, ".ko");

Why not just snprintf() or SAFE_ASPRINTF() here as well?

> +	f = SAFE_FOPEN(NULL, path, "r");
> +
> +	while (fgets(buf, sizeof(buf), f)) {
> +		if (sscanf(buf, "%s", module) != 1)
> +			continue;
> +
> +		if (strstr(module, search) != NULL) {

And I'm not sure that this is safe either, what about the case that one
module name is a substring of another.

E.g. if we look for "foo.ko" and the file contains "this_is_not_foo.ko"
it will still match here.


Also this seems to be rather distruptive change, so I guess it would be
safer to apply after the release.

-- 
Cyril Hrubis
chrubis@suse.cz
