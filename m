Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MxicP-00074H-Bf
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:44:53 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxic8-0003gz-2l
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:44:43 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DEau7Y007173
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 10:36:56 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DEiUHf225328
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 10:44:30 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DEiKE4004093
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 10:44:29 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20091008135038.008f8df7@sripathi.in.ibm.com>
References: <20091008135038.008f8df7@sripathi.in.ibm.com>
Date: Tue, 13 Oct 2009 20:13:47 +0530
Message-Id: <1255445027.8438.69.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] realtime: Remove printing of cpu affinity
	masks	in pi-tests
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
To: Sripathi Kodi <sripathik@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net, gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

On Thu, 2009-10-08 at 13:50 +0530, Sripathi Kodi wrote: 
> Hi,
> 
> Some tests under realtime/func/pi-tests in LTP display junk values for
> cpu affinity masks:
> 
> Start ./testpi-2
> protocol in mutexattr is 1
> Thread 14574 started running with priority 10 on CPU 1110536304
> Thread 14574 at start pthread pol 2 pri 10 - Got global lock
> Thread 14575 started running with prio 20 on CPU 1084272752
> Thread 14576 started running with prio 30 on CPU 1118929008
> Thread 14577 started running with prio 40 on CPU 1127321712
> Noise Thread 14578 started running with prio 40 on CPU 1099915376
> 
> testpi-1 and testpi-4 also report similar wrong values.
> 
> The cause of this problem is the incorrect way in which
> sched_getaffinity output is used in the tests. I think there is no need
> to call getaffinity() to know the cpu mask, because we test the return
> value of setaffinity() before that. The following patch removes all
> calls to sched_affinity() and removes printing cpu affinity masks.
> 
> Thanks,
> Sripathi.
> 
> 
> Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>
> Acked-by: Gowrishankar <gowrishankar.m@in.ibm.com>

Thanks.

Regards--
Subrata

