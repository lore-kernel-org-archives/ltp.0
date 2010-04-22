Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1O4pbL-0006Nc-48
	for ltp-list@lists.sourceforge.net; Thu, 22 Apr 2010 06:09:27 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O4pbI-0004uE-L9
	for ltp-list@lists.sourceforge.net; Thu, 22 Apr 2010 06:09:27 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3M5rxcD010373
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Apr 2010 01:53:59 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3M69Iao159932
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Apr 2010 02:09:18 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3M69Ix5018646
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Apr 2010 02:09:18 -0400
Date: Thu, 22 Apr 2010 11:39:15 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100422060915.GA4780@linux.vnet.ibm.com>
References: <4B61E7F7.3000502@us.ibm.com>
 <4BCF5EB6.1040005@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4BCF5EB6.1040005@us.ibm.com>
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
To: Darren Hart <dvhltc@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Wed, Apr 21, 2010 at 01:23:18PM -0700, Darren Hart wrote:
> This patch does not appear in current CVS. Please apply.
Hi darren,

Committed
5162b710bfc574107d915093c08b198f0a15727e

Thanks.

-Rishi
> 
> Thanks,
> 
> Darren Hart
> 
> Darren Hart wrote:
> > prio-wake: avoid glibc to kernel sleep race
> > 
> > In the unlocked broadcast scenario, there exists a race between when the
> > running_threads variable reaches rt_threads and when the last worker_thread
> > blocks in the kernel after a cond_wait(). It is possible for a thread to miss
> > the broadcast if it fails to sleep before the broadcast is issued.  
> > 
> > The previous code did not guarantee a small window of time to allow the threads
> > to get to sleep.  It also used an unreasonably large sleep time which
> > unnecessarily extended the length of the test run time.  This patch ensures some
> > time is given to the threads to get to sleep and at the same time uses a much
> > shorter (1000x) sleep period which results in a 50-100x reduction in test run
> > time. Lastly, two unecessary loops waiting for the threads to complete were
> > removed, relying on pthread_join() instead to wait for the threads to complete.
> > 
> > Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
> > Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> > 
> > ---
> >  func/prio-wake/prio-wake.c |   10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > Index: realtime/func/prio-wake/prio-wake.c
> > ===================================================================
> > --- realtime.orig/func/prio-wake/prio-wake.c
> > +++ realtime/func/prio-wake/prio-wake.c
> > @@ -108,7 +108,10 @@ void *master_thread(void* arg)
> > 
> >  	/* make sure children are started */
> >  	while (running_threads < rt_threads)
> > -		sleep(1);
> > +		usleep(1000);
> > +	/* give the worker threads a chance to get to sleep in the kernel
> > +	 * in the unlocked broadcast case. */
> > +	usleep(1000);
> > 
> >  	start = rt_gettime() - beginrun;
> > 
> > @@ -120,8 +123,6 @@ void *master_thread(void* arg)
> >  	if (locked_broadcast)
> >  		rc = pthread_mutex_unlock(&mutex);
> > 
> > -	while (running_threads > 0)
> > -		sleep(1);
> >  	return NULL;
> >  }
> > 
> > @@ -157,9 +158,6 @@ void *worker_thread(void* arg)
> > 
> >  	rc = pthread_mutex_unlock(&mutex);
> > 
> > -	/* wait for all threads to quit */
> > -	while (running_threads > 0)
> > -		sleep(1);
> >  	return NULL;
> >  }
> > 
> 
> 
> -- 
> Darren Hart
> IBM Linux Technology Center
> Real-Time Linux Team
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
