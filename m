From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Nov 2017 15:58:22 +0100
Subject: [LTP] [PATCH] syscalls/fallocate[4,
 5]: Fix failure when using old mkfs.btrfs
In-Reply-To: <1510818534-7378-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1510818534-7378-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20171122145822.GF2389@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static int attach_device(const char *dev, const char *file)
>  {
>  	int dev_fd, file_fd;
> +	struct loop_info loopinfo;
>  
>  	dev_fd = open(dev, O_RDWR);
>  	if (dev_fd < 0) {
> @@ -156,6 +157,21 @@ static int attach_device(const char *dev, const char *file)
>  		return 1;
>  	}
>  
> +	/* Old mkfs.btrfs use LOOP_GET_STATUS instead of backing_file to get
> +	 * associated filename, so we need to set up the device by calling
> +	 * LOOP_SET_FD and LOOP_SET_STATUS.
> +	 */
> +	memset(&loopinfo, 0, sizeof(loopinfo));
> +	strcpy((char *)loopinfo.lo_name, file);
                 ^
		 Why the cast here, as far as I can tell the lo_name is
		 just array of chars which should be char * pointer
		 compatible.

> +	if (ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo)) {
> +		close(dev_fd);
> +		close(file_fd);
> +		tst_resm(TWARN | TERRNO,
> +			 "ioctl(%s, LOOP_SET_STATUS, %s) failed", dev, file);
> +		return 1;
> +	}
> +
>  	close(dev_fd);
>  	close(file_fd);
>  	return 0;

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
