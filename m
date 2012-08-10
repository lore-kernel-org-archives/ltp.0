Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SzmMj-0005wo-So
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 10:22:49 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzmMh-0003Bs-MX
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 10:22:49 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7AAMfYC028155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Aug 2012 06:22:41 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q7AAMeSY031928
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Aug 2012 06:22:41 -0400
Message-ID: <5024E0F0.3080406@redhat.com>
Date: Fri, 10 Aug 2012 12:22:40 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <1344508258-25054-1-git-send-email-kai.kang@windriver.com>
	<1344508258-25054-2-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1344508258-25054-2-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH 1/3] pthread_cond_signal/1-1: use sched_yield to
 sync	threads
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
To: ltp-list@lists.sourceforge.net

Hi,

Here's a different proposal: don't count how many pthread_cond_signals it took,
if any fails SIGALRM will trigger testcase failure.

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
index bf55b31..266d42f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
@@ -134,9 +134,7 @@ int main()
 	alarm(5);
 
 	/* loop to wake up the rest threads */
-	i=0;
-	while (waken_num < THREAD_NUM) {
-		++i;
+	for (i=1; i<THREAD_NUM; i++) {
 		fprintf(stderr,"[Main thread] signals to wake up the next thread\n");
 		if (pthread_cond_signal(&td.cond) != 0) {
 			fprintf(stderr,"Main failed to signal the condition\n");
@@ -145,12 +143,6 @@ int main()
 		usleep(100);
 	}
 
-	if (i >= THREAD_NUM) {
-		fprintf(stderr,"[Main thread] had to signal the condition %i times\n", i+1);
-		fprintf(stderr,"[Main thread] to wake up %i threads\n. Test FAILED.\n", THREAD_NUM);
-		exit(PTS_FAIL);
-	}
-
 	/* join all secondary threads */
 	for (i=0; i<THREAD_NUM; i++) {
 	    	if (pthread_join(thread[i], NULL) != 0) {

Regards,
Jan

On 08/09/2012 12:30 PM, Kang Kai wrote:
> This case fails on mips board routerstation randomly. The root cause is
> that when main thread call usleep(100) after signal the child threads,
> no child thread is scheduled to run.  So the case fails.
> 
> I update it to set main thread with a lower priority and child threads
> with a higher one, then call sched_yield and usleep in main thread will
> make sure that one of the child threads will be scheduled.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  .../interfaces/pthread_cond_signal/1-1.c           |   44 +++++++++++++++++++-
>  1 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> index bf55b31..77374bf 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> @@ -12,6 +12,7 @@
>  
>  #define _XOPEN_SOURCE 600
>  
> +#include <errno.h>
>  #include <pthread.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -20,6 +21,7 @@
>  #include "posixtest.h"
>  
>  #define THREAD_NUM  3
> +#define SCHED_POLICY SCHED_FIFO
>  
>  struct testdata
>  {
> @@ -77,6 +79,10 @@ int main()
>  {
>  	int i, rc;
>  	struct sigaction act;
> +	int pid;
> +	int policy;
> +	struct sched_param param;
> +	pthread_attr_t attr;
>  
>  	if (pthread_mutex_init(&td.mutex, NULL) != 0) {
>  		fprintf(stderr,"Fail to initialize mutex\n");
> @@ -87,8 +93,35 @@ int main()
>  		return PTS_UNRESOLVED;
>  	}
>  
> +	pid = getpid();
> +	param.sched_priority = sched_get_priority_min(SCHED_POLICY);
> +	if (sched_setscheduler(pid, SCHED_POLICY, &param) != 0) {
> +		fprintf(stderr, "Fail to set main thread scheduler.\n");
> +		if (errno == EPERM)
> +			fprintf(stderr, "Failed with EPERM: are you root?\n");
> +		return PTS_UNRESOLVED;
> +	}
> +
> +	if (pthread_attr_init(&attr) != 0) {
> +		fprintf(stderr, "Fail to init child thread attribute.\n");
> +		return PTS_UNRESOLVED;
> +	}
> +	if (pthread_attr_setschedpolicy(&attr, SCHED_POLICY) != 0) {
> +		fprintf(stderr, "Fail to set child thread schedule policy attribute.\n");
> +		return PTS_UNRESOLVED;
> +	}
> +	param.sched_priority += 10;
> +	if (pthread_attr_setschedparam(&attr, &param) != 0) {
> +		fprintf(stderr, "Fail to set child thread schedule priority attribute.\n");
> +		return PTS_UNRESOLVED;
> +	}
> +	if (pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED) != 0) {
> +		fprintf(stderr, "Fail to set child thread inheritace attribute.\n");
> +		return PTS_UNRESOLVED;
> +	}
> +
>  	for (i=0; i<THREAD_NUM; i++) {	/* create THREAD_NUM threads */
> -	    	if (pthread_create(&thread[i], NULL, thr_func, NULL) != 0) {
> +		if (pthread_create(&thread[i], &attr, thr_func, NULL) != 0) {
>  			fprintf(stderr,"Fail to create thread[%d]\n", i);
>  			exit(PTS_UNRESOLVED);
>  		}
> @@ -96,6 +129,8 @@ int main()
>  	while (start_num < THREAD_NUM)	/* waiting for all threads started */
>  		usleep(100);
>  
> +	pthread_attr_destroy(&attr);
> +
>  	/* Acquire the mutex to make sure that all waiters are currently
>  	   blocked on pthread_cond_wait */
>  	if (pthread_mutex_lock(&td.mutex) != 0) {
> @@ -142,6 +177,7 @@ int main()
>  			fprintf(stderr,"Main failed to signal the condition\n");
>  			exit(PTS_UNRESOLVED);
>  		}
> +		sched_yield();
>  		usleep(100);
>  	}
>  
> @@ -158,6 +194,10 @@ int main()
>  			exit(PTS_UNRESOLVED);
>  		}
>  	}
> +
> +	pthread_mutex_destroy(&td.mutex);
> +	pthread_cond_destroy(&td.cond);
> +
>  	printf("Test PASSED\n");
>  	return PTS_PASS;
> -}
> \ No newline at end of file
> +}


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
