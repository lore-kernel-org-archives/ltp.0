From: Jan Kara <jack@suse.cz>
Date: Mon, 24 Sep 2018 12:52:09 +0200
Subject: [LTP] [PATCH v2][RFC] syscalls/fanotify03: simplify test
In-Reply-To: <20180923094032.32078-1-amir73il@gmail.com>
References: <20180923094032.32078-1-amir73il@gmail.com>
Message-ID: <20180924105209.GB28775@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun 23-09-18 12:40:32, Amir Goldstein wrote:
> Re-init fanotify fd on every test iteration instead of storing and
> restoring fd_notify from duplicated fd_notify_backup.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> Do you see any problem with this "simplification"?
> Does this test need to have the fanotify fd preserved between test
> iterations?
> 
> I would rather make this change instead of adding the missing cleanup for
> fd_notify_backup, because it sits better with my plans to re-structure
> this test [1].

The patch looks good to me and yes, the test looks cleaner that way.

								Honza

> [1] https://github.com/amir73il/ltp/commits/fanotify_sb
> 
>  .../kernel/syscalls/fanotify/fanotify03.c     | 52 +++++++++----------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> index 83cd26640..59dedbe21 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> @@ -138,15 +138,33 @@ static void check_child(void)
>  		tst_res(TFAIL, "child %s", tst_strstatus(child_ret));
>  }
>  
> -void test01(void)
> +static void setup_mark(void)
>  {
> -	int tst_count, fd_notify_backup = -1;
> +	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> +
> +	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
> +			  FAN_ACCESS_PERM | FAN_OPEN_PERM,
> +			  AT_FDCWD, fname) < 0) {
> +		if (errno == EINVAL) {
> +			tst_brk(TCONF | TERRNO,
> +				"CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
> +				"configured in kernel?");
> +		} else {
> +			tst_brk(TBROK | TERRNO,
> +				"fanotify_mark (%d, FAN_MARK_ADD, "
> +				"FAN_ACCESS_PERM | FAN_OPEN_PERM, "
> +				"AT_FDCWD, %s) failed.",
> +				fd_notify, fname);
> +		}
> +	}
> +}
>  
> +void test01(void)
> +{
> +	int tst_count;
>  	int ret, len = 0, i = 0, test_num = 0;
>  
> -	if (fd_notify_backup == -1) {
> -		fd_notify_backup = SAFE_DUP(fd_notify);
> -	}
> +	setup_mark();
>  	run_child();
>  
>  	tst_count = 0;
> @@ -229,33 +247,15 @@ void test01(void)
>  
>  	}
>  	check_child();
> -	/* We got SIGCHLD while running, resetup fd_notify */
> -	if (fd_notify == -1) {
> -		fd_notify = fd_notify_backup;
> -		fd_notify_backup = -1;
> -	}
> +
> +	if (fd_notify > 0)
> +		SAFE_CLOSE(fd_notify);
>  }
>  
>  static void setup(void)
>  {
>  	sprintf(fname, "fname_%d", getpid());
>  	SAFE_FILE_PRINTF(fname, "1");
> -
> -	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> -
> -	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS_PERM |
> -			    FAN_OPEN_PERM, AT_FDCWD, fname) < 0) {
> -		if (errno == EINVAL) {
> -			tst_brk(TCONF | TERRNO,
> -				 "CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
> -				 "configured in kernel?");
> -		} else {
> -			tst_brk(TBROK | TERRNO,
> -				 "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM | "
> -				 "FAN_OPEN_PERM, AT_FDCWD, %s) failed.", fd_notify, fname);
> -		}
> -	}
> -
>  }
>  
>  static void cleanup(void)
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
