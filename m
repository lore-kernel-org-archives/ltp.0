From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 22 Jun 2017 06:32:31 -0400 (EDT)
Subject: [LTP] [PATCH 2/2] syscalls: Add timer measurement library
In-Reply-To: <1505342784.40797880.1498048926551.JavaMail.zimbra@redhat.com>
References: <20170620134218.13461-1-chrubis@suse.cz>
 <20170620134218.13461-2-chrubis@suse.cz>
 <1505342784.40797880.1498048926551.JavaMail.zimbra@redhat.com>
Message-ID: <432037044.41235917.1498127551219.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> 
> ----- Original Message -----
> > From: "Cyril Hrubis" <chrubis@suse.cz>
> > To: ltp@lists.linux.it
> > Sent: Tuesday, 20 June, 2017 3:42:18 PM
> > Subject: [LTP] [PATCH 2/2] syscalls: Add timer measurement library
> > 
> > This commit adds a timer measurement library, mostly based on changes
> > done to the pselect01.c test and changes all tests that measure timer
> > precision to use it.
> > 
> > The timer testcases that measure timeouts now just define sampling function
> > and
> > optional setup and cleanup. The rest of the functionality is implemented in
> > the
> > lib/tst_timer_test.c library. This change not only removes fair amount of
> > duplicated code but also allows us to tune thresholds and define testcases
> > in
> > a
> > single place for all testcases.
> > 
> > The timer measurement library also supports for passing sleep time and
> > number of iterations as a command-line parameters, can print nifty
> > frequency plot into the terminal, as well as save test measurements into
> > a text file.
> > 
> 
> Hi,
> 
> looks good to me.
> 
> It compiled fine across RHEL 5/6/7 x86_64. No failures when I run it
> on my laptop.
> 
> I plan to also run it across multiple arches/distros on randomly
> picked systems from lab.

Results from ~35 random RHEL6/7 systems look OK. I've hit
one failure in RHEL6, but that looks like bug in older kernel,
because the delays are huge:

tst_test.c:870: INFO: Timeout per run is 0h 05m 00s
tst_timer_test.c:345: INFO: CLOCK_MONOTONIC resolution 1ns
tst_timer_test.c:357: INFO: prctl(PR_GET_TIMERSLACK) = 50us
tst_timer_test.c:275: INFO: nanosleep() sleeping for 1000us 500 iterations, threshold 450.01us
tst_timer_test.c:296: INFO: Found 488 outliners in [500430,12493] range
tst_timer_test.c:318: INFO: min 1056us, max 500430us, median 500198us, trunc mean 466362.70us (discarded 25)
tst_timer_test.c:321: FAIL: nanosleep() slept for too long

 Time: us | Frequency
--------------------------------------------------------------------------------
     1056 | **+
    27339 | -
    53622 | -
    79905 | .
   106188 | -
   132471 | .
   158754 | .
   185037 | -
   211320 | .
   237603 | -
   263886 | .
   290169 | -
   316452 | .
   342735 | -
   369018 | -
   395301 | .
   421584 | -
   447867 | -
   474150 | ********************************************************************
--------------------------------------------------------------------------------
  26283us | 1 sample = 0.15044 '*', 0.30088 '+', 0.60177 '-', non-zero '.'

Not reproducible when I try to run it by hand.

Regards,
Jan