> 
> diff -uprN ltp_org/testcases/realtime/func/pi-tests/testpi-1.c ltp/testcases/realtime/func/pi-tests/testpi-1.c
> --- ltp_org/testcases/realtime/func/pi-tests/testpi-1.c	2009-10-06 23:09:13.000000000 -0700
> +++ ltp/testcases/realtime/func/pi-tests/testpi-1.c	2009-10-06 23:10:10.000000000 -0700
> @@ -91,9 +91,8 @@ void* func_nonrt(void* arg)
>       printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
>       exit(-1);
>    }
> -  rc = sched_getaffinity(0, sizeof(mask), &mask);
> 
> -  printf("Thread %d started running with priority %d on CPU %ld\n", tid, pthr->priority, (long)mask.__bits);
> +  printf("Thread %d started running with priority %d\n", tid, pthr->priority);
>    pthread_mutex_lock(&glob_mutex);
>    printf("Thread %d at start pthread pol %d pri %d - Got global lock\n", tid, pthr->policy, pthr->priority);
>    /* Wait for other RT threads to start up */
> @@ -127,9 +126,8 @@ void* func_rt(void* arg)
>       printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
>       exit(-1);
>    }
> -  rc = sched_getaffinity(0, sizeof(mask), &mask);
> 
> -  printf("Thread %d started running with prio %d on CPU %ld\n", tid, pthr->priority, (long)mask.__bits);
> +  printf("Thread %d started running with prio %d\n", tid, pthr->priority);
>    pthread_barrier_wait(&barrier);
>    pthread_mutex_lock(&glob_mutex);
>    printf("Thread %d at start pthread pol %d pri %d - Got global lock\n", tid, pthr->policy, pthr->priority);
> @@ -167,9 +165,8 @@ void* func_noise(void* arg)
>       printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
>       exit(-1);
>    }
> -  rc = sched_getaffinity(0, sizeof(mask), &mask);
> 
> -  printf("Noise Thread %d started running with prio %d on CPU %ld\n", tid, pthr->priority, (long)mask.__bits);
> +  printf("Noise Thread %d started running with prio %d\n", tid, pthr->priority);
>    pthread_barrier_wait(&barrier);
> 
>    for (i=0;i<10000;i++) {
> @@ -209,7 +206,6 @@ int main(int argc, char* argv[]) {
>       printf("Main Thread: Can't set affinity: %d %s\n", retc, strerror(retc));
>       exit(-1);
>    }
> -  retc = sched_getaffinity(0, sizeof(mask), &mask);
>    for (i=0;i<argc;i++) {
>      if (strcmp(argv[i],"nopi") == 0) nopi = 1;
>    }
> diff -uprN ltp_org/testcases/realtime/func/pi-tests/testpi-2.c ltp/testcases/realtime/func/pi-tests/testpi-2.c
> --- ltp_org/testcases/realtime/func/pi-tests/testpi-2.c	2009-10-06 23:09:13.000000000 -0700
> +++ ltp/testcases/realtime/func/pi-tests/testpi-2.c	2009-10-06 23:10:10.000000000 -0700
> @@ -91,9 +91,8 @@ void* func_lowrt(void* arg)
>       printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
>       exit(-1);
>    }
> -  rc = sched_getaffinity(0, sizeof(mask), &mask);
> 
> -  printf("Thread %d started running with priority %d on CPU %ld\n", tid, pthr->priority, (long)mask.__bits);
> +  printf("Thread %d started running with priority %d\n", tid, pthr->priority);
>    pthread_mutex_lock(&glob_mutex);
>    printf("Thread %d at start pthread pol %d pri %d - Got global lock\n", tid, pthr->policy, pthr->priority);
>    /* Wait for other RT threads to start up */
> @@ -127,9 +126,8 @@ void* func_rt(void* arg)
>       printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
>       exit(-1);
>    }
> -  rc = sched_getaffinity(0, sizeof(mask), &mask);
> 
> -  printf("Thread %d started running with prio %d on CPU %ld\n", tid, pthr->priority, (long)mask.__bits);
> +  printf("Thread %d started running with prio %d\n", tid, pthr->priority);
>    pthread_barrier_wait(&barrier);
>    pthread_mutex_lock(&glob_mutex);
>    printf("Thread %d at start pthread pol %d pri %d - Got global lock\n", tid, pthr->policy, pthr->priority);
> @@ -167,9 +165,8 @@ void* func_noise(void* arg)
>       printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
>       exit(-1);
>    }
> -  rc = sched_getaffinity(0, sizeof(mask), &mask);
> 
> -  printf("Noise Thread %d started running with prio %d on CPU %ld\n", tid, pthr->priority, (long)mask.__bits);
> +  printf("Noise Thread %d started running with prio %d\n", tid, pthr->priority);
>    pthread_barrier_wait(&barrier);
> 
>    for (i=0;i<10000;i++) {
> @@ -208,7 +205,6 @@ int main(int argc, char* argv[]) {
>       printf("Main Thread: Can't set affinity: %d %s\n", retc, strerror(retc));
>       exit(-1);
>    }
> -  retc = sched_getaffinity(0, sizeof(mask), &mask);
> 
>    for (i=0;i<argc;i++) {
>      if (strcmp(argv[i],"nopi") == 0) nopi = 1;
> diff -uprN ltp_org/testcases/realtime/func/pi-tests/testpi-4.c ltp/testcases/realtime/func/pi-tests/testpi-4.c
> --- ltp_org/testcases/realtime/func/pi-tests/testpi-4.c	2009-10-06 23:09:13.000000000 -0700
> +++ ltp/testcases/realtime/func/pi-tests/testpi-4.c	2009-10-06 23:10:10.000000000 -0700
> @@ -92,9 +92,8 @@ void* func_nonrt(void* arg)
>       printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
>       exit(-1);
>    }
> -  rc = sched_getaffinity(0, sizeof(mask), &mask);
> 
> -  printf("Thread %d started running with priority %d on CPU %ld\n", tid, pthr->priority, (long)mask.__bits);
> +  printf("Thread %d started running with priority %d\n", tid, pthr->priority);
>    pthread_mutex_lock(glob_mutex);
>    printf("Thread %d at start pthread pol %d pri %d - Got global lock\n", tid, pthr->policy, pthr->priority);
>    pthread_barrier_wait(&barrier);
> @@ -127,9 +126,8 @@ void* func_rt(void* arg)
>       printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
>       exit(-1);
>    }
> -  rc = sched_getaffinity(0, sizeof(mask), &mask);
> 
> -  printf("Thread %d started running with prio %d on CPU %ld\n", tid, pthr->priority, (long)mask.__bits);
> +  printf("Thread %d started running with prio %d\n", tid, pthr->priority);
>    pthread_barrier_wait(&barrier);
>    pthread_mutex_lock(glob_mutex);
>    printf("Thread %d at start pthread pol %d pri %d - Got global lock\n", tid, pthr->policy, pthr->priority);
> @@ -167,9 +165,8 @@ void* func_noise(void* arg)
>       printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
>       exit(-1);
>    }
> -  rc = sched_getaffinity(0, sizeof(mask), &mask);
> 
> -  printf("Noise Thread started running with prio %d on CPU %ld\n", pthr->priority, (long)mask.__bits);
> +  printf("Noise Thread started running with prio %d\n", pthr->priority);
>    pthread_barrier_wait(&barrier);
> 
>    for (i=0;i<10000;i++) {
> @@ -209,7 +206,6 @@ int main(int argc, char* argv[]) {
>       printf("Main Thread: Can't set affinity: %d %s\n", retc, strerror(retc));
>       exit(-1);
>    }
> -  retc = sched_getaffinity(0, sizeof(mask), &mask);
>    for (i=0;i<argc;i++) {
>      if (strcmp(argv[i],"nopi") == 0) nopi = 1;
>    }
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
