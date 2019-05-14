From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 May 2019 15:48:39 +0200
Subject: [LTP] [PATCH v3] crypto/af_alg02: fixed read() being stuck
In-Reply-To: <20190508071636.13804-1-camann@suse.com>
References: <20190508071636.13804-1-camann@suse.com>
Message-ID: <20190514134838.GA1516@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> -static void run(void)
> +void *verify_encrypt(void *arg LTP_ATTRIBUTE_UNUSED)
>  {
>  	char buf[16];
>  	int reqfd = tst_alg_setup_reqfd("skcipher", "salsa20", NULL, 16);
>  
> +	TST_CHECKPOINT_WAKE(0);
> +
>  	/* With the bug the kernel crashed here */
>  	if (read(reqfd, buf, 16) == 0)
>  		tst_res(TPASS, "Successfully \"encrypted\" an empty message");
>  	else
> -		tst_res(TBROK, "read() didn't return 0");
> +		tst_res(TFAIL, "read() didn't return 0");
> +	return arg;

Actually there is no point in adding the LTP_ATTRIBUTE_UNUSED since you
do return arg; at the end of the function.

So I've removed the LTP_ATTRIBUTE_UNUSED, changed the function to be
static and pushed. thanks.

> +}
> +
> +static void run(void)
> +{
> +	pthread_t thr;
> +
> +	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> +	SAFE_PTHREAD_CREATE(&thr, NULL, verify_encrypt, NULL);
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	while (pthread_kill(thr, 0) != ESRCH) {
> +		if (tst_timeout_remaining() <= 10) {
> +			pthread_cancel(thr);
> +			tst_brk(TBROK,
> +				"Timed out while reading from request socket.");
> +		}
> +		usleep(1000);
> +	}
>  }
>  
>  static struct tst_test test = {
>  	.test_all = run,
> +	.timeout = 20,
> +	.needs_checkpoints = 1,
>  };
> -- 
> 2.16.4
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
