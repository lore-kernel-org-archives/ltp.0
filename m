From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 28 May 2020 10:27:10 +0200
Subject: [LTP] [PATCH V2] syscalls: clock_settime: Add test around y2038
 vulnerability
In-Reply-To: <86a36c7d5919a966e077cb76f0d8710f31bcc60a.1590649002.git.viresh.kumar@linaro.org>
References: <70417fdc55c750e8b13d7124e66a7e8a59182e75.1590494889.git.viresh.kumar@linaro.org>
 <86a36c7d5919a966e077cb76f0d8710f31bcc60a.1590649002.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a11aWYdBtgV=T91_BOVR_hX-OZTAVhr806nbTFtCE+3MQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 28, 2020 at 8:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This adds a test around the y2038 vulnerability, it sets the system time
> to just before y2038 time (i.e. max value that can be stored in s32),
> and adds a timer to expire just after crossing it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Fix the y2038 bug in the test itself, changes in the setup() routine.
>   :)

So I assume this version works as expected?
I don't see any more problems with it.

> +       ret = tv->clock_settime(CLOCK_REALTIME, tst_ts_get(&ts));
> +       if (ret == -1)
> +               tst_brk(TBROK | TERRNO, "clock_settime() failed");
> +
> +       tst_its_set_time(&its, time + EXPIREDELTA, 0, 0, 0);
> +
> +       TEST(tv->timer_settime(timer, TIMER_ABSTIME, tst_its_get(&its), NULL));
> +       if (TST_RET == -1)
> +               tst_brk(TBROK | TTERRNO, "timer_settime() failed");
> +
> +       if (sigwait(&set, &sig) == -1)
> +               tst_brk(TBROK, "sigwait() failed");

Should you maybe check the time after the expiration to ensure the
timer ran for the expected length?

I suppose you can read the time in CLOCK_MONOTONIC to check
for the elapsed time regardless of what the kernel might think the
CLOCK_REALTIME is after this.

      Arnd
