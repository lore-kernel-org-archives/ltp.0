Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QCJ2M-0004Sr-9M
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 22:04:46 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QCJ2L-0005YU-AI
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 22:04:46 +0000
Received: by pwj9 with SMTP id 9so128684pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Apr 2011 15:04:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1460652483.36832.1303236011908.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <BANLkTimn5YKKSb2nVY-va-4-Oz_fH1Z5hA@mail.gmail.com>
	<1460652483.36832.1303236011908.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 19 Apr 2011 15:04:38 -0700
Message-ID: <BANLkTikvFfzQBwq-17_6B1WCmRCmLA67eA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Apr 19, 2011 at 11:00 AM, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>> From: "Garrett Cooper" <yanegomi@gmail.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Tuesday, April 19, 2011 7:40:46 PM
>> Subject: Re: [LTP] [PATCH] cgroups/cgroup_regression_test: fix sporadic failures
>> On Tue, Apr 19, 2011 at 9:31 AM, Jan Stancek <jstancek@redhat.com>
>> wrote:
>> >
>> >
>> > ----- Original Message -----
>> >> From: "Garrett Cooper" <yanegomi@gmail.com>
>> >> To: "Jan Stancek" <jstancek@redhat.com>
>> >> Cc: ltp-list@lists.sourceforge.net
>> >> Sent: Tuesday, April 19, 2011 6:13:48 PM
>> >> Subject: Re: [LTP] [PATCH] cgroups/cgroup_regression_test: fix
>> >> sporadic failures
>> >> On Tue, Apr 19, 2011 at 6:27 AM, Jan Stancek <jstancek@redhat.com>
>> >> wrote:
>> >> >
>> >> > There were failures caused by incomplete cleanup,
>> >> > leaving groups behind after some stress tests.
>> >> > Some stress tests failed to complete upon receiving SIGUSR1.
>> >> >
>> >> > 1. dmesg can rotate and number of found bugs can actually go down
>> >> > clear the buffer before test to avoid this
>> >> >
>> >> > 2. test_5: test should mount 2 subsystems, but mount command
>> >> > says "$subsys" instead of "$subsys2"
>> >> >
>> >> > 3. test_6: test may leave groups behind, fix rmdir
>> >> > to match test_6_1.sh
>> >> >
>> >> > 4. test_7_2: mounts whole cgroup not $subsys
>> >> >
>> >> > 5. test_10: can leave cgroups umounted before cleanup
>> >> > make sure cgroups are mounted before doing cleanup
>> >> >
>> >> > 6. test_*.sh scripts use trap in loop, which may cause bash
>> >> > to miss signal, see
>> >> > https://bugzilla.redhat.com/show_bug.cgi?id=695656
>> >> > move trap outside loop to avoid it
>> >>
>> >> I personally don't have a lot of context into cgroups, but when is
>> >> it acceptable for Linux to send SIGUSR1 when mounting, unmounting,
>> >> or
>> >> removing cgroup directories?
>> >
>> > The main test spawns couple of workers, which run infinite loop and
>> > stress
>> > test some area. SIGUSR1 was chosen by author of test to stop these
>> > workers
>> > after certain amount of time.
>> >
>> > The signal only controls workers, it is not directly related to any
>> > cgroup functionality AFAIK.
>> >
>> > Unfortunetly, when resetting "trap" in bash, signal is ignored for
>> > short period of time, which occasionally hangs the whole test.
>>
>> That just sounds like a cop-out for fixing a bug in bash. Unless
>> the item is documented in bash and/or the POSIX spec prior to that
>> bug, I would just push back on the devs until they fix the shell.
>> Setting signal handlers in a synchronous fashion isn't rocket science.
>> Thanks,
>> -Garrett
>
> I am trying to push them :-). If you look at bz, maintainer is trying
> to get things moving upstream:
> http://www.mail-archive.com/bug-bash@gnu.org/msg09099.html
>
> But at the same time, it seems pointless for test to keep resetting
> signal handler in busy loop, unless it is a bash stress test.
>
> One way or another, bash folks will deal with the issue: fix it or
> document it. Avoiding this problem by moving trap out of loop allows
> people to use test also on older versions.
>
> Or as alternative, I can put in extra "kill -SIGTERM", so even
> when SIGUSR1 gets lost, test will be able to progress.

    Sure. My concern is that there could be other unintended behavior
that crops up because the signal handler is being setup once now
instead of each and every loop. But I also understand your plight...
    FWIW it would be nice to move away from SIGUSR1/SIGUSR2 because I
know people who have hacked the Linux kernel and init in the past to
pass 'special messages' / trigger asynchronous systemwide events with
these signals. Granted, I think they're morons for doing so as
SIGUSR1/SIGUSR2 are general purpose user-defined signals with certain
semantic meaning (in particular dealing with legacy shell and init
behavior), but I was QA at the time and had no real say in what
'design'/hacks they employed to get software out the door.
Thanks,
-Garrett

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
