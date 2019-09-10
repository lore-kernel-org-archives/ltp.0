From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Sep 2019 15:05:53 +0200
Subject: [LTP] LTP Release
In-Reply-To: <CAEemH2frzqyUmgm2mXTG3dusUtggwX4Y3oRBr34p+NCUJFW7_g@mail.gmail.com>
References: <20190906130707.GA7515@rei.lan>
 <CAEemH2frzqyUmgm2mXTG3dusUtggwX4Y3oRBr34p+NCUJFW7_g@mail.gmail.com>
Message-ID: <20190910130549.GC18210@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The one to print errno number.
>     [PATCH] tst_res: Print errno number in addition to error name

Pushed the patch as it was, I do not think that reordering the
statements was important enough.

> Some test failures:
> ==============
> 
> acct02 (s390x):
> acct02.c:174: INFO: Verifying using 'struct acct_v3'
> acct02.c:140: INFO: Number of accounting file entries tested: 2
> acct02.c:145: FAIL: acct() wrote incorrect file contents!

I can reproduce it here as well, no idea what is wrong there. I guess
that modifying the test to be more verbose, i.e. to print if we haven't
matched the pid or if the contents of the structure were wrong would be
a good start.

> timer_create01 (s390x, ppc64le, aarch64):
> timer_create01.c:48: INFO: Testing notification type: SIGEV_THREAD_ID
> timer_create01.c:93: PASS: Timer successfully created for CLOCK_REALTIME
> timer_create01.c:93: PASS: Timer successfully created for CLOCK_MONOTONIC
> timer_create01.c:93: PASS: Timer successfully created for
> CLOCK_PROCESS_CPUTIME_ID
> timer_create01.c:93: PASS: Timer successfully created for
> CLOCK_THREAD_CPUTIME_ID
> timer_create01.c:93: PASS: Timer successfully created for CLOCK_BOOTTIME
> timer_create01.c:87: FAIL: Failed to create timer for CLOCK_BOOTTIME_ALARM:
> ???
> timer_create01.c:87: FAIL: Failed to create timer for CLOCK_REALTIME_ALARM:
> ???
> timer_create01.c:93: PASS: Timer successfully created for CLOCK_TAI

I'm pretty sure that we concluded that this is a kernel bug since it
returns kernel internal errno.

-- 
Cyril Hrubis
chrubis@suse.cz
