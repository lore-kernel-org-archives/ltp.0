From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Sep 2016 14:43:25 +0200
Subject: [LTP] [PATCH v4] test.sh: make the loop device size can be
	increased
In-Reply-To: <1472637499-6076-1-git-send-email-liwang@redhat.com>
References: <1472637499-6076-1-git-send-email-liwang@redhat.com>
Message-ID: <20160922124325.GA10292@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index c7d301f..44dd444 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1318,12 +1318,16 @@ Following functions similar to the LTP C interface are available.
>  * tst_rmdir()
>  * tst_fs_has_free()
>  * tst_mkfs()
> -* tst_acquire_device()
>  * tst_release_device()
>  
> -There is one more function called 'tst_check_cmds()' that gets unspecified
> -number of parameters and asserts that each parameter is a name of an
> -executable in '$PATH' and exits the test with 'TCONF' on first missing.
> +One more function called 'tst_check_cmds()' that gets unspecified number
> +of parameters and asserts that each parameter is a name of an executable
> +in '$PATH' and exits the test with 'TCONF' on first missing.
> +
> +Another one is 'tst_acquire_device()' that looks for LTP_DEV env variable
> +first (which may be passed by the test driver or by a user) and returns while
> +it's value greater than 150MB. It also does clear first sectors of $LTP_DEV
> +and makes the block device size can be increased according to real need.



>  tst_sleep
>  +++++++++
> diff --git a/include/old/old_device.h b/include/old/old_device.h
> index 4dae05e..94870c0 100644
> --- a/include/old/old_device.h
> +++ b/include/old/old_device.h
> @@ -36,13 +36,13 @@ const char *tst_dev_fs_type(void);
>   * Looks for LTP_DEV env variable first (which may be passed by the test
>   * driver or by a user) and returns just it's value if found.
>   *
> - * Otherwise creates a temp file and loop device.
> + * Otherwise creates a temp file and loop device according to real need.
>   *
>   * Note that you have to call tst_tmpdir() beforehand.
>   *
>   * Returns path to the device or NULL if it cannot be created.
>   */
> -const char *tst_acquire_device(void (cleanup_fn)(void));
> +const char *tst_acquire_device(void (cleanup_fn)(void), const int size);

This is the old API, that one should not be changed at all.

We should rather add unsigned int device_min_size to the tst_test structure
and make use of that in case that it's > 0.

>  /*
>   * @dev: device path returned by the tst_acquire_device()
> diff --git a/lib/tests/tst_device.c b/lib/tests/tst_device.c
> index c010475..e22eb9d 100644
> --- a/lib/tests/tst_device.c
> +++ b/lib/tests/tst_device.c
> @@ -40,7 +40,7 @@ int main(void)
>  {
>  	tst_tmpdir();
>  
> -	dev = tst_acquire_device(cleanup);
> +	dev = tst_acquire_device(cleanup, -1);
>  	if (!dev)
>  		tst_brkm(TCONF, cleanup, "Failed to acquire test device");
>  
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 30b1be2..5226d0f 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -182,10 +182,15 @@ static void detach_device(const char *dev)
>  		"ioctl(%s, LOOP_CLR_FD, 0) no ENXIO for too long", dev);
>  }
>  
> -const char *tst_acquire_device(void (cleanup_fn)(void))
> +const char *tst_acquire_device(void (cleanup_fn)(void), const int size)
>  {
> +	int fd;
>  	char *dev;
>  	struct stat st;
> +	unsigned long acq_dev_size;
> +	unsigned long ltp_dev_size;
> +
> +	acq_dev_size = size > 150 ? size : 150;
>  
>  	if (device_acquired)
>  		tst_brkm(TBROK, cleanup_fn, "Device allready acquired");
> @@ -204,18 +209,28 @@ const char *tst_acquire_device(void (cleanup_fn)(void))
>  
>  		if (!S_ISBLK(st.st_mode)) {
>  			tst_brkm(TBROK, cleanup_fn,
> -			         "%s is not a block device", dev);
> +					"%s is not a block device", dev);
                                 ^
				 Useless whitespace change.

>  		}
>  
> -		if (tst_fill_file(dev, 0, 1024, 512)) {
> -			tst_brkm(TBROK | TERRNO, cleanup_fn,
> -				 "Failed to clear the first 512k of %s", dev);
> +		fd = SAFE_OPEN(cleanup_fn, dev, O_RDONLY);
> +		SAFE_IOCTL(cleanup_fn, fd, BLKGETSIZE64, &ltp_dev_size);
> +		SAFE_CLOSE(cleanup_fn, fd);
> +		ltp_dev_size = ltp_dev_size/1024/1024;
> +
> +		if (acq_dev_size <= ltp_dev_size) {
> +			if (tst_fill_file(dev, 0, 1024, 512)) {
> +				tst_brkm(TBROK | TERRNO, cleanup_fn,
> +					"Failed to clear the first 512k of %s", dev);
> +			}
> +
> +			return dev;
>  		}
>  
> -		return dev;
> +		tst_resm(TINFO, "Skipping $LTP_DEV size %luMB, requested size %luMB",
> +				ltp_dev_size, acq_dev_size);
>  	}
>  
> -	if (tst_fill_file(DEV_FILE, 0, 1024, 153600)) {
> +	if (tst_fill_file(DEV_FILE, 0, 1024, 1024 * acq_dev_size)) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  		         "Failed to create " DEV_FILE);

This function has to be renamed to tst_acquire_device_() and the
tst_acquire_device() from the old API header should call this function
with zero as the size argument.

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 12ca051..8b37d75 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -596,7 +596,7 @@ static void do_setup(int argc, char *argv[])
>  	}
>  
>  	if (tst_test->needs_device) {
> -		tdev.dev = tst_acquire_device(NULL);
> +		tdev.dev = tst_acquire_device(NULL, -1);
>  		tdev.fs_type = tst_dev_fs_type();

Here we should simply pass tst_test->device_min_size.

-- 
Cyril Hrubis
chrubis@suse.cz
