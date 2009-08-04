Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYInq-00019B-6b
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:07:38 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYInU-0005TS-OS
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:07:25 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090803120919.GB19594@in.ibm.com>
References: <20090722062905.GA3113@in.ibm.com>
	<20090803120919.GB19594@in.ibm.com>
Date: Tue, 04 Aug 2009 17:36:46 +0530
Message-Id: <1249387616.15587.27.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Remove pidns14 test case
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
To: mohan@in.ibm.com
Cc: ltp-list@lists.sf.net, sukadev@linux.vnet.ibm.com, sachinp@in.ibm.com

Hi Mohan,

On Mon, 2009-08-03 at 17:39 +0530, M. Mohan Kumar wrote: 
> Hi Subrata,
> 
> July LTP release has partially removed pidns14 test case. Still the
> runpidnstest.sh script has reference to pidns14 test case. My patch removed
> all of the references. Could you please remove the reference to pidns14 in
> runpidnstest.sh script also?

Would you please mind resending a patch to do that ?

Regards--
Subrata

> 
> Regards,
> M. Mohan Kumar.
> 
> On Wed, Jul 22, 2009 at 11:59:05AM +0530, M. Mohan Kumar wrote:
> > [PATCH] Remove pidns14 test case
> > Container-init may be immune to unhandled fatal signals (like SIGUSR1)
> > even if they are from ancestor namespace. SIGKILL/SIGSTOP are the only
> > reliable signals to a container-init from ancestor namespace. So remove
> > test case pidns14 from container test suite. Please check git commit id
> > b3bfa0cba867f23365b81658b47efd906830879b for the kernel changes.
> > 
> > Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
> > ---
> >  testcases/kernel/containers/pidns/pidns14.c       |  122 ---------------------
> >  testcases/kernel/containers/pidns/runpidnstest.sh |    6 -
> >  2 files changed, 0 insertions(+), 128 deletions(-)
> >  delete mode 100644 testcases/kernel/containers/pidns/pidns14.c
> > 
> > diff --git a/testcases/kernel/containers/pidns/pidns14.c b/testcases/kernel/containers/pidns/pidns14.c
> > deleted file mode 100644
> > index e95bf95..0000000
> > --- a/testcases/kernel/containers/pidns/pidns14.c
> > +++ /dev/null
> > @@ -1,122 +0,0 @@
> > -/*
> > -* Copyright (c) International Business Machines Corp., 2008
> > -* This program is free software; you can redistribute it and/or modify
> > -* it under the terms of the GNU General Public License as published by
> > -* the Free Software Foundation; either version 2 of the License, or
> > -* (at your option) any later version.
> > -* This program is distributed in the hope that it will be useful,
> > -* but WITHOUT ANY WARRANTY; without even the implied warranty of
> > -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> > -* the GNU General Public License for more details.
> > -* You should have received a copy of the GNU General Public License
> > -* along with this program; if not, write to the Free Software
> > -* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> > -*
> > -***************************************************************************
> > -* * Assertion:
> > -* * kill -USR1 container_init from outside a container
> > -* * 	$ Where init has not defined a custom handler for USR1
> > -* * 	$ Should kill the container
> > -* * 	$ else the test fails.
> > -* *
> > -* * Description:
> > -* *  This testcase creates container and waits till it is awakened by parent.
> > -* *  The parent process sends the SIGUSR1 to container init.
> > -* *  This would invoke default handler & terminate the container init.
> > -* *  In parent process verify, if the SIGUSR1 signal is passed to c-init.
> > -* *  If yes then Test is Passed else Test is Failed.
> > -* *
> > -* * History:
> > -* *  DATE	  NAME				   DESCRIPTION
> > -* *  14/11/08  Veerendra C  <vechandr@in.ibm.com> Verifying kill -USR1 in pidns
> > -*
> > -******************************************************************************/
> > -#include "config.h"
> > -
> > -#define _GNU_SOURCE 1
> > -#include <sys/wait.h>
> > -#include <sys/types.h>
> > -#include <signal.h>
> > -#include <stdlib.h>
> > -#include <unistd.h>
> > -#include <usctest.h>
> > -#include <test.h>
> > -#include <libclone.h>
> > -
> > -char *TCID = "pidns14";
> > -int TST_TOTAL = 1;
> > -
> > -int child_fn(void *);
> > -void cleanup(void);
> > -
> > -#define CHILD_PID	1
> > -#define PARENT_PID	0
> > -
> > -/*
> > - * child_fn() - Inside container
> > - */
> > -int child_fn(void *ttype)
> > -{
> > -	pid_t pid, ppid;
> > -
> > -	/* Set process id and parent pid */
> > -	pid = getpid();
> > -	ppid = getppid();
> > -
> > -	if ((pid != CHILD_PID) || (ppid != PARENT_PID)) {
> > -		tst_resm(TBROK, "pidns is not created.");
> > -		cleanup();
> > -	}
> > -	pause();
> > -	tst_resm(TFAIL, "Oops! Container init resumed after receiving SIGUSR1");
> > -	return -1;
> > -}
> > -
> > -/*
> > - * cleanup() - performs all ONE TIME cleanup for this test at
> > - *			 completion or premature exit.
> > - */
> > -void cleanup()
> > -{
> > -	/* Clean the test testcase as LTP wants*/
> > -	TEST_CLEANUP;
> > -	tst_exit();
> > -
> > -}
> > -
> > -/***********************************************************************
> > -*   M A I N
> > -***********************************************************************/
> > -
> > -int main(int argc, char *argv[])
> > -{
> > -	int status;
> > -	pid_t cpid;
> > -
> > -	cpid = do_clone(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
> > -
> > -	if (cpid < 0) {
> > -		tst_resm(TBROK, "clone() failed.");
> > -		cleanup();
> > -	}
> > -
> > -	sleep(1);
> > -	/* Passing the SIGUSR1 to the container init */
> > -	if (kill(cpid, SIGUSR1) != 0) {
> > -		tst_resm(TBROK, "kill(SIGUSR1) fails.");
> > -		cleanup();
> > -	}
> > -
> > -	sleep(1);
> > -	if (waitpid(cpid, &status, 0) < 0)
> > -		tst_resm(TWARN, "waitpid() failed.");
> > -
> > -	if ((WIFSIGNALED(status)) && (WTERMSIG(status) == SIGUSR1))
> > -		tst_resm(TPASS, "Container init is killed as expected, "
> > -				" when the SIGUSR1 is passed from parent\n");
> > -	 else
> > -		tst_resm(TFAIL, "After sending signal kill -USR1, "
> > -				"returned unexpected error\n");
> > -
> > -	return 0;
> > -}	/* End main */
> > diff --git a/testcases/kernel/containers/pidns/runpidnstest.sh b/testcases/kernel/containers/pidns/runpidnstest.sh
> > index 12d3b34..03fed38 100644
> > --- a/testcases/kernel/containers/pidns/runpidnstest.sh
> > +++ b/testcases/kernel/containers/pidns/runpidnstest.sh
> > @@ -85,12 +85,6 @@ if [ $rc -ne 0 ] && [ -z $err_code ]; then
> >  	err_code=$rc
> >  fi
> >  
> > -pidns14
> > -rc=$?
> > -if [ $rc -ne 0 ] && [ -z $err_code ]; then
> > -	err_code=$rc
> > -fi
> > -
> >  pidns16
> >  rc=$?
> >  if [ $rc -ne 0 ] && [ -z $err_code ]; then
> > -- 
> > 1.6.2.5
> > 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
