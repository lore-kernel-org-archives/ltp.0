From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 16 Oct 2019 10:42:26 +0200
Subject: [LTP] [PATCH] open_posix/timer_getoverrun/2-3: Fix test for
 systems with low timer precision
In-Reply-To: <20191016083822.GA11593@dustball.usersys.redhat.com>
References: <20191011053134.18416-1-lkml@jv-coder.de>
 <2097000229.6302768.1571152116580.JavaMail.zimbra@redhat.com>
 <3c5988d6-0e37-6ca8-2567-a98d2ff84dce@jv-coder.de>
 <20191016083822.GA11593@dustball.usersys.redhat.com>
Message-ID: <77c71c80-0ca2-6f67-d628-d337a13539d7@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> I didn't change timer resolution, I only used larger interval values
> as multiple of timer resolution:
> ? intervalnsec = largeX * timer_resolution
>
ah ok
> I'd prefer we tweak the tolerance rather than make test run longer.
> I'm thinking just allow ~50ms of extra overruns, and don't be so
> strict about absolute number of overruns. (KVM guests and s390 lpars
> tend to suffer from higher steal time).
>
> diff --git 
> a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c 
> b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c 
>
> index 96b7d01e6ffe..66f8b583a5a6 100644
> --- 
> a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
> +++ 
> b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
> @@ -94,11 +94,17 @@ int main(void)
>
> ??????? valuensec = tsres.tv_nsec;
> ??????? intervalnsec = 2 * valuensec;
> -?????? //expectedoverruns = (1000000000 - valuensec) / intervalnsec;
> ??????? expectedoverruns = 1000000000 / intervalnsec - 1;
>
> +?????? /*
> +??????? * waking up from sleep isn't instant, we can overshoot.
> +??????? * Allow up to ~50ms worth of extra overruns.
> +??????? */
> +?????? fudge = 50000000 / intervalnsec + 1;
> +
> ??????? printf("value = %d sec, interval = %d nsec, "
> -????????????? "expected overruns = %d\n", 1, intervalnsec, 
> expectedoverruns);
> +????????????? "expected overruns = %d, fudge = %d\n", 1,
> +????????????? intervalnsec, expectedoverruns, fudge);
>
> ??????? its.it_interval.tv_sec = 0;
> ??????? its.it_interval.tv_nsec = intervalnsec;
> @@ -146,7 +152,6 @@ int main(void)
> ???????? * extra expiries after the nanosleep completes so do
> ???????? * a range check.
> ???????? */
> -?????? fudge = expectedoverruns / 100;
> ??????? if (overruns >= expectedoverruns && overruns < 
> expectedoverruns + fudge) {
> ??????????????? printf("Test PASSED\n");
> ??????????????? return PTS_PASS;
>
I wonder if there was a way to do this more accurate, like busy waiting 
while signals
are blocked. But I would also be fine with your solution.

