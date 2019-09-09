From: Li Wang <liwang@redhat.com>
Date: Mon, 9 Sep 2019 15:46:45 +0800
Subject: [LTP] LTP Release
In-Reply-To: <20190906130707.GA7515@rei.lan>
References: <20190906130707.GA7515@rei.lan>
Message-ID: <CAEemH2frzqyUmgm2mXTG3dusUtggwX4Y3oRBr34p+NCUJFW7_g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 6, 2019 at 9:07 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> As usually we should start prepare for a release somewhere at the end of
> the September.
>
> I will try to review as much patches as possible next week, then I would
> like to start the pre-release testing. So if there is something that
> really should go in before the release let me know.
>

The one to print errno number.
    [PATCH] tst_res: Print errno number in addition to error name


Some test failures:
==============

acct02 (s390x):
acct02.c:174: INFO: Verifying using 'struct acct_v3'
acct02.c:140: INFO: Number of accounting file entries tested: 2
acct02.c:145: FAIL: acct() wrote incorrect file contents!

timer_create01 (s390x, ppc64le, aarch64):
timer_create01.c:48: INFO: Testing notification type: SIGEV_THREAD_ID
timer_create01.c:93: PASS: Timer successfully created for CLOCK_REALTIME
timer_create01.c:93: PASS: Timer successfully created for CLOCK_MONOTONIC
timer_create01.c:93: PASS: Timer successfully created for
CLOCK_PROCESS_CPUTIME_ID
timer_create01.c:93: PASS: Timer successfully created for
CLOCK_THREAD_CPUTIME_ID
timer_create01.c:93: PASS: Timer successfully created for CLOCK_BOOTTIME
timer_create01.c:87: FAIL: Failed to create timer for CLOCK_BOOTTIME_ALARM:
???
timer_create01.c:87: FAIL: Failed to create timer for CLOCK_REALTIME_ALARM:
???
timer_create01.c:93: PASS: Timer successfully created for CLOCK_TAI

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190909/8fb3bd75/attachment-0001.htm>
