From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Sep 2016 15:07:15 +0200
Subject: [LTP] [PATCH v5] lib: make the loop device size can be increased
In-Reply-To: <1474884724-19972-1-git-send-email-liwang@redhat.com>
References: <1474884724-19972-1-git-send-email-liwang@redhat.com>
Message-ID: <20160926130715.GB4164@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 30b1be2..7effac8 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -184,8 +184,18 @@ static void detach_device(const char *dev)
>  
>  const char *tst_acquire_device(void (cleanup_fn)(void))
>  {
> +	return tst_acquire_device_(cleanup_fn, 0);
> +}

This can be implemented as static inline function inside the header
file.

> +const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
> +{
> +	int fd;
>  	char *dev;
>  	struct stat st;
> +	unsigned int acq_dev_size;
> +	unsigned int ltp_dev_size;
> +
> +	acq_dev_size = size > 150 ? size : 150;
>  
>  	if (device_acquired)
>  		tst_brkm(TBROK, cleanup_fn, "Device allready acquired");
> @@ -207,15 +217,25 @@ const char *tst_acquire_device(void (cleanup_fn)(void))
>  			         "%s is not a block device", dev);
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
>  
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 12ca051..1c2995e 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -596,7 +596,10 @@ static void do_setup(int argc, char *argv[])
>  	}
>  
>  	if (tst_test->needs_device) {
> -		tdev.dev = tst_acquire_device(NULL);
> +		if(!tst_test->device_min_size)
> +			tst_test->device_min_size = 150;

The tst_acquire_device_ will make sure that the size is at least 150MB
anyway. So this part is useless, isn't it?

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
