From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Sat, 2 May 2020 17:09:58 +1000
Subject: [LTP] [PATCH 3/4] syscalls/fanotify15: Add a test case for
 inode marks
In-Reply-To: <20200421065002.12417-4-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
 <20200421065002.12417-4-amir73il@gmail.com>
Message-ID: <20200502070956.GA1649@morpheus.bobrowski.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 21, 2020 at 09:50:01AM +0300, Amir Goldstein wrote:
> +	tst_res(TINFO,
> +		"Test #%d: FAN_REPORT_FID with mark type: %s",
> +		number, mark->name);
>  
> -	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
> +

A nit, but there's an unnecessary extra whiteline here.

> +	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | mark->flag, tc->mask |
>  				FAN_CREATE | FAN_DELETE | FAN_MOVE |
> -				FAN_MODIFY | FAN_DELETE_SELF | FAN_ONDIR,
> +				FAN_MODIFY | FAN_ONDIR,
>  				AT_FDCWD, TEST_DIR) == -1) {
>  		if (errno == ENODEV)
>  			tst_brk(TCONF,
>  				"FAN_REPORT_FID not supported on %s "
>  				"filesystem", tst_device->fs_type);
>  		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark(%d, FAN_MARK_ADD | FAN_MARK_FILESYSTEM, "
> +			"fanotify_mark(%d, FAN_MARK_ADD | %s, "
>  			"FAN_CREATE | FAN_DELETE | FAN_MOVE | "
> -			"FAN_MODIFY | FAN_DELETE_SELF | FAN_ONDIR, "
> +			"FAN_MODIFY | FAN_ONDIR, "
>  			"AT_FDCWD, %s) failed",
> -			fanotify_fd, TEST_DIR);
> +			fanotify_fd, mark->name, TEST_DIR);

I see that you've removed the FAN_DELETE_SELF mask here, although
should we consider adding tc->mask here too for the sake of
correctness?

The rest looks fine to me.

Reviewed-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

/M
