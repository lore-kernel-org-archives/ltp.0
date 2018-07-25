From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Jul 2018 16:20:30 +0200
Subject: [LTP] [PATCH 2/3] syscalls/alarm03: Rewrite to new library
In-Reply-To: <1532431855-18452-2-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1532431855-18452-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1532431855-18452-2-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180725142030.GC23890@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	TEST(alarm(100));
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		TEST(alarm(0));
> +		if (TEST_RETURN != 0) {
> +			tst_res(TFAIL,
> +				"alarm(100), fork, alarm(0) child's "
> +				"alarm returned %ld", TEST_RETURN);
> +		} else {
> +			tst_res(TPASS,
> +				"alarm(100), fork, alarm(0) child's "
> +				"alarm returned %ld", TEST_RETURN);
>  		}
> -
> +		exit(0);
> +	} else {
> +		TEST(alarm(0));
> +		if (TEST_RETURN <= 0 || TEST_RETURN > 101) {
> +			tst_res(TFAIL,
> +				"alarm(100), fork, alarm(0) parent's "
> +				"alarm returned %ld", TEST_RETURN);
> +		} else {
> +			tst_res(TPASS,
> +				"alarm(100), fork, alarm(0) parent's "
> +				"alarm returned %ld", TEST_RETURN);
> +		}
> +		tst_reap_children();

There is no need for the else branch here as the child calls exit(0);

>  }
>  
> -void setup(void)
> +static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
>  {
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	signal(SIGALRM, trapper);
> -
> -	TEST_PAUSE;
> +	SAFE_SIGNAL(SIGALRM, sighandler);

I do wonder why do we call the SAFE_SIGNAL() here?

It does not make much sense.

>  }
>  
> -void cleanup(void)
> +static void setup(void)
>  {
> +	SAFE_SIGNAL(SIGALRM, sighandler);
>  }
>  
> -void trapper(int sig)
> -{
> -	signal(SIGALRM, trapper);
> -}
> +static struct tst_test test = {
> +	.test_all = verify_alarm,
> +	.setup = setup,
> +	.forks_child = 1,
> +};
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
