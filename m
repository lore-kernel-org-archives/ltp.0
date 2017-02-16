From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Feb 2017 10:28:57 +0100
Subject: [LTP] [PATCH v2] syscalls/mq_open: fix limits for queues_max
In-Reply-To: <1487212730-7295-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170215152406.GB29673@rei.lan>
 <1487212730-7295-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170216092857.GA5543@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>    these limits are removed in kernel:
>    'a5c5928b759d8("ipc: convert use of typedef ctl_table to struct ctl_table")'

And I did a copy & paste error yesterday, the right commit is:

      f3713fd9cff73
      ("ipc,mqueue: remove limits for the amount of system-wide queues")

I will fix that in the commit message and push the patch, thanks.

> 2) This case fails recently because it has been changed in ltp:
>    '8e49ed6b0fa28("syscalls/mq_open: fix old tests + convert to use new API")'
> 
> We set queues_max to 1 instead of 0, so this case can work on both
> older kernels(eg. RHEL6) and newer kernels.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/mq_open/mq_open01.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
> index d6f7196..6324d92 100644
> --- a/testcases/kernel/syscalls/mq_open/mq_open01.c
> +++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
> @@ -28,6 +28,7 @@
>  #include "tst_test.h"
>  
>  #define QUEUE_NAME	"/test_mqueue"
> +#define QUEUE_INIT	"/init_mqueue"
>  
>  static uid_t euid;
>  static struct passwd *pw;
> @@ -35,6 +36,7 @@ static char *qname;
>  static struct rlimit rlim;
>  
>  static mqd_t fd, fd2;
> +static mqd_t fd3 = -1;
>  static int max_queues;
>  
>  struct test_case {
> @@ -174,7 +176,7 @@ static void unlink_queue(void)
>  static void set_max_queues(void)
>  {
>  	SAFE_FILE_SCANF(PROC_MAX_QUEUES, "%d", &max_queues);
> -	SAFE_FILE_PRINTF(PROC_MAX_QUEUES, "%d", 0);
> +	SAFE_FILE_PRINTF(PROC_MAX_QUEUES, "%d", 1);
>  
>  	SAFE_SETEUID(pw->pw_uid);
>  }
> @@ -206,6 +208,10 @@ static void setup(void)
>  	euid = geteuid();
>  	pw = SAFE_GETPWNAM("nobody");
>  	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim);
> +
> +	fd3 = mq_open(QUEUE_INIT, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
> +	if (fd3 == -1)
> +		tst_brk(TBROK | TERRNO, "mq_open(%s) failed", QUEUE_INIT);
>  }
>  
>  static void cleanup(void)
> @@ -216,6 +222,12 @@ static void cleanup(void)
>  	if (fd2 > 0)
>  		mq_close(fd2);
>  
> +	if (fd3 > 0 && mq_close(fd3))
> +		tst_res(TWARN | TERRNO, "mq_close(%s) failed", QUEUE_INIT);
> +
> +	if (mq_unlink(QUEUE_INIT))
> +		tst_res(TWARN | TERRNO, "mq_unlink(%s) failed", QUEUE_INIT);
> +
>  	mq_unlink(qname);
>  }
>  
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
