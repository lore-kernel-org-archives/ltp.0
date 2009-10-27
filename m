Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N2gZh-0004Mq-Jm
	for ltp-list@lists.sourceforge.net; Tue, 27 Oct 2009 07:34:37 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N2gZa-0004OB-6x
	for ltp-list@lists.sourceforge.net; Tue, 27 Oct 2009 07:34:37 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9R7T8Ut012604
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Oct 2009 01:29:08 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9R7Y8pO104206
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Oct 2009 01:34:09 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9R7Y8iL006637
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Oct 2009 01:34:08 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40910261233m30e06594j584387d6de403349@mail.gmail.com>
References: <364299f40910212314yc2f4f3fjc54b8d3897636be3@mail.gmail.com>
	<1256576579.4929.59.camel@subratamodak.linux.ibm.com>
	<364299f40910261233m30e06594j584387d6de403349@mail.gmail.com>
Date: Tue, 27 Oct 2009 13:03:54 +0530
Message-Id: <1256628834.4957.3.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [New test] ptrace05.c - ptrace(PTRACE_TRACEME, ...) test
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

OK. Thanks. I will test this later and let you know.

Regards--
Subrata

On Mon, 2009-10-26 at 12:33 -0700, Garrett Cooper wrote:
> On Mon, Oct 26, 2009 at 10:02 AM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
> > On Wed, 2009-10-21 at 23:14 -0700, Garrett Cooper wrote:
> >> The following calls ptrace(PTRACE_TRACEME, 0) for all signals and
> >> validates that all signals apart from SIGKILL are properly intercepted
> >> and WIFSTOPPED remains true, and SIGKILL is properly treated as
> >> WIFSIGNALED() && WTERMSIG() returns SIGKILL.
> >>
> >>     1. This test app helped unroot another issue with our custom Linux
> >> platform here at Cisco.
> >>     2. This test application does function properly on a Gentoo Linux
> >> based x86_64 / 2.6.30 kernel however, so it's an issue with our OS
> >> platform.
> >>
> >>     I will add this application to testcases/kernel/syscalls/ptrace,
> >> if someone else sees the value in it. I agree that additional error
> >> checking could be added for the calls to kill(2)... I just whipped
> >> this up in 45 mins after finding this strange behavior on our
> >> platform.
> >>
> >> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> >
> > Just a quick build and test. It fails on my 32 bit and 64 bit X
> > machines:
> 
> I looked at it again this weekend, and my criterion for kill (..., 0)
> was incorrect. The newer version passes, and tests correct criterion,
> as per the manpage:
> 
> ptrace05   23  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 23)
> ptrace05   24  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 24)
> ptrace05   25  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 25)
> ptrace05   26  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 26)
> ptrace05   27  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 27)
> ptrace05   28  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 28)
> ptrace05   29  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 29)
> ptrace05   30  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 30)
> ptrace05   31  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 31)
> ptrace05   32  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 32)
> ptrace05   33  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 33)
> ptrace05   34  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 34)
> ptrace05   35  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 35)
> ptrace05   36  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 36)
> ptrace05   37  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 37)
> ptrace05   38  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 38)
> ptrace05   39  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 39)
> ptrace05   40  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 40)
> ptrace05   41  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 41)
> ptrace05   42  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 42)
> ptrace05   43  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 43)
> ptrace05   44  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 44)
> ptrace05   45  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 45)
> ptrace05   46  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 46)
> ptrace05   47  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 47)
> ptrace05   48  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 48)
> ptrace05   49  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 49)
> ptrace05   50  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 50)
> ptrace05   51  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 51)
> ptrace05   52  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 52)
> ptrace05   53  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 53)
> ptrace05   54  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 54)
> ptrace05   55  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 55)
> ptrace05   56  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 56)
> ptrace05   57  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 57)
> ptrace05   58  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 58)
> ptrace05   59  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 59)
> ptrace05   60  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 60)
> ptrace05   61  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 61)
> ptrace05   62  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 62)
> ptrace05   63  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 63)
> ptrace05   64  TPASS  :  Stopped as expected
> ptrace05    0  TINFO  :  [child] Sending kill(.., 64)
> ptrace05   65  TPASS  :  Stopped as expected
> gcooper@orangebox /scratch/ltp-dev2/ltp $ echo $?
> 0
> 
> /*
>  ******************************************************************************
>  *
>  *   ptrace05 - an app which ptraces itself as per arbitrarily
> specified signals,
>  *   over a user specified range.
>  *
>  *   Copyright (C) 2009, Garrett Cooper
>  *
>  *   This program is free software; you can redistribute it and/or modify
>  *   it under the terms of the GNU General Public License as published by
>  *   the Free Software Foundation; either version 2 of the License, or
>  *   (at your option) any later version.
>  *
>  *   This program is distributed in the hope that it will be useful,
>  *   but WITHOUT ANY WARRANTY; without even the implied warranty of
>  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  *   GNU General Public License for more details.
>  *
>  *   You should have received a copy of the GNU General Public License along
>  *   with this program; if not, write to the Free Software Foundation, Inc.,
>  *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  *
>  ******************************************************************************
>  */
> 
> #include <sys/ptrace.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <signal.h>
> #include <errno.h>
> #include <libgen.h>
> #include <math.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <unistd.h>
> #include "test.h"
> #include "usctest.h"
> 
> char	*TCID		= "ptrace05";
> int	TST_TOTAL	= 0;
> 
> int usage(const char*);
> 
> int
> usage(const char *argv0)
> {
> 	fprintf(stderr, "usage: %s [start-signum] [end-signum]\n", argv0);
> 	return 1;
> }
> 
> int
> main(int argc, char **argv)
> {
> 
> 	int end_signum = -1;
>        	int signum;
> 	int start_signum = -1;
> 	int status;
> 
> 	pid_t child;
> 
> 	/* Parse the CLI args appropriately. */
> 	switch (argc) {
> 	case 3:
> 		end_signum = (int) strtol((const char*) *(argv+2), NULL, 10);
> 		/* Parse the signal value. */
> 		if (end_signum == 0 && errno != 0) {
> 			tst_resm(TBROK, "argument (%s) isn't a valid number.\n",
> 					*(argv+2));
> 			tst_exit();
> 		}
> 		/* FALLTHROUGH */
> 	case 2:
> 		start_signum = (int) strtol((const char*) *(argv+1), NULL, 10);
> 		/* Parse the signal value. */
> 		if (end_signum == 0 && errno != 0) {
> 			tst_resm(TBROK, "argument (%s) isn't a valid number.\n",
> 					*(argv+1) );
> 			tst_exit();
> 		}
> 		break;
> 	case 1:
> 		/* Do nothing. */
> 		break;
> 	default:
> 		return usage(basename(*argv));
> 	}
> 
> 	if (start_signum == -1) {
> 		start_signum = 0;
> 	}
> 	if (end_signum == -1) {
> 		end_signum = SIGRTMAX;
> 	}
> 
> 	for (signum = start_signum; signum <= end_signum; signum++) {
> 
> 		switch (child = fork()) {
> 		case -1:
> 			tst_resm(TBROK | TERRNO, "Failed to fork properly.");
> 			break;
> 		case 0:
> 
> 			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != -1) {
> 				tst_resm(TINFO, "[child] Sending kill(.., %d)",
> 						signum);
> 				if (kill(getpid(), signum) < 0) {
> 					tst_resm(TINFO | TERRNO,
> 						"[child] kill(.., %d) failed.",
> 						signum);
> 				}
> 			} else {
> 
> 				/*
> 				 * This won't increment the TST_COUNT var.
> 				 * properly, but it'll show up as a failure
> 				 * nonetheless.
> 				 */
> 				tst_resm(TFAIL | TERRNO,
> 					"Failed to ptrace(PTRACE_TRACEME, ...) "
> 					"properly");
> 
> 			}
> 			/* Shouldn't get here if signum == 0. */
> 			exit((signum == 0 ? 0 : 2));
> 			break;
> 
> 		default:
> 
> 			waitpid(child, &status, 0);
> 
> 			switch(signum) {
> 			case 0:
> 				if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
> 					tst_resm(TPASS, "kill(.., 0) exited "
> 							"with 0, as expected.");
> 				} else {
> 					tst_resm(TFAIL, "kill(.., 0) didn't exit "
> 							"with 0.");
> 				}
> 				break;
> 			case SIGKILL:
> 				if (WIFSIGNALED(status)) {
> 					/* SIGKILL must be uncatchable. */
> 					if (WTERMSIG(status) == SIGKILL) {
> 						tst_resm(TPASS,
> 							"Killed with SIGKILL, "
> 							"as expected.");
> 					} else {
> 						tst_resm(TPASS,
> 							"Didn't die with "
> 							"SIGKILL (?!) ");
> 					}
> 				} else if (WIFEXITED(status)) {
> 					tst_resm(TFAIL,
> 						"Exited unexpectedly instead "
> 						"of dying with SIGKILL.");
> 				} else if (WIFSTOPPED(status)) {
> 					tst_resm(TFAIL,
> 						"Stopped instead of dying "
> 						"with SIGKILL.");
> 				}
> 				break;
> 			/* All other processes should be stopped. */
> 			default:
> 				if (WIFSTOPPED(status)) {
> 					tst_resm(TPASS, "Stopped as expected");
> 				} else {
> 					tst_resm(TFAIL, "Didn't stop as "
> 							"expected.");
> 					if (kill (child, 0)) {
> 						tst_resm(TINFO,
> 							"Is still alive!?");
> 					} else if (WIFEXITED(status)) {
> 						tst_resm(TINFO,
> 							"Exited normally");
> 					} else if (WIFSIGNALED(status)) {
> 						tst_resm(TINFO,
> 							"Was signaled with "
> 							"signum=%d",
> 							WTERMSIG(status));
> 					}
> 
> 				}
> 
> 				break;
> 
> 			}
> 				
> 		}
> 		/* Make sure the child dies a quick and painless death ... */
> 		kill(child, 9);
> 
> 	}
> 		
> 	tst_exit();
> 
> }


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
