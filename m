From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jul 2020 14:32:35 +0200
Subject: [LTP] [PATCH 4/4] libs: sigwait: Get rid of REPORT_SUCCESS()
 macro
In-Reply-To: <a83166af3a2b432bb11a0876e18e15705479f32d.1595511710.git.viresh.kumar@linaro.org>
References: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
 <a83166af3a2b432bb11a0876e18e15705479f32d.1595511710.git.viresh.kumar@linaro.org>
Message-ID: <20200724123235.GA3539@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  void test_empty_set(swi_func sigwaitinfo, int signo,
>  		    enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
>  {
> @@ -55,7 +22,15 @@ void test_empty_set(swi_func sigwaitinfo, int signo,
>  	child = create_sig_proc(signo, INT_MAX, 100000);
>  
>  	TEST(sigwaitinfo(&sigs, &si, NULL));
> -	REPORT_SUCCESS(-1, EINTR);
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EINTR)
> +			tst_res(TPASS, "%s: Test passed", __func__);
> +		else
> +			tst_res(TFAIL | TTERRNO, "%s: Unexpected failure", __func__);

Can we please make the messages a bit more user friendly?

- the tst_res() already prints line and filename the __func__ is a bit
  redundant

- it also prints PASS/FAIL so we can omit the "Test passed" we can print
  something that describes the testcase instead e.g.
  "Wait interrupted by a signal"

- also in the "Unexpected failure" case we should print which error we
  expected with someting as: tst_res(TFAIL | TTERRNO, "Expected to return EINTER, got");

-- 
Cyril Hrubis
chrubis@suse.cz
