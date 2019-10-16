From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 16 Oct 2019 10:38:22 +0200
Subject: [LTP] [PATCH] open_posix/timer_getoverrun/2-3: Fix test for
 systems with low timer precision
In-Reply-To: <3c5988d6-0e37-6ca8-2567-a98d2ff84dce@jv-coder.de>
References: <20191011053134.18416-1-lkml@jv-coder.de>
 <2097000229.6302768.1571152116580.JavaMail.zimbra@redhat.com>
 <3c5988d6-0e37-6ca8-2567-a98d2ff84dce@jv-coder.de>
Message-ID: <20191016083822.GA11593@dustball.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 16, 2019 at 07:39:52AM +0200, Joerg Vehlow wrote:
>Actually rounding up would not work. I tried it with a timer accuracy 
>of 4ms and I needed
>at least a fudge of two. Rounding up would only result in one. That 
>it why I decided to
>go for extending the duration
>>
>>I was assuming -1 in original code is to cope with final timer expiration of tssleep.tv_sec,
>>which might not be counted as "overrun". What does the -1 do in your formula?
>>Why is it inside brackets?
>You may be right. I am not completely sure what it is used for, but I 
>guess you are right.
>>
>>When I try to force different interval values, it fails for me (on x86):
>>3ms
>># ./timer_getoverrun_2-3.run-test
>>duration = 7 sec, interval = 6000000 nsec, expected overruns = 1155
>>1166 overruns occurred
>>FAIL:  1166 overruns sent; expected 1155
>>
>>5ms
>># ./timer_getoverrun_2-3.run-test
>>duration = 11 sec, interval = 10000000 nsec, expected overruns = 1089
>>1100 overruns occurred
>>FAIL:  1100 overruns sent; expected 1089
>How is it possible to force the timer resolution? I tested on qemu
>with aarch64 and x86_64 with and without highres=off and ir worked.

I didn't change timer resolution, I only used larger interval values
as multiple of timer resolution:
   intervalnsec = largeX * timer_resolution

I'd prefer we tweak the tolerance rather than make test run longer.
I'm thinking just allow ~50ms of extra overruns, and don't be so
strict about absolute number of overruns. (KVM guests and s390 lpars
tend to suffer from higher steal time).

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
index 96b7d01e6ffe..66f8b583a5a6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
@@ -94,11 +94,17 @@ int main(void)
  
         valuensec = tsres.tv_nsec;
         intervalnsec = 2 * valuensec;
-       //expectedoverruns = (1000000000 - valuensec) / intervalnsec;
         expectedoverruns = 1000000000 / intervalnsec - 1;
  
+       /*
+        * waking up from sleep isn't instant, we can overshoot.
+        * Allow up to ~50ms worth of extra overruns.
+        */
+       fudge = 50000000 / intervalnsec + 1;
+
         printf("value = %d sec, interval = %d nsec, "
-              "expected overruns = %d\n", 1, intervalnsec, expectedoverruns);
+              "expected overruns = %d, fudge = %d\n", 1,
+              intervalnsec, expectedoverruns, fudge);
  
         its.it_interval.tv_sec = 0;
         its.it_interval.tv_nsec = intervalnsec;
@@ -146,7 +152,6 @@ int main(void)
          * extra expiries after the nanosleep completes so do
          * a range check.
          */
-       fudge = expectedoverruns / 100;
         if (overruns >= expectedoverruns && overruns < expectedoverruns + fudge) {
                 printf("Test PASSED\n");
                 return PTS_PASS;

