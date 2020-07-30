From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Jul 2020 17:34:17 +0200
Subject: [LTP] [PATCH V2 resend 2/2] libs: sigwait: Get rid of
 REPORT_SUCCESS() macro
In-Reply-To: <ec86df91b3664ff7555717ac547d9e2c579d236a.1596035606.git.viresh.kumar@linaro.org>
References: <53c9ed8dc17ea6fa0b46502cd1c724a3a8539c8c.1595842740.git.viresh.kumar@linaro.org>
 <ec86df91b3664ff7555717ac547d9e2c579d236a.1596035606.git.viresh.kumar@linaro.org>
Message-ID: <20200730153417.GA17418@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	SAFE_KILL(child, SIGTERM);
>  	SAFE_WAIT(NULL);
> @@ -78,7 +52,14 @@ void test_timeout(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
>  	child = create_sig_proc(signo, INT_MAX, 100000);
>  
>  	TEST(sigwaitinfo(&sigs, &si, tst_ts_get(&ts)));
> -	REPORT_SUCCESS(-1, EAGAIN);
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EAGAIN)
> +			tst_res(TPASS, "Wait interrupted by a signal");

Can we please fix these messages as well so that it's not copy & paste
of the same message all over?

This one should say "Wait interrupted by a timeout"

> +		else
> +			tst_res(TFAIL | TTERRNO, "Expected error number EAGAIN, got");
> +	} else {
> +		tst_res(TFAIL, "Expected return value -1, got: %ld", TST_RET);
> +	}
>  
>  	SAFE_KILL(child, SIGTERM);
>  	SAFE_WAIT(NULL);
> @@ -101,9 +82,15 @@ void test_unmasked_matching(swi_func sigwaitinfo, int signo,
>  	child = create_sig_proc(signo, INT_MAX, 100000);
>  
>  	TEST(sigwaitinfo(&sigs, &si, NULL));
> -	REPORT_SUCCESS_COND(signo, 0, si.si_pid == child
> -			    && si.si_code == SI_USER
> -			    && si.si_signo == signo, "Struct siginfo mismatch");
> +	if (TST_RET == signo) {
> +		if (si.si_pid == child && si.si_code == SI_USER &&
> +		    si.si_signo == signo)
> +			tst_res(TPASS, "Wait interrupted by a signal");

And this one "struct siginfo is correct"


etc.

-- 
Cyril Hrubis
chrubis@suse.cz
