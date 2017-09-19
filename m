From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Sep 2017 10:43:23 +0200
Subject: [LTP] [RESEND][PATCH v3 1/2] libltp: add support to mount tmpfs
 for EROFS testing
In-Reply-To: <20170918165630.134076-2-sspatil@google.com>
References: <20170918165630.134076-1-sspatil@google.com>
 <20170918165630.134076-2-sspatil@google.com>
Message-ID: <20170919084323.GA14133@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 4c30edab5..828eae49d 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -21,6 +21,7 @@
>  #include <string.h>
>  #include <stdlib.h>
>  #include <errno.h>
> +#include <sys/mount.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  #include <sys/time.h>
> @@ -41,7 +42,7 @@ struct tst_test *tst_test;
>  static int iterations = 1;
>  static float duration = -1;
>  static pid_t main_pid, lib_pid;
> -static int device_mounted;
> +static int mntpoint_active;

A bit better name would be 'mntpoint_mounted' but that is very minor.

>  struct results {
>  	int passed;
> @@ -701,7 +702,32 @@ static void do_setup(int argc, char *argv[])
>  	if (needs_tmpdir() && !tst_tmpdir_created())
>  		tst_tmpdir();
>  
> -	if (tst_test->needs_device) {
> +	if (tst_test->mntpoint)
> +		SAFE_MKDIR(tst_test->mntpoint, 0777);
> +
> +	if (tst_test->needs_rofs) {
> +		if (!tst_test->mntpoint) {
> +			tst_brk(TBROK,
> +				"tst_test->mntpoint must be set!");
> +		}

We may as well move this check from both branches to the top to avoid
duplication, i.e. add:

	if ((tst_test->needs_rofs || tst_test->mount_device) &&
	    !tst_test->mntpoint) {
		tst_brk(TBROK, "tst_test->mntpoint must be set!");
	}

> +		/* If we failed to do read-only bind mount for '/'. Fallback to
> +		 * using a device with empty read-only filesystem.
> +		 */
> +		if (mount(NULL, tst_test->mntpoint, "tmpfs", MS_RDONLY, NULL)) {
> +			tst_res(TINFO, "Cannot mount tmpfs read-only at %s, "
                                ^
				Maybe we should add | TERRNO here as
				well so that user gets a hint why this
				mount() had failed.
> +					"setting up a device instead\n",
> +					tst_test->mntpoint);
> +			tst_test->mount_device = 1;
> +			tst_test->needs_device = 1;
> +			tst_test->format_device = 1;
> +			tst_test->mnt_flags = MS_RDONLY;
> +		} else {
> +			mntpoint_active = 1;
> +		}
> +	}
> +
> +	if (tst_test->needs_device && !mntpoint_active) {
>  		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
>  
>  		if (!tdev.dev)
> @@ -721,16 +747,14 @@ static void do_setup(int argc, char *argv[])
>  		}
>  
>  		if (tst_test->mount_device) {
> -
>  			if (!tst_test->mntpoint) {
>  				tst_brk(TBROK,
>  					"tst_test->mntpoint must be set!");
>  			}
>  
> -			SAFE_MKDIR(tst_test->mntpoint, 0777);
>  			SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
>  				   tst_test->mnt_flags, tst_test->mnt_data);
> -			device_mounted = 1;
> +			mntpoint_active = 1;
>  		}
>  	}
>  
> @@ -751,7 +775,7 @@ static void do_test_setup(void)
>  
>  static void do_cleanup(void)
>  {
> -	if (device_mounted)
> +	if (mntpoint_active)
>  		tst_umount(tst_test->mntpoint);
>  
>  	if (tst_test->needs_device && tdev.dev)

Other than the minor nits it looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
