Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VRjEL-00021v-H2
	for ltp-list@lists.sourceforge.net; Thu, 03 Oct 2013 13:46:13 +0000
Date: Thu, 3 Oct 2013 15:46:39 +0200
From: chrubis@suse.cz
Message-ID: <20131003134639.GA4048@rei.Home>
References: <8803687faf31650b5174df670f07014a7a2f7532.1380794505.git.jstancek@redhat.com>
	<ac99f1c859b7e69d93ed09bc9223f2aabf325a5a.1380794505.git.jstancek@redhat.com>
	<20131003123834.GC3516@rei.Home>
	<997090639.1023118.1380805094088.JavaMail.root@redhat.com>
	<20131003131306.GA3862@rei.Home>
	<1572642675.1045335.1380806767492.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572642675.1045335.1380806767492.JavaMail.root@redhat.com>
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
> > > 2. linux default sched_rt_runtime_us gives 0.05s to be used by
> > >    SCHED_OTHER (non-RT tasks) (Documentation/scheduler/sched-rt-group.txt)
> > >    If we set also main thread to use SCHED_FIFO, then this shouldn't be
> > >    problem.
> > 
> > That shouldn't be much of problem, the main thread would pick up once
> > the realtime threads are locked on mutexes/cond vars. Or am I mistaken
> > here?
> 
> (assuming all threads are bound to single CPU)
> That's true, but (the way I understand it) non-rt main thread can also run
> when scheduler thinks that RT processes are monopolizing CPU for too long.

As I understand it, it's a anti lockup measure so if the kernel detects
that realtime threads has been running for nearly a second in a row it
stops the execution and schedules some other threads. But that shouldn't
be the case here.

> So you can't be sure that thread is actually on "mutex".
> 
> thread_func():
>   pthread_mutex_lock(&c_mutex);
>   pthread_cond_signal(&cond);
>   pthread_mutex_unlock(&c_mutex);
> --> here scheduler decides it's time to give a chance to non-rt threads
>     and runs main thread, condition was already signalled so main thinks
>     thread is already blocking on mutex
>   pthread_mutex_lock(&mutex);
> 
> If we set SCHED_FIFO also on main thread with lowest priority, then
> it shouldn't run regardless of value in sched_rt_runtime_us.

That is why I said that we have to wait for the lowest priority thread
to run. Giving the main thread even lower priority is a way of doing
that.

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
