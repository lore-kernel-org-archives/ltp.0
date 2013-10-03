Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VRhwB-0004uM-Sd
	for ltp-list@lists.sourceforge.net; Thu, 03 Oct 2013 12:23:23 +0000
Date: Thu, 3 Oct 2013 14:23:48 +0200
From: chrubis@suse.cz
Message-ID: <20131003122348.GB3516@rei.Home>
References: <8803687faf31650b5174df670f07014a7a2f7532.1380794505.git.jstancek@redhat.com>
	<1f03930f721cfec46a30d523a0447672a1ba6049.1380794505.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1f03930f721cfec46a30d523a0447672a1ba6049.1380794505.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 2/3] pthread_attr_setschedpolicy/2-1.c: fix race
 at thread startup
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
> Test can hang during startup in following scenario:
> 
>                     main                                       new thread
> --------------------------------------------------+-------------------------------------
> int create_thread(int prio, pthread_t * tid)      |
> ...                                               |
>     pthread_create(tid, &attr, thread_func, NULL);|
>         while (!thread_started) {                 |
>                                                   |   void *thread_func(void *data)
>                                                   |        thread_started = 1;
>                                                   |        pthread_cond_signal(&cond);
>             pthread_mutex_lock(&c_mutex);         |
> 132:        pthread_cond_wait(&cond, &c_mutex);   |
>                                                   |65:     pthread_mutex_lock(&mutex);
>                                                   |
> 
> (gdb) bt
>  #0  0x00007fd588808f6d in __lll_lock_wait () from /lib64/libpthread.so.0
>  #1  0x00007fd588804d31 in _L_lock_790 () from /lib64/libpthread.so.0
>  #2  0x00007fd588804c37 in pthread_mutex_lock () from /lib64/libpthread.so.0
>  #3  0x0000000000400bba in thread_func (data=0x0) at ../../../conformance/interfaces/pthread_attr_setschedpolicy/2-1.c:65
>  #4  0x00007fd588802de3 in start_thread () from /lib64/libpthread.so.0
>  #5  0x00007fd5885300dd in clone () from /lib64/libc.so.6
> (gdb) t 2
> (gdb) bt
>  #0  0x00007fd5888066f5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
>  #1  0x0000000000400d9b in create_thread (prio=5, tid=0x7fffdb562678) at ../../../conformance/interfaces/pthread_attr_setschedpolicy/2-1.c:132
>  #2  0x0000000000400e82 in main () at ../../../conformance/interfaces/pthread_attr_setschedpolicy/2-1.c:174
> 
> Fix this by using same c_mutex in thread_func for updating
> thread_started and signalling cond.

Looks good.

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
