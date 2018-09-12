From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 12 Sep 2018 09:01:35 +0200
Subject: [LTP] [PATCH] syscalls/fanotify03: Cleanup backup file
	descriptor
In-Reply-To: <20180911145602.18106-1-amir73il@gmail.com>
References: <20180911145602.18106-1-amir73il@gmail.com>
Message-ID: <87bm935hdc.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Amir Goldstein <amir73il@gmail.com> writes:

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Cyril,
>
> As requested by Richard, here is the fanotify03 minor fix separated from
> whitespace cleanup.
> If you wish to take the whitespace cleanup patch you can find it here:
> https://github.com/amir73il/ltp/commits/fanotify_sb

LGTM

>
> Thanks,
> Amir.
>
>  testcases/kernel/syscalls/fanotify/fanotify03.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> index 50401157b..966366a72 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> @@ -57,6 +57,7 @@
>  static char fname[BUF_SIZE];
>  static char buf[BUF_SIZE];
>  static volatile int fd_notify;
> +static int fd_notify_backup = -1;
>  
>  static pid_t child_pid;
>  
> @@ -140,7 +141,7 @@ static void check_child(void)
>  
>  void test01(void)
>  {
> -	int tst_count, fd_notify_backup = -1;
> +	int tst_count;
>  
>  	int ret, len = 0, i = 0, test_num = 0;
>  
> @@ -262,6 +263,8 @@ static void cleanup(void)
>  {
>  	if (fd_notify > 0)
>  		SAFE_CLOSE(fd_notify);
> +	if (fd_notify_backup > 0)
> +		SAFE_CLOSE(fd_notify_backup);
>  }
>  
>  static struct tst_test test = {


-- 
Thank you,
Richard.
