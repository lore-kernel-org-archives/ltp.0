Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VRihu-0007Xp-GS
	for ltp-list@lists.sourceforge.net; Thu, 03 Oct 2013 13:12:42 +0000
Date: Thu, 3 Oct 2013 15:13:06 +0200
From: chrubis@suse.cz
Message-ID: <20131003131306.GA3862@rei.Home>
References: <8803687faf31650b5174df670f07014a7a2f7532.1380794505.git.jstancek@redhat.com>
	<ac99f1c859b7e69d93ed09bc9223f2aabf325a5a.1380794505.git.jstancek@redhat.com>
	<20131003123834.GC3516@rei.Home>
	<997090639.1023118.1380805094088.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <997090639.1023118.1380805094088.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH 3/3] pthread_attr_setschedpolicy/2-1.c: give
 threads a moment to block on mutex
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

Hi!
> > Hmm, so you did hit the small window for race condition between the new
> > thread signals the main thread that it's executed and the next call to
> > the mutex_lock on the tested mutex?
> 
> Yes, I'm assuming this is reason why I see it sporadically failing on
> different distros/kernels. I see it happening the most on IBM z/VM (s390)
> guests which have overcommitted resources, which affects scheduling. 
> 
> It takes longer, but I could trigger it on x86_64 too.

I think that I know where the problem may come from. We are starting the
threads in reverse order by priority, so the lowest one can actually be
preempted by the higher priority one before the lock is taken, which
makes sense.

> > I do not like this solution much, but this is not easy to do properly.
> > One posibility is to pinpoint the threads on one cpu via the affinity()
> > interface (open_posix_testsuite/include/affinity.h) then we can wait in
> > the main thread until the thread with lowest priority is executed and
> > safely say that the rest is locked on the mutex allready (as they run
> > with FIFO scheduling).
> 
> I was considering this too, but there are some problems:
> 
> 1. pthread_setaffinity_np is not portable / sched_setaffinity is Linux only

This is the reason we have the open_posix_testsuite/include/affinity.h,
it's not portable but some test cannot be written without it and it's
implemented on most POSIX OSes, so we keep the unportable chunks in one
place.

> 2. linux default sched_rt_runtime_us gives 0.05s to be used by
>    SCHED_OTHER (non-RT tasks) (Documentation/scheduler/sched-rt-group.txt)
>    If we set also main thread to use SCHED_FIFO, then this shouldn't be problem.

That shouldn't be much of problem, the main thread would pick up once
the realtime threads are locked on mutexes/cond vars. Or am I mistaken
here?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
