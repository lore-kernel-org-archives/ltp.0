From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Feb 2021 16:39:55 +0100
Subject: [LTP] [PATCH v2 1/2] syscalls/getpid01: Convert to new API
In-Reply-To: <20210225110118.583486-1-ruansy.fnst@cn.fujitsu.com>
References: <20210225110118.583486-1-ruansy.fnst@cn.fujitsu.com>
Message-ID: <YDfEy9K+p3cyGL2/@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with small changes, thanks.

I've fixed some typos plus two changes explained below.

> +static void verify_getpid(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		TEST(getpid());
> -
> -		if (TEST_RETURN == -1)
> -			tst_resm(TFAIL | TTERRNO, "getpid failed");
> -		else
> -			tst_resm(TPASS, "getpid returned %ld", TEST_RETURN);
> -
> +	pid_t pid_max, pid;
> +	int status;
> +
> +	/* get pid_max of this system */
> +	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
> +
> +	for (int i = 0; i < 100; i++) {

This int declaration inside of a for () statement will cause error with
older compiters, so I moved the variable declaration out of the
statement.

> +		pid = SAFE_FORK();
> +		if (pid == 0) {
> +			pid = getpid();
> +
> +			/* pid should not be 1 or out of maximum */
> +			if (1 < pid && pid <= pid_max)
> +				tst_res(TPASS, "getpid() returns %d", pid);
> +			else
> +				tst_res(TFAIL | TTERRNO,
> +					"getpid() returns out of range: %d", pid);
> +		} else {
> +			SAFE_WAIT(&status);
> +			break;

This is parent process, which should continue to run the for loop, so
I've removed the break; here and added exit(0) at the end fo thec child
instead.

> +		}
>  	}
> -
> -	cleanup();
> -	tst_exit();
>  }
>  
> -void setup(void)
> -{
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -}
> -
> -void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.test_all = verify_getpid,
> +};
> -- 
> 2.30.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
