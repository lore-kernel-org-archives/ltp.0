Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MATUt-0002rg-Vs
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2009 18:41:35 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MATUU-0004FN-Gs
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2009 18:41:33 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4UIbHwT009920
	for <ltp-list@lists.sourceforge.net>; Sat, 30 May 2009 12:37:17 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4UIf9j0241316
	for <ltp-list@lists.sourceforge.net>; Sat, 30 May 2009 12:41:09 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4UIf9fE024891
	for <ltp-list@lists.sourceforge.net>; Sat, 30 May 2009 12:41:09 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810905290819j2eff2629kfda4e11cd4766427@mail.gmail.com>
References: <f5a7b3810905280814gad8b6a4h9c161af8d58a739d@mail.gmail.com>
	<1243601702.5188.38.camel@subratamodak.linux.ibm.com>
	<f5a7b3810905290819j2eff2629kfda4e11cd4766427@mail.gmail.com>
Date: Sun, 31 May 2009 00:11:04 +0530
Message-Id: <1243708864.5556.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] open posix sigaction/10-1.c test fix
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>

Thanks.

Regards--
Subrata

On Fri, 2009-05-29 at 20:49 +0530, naresh kamboju wrote: 
> Hi Subrata,
> 
> Here i have attached patch file sigaction_10-1.patch.
> i am able to patch this by using the command
> as
> #pwd
> /home/naresh/ltp
> ltp#patch -p1<  /patch/sigaction_10-1.patch
> ltp#
> 
> I come across with this kernel issue in 2.6.27
> http://lkml.org/lkml/2008/9/23/218
> http://lkml.org/lkml/2008/9/23/228
> http://lkml.org/lkml/2008/9/24/180
> http://lkml.org/lkml/2008/9/24/186
> http://lkml.org/lkml/2008/9/24/193
> http://lkml.org/lkml/2008/9/24/243
> http://lkml.org/lkml/2008/9/24/247
> 
> 
> Test cases modification noticed for
> ltp/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
> I have modified patch and submitting fix patch.
> This test case is passed now.
> 
> Previous log:
> 
> -bash-3.2# pwd
> /tmp/open_posix_testsuite/conformance/interfaces/sigaction
> -bash-3.2# ./10-1.test
> --> Sending SIGSTOP
> Child has been stopped
> --> Sending SIGCONT
> --> Sending SIGSTOP
> --> Sending SIGCONT
> --> Sending SIGSTOP
> --> Sending SIGCONT
> --> Sending SIGSTOP
> --> Sending SIGCONT
> --> Sending SIGSTOP
> --> Sending SIGCONT
> --> Sending SIGSTOP
> --> Sending SIGCONT
> --> Sending SIGSTOP
> --> Sending SIGCONT
> --> Sending SIGSTOP
> --> Sending SIGCONT
> --> Sending SIGSTOP
> --> Sending SIGCONT
> --> Sending SIGSTOP
> --> Sending SIGCONT
> Test FAILED
> -bash-3.2#
> 
> 
> Current log:
> -bash-3.2# pwd
> /tmp/open_posix_testsuite/conformance/interfaces/sigaction
> --> Sending SIGSTOP
> Child has been stopped
> --> Sending SIGCONT
> Child has been continued
> --> Sending SIGSTOP
> Child has been stopped
> --> Sending SIGCONT
> Child has been continued
> --> Sending SIGSTOP
> Child has been stopped
> --> Sending SIGCONT
> Child has been continued
> --> Sending SIGSTOP
> Child has been stopped
> --> Sending SIGCONT
> Child has been continued
> --> Sending SIGSTOP
> Child has been stopped
> --> Sending SIGCONT
> Child has been continued
> --> Sending SIGSTOP
> Child has been stopped
> --> Sending SIGCONT
> Child has been continued
> --> Sending SIGSTOP
> Child has been stopped
> --> Sending SIGCONT
> Child has been continued
> --> Sending SIGSTOP
> Child has been stopped
> --> Sending SIGCONT
> Child has been continued
> --> Sending SIGSTOP
> Child has been stopped
> --> Sending SIGCONT
> Child has been continued
> --> Sending SIGSTOP
> Child has been stopped
> --> Sending SIGCONT
> Child has been continued
> Test PASSED
> -bash-3.2#
> 
> 
> Original changes done by Oleg Nesterov and Joe Korty
> Modified by: Naresh Kamboju
>  < naresh.kernel@gmail.com >
> 
> Signed-off-by: Naresh Kamboju
> < naresh.kernel@gmail.com >
> 
> Regards
> Naresh
> 
> On Fri, May 29, 2009 at 6:25 PM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
> > On Thu, 2009-05-28 at 20:44 +0530, naresh kamboju wrote:
> >> Hi,
> >>
> >> Original changes done by Oleg Nesterov and Joe Korty
> >> Modified by: Naresh Kamboju < naresh.kernel@gmail.com >
> >>
> >> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
> >
> > Sorry, this fails to apply on the latest CVS.
> >
> > patching file
> > testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
> > Hunk #1 FAILED at 19.
> >
> > Please resend containing the same description.
> >
> > Regards--
> > Subrata
> >
> >>
> >> diff -Naurb ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
> >> ltp-full-20090430_mod/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
> >> --- ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c  2005-06-03
> >> 22:04:51.000000000 +0530
> >> +++ ltp-full-20090430_mod/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c      2009-05-28
> >> 19:25:03.000000000 +0530
> >> @@ -19,19 +19,42 @@
> >>  #define NUMSTOPS 10
> >>
> >>  int child_stopped = 0;
> >> -int waiting = 1;
> >> +int child_continued = 0;
> >> +int notification;
> >>
> >>  void handler(int signo, siginfo_t *info, void *context)
> >>  {
> >> -     if (info && info->si_code == CLD_STOPPED) {
> >> +             if (!info)
> >> +             return;
> >> +
> >> +
> >> +             notification = info->si_code;
> >> +
> >> +             switch (notification) {
> >> +             case CLD_STOPPED:
> >>               printf("Child has been stopped\n");
> >> -             waiting = 0;
> >>               child_stopped++;
> >> +             break;
> >> +             case CLD_CONTINUED:
> >> +             printf("Child has been continued\n");
> >> +             child_continued++;
> >> +             break;
> >>       }
> >>  }
> >>
> >> +void wait_for_notification(int val)
> >> +{
> >> + struct timeval tv;
> >>
> >> -int main()
> >> + while (notification != val) {
> >> + tv.tv_sec = 1;
> >> + tv.tv_usec = 0;
> >> + if (!select(0, NULL, NULL, NULL, &tv))
> >> + break;
> >> + }
> >> +}
> >> +
> >> +int main(void)
> >>  {
> >>       pid_t pid;
> >>       struct sigaction act;
> >> @@ -58,25 +81,25 @@
> >>               int i;
> >>
> >>               for (i = 0; i < NUMSTOPS; i++) {
> >> -                     waiting = 1;
> >> -
> >>                       printf("--> Sending SIGSTOP\n");
> >> +                     notification = 0;
> >>                       kill(pid, SIGSTOP);
> >>
> >>                       /*
> >>                         Don't let the kernel optimize away queued
> >>                         SIGSTOP/SIGCONT signals.
> >>                       */
> >> -                     while (waiting) {
> >> -                             tv.tv_sec = 1;
> >> -                             tv.tv_usec = 0;
> >> -                             if (!select(0, NULL, NULL, NULL, &tv))
> >> -                               break;
> >> -                     }
> >>
> >> +                     wait_for_notification(CLD_STOPPED);
> >>
> >>                       printf("--> Sending SIGCONT\n");
> >> +                     notification = 0;
> >>                       kill(pid, SIGCONT);
> >> +                     /*
> >> +                      SIGCHLD doesn't queue, make sure CLD_CONTINUED
> >> +                      doesn't mask the next CLD_STOPPED
> >> +                      */
> >> +                      wait_for_notification(CLD_CONTINUED);
> >>               }
> >>
> >>               /* POSIX specifies default action to be abnormal termination */
> >> @@ -84,7 +107,7 @@
> >>               waitpid(pid, &s, 0);
> >>       }
> >>
> >> -     if (child_stopped == NUMSTOPS) {
> >> +     if (child_stopped == NUMSTOPS && child_continued == NUMSTOPS) {
> >>               printf("Test PASSED\n");
> >>               return 0;
> >>       }
> >> @@ -92,4 +115,3 @@
> >>       printf("Test FAILED\n");
> >>       return -1;
> >>  }
> >> -
> >> Best regards,
> >> Naresh Kamboju
> >
> >


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
