From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Nov 2018 13:20:55 +0100
Subject: [LTP] [PATCH V2] kernel/syscall/setrlimit05.c: use a legal bad
 address for mips
In-Reply-To: <1541488193-67790-2-git-send-email-hongzhi.song@windriver.com>
References: <1541488193-67790-1-git-send-email-hongzhi.song@windriver.com>
 <1541488193-67790-2-git-send-email-hongzhi.song@windriver.com>
Message-ID: <20181106122055.GA4834@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This testcase fails on mips32. The process is killed by SIGBUS which
> doesn't return EFAULT as expect.
> 
> This is because:
> ((void *)-1) is not a legal bad address which causes the process
> killed by SIGBUG on mips.
> 
> 'tst_get_bad_addr()' returns an address that should work on mips
> and other arches.

Generally looks good, minor nits pointed out below.

> Signed-off-by: Hongzhi.Song <hongzhi.song@windriver.com>
> ---
>  testcases/kernel/syscalls/setrlimit/setrlimit05.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit05.c b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
> index e716722..92ff33c 100644
> --- a/testcases/kernel/syscalls/setrlimit/setrlimit05.c
> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
> @@ -26,6 +26,8 @@
>  
>  #include "tst_test.h"
>  
> +static void *bad_addr;
> +
>  static void verify_setrlimit(void)
>  {
>  	int status;
> @@ -33,7 +35,7 @@ static void verify_setrlimit(void)
>  
>  	pid = SAFE_FORK();
>  	if (!pid) {
> -		TEST(setrlimit(RLIMIT_NOFILE, (void *) -1));
> +		TEST(setrlimit(RLIMIT_NOFILE, (struct rlimit *)bad_addr));
                                                  ^
						  This cast is not
						  needed, in C void *
						  pointer is converted
						  to any other pointer
						  automatically.

>  		if (TST_RET != -1) {
>  			tst_res(TFAIL, "setrlimit()  succeeded unexpectedly");
>  			exit(0);
> @@ -67,7 +69,13 @@ static void verify_setrlimit(void)
>  	tst_res(TBROK, "child %s", tst_strstatus(status));
>  }
>  
> +static void setup(void)
> +{
> +    bad_addr = tst_get_bad_addr(NULL);

You really should use tabs instead of spaces for indentation.

> +}
> +
>  static struct tst_test test = {
>  	.test_all = verify_setrlimit,
>  	.forks_child = 1,
> +    .setup = setup,

Here as well.

>  };
> -- 
> 2.8.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
