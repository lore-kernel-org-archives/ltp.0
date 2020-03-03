From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Mar 2020 11:47:37 +0100
Subject: [LTP] [PATCH v2] Add test for CVE 2017-10661
In-Reply-To: <20200221120850.15874-1-mdoucha@suse.cz>
References: <20200221120850.15874-1-mdoucha@suse.cz>
Message-ID: <20200303104737.GA42129@gacrux.arch.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Changes since v1:
> - typo fixes
> - code style fixes
> - move test from cve/ to kernel/syscall/timerfd/
> - add test to cve runfile
Thanks for fixing all Richie's comments.

> +++ b/testcases/kernel/syscalls/timerfd/Makefile
> @@ -20,6 +20,7 @@ top_srcdir		?= ../../../..

>  include $(top_srcdir)/include/mk/testcases.mk

> -LDLIBS			+= -lpthread -lrt
> +timerfd_settime02:	CFLAGS	+= -pthread
> +timerfd_settime02:	LDLIBS	+= -pthread -lrt
Interesting, I thought -pthread wouldn't be needed to be in LDLIBS
(enough to have it in CFLAGS), but old distros (CentOS 6 in our travis: gcc
4.4.7, glibc 2.12).

...
> diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
...
> +static void setup(void)
> +{
> +	int ttype;
> +
> +	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
> +	errno = 0;
I guess reset errno shouldn't be needed, but sure it's safe.

> +	fd = timerfd_create(CLOCK_REALTIME, 0);
> +
> +	if (fd < 0) {
> +		ttype = (errno == ENOTSUP ? TCONF : TBROK);
> +		tst_brk(ttype | TERRNO, "Cannot create timer");
> +	}
It looks like we'd benefit from SAFE_TIMERFD_CREATE().
+ I like you take care about ENOTSUP.

...
> +static void run(void)
> +{
> +	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
> +
> +	while (tst_fzsync_run_a(&fzsync_pair)) {
> +		TEST(punch_clock(TFD_TIMER_ABSTIME | TFD_TIMER_CANCEL_ON_SET));
> +
> +		if (TST_RET == -1)
> +			tst_res(TBROK | TTERRNO, TIMERFD_FLAGS " failed");
Now this needs to be tst_res(TFAIL (person who merges this will do).

> +
> +		if (TST_RET != 0)
> +			tst_res(TBROK | TTERRNO, "Invalid " TIMERFD_FLAGS
> +				" return value");
The same here.


Kind regards,
Petr
