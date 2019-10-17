From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Oct 2019 14:54:42 +0200
Subject: [LTP] [PATCH] timer_getoverrun/2-3: increase tolerance for
 overshoot
In-Reply-To: <81c89bbde27ede0ef4291df60186bdcd293a3db5.1571219422.git.jstancek@redhat.com>
References: <77c71c80-0ca2-6f67-d628-d337a13539d7@jv-coder.de>
 <81c89bbde27ede0ef4291df60186bdcd293a3db5.1571219422.git.jstancek@redhat.com>
Message-ID: <20191017125442.GB31415@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Joerg reports that test fails on systems with low timer precision (qemu-arm64,
> 4ms timer precision) due to way we calculate maximum number of overruns.
> If the expected overruns is less than 200, there is no tollerance.
> 
> Allow up to ~50ms of extra overruns.
> 
> Reported-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> Acked-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../conformance/interfaces/timer_getoverrun/2-3.c             | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
> index 96b7d01e6ffe..66f8b583a5a6 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
> @@ -94,11 +94,17 @@ int main(void)
>  
>  	valuensec = tsres.tv_nsec;
>  	intervalnsec = 2 * valuensec;
> -	//expectedoverruns = (1000000000 - valuensec) / intervalnsec;
>  	expectedoverruns = 1000000000 / intervalnsec - 1;
>  
> +	/*
> +	 * waking up from sleep isn't instant, we can overshoot.
> +	 * Allow up to ~50ms worth of extra overruns.
> +	 */
> +	fudge = 50000000 / intervalnsec + 1;

I wonder if we can measure the sleep with monotonic clock, then we can
be more precise, since we would know how much we overshoot. But it's
probably not worth of complicating the code.

Either way I'm fine with this version as well, acked.

>  	printf("value = %d sec, interval = %d nsec, "
> -	       "expected overruns = %d\n", 1, intervalnsec, expectedoverruns);
> +	       "expected overruns = %d, fudge = %d\n", 1,
> +	       intervalnsec, expectedoverruns, fudge);
>  
>  	its.it_interval.tv_sec = 0;
>  	its.it_interval.tv_nsec = intervalnsec;
> @@ -146,7 +152,6 @@ int main(void)
>  	 * extra expiries after the nanosleep completes so do
>  	 * a range check.
>  	 */
> -	fudge = expectedoverruns / 100;
>  	if (overruns >= expectedoverruns && overruns < expectedoverruns + fudge) {
>  		printf("Test PASSED\n");
>  		return PTS_PASS;
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
