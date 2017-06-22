From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 22 Jun 2017 09:58:20 -0400 (EDT)
Subject: [LTP] [PATCH 2/2] syscalls: Add timer measurement library
In-Reply-To: <20170622134512.GB8678@rei.suse.de>
References: <20170620134218.13461-1-chrubis@suse.cz>
 <20170620134218.13461-2-chrubis@suse.cz>
 <1505342784.40797880.1498048926551.JavaMail.zimbra@redhat.com>
 <432037044.41235917.1498127551219.JavaMail.zimbra@redhat.com>
 <20170622134512.GB8678@rei.suse.de>
Message-ID: <1763007177.41308824.1498139900018.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> > 
> > tst_test.c:870: INFO: Timeout per run is 0h 05m 00s
> > tst_timer_test.c:345: INFO: CLOCK_MONOTONIC resolution 1ns
> > tst_timer_test.c:357: INFO: prctl(PR_GET_TIMERSLACK) = 50us
> > tst_timer_test.c:275: INFO: nanosleep() sleeping for 1000us 500 iterations,
> > threshold 450.01us
> > tst_timer_test.c:296: INFO: Found 488 outliners in [500430,12493] range
> > tst_timer_test.c:318: INFO: min 1056us, max 500430us, median 500198us,
> > trunc mean 466362.70us (discarded 25)
> > tst_timer_test.c:321: FAIL: nanosleep() slept for too long
> > 
> >  Time: us | Frequency
> > --------------------------------------------------------------------------------
> >      1056 | **+
> >     27339 | -
> >     53622 | -
> >     79905 | .
> >    106188 | -
> >    132471 | .
> >    158754 | .
> >    185037 | -
> >    211320 | .
> >    237603 | -
> >    263886 | .
> >    290169 | -
> >    316452 | .
> >    342735 | -
> >    369018 | -
> >    395301 | .
> >    421584 | -
> >    447867 | -
> >    474150 |
> >    ********************************************************************
> > --------------------------------------------------------------------------------
> >   26283us | 1 sample = 0.15044 '*', 0.30088 '+', 0.60177 '-', non-zero '.'
> > 
> > Not reproducible when I try to run it by hand.
> 
> That indeed looks like a kernel bug, isn't there something in dmesg?

No, nothing at the time nanosleep01 was running.

We carry patch below in our tests, so it's easier to link some dmesg
output with testcases.

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index cee71aa..79dc3fa 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -1360,6 +1360,12 @@ static void write_test_start(struct tag_pgrp *running)
 		     running->cmd->cmdline, "", "exit", "<<<test_output>>>");
 	}
 	fflush(stdout);
+
+	FILE *f = fopen("/dev/kmsg", "w");
+	if (f) {
+		fprintf(f, "ltptest %s start\n", running->cmd->name);
+		fclose(f);
+	}
 }
 
Regards,
Jan
