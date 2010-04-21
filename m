Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1O4gSO-0003ba-6z
	for ltp-list@lists.sourceforge.net; Wed, 21 Apr 2010 20:23:36 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O4gSL-0003WR-OG
	for ltp-list@lists.sourceforge.net; Wed, 21 Apr 2010 20:23:36 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3LKDqDY026622
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Apr 2010 14:13:52 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3LKNNLw034152
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Apr 2010 14:23:24 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3LKNJ9x019871
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Apr 2010 14:23:19 -0600
Received: from [9.48.114.117] (sig-9-48-114-117.mts.ibm.com [9.48.114.117])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o3LKNIHl019837
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Apr 2010 14:23:19 -0600
Message-ID: <4BCF5EB6.1040005@us.ibm.com>
Date: Wed, 21 Apr 2010 13:23:18 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
References: <4B61E7F7.3000502@us.ibm.com>
In-Reply-To: <4B61E7F7.3000502@us.ibm.com>
Subject: Re: [LTP] [PATCH] prio-wake: avoid glibc to kernel sleep race
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
To: ltp-list <ltp-list@lists.sourceforge.net>

This patch does not appear in current CVS. Please apply.

Thanks,

Darren Hart

Darren Hart wrote:
> prio-wake: avoid glibc to kernel sleep race
> 
> In the unlocked broadcast scenario, there exists a race between when the
> running_threads variable reaches rt_threads and when the last worker_thread
> blocks in the kernel after a cond_wait(). It is possible for a thread to miss
> the broadcast if it fails to sleep before the broadcast is issued.  
> 
> The previous code did not guarantee a small window of time to allow the threads
> to get to sleep.  It also used an unreasonably large sleep time which
> unnecessarily extended the length of the test run time.  This patch ensures some
> time is given to the threads to get to sleep and at the same time uses a much
> shorter (1000x) sleep period which results in a 50-100x reduction in test run
> time. Lastly, two unecessary loops waiting for the threads to complete were
> removed, relying on pthread_join() instead to wait for the threads to complete.
> 
> Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
> Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> 
> ---
>  func/prio-wake/prio-wake.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> Index: realtime/func/prio-wake/prio-wake.c
> ===================================================================
> --- realtime.orig/func/prio-wake/prio-wake.c
> +++ realtime/func/prio-wake/prio-wake.c
> @@ -108,7 +108,10 @@ void *master_thread(void* arg)
> 
>  	/* make sure children are started */
>  	while (running_threads < rt_threads)
> -		sleep(1);
> +		usleep(1000);
> +	/* give the worker threads a chance to get to sleep in the kernel
> +	 * in the unlocked broadcast case. */
> +	usleep(1000);
> 
>  	start = rt_gettime() - beginrun;
> 
> @@ -120,8 +123,6 @@ void *master_thread(void* arg)
>  	if (locked_broadcast)
>  		rc = pthread_mutex_unlock(&mutex);
> 
> -	while (running_threads > 0)
> -		sleep(1);
>  	return NULL;
>  }
> 
> @@ -157,9 +158,6 @@ void *worker_thread(void* arg)
> 
>  	rc = pthread_mutex_unlock(&mutex);
> 
> -	/* wait for all threads to quit */
> -	while (running_threads > 0)
> -		sleep(1);
>  	return NULL;
>  }
> 


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
