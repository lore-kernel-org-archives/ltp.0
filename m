From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Nov 2018 16:22:37 +0100
Subject: [LTP] [PATCH] kernel/syscall/setrlimit05.c: use a legal bad
 address for mips
In-Reply-To: <1541403031-141386-1-git-send-email-hongzhi.song@windriver.com>
References: <1541403031-141386-1-git-send-email-hongzhi.song@windriver.com>
Message-ID: <20181105152237.GA3478@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit05.c b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
> index e716722..57b0b82 100644
> --- a/testcases/kernel/syscalls/setrlimit/setrlimit05.c
> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
> @@ -31,9 +31,13 @@ static void verify_setrlimit(void)
>  	int status;
>  	pid_t pid;
>  
> +    void *bad_addr;
> +
> +    bad_addr = tst_get_bad_addr(NULL);

It would be better if we called this only once in the test setup()
function as the function actually maps a page of memory, the test may
fail if we pass large enough -i parameter.

>  	pid = SAFE_FORK();
>  	if (!pid) {
> -		TEST(setrlimit(RLIMIT_NOFILE, (void *) -1));
> +		TEST(setrlimit(RLIMIT_NOFILE,(struct rlimit *)bad_addr));
>  		if (TST_RET != -1) {
>  			tst_res(TFAIL, "setrlimit()  succeeded unexpectedly");
>  			exit(0);
> -- 
> 2.8.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
