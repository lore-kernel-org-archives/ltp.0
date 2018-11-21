From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Nov 2018 13:01:03 +0100
Subject: [LTP] [PATCH 1/5] syscalls/fanotify01: check events also on
 mountpoint mark
In-Reply-To: <20181116065119.6912-2-amir73il@gmail.com>
References: <20181116065119.6912-1-amir73il@gmail.com>
 <20181116065119.6912-2-amir73il@gmail.com>
Message-ID: <20181121120103.GB2954@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	/* This event should be ignored */
> @@ -181,13 +200,13 @@ void test01(void)
>  
>  	/* Now remove open and close from ignored mask */
>  	if (fanotify_mark(fd_notify,
> -			  FAN_MARK_REMOVE | FAN_MARK_IGNORED_MASK,
> +			  FAN_MARK_REMOVE | mark->flag | FAN_MARK_IGNORED_MASK,
>  			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
>  		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_REMOVE | "
> -			"FAN_MARK_IGNORED_MASK, FAN_OPEN | "
> -			"FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
> -			fname);
> +			"fanotify_mark (%d, FAN_MARK_REMOVE | %s | "
> +			"FAN_MARK_IGNORED_MASK, FAN_OPEN | FAN_CLOSE, "
> +			"AT_FDCWD, %s) failed", fd_notify,
> +			mark->name, fname);
>  	}
>  
>  	SAFE_CLOSE(fd);
> @@ -283,12 +302,13 @@ pass:
>  
>  	}
>  	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
> -	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE, FAN_ACCESS | FAN_MODIFY |
> -			    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
> +	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE | mark->flag,
> +			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
> +			  AT_FDCWD, fname) < 0) {
>  		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_REMOVE, FAN_ACCESS | "
> +			"fanotify_mark (%d, FAN_MARK_REMOVE | %s, FAN_ACCESS | "
>  			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
> -			"failed", fd_notify, fname);
> +			"failed", fd_notify, mark->name, fname);
>  	}
>  }
>  
> @@ -296,8 +316,6 @@ static void setup(void)
>  {
>  	sprintf(fname, "tfile_%d", getpid());
>  	SAFE_FILE_PRINTF(fname, "1");
> -
> -	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);

I've added SAFE_CLOSE(fd_notify) here so that we do not use all
available file descriptors with large enough -i parameter and pushed.

I do wonder what is the reason to move the fanotify_init() from setup
the the test_fanotify(), is there a problem with recycling the same fd
for different tests?

-- 
Cyril Hrubis
chrubis@suse.cz
