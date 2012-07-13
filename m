Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SpgI6-0007cS-5O
	for ltp-list@lists.sourceforge.net; Fri, 13 Jul 2012 13:52:18 +0000
Date: Fri, 13 Jul 2012 15:07:45 +0200
From: chrubis@suse.cz
Message-ID: <20120713130745.GA8634@saboteur.suse.cz>
References: <1342086687-5242-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1342086687-5242-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] pthread_cond_signal/1-1: use sched_yield to
 schedule child threads
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Zhenfeng.Zhao@windriver.com

Hi!
> This case fails on mips board routerstation randomly. The root cause is
> that when main thread call usleep(100) after signal the child threads,
> no child thread is scheduled to run.  So the case fails.
> 
> I update it to set main thread with a lower priority and child threads
> with a higher one, then when sched_yield is called in main thread, one
> of the child threads will be scheduled and run.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  .../interfaces/pthread_cond_signal/1-1.c           |   55 ++++++++++++++++++--
>  1 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> index bf55b31..51c0cfb 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #define _XOPEN_SOURCE 600
> +#define _GNU_SOURCE

This is open posix testsuite keep that in mind so inserting _GNU_SOURCE
is not allowed here.

>  #include <pthread.h>
>  #include <stdio.h>
> @@ -18,6 +19,7 @@
>  #include <unistd.h>
>  #include <signal.h>
>  #include "posixtest.h"
> +#include "affinity.h"
>  
>  #define THREAD_NUM  3
>  
> @@ -77,6 +79,18 @@ int main()
>  {
>  	int i, rc;
>  	struct sigaction act;
> +	int pid;
> +	int policy;
> +	struct sched_param param;
> +	pthread_attr_t attr;
> +
> +	if (getuid() != 0)
> +	{
> +		fprintf(stderr, "Run this test as root, not as a Regular User\n");
> +		return PTS_UNTESTED;
> +	}

Wrong coding style. The opening brace should be at the end of the if
statement. Please use checkpatch.pl on your patches.

And also I think that the check is not 100% correct, the POSIX says that
schedulling priorities and so may be changed "if calling process has
permission to...", there are capabilities and other mechanisms to check
for that. The rest of the testcases seems to deal with this just by
printing a hint after first call has that may need the priviledge
failed, for example:

"foo failed with -1: are you root?"

> +	set_affinity(0);

I setting affinity really needed here? (I'm just asking before it wasn't
described in the commit description).

>  	if (pthread_mutex_init(&td.mutex, NULL) != 0) {
>  		fprintf(stderr,"Fail to initialize mutex\n");
> @@ -87,14 +101,41 @@ int main()
>  		return PTS_UNRESOLVED;
>  	}
>  
> +	pid = getpid();
> +	param.sched_priority = sched_get_priority_min(SCHED_FIFO);
> +	if (sched_setscheduler(pid, SCHED_FIFO, &param) != 0) {
> +		fprintf(stderr, "Fail to set main thread scheduler.\n");
> +		return PTS_UNRESOLVED;
> +	}
> +
> +	if (pthread_attr_init(&attr) != 0) {
> +		fprintf(stderr, "Fail to init child thread attribute.\n");
> +		return PTS_UNRESOLVED;
> +	}
> +	if (pthread_attr_setschedpolicy(&attr, SCHED_FIFO) != 0) {
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
>  	}
>  	while (start_num < THREAD_NUM)	/* waiting for all threads started */
> -		usleep(100);
> +		sched_yield();

Hmm, I've been burned by:

while (xxx)
	sched_yield();

code before. In certain situations this translates just to bussy loops,
so most of the time small sleep or both sleep and sched_yield may be
better.

> +	pthread_attr_destroy(&attr);
>  
>  	/* Acquire the mutex to make sure that all waiters are currently
>  	   blocked on pthread_cond_wait */
> @@ -114,7 +155,7 @@ int main()
>  		fprintf(stderr,"[Main thread] failed to signal the condition\n");
>  		exit(PTS_UNRESOLVED);
>  	}
> -	sleep(1);
> +	sched_yield();
>  	if (waken_num <= 0) {
>  		fprintf(stderr,"[Main thread] but no waiters were wakened\n");
>                  printf("Test FAILED\n");
> @@ -142,7 +183,7 @@ int main()
>  			fprintf(stderr,"Main failed to signal the condition\n");
>  			exit(PTS_UNRESOLVED);
>  		}
> -		usleep(100);
> +		sched_yield();
>  	}
>  
>  	if (i >= THREAD_NUM) {
> @@ -158,6 +199,10 @@ int main()
>  			exit(PTS_UNRESOLVED);
>  		}
>  	}
> +
> +	pthread_mutex_destroy(&td.mutex);
> +	pthread_cond_destroy(&td.cond);;
> +
>  	printf("Test PASSED\n");
>  	return PTS_PASS;
> -}
> \ No newline at end of file
> +}

And as far as I remeber the original problem was that some of the
threads failed to wake up because the while loop that wakes them was too
tight. Does inserting sched_yield() there help?

-- 
Cyril Hrubis
chrubis@suse.cz

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
