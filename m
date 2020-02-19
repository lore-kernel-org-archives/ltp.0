From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Feb 2020 13:52:38 +0100
Subject: [LTP] [PATCH] syscalls/timer_settime: timer invokes signal
 handler using timer_settime function.
In-Reply-To: <20200206113958.11567-1-prachiparekh20@gmail.com>
References: <chrubis@suse.cz> <20200206113958.11567-1-prachiparekh20@gmail.com>
Message-ID: <20200219125238.GA5497@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <time.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include "lapi/common_timers.h"
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +
> +#define SIG SIGALRM

Just use SIGALRM in the code instead, there is no real need to obscure
which signal are we using.

> +static struct timespec timenow;
> +static struct itimerspec new_set, old_set;
> +static kernel_timer_t timer;

There is no need for three of these variables to be global at all.

> +static volatile int handler_var;
                         ^
			 It would be a bit more descriptive if this
			 variable was called signal_caught or got_signal.


> +static struct testcase {
> +	struct itimerspec	*old_ptr;
> +	int			it_value_tv_sec;
> +	int			it_value_tv_nsec;
> +	int			it_interval_tv_sec;
> +	int	         	it_interval_tv_nsec;
                 ^
		 Spaces after a tab

You can use the checkpatch.pl script, shipped along with Linux kernel
sources, to check for style violations.

> +	int			flag;
> +	char			*description;
> +} tcases[] = {
> +	{&old_set, 0, 5, 0, 5, TIMER_ABSTIME, "using absolute timer"},
> +	{NULL,     0, 5, 0, 5, 0, "using periodic timer"},
> +};
> +
> +
> +static void handler(int sig, siginfo_t *si, void *uc)
> +{

There is no point in defining the handler with the two additional
pointers if we do not use them. Just set the sa_handler in the sigaction
structure instead and do not set the SA_SIGINFO flag.

> +	handler_var = 1;
> +}
> +
> +static void run(unsigned int n)
> +{
> +	unsigned int i;
> +	struct testcase *tc = &tcases[n];
> +	tst_res(TINFO, "n = %d", n);

This message is useless and only polutes the test output.

> +	unsigned int u_secs = 10000;
> +	struct sigevent evp;
> +	struct sigaction sa;
> +
> +	tst_res(TINFO, "Testing for %s:", tc->description);
> +
> +	for (i = 0; i < CLOCKS_DEFINED; ++i) {
> +		clock_t clock = clock_list[i];
> +
> +		tst_res(TINFO, "i= %d:", i);

Here as well, useless message.

> +		/* Establish handler for timer signal */

Here you are commenting the obvious, please avoid comments like this
one.

> +		tst_res(TINFO, "Establishing handler for siganl %d:", SIG);

This message is polluting the test output as well.

> +		sa.sa_flags = SA_SIGINFO;
> +		sa.sa_sigaction = handler;
> +		sigemptyset(&sa.sa_mask);
> +		if (sigaction(SIG, &sa, NULL) == -1)

We do have SAFE_SIGACTION() please use that one instead.

> +			continue;

There is no need to setup the the handler for each test iteration, we
can do that once in the test setup.

> +		evp.sigev_value  = (union sigval) 0;
> +		evp.sigev_signo  = SIG;
> +		evp.sigev_notify = SIGEV_SIGNAL;
> +
> +		if (clock == CLOCK_PROCESS_CPUTIME_ID ||
> +				clock == CLOCK_THREAD_CPUTIME_ID) {
> +			if (!have_cputime_timers())
> +				continue;
> +		}
> +
> +		TEST(tst_syscall(__NR_timer_create, clock, &evp, &timer));
> +
> +		if (TST_RET != 0) {
> +			if (possibly_unsupported(clock) && TST_ERR == EINVAL) {
> +				tst_res(TPASS | TTERRNO,
> +						"%s unsupported, failed as expected",
> +						get_clock_str(clock));
> +			} else {
> +				tst_res(TBROK | TTERRNO,
> +						"timer_create(%s) failed",
> +						get_clock_str(clock));
> +			}
> +			continue;
> +		}
> +
> +		memset(&new_set, 0, sizeof(new_set));
> +		memset(&old_set, 0, sizeof(old_set));
> +
> +		new_set.it_value.tv_sec = tc->it_value_tv_sec;
> +		new_set.it_value.tv_nsec = tc->it_value_tv_sec * 1000000;
> +		new_set.it_interval.tv_sec = tc->it_interval_tv_sec;
> +		new_set.it_interval.tv_nsec = tc->it_interval_tv_nsec * 1000000;
> +
> +		if (tc->flag & TIMER_ABSTIME) {
> +			if (clock_gettime(clock, &timenow) < 0) {
> +				tst_res(TBROK,
> +						"clock_gettime(%s) failed - skipping the test",
> +						get_clock_str(clock));
> +				continue;
> +			}
> +			new_set.it_value.tv_sec += timenow.tv_sec;

			Does this even work? As far as I can tell we
			have to add both tv_sec and tv_nsec and then
			normalize the result.

			Btw we do have a library for that in
			include/tst_timer.h, where there are fucntions
			to add two timespec values.

> +		}
> +
> +		TEST(tst_syscall(__NR_timer_settime, timer,
> +					tc->flag, &new_set, tc->old_ptr));
> +
> +		/* sleep for sometime so periodic timer expires in that time*/
> +		usleep(u_secs);

The duration for the sleep here should either be based on the values in
the testcase structure, or we can simply pause() here.

And if we pause() here we should also measure the time we slept here and
check that it's bounded by a reasonable value. Choosing a reasonable
value for short sleeps is a bit difficuilt though becuase of timerslack
and other things, so for a start we may just pause() here for now.

> +		if (handler_var == 0) {
> +			tst_res(TFAIL | TTERRNO, "%s failed",
> +					get_clock_str(clock));
> +		} else {
> +			tst_res(TPASS, "%s was successful",
> +					get_clock_str(clock));
> +
> +			handler_var = 0;

Can we reset this at the start of the loop unconditionally please?

> +			tst_res(TINFO, "Caught signal %d\n", SIG);

Another useless message, if we print the PASS here it implies that the
signal has been caught.

> +		}

You should delete the timer with timer_delete() here.

> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +};

-- 
Cyril Hrubis
chrubis@suse.cz
