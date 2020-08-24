From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Aug 2020 19:37:30 +0200
Subject: [LTP] [PATCH 2/2] Add test for CVE 2018-12896
In-Reply-To: <20200817160503.11381-2-mdoucha@suse.cz>
References: <20200817160503.11381-1-mdoucha@suse.cz>
 <20200817160503.11381-2-mdoucha@suse.cz>
Message-ID: <20200824173730.GB19931@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

...
> +++ b/testcases/kernel/syscalls/timer_settime/timer_settime03.c
...
> +static volatile int handler_called;
> +
> +static void sighandler(int sig)
static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)

> +{
> +	struct itimerspec spec;
> +
> +	/*
> +	 * Signal handler will be called twice in total because kernel will
> +	 * schedule another pending signal before the timer gets disabled.
> +	 */
> +	if (handler_called)
> +		return;
> +
> +	TEST(timer_getoverrun(timer));
> +
> +	memset(&spec, 0, sizeof(struct itimerspec));
> +	SAFE_TIMER_SETTIME(timer, 0, &spec, NULL);
> +	handler_called = 1;
Test cannot run with -i > 1.

> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "Error reading timer overrun count");
> +
> +	if (TST_RET == INT_MAX) {
> +		tst_res(TPASS, "Timer overrun count is capped");
> +		return;
> +	}
> +
> +	if (TST_RET < 0) {
> +		tst_res(TFAIL, "Timer overrun counter overflow");
> +		return;
> +	}
> +
> +	tst_res(TFAIL, "Timer overrun counter is wrong: %ld; expected %d or "
> +		"negative number", TST_RET, INT_MAX);

According to Cyril [1] tst_res() is not signal-async-safe (uses printf()).

[1] https://patchwork.ozlabs.org/project/ltp/patch/47e40724c2a7a9612aca0265e493e62c69d65996.1594204153.git.viresh.kumar@linaro.org/#2483231
> +}
...

Kind regards,
Petr
