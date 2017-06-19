From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Jun 2017 15:26:29 +0200
Subject: [LTP] [PATCH v2] syscalls: Add timer measurement library
In-Reply-To: <88192643.36961651.1497621378847.JavaMail.zimbra@redhat.com>
References: <20170614124239.21109-1-chrubis@suse.cz>
 <88192643.36961651.1497621378847.JavaMail.zimbra@redhat.com>
Message-ID: <20170619132629.GA24421@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> - error: ???PR_GET_TIMERSLACK??? undeclared (first use in this function)
> Old ditros don't have this define.

What about ifdefing it around as:

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 7566180c3..74157dbce 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -333,6 +333,7 @@ static void timer_setup(void)
 
        monotonic_resolution = t.tv_nsec / 1000;
 
+#ifdef PR_GET_TIMERSLACK
        ret = prctl(PR_GET_TIMERSLACK);
        if (ret < 0) {
                tst_res(TINFO, "prctl(PR_GET_TIMERSLACK) = -1, using 50us");
@@ -341,6 +342,10 @@ static void timer_setup(void)
                timerslack = ret / 1000;
                tst_res(TINFO, "prctl(PR_GET_TIMERSLACK) = %ius", timerslack);
        }
+#else
+       tst_res(TINFO, "PR_GET_TIMERSLACK not defined, using 50us");
+       timerslack = 50;
+#endif /* PR_GET_TIMERSLACK */


> - clock_getres/clock_gettime requires -rt for glibc < 2.17
> On RHEL5/6 I had to modify these Makefiles:
> #       modified:   include/mk/testcases.mk
> #       modified:   lib/newlib_tests/Makefile
> #       modified:   lib/tests/Makefile
> #       modified:   testcases/kernel/containers/netns/Makefile
> #       modified:   testcases/kernel/containers/share/Makefile

Ah right, will fix that in v3.

> - threshold might be too low for some systems
> The data I sent in:
>   http://lists.linux.it/pipermail/ltp/2017-June/004705.html
> was from a quite beefy system, and it sometimes went over
> 250us threshold.

That is something I left for discussion after we agree on the test API.

> Should we increase threshold? The formula is based on comment
> for select(), but we are applying this to other syscalls as well.
> We used to do 1%, now it's more strict with just 0.1%.

Well, if you look at man prctl and the PR_SET_TIMERSLACK it explicitly states
that the value is used for select, poll, epoll, nanosleep and futex.

The select and *poll family all use the same function with a formula we copy in
the test library. The futex seems to use only the timerslack value, so we are
less strict for that case and likely for the nanosleep calls, though I haven't
checked that part of the kernel to make sure that the slack is used there. We
may as well modify the threshold based on the scall name we get if you think
that it's worth the additional complexity.

> Should we use RT priority?
> Should we set CPU affinity to only single CPU?

I would rather increase the thresholds a bit than change the test to test in a
this kind of artificial scenario. Or even better we may try to run the test
twice with a stricter threshold for RT thread pinned to a single CPU.

> It fails easily on my laptop (i7-6820HQ CPU @ 2.70GHz) atm.:
> 
> tst_timer_test.c:269: INFO: pselect() sleeping for 25000us 50 iterations, threshold 301.29us
> tst_timer_test.c:312: INFO: min 25063us, max 25586us, median 25293us, trunc mean 25303.85us (discarded 2)
> tst_timer_test.c:315: FAIL: pselect() slept for too long
> 
>  Time: us | Frequency
> --------------------------------------------------------------------------------
>     25063 | *******************-
>     25091 | ************************-
>     25119 | *****************************
>     25147 |
>     25175 | *********+
>     25203 | **************+
>     25231 | ****+
>     25259 | **************+
>     25287 | *********+
>     25315 | *********+
>     25343 | ****+
>     25371 | *********+
>     25399 |
>     25427 |
>     25455 | ****+
>     25483 | ********************************************************************
>     25511 | **************+
>     25539 |
>     25567 | ****+
> --------------------------------------------------------------------------------
>      28us | 1 sample = 4.85714 '*', 9.71429 '+', 19.42857 '-', non-zero '.'

Was that under a load or on an idle machine?

Anyway I'm OK with increasing the thresholds, the question is how much. For
this particular case it's failing just by a tiny little bit. Do you see any
failures if the static part of the treshold gets increased from 250 to 350 or
do we need even more?

-- 
Cyril Hrubis
chrubis@suse.cz
