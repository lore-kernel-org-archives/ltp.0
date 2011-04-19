Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QCFDn-0006Ls-I1
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 18:00:19 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QCFDm-0002vQ-74
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 18:00:19 +0000
Date: Tue, 19 Apr 2011 14:00:11 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1460652483.36832.1303236011908.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <BANLkTimn5YKKSb2nVY-va-4-Oz_fH1Z5hA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] cgroups/cgroup_regression_test: fix sporadic
 failures
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
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Garrett Cooper" <yanegomi@gmail.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Tuesday, April 19, 2011 7:40:46 PM
> Subject: Re: [LTP] [PATCH] cgroups/cgroup_regression_test: fix sporadic failures
> On Tue, Apr 19, 2011 at 9:31 AM, Jan Stancek <jstancek@redhat.com>
> wrote:
> >
> >
> > ----- Original Message -----
> >> From: "Garrett Cooper" <yanegomi@gmail.com>
> >> To: "Jan Stancek" <jstancek@redhat.com>
> >> Cc: ltp-list@lists.sourceforge.net
> >> Sent: Tuesday, April 19, 2011 6:13:48 PM
> >> Subject: Re: [LTP] [PATCH] cgroups/cgroup_regression_test: fix
> >> sporadic failures
> >> On Tue, Apr 19, 2011 at 6:27 AM, Jan Stancek <jstancek@redhat.com>
> >> wrote:
> >> >
> >> > There were failures caused by incomplete cleanup,
> >> > leaving groups behind after some stress tests.
> >> > Some stress tests failed to complete upon receiving SIGUSR1.
> >> >
> >> > 1. dmesg can rotate and number of found bugs can actually go down
> >> > clear the buffer before test to avoid this
> >> >
> >> > 2. test_5: test should mount 2 subsystems, but mount command
> >> > says "$subsys" instead of "$subsys2"
> >> >
> >> > 3. test_6: test may leave groups behind, fix rmdir
> >> > to match test_6_1.sh
> >> >
> >> > 4. test_7_2: mounts whole cgroup not $subsys
> >> >
> >> > 5. test_10: can leave cgroups umounted before cleanup
> >> > make sure cgroups are mounted before doing cleanup
> >> >
> >> > 6. test_*.sh scripts use trap in loop, which may cause bash
> >> > to miss signal, see
> >> > https://bugzilla.redhat.com/show_bug.cgi?id=695656
> >> > move trap outside loop to avoid it
> >>
> >> I personally don't have a lot of context into cgroups, but when is
> >> it acceptable for Linux to send SIGUSR1 when mounting, unmounting,
> >> or
> >> removing cgroup directories?
> >
> > The main test spawns couple of workers, which run infinite loop and
> > stress
> > test some area. SIGUSR1 was chosen by author of test to stop these
> > workers
> > after certain amount of time.
> >
> > The signal only controls workers, it is not directly related to any
> > cgroup functionality AFAIK.
> >
> > Unfortunetly, when resetting "trap" in bash, signal is ignored for
> > short period of time, which occasionally hangs the whole test.
> 
> That just sounds like a cop-out for fixing a bug in bash. Unless
> the item is documented in bash and/or the POSIX spec prior to that
> bug, I would just push back on the devs until they fix the shell.
> Setting signal handlers in a synchronous fashion isn't rocket science.
> Thanks,
> -Garrett

I am trying to push them :-). If you look at bz, maintainer is trying
to get things moving upstream:
http://www.mail-archive.com/bug-bash@gnu.org/msg09099.html

But at the same time, it seems pointless for test to keep resetting
signal handler in busy loop, unless it is a bash stress test. 

One way or another, bash folks will deal with the issue: fix it or
document it. Avoiding this problem by moving trap out of loop allows
people to use test also on older versions.

Or as alternative, I can put in extra "kill -SIGTERM", so even
when SIGUSR1 gets lost, test will be able to progress.

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
