From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 14:39:59 +0200
Subject: [LTP] [PATCH v2 15/16] syscalls/sched_getscheduler01: convert
 to new API
In-Reply-To: <20210806164730.51040-16-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
 <20210806164730.51040-16-aleksei.kodanev@bell-sw.com>
Message-ID: <YREiH6MkdFCYZbw+@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -int main(int ac, char **av)
> +static void run(unsigned int n)
>  {
> -	int lc;
> -	int i;
> -	struct sched_param param;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> +	struct sched_variants *tv = &variants[tst_variant];
> +	struct test_cases_t *tc = &tcases[n];
> +	struct sched_param p = { .sched_priority = tc->priority };
>  
> -		for (i = 0; i < TST_TOTAL; i++) {
> +	TST_EXP_PASS_SILENT(tv->sched_setscheduler(0, tc->policy, &p));

We should probably do:

	if (!TST_PASS)
		return;

Because it does not make much sense to continue if setscheduler() have
failed, but that's very minor.


Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
