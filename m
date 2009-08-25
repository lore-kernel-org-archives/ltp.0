Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mfsnw-0004wM-Bi
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:59:04 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mfsnl-0003Ac-HM
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:58:59 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7P9vpQv015440
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:57:51 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7P9whUB199324
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:58:43 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7P9wh9g026493
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:58:43 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A93114B.4000809@us.ibm.com>
References: <4A93114B.4000809@us.ibm.com>
Date: Tue, 25 Aug 2009 15:28:27 +0530
Message-Id: <1251194307.5534.28.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH][realtime] prio-wake: enable using more than
	95	threads
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
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Gowrishankar <gowrishankar.m@in.ibm.com>, ltp-list <ltp-list@lists.sourceforge.net>, vernux@us.ibm.com

On Mon, 2009-08-24 at 15:16 -0700, Darren Hart wrote: 
> prio-wake: enable using more than 95 threads
> 
> prio-wake will currently spew pthread errors on systems with more
> than 95 CPUS, or if an -n value > 95 is specified on the command line.
> To avoid this, spread threads out equally over the priorities by
> calculated the number of threads per priority.
> 
> Tested with all pathological numbers (i.e. mod=0 mod=1, etc) of threads.
> Ran 10000 times in parallel.  Confirmed failure continues to exist without
> requeue PI (as it should) and success is seen with requeue PI 
> (as it should be).
> 
> Signed-off-by: Darren Hart <dvhltc@us.ibm.com>

All Patches are in.

Regards--
Subrata

> Acked-By: Dinakar Guniguntala <dino@in.ibm.com>
> Acked-by: Vernon Mauery <vernux@us.ibm.com>
> Acked-by: Gowrishankar <gowrishankar.m@in.ibm.com>
> 
> ---
>  func/prio-wake/prio-wake.c |   24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> Index: realtime/func/prio-wake/prio-wake.c
> ===================================================================
> --- realtime.orig/func/prio-wake/prio-wake.c
> +++ realtime/func/prio-wake/prio-wake.c
> @@ -54,6 +54,8 @@
>  #include <errno.h>
>  #include <sys/syscall.h>
>  #include <librttest.h>
> +#include <libstats.h>
> +
>  volatile int running_threads = 0;
>  static int rt_threads = 0;
>  static int locked_broadcast = 1;
> @@ -164,8 +166,10 @@ void *worker_thread(void* arg)
> 
>  int main(int argc, char* argv[])
>  {
> -	int pri_boost;
> +	int threads_per_prio;
>          int numcpus;
> +	int numprios;
> +	int prio;
>  	int i;
>  	setup();
> 
> @@ -184,19 +188,29 @@ int main(int argc, char* argv[])
>  	printf("Calling pthread_cond_broadcast() with mutex: %s\n\n",
>  	       locked_broadcast ? "LOCKED" : "UNLOCKED");
> 
> -	pri_boost = 3;
> -
>  	beginrun = rt_gettime();
> 
>  	init_pi_mutex(&mutex);
> 
> +	/* calculate the number of threads per priority */
> +	/* we get num numprios -1 for the workers, leaving one for the master */
> +	numprios = sched_get_priority_max(SCHED_FIFO) -
> +		   sched_get_priority_min(SCHED_FIFO);
> +
> +	threads_per_prio = rt_threads /	numprios;
> +	if (rt_threads % numprios)
> +		threads_per_prio++;
> +
>  	/* start the worker threads */
> +	prio = sched_get_priority_min(SCHED_FIFO);
>  	for (i = rt_threads; i > 0; i--) {
> -		create_fifo_thread(worker_thread, (void*)(intptr_t)i, sched_get_priority_min(SCHED_FIFO) + pri_boost++);
> +		if ((i != rt_threads && (i % threads_per_prio) == 0))
> +			prio++;
> +		create_fifo_thread(worker_thread, (void*)(intptr_t)i, prio);
>  	}
> 
>  	/* start the master thread */
> -	create_fifo_thread(master_thread, (void*)(intptr_t)i, sched_get_priority_min(SCHED_FIFO) + pri_boost);
> +	create_fifo_thread(master_thread, (void*)(intptr_t)i, ++prio);
> 
>  	/* wait for threads to complete */
>  	join_threads();


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
