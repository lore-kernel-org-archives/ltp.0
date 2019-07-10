From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Jul 2019 15:57:11 +0200
Subject: [LTP] [PATCH v4 1/3] lib: alter find_free_loopdev()
In-Reply-To: <1562755997-5626-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <5D25B05A.8000600@cn.fujitsu.com>
 <1562755997-5626-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190710135710.GC5628@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Alter find_free_loopdev() to return the free loopdev minor
> (and -1 for no free loopdev) and then WE can safely use the
> minor number that find_free_loopdev() returned in test cases.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  doc/test-writing-guidelines.txt |  9 +++++++++
>  include/tst_device.h            |  6 ++++++
>  lib/tst_device.c                | 12 ++++++------
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index c6d4e001d..887801e68 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1045,6 +1045,15 @@ IMPORTANT: All testcases should use 'tst_umount()' instead of 'umount(2)' to
>  -------------------------------------------------------------------------------
>  #include "tst_test.h"
>  
> +int find_free_loopdev();

Once this is exported as public API it should be prefixed with tst_.

> -static int find_free_loopdev(void)
> +int find_free_loopdev(void)
>  {
>  	int ctl_fd, dev_fd, rc, i;
>  	struct loop_info loopinfo;
> @@ -82,10 +82,10 @@ static int find_free_loopdev(void)
>  		if (rc >= 0) {
>  			set_dev_path(rc);
>  			tst_resm(TINFO, "Found free device '%s'", dev_path);
> -			return 0;
> +			return rc;
>  		}
>  		tst_resm(TINFO, "Couldn't find free loop device");
> -		return 1;
> +		return -1;
>  	}
>  
>  	switch (errno) {
> @@ -121,7 +121,7 @@ static int find_free_loopdev(void)
>  				continue;
>  			tst_resm(TINFO, "Found free device '%s'", dev_path);
>  			close(dev_fd);
> -			return 0;
> +			return i;
>  		}
>  
>  		close(dev_fd);
> @@ -129,7 +129,7 @@ static int find_free_loopdev(void)
>  
>  	tst_resm(TINFO, "No free devices found");
>  
> -	return 1;
> +	return -1;
>  }

This needs more changes than this.

The problem here is that the function modifies dev_path which is
returned by tst_acquire_device() so if you call this function after
tst_acquire_device() it will rewrite the dev_path which means that the
test would end up with wrong device path in tst_device->dev.

I guess that the easiest solution would be changing the function to get
buffer parameter which, when non-NULL, is filled with the path.

I.e. the function prototype would became:

int tst_find_free_loopdev(char *path, size_t path_len);

And we would pass the dev_path inside of the tst_device.c and NULL from
the copy_file_range() tests.

-- 
Cyril Hrubis
chrubis@suse.cz
