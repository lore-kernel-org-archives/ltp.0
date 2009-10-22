Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N0qx2-0004Oe-Qz
	for ltp-list@lists.sourceforge.net; Thu, 22 Oct 2009 06:15:08 +0000
Received: from mail-ew0-f214.google.com ([209.85.219.214])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N0qww-0007Bk-8g
	for ltp-list@lists.sourceforge.net; Thu, 22 Oct 2009 06:15:08 +0000
Received: by ewy10 with SMTP id 10so9213384ewy.33
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Oct 2009 23:14:56 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 21 Oct 2009 23:14:55 -0700
Message-ID: <364299f40910212314yc2f4f3fjc54b8d3897636be3@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [New test] ptrace05.c - ptrace(PTRACE_TRACEME, ...) test
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
To: LTP list <ltp-list@lists.sourceforge.net>

    The following calls ptrace(PTRACE_TRACEME, 0) for all signals and
validates that all signals apart from SIGKILL are properly intercepted
and WIFSTOPPED remains true, and SIGKILL is properly treated as
WIFSIGNALED() && WTERMSIG() returns SIGKILL.

    1. This test app helped unroot another issue with our custom Linux
platform here at Cisco.
    2. This test application does function properly on a Gentoo Linux
based x86_64 / 2.6.30 kernel however, so it's an issue with our OS
platform.

    I will add this application to testcases/kernel/syscalls/ptrace,
if someone else sees the value in it. I agree that additional error
checking could be added for the calls to kill(2)... I just whipped
this up in 45 mins after finding this strange behavior on our
platform.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

/*
 ******************************************************************************
 *
 *   ptrace05 - an app which does PTRACE_TRACEME over the maximum available
 *   signal range, or a set user-defined range.
 *
 *   Copyright (C) 2009, Garrett Cooper
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License along
 *   with this program; if not, write to the Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 ******************************************************************************
 */

#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <errno.h>
#include <libgen.h>
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "test.h"
#include "usctest.h"

char	*TCID		= "ptrace05";
int	TST_TOTAL	= 0;

int usage(const char*);

int
usage(const char *argv0)
{
	fprintf(stderr, "usage: %s [start-signum] [end-signum]\n", argv0);
	return 1;
}

int
main(int argc, char **argv)
{

	int end_signum = -1;
       	int signum;
	int start_signum = -1;
	int status;

	pid_t child;

	/* Parse the CLI args appropriately. */
	switch (argc) {
	case 3:
		end_signum = (int) strtol((const char*) *(argv+2), NULL, 10);
		/* Parse the signal value. */
		if (end_signum == 0 && errno != 0) {
			tst_resm(TBROK, "argument (%s) isn't a valid number.\n",
					*(argv+2));
			tst_exit();
		}
		/* FALLTHROUGH */
	case 2:
		start_signum = (int) strtol((const char*) *(argv+1), NULL, 10);
		/* Parse the signal value. */
		if (end_signum == 0 && errno != 0) {
			tst_resm(TBROK, "argument (%s) isn't a valid number.\n",
					*(argv+1) );
			tst_exit();
		}
		break;
	case 1:
		/* Do nothing. */
		break;
	default:
		return usage(basename(*argv));
	}

	if (start_signum == -1) {
		start_signum = 0;
	}
	if (end_signum == -1) {
		end_signum = SIGRTMAX;
	}

	for (signum = start_signum; signum <= end_signum; signum++) {

		switch (child = fork()) {
		case -1:
			tst_resm(TBROK | TERRNO, "Failed to fork properly.");
			break;
		case 0:

			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != -1) {
				tst_resm(TINFO, "[child] Sending kill(.., %d)",
						signum);
				kill(getpid(), signum);
			} else {

				/*
				 * This won't increment the TST_COUNT var.
				 * properly, but it'll show up as a failure
				 * nonetheless.
				 */
				tst_resm(TFAIL | TERRNO,
					"Failed to ptrace(PTRACE_TRACEME, ...) "
					"properly");

			}
			exit(2); /* Shouldn't get here. */

			break;

		default:

			waitpid(child, &status, 0);

			switch(signum) {

                        /*
                         * SIGKILL should be trigger WIFSIGNALED => `true',
                         * and should return WTERMSIG => SIGKILL
                         */
			case SIGKILL:
				if (WIFSIGNALED(status)) {
					/* SIGKILL must be uncatchable. */
					if (WTERMSIG(status) == SIGKILL) {
						tst_resm(TPASS,
							"Killed with SIGKILL, "
							"as expected.");
					} else {
						tst_resm(TPASS,
							"Didn't die with "
							"SIGKILL (?!) ");
					}
				} else if (WIFEXITED(status)) {
					tst_resm(TFAIL,
						"Exited unexpectedly instead "
						"of dying with SIGKILL.");
				} else if (WIFSTOPPED(status)) {
					tst_resm(TFAIL,
						"Stopped instead of dying "
						"with SIGKILL.");
				}
				break;
			/* All other processes should be stopped. */
			default:
				if (WIFSTOPPED(status)) {
					tst_resm(TPASS, "Stopped as expected");
				} else {
					tst_resm(TFAIL, "Didn't stop as "
							"expected.");
					if (kill (child, 0)) {
						tst_resm(TINFO,
							"Is still alive!?");
					} else if (WIFEXITED(status)) {
						tst_resm(TINFO,
							"Exited normally");
					} else if (WIFSIGNALED(status)) {
						tst_resm(TINFO,
							"Was signaled with "
							"signum=%d",
							WTERMSIG(status));
					}

				}

				break;

			}
				
		}
		/* Make sure the child dies a quick and painless death ... */
		kill(child, 9);

	}
		
	tst_exit();

}

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
