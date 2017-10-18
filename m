From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Oct 2017 12:58:32 +0200
Subject: [LTP] [PATCH] Increase threshold in timer measurement library
In-Reply-To: <20170928164926.32415-1-ynorov@caviumnetworks.com>
References: <20170928164926.32415-1-ynorov@caviumnetworks.com>
Message-ID: <20171018105832.GB25433@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> On my system - arm64 emulated in QEMU, the following tests fail:
> epoll_wait02, nanosleep01, pselect01 and select04  - all due to 
> violation the threshold limit for sleeping in  do_timer_test().
> 
> If my understanding correct, the threshold per syscall is rather
> empirical value. I tested LTP in ILP32 and LP64 modes, and despite
> the random nature of time accounting, failures are reproducible very
> stable.

It's more of an educated guess, we did quite a lot of measurements and
so the final formula is both based on the understanding of the kernel
internals and the empirical data.

> Increasing threshold fixes my failures.

I'm a bit worried here that we would end up increasing the thresholds up
to the point where we do not assert anything reasonable since for any
treshold we can possibly find a slow enough emulated machine where it
fails. I guess that the machine emulates arm64 on x86 right?

I think that it would be much better if we solved this in a way that
wouldn't increase the thresholds for most of the test targets. Simple
way would be adding an interface to multiply the threshold when needed,
we do have LTP_TIMEOUT_MUL already, we may as well use it here. Or we
can try some kind of auto-tuning such as BogoMips but that would be
quite complicated to get right.

> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  lib/tst_timer_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
> index cd4ebcaa8..8e2881e24 100644
> --- a/lib/tst_timer_test.c
> +++ b/lib/tst_timer_test.c
> @@ -176,7 +176,7 @@ static int cmp(const void *a, const void *b)
>  /*
>   * The threshold per one syscall is computed as a sum of:
>   *
> - *  400 us                 - accomodates for context switches, process
> + *  1500 us                - accomodates for context switches, process
>   *                           migrations between CPUs on SMP, etc.
>   *  2*monotonic_resolution - accomodates for granurality of the CLOCK_MONOTONIC
>   *  slack_per_scall        - max of 0.1% of the sleep capped on 100ms or
> @@ -198,7 +198,7 @@ static long long compute_threshold(long long requested_us,
>  
>  	slack_per_scall = MAX(slack_per_scall, timerslack);
>  
> -	return (400 + 2 * monotonic_resolution + slack_per_scall) * nsamples
> +	return (1500 + 2 * monotonic_resolution + slack_per_scall) * nsamples
>  		+ 3000/nsamples;
>  }
>  
> -- 
> 2.11.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
