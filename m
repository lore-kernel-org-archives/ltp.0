From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Oct 2017 15:34:43 +0200
Subject: [LTP] [PATCH 1/2] POSIX: Allow pthread_barrier_destroy() to
	block
In-Reply-To: <20171009101824.17251-2-rpalethorpe@suse.com>
References: <20171009101824.17251-1-rpalethorpe@suse.com>
 <20171009101824.17251-2-rpalethorpe@suse.com>
Message-ID: <20171012133442.GB21253@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static pthread_barrier_t barrier;
> -static int thread_state;
> +static volatile int thread_state;
>  #define NOT_CREATED_THREAD 1
>  #define ENTERED_THREAD 2
>  #define EXITING_THREAD 3
> +#define WAIT_LOOP 0xFFFFFF
>  
>  static void *fn_chld(void *arg)
>  {
> @@ -42,73 +46,90 @@ static void *fn_chld(void *arg)
>  
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>  
> +	printf("child: barrier wait\n");
>  	thread_state = ENTERED_THREAD;
> +	rc = pthread_barrier_wait(&barrier);
> +	if (rc == PTHREAD_BARRIER_SERIAL_THREAD)
> +		printf("child: got PTHREAD_BARRIER_SERIAL_THREAD\n");
> +	else if (rc != 0)
> +		perror("child: pthread_barrier_wait");
> +	else
> +		printf("child: pthread_barrier_wait returned success");
>  
> -	/* Child should block here */
> -	printf("child: barrier wait\n");
> +	thread_state = EXITING_THREAD;
> +	return arg;
> +}
> +
> +static void *watchdog(void *arg)
> +{
> +	int rc = 0;
> +
> +	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> +
> +	sleep(1);
> +	printf("watchdog: It appears pthread_barrier_destroy() is blocking\n");
>  	rc = pthread_barrier_wait(&barrier);
>  	if (rc != 0 && rc != PTHREAD_BARRIER_SERIAL_THREAD) {
> -		printf("Error: child: pthread_barrier_wait() get unexpected "
> -		       "return code : %d\n", rc);
> +		perror("watchdog: pthread_barrier_wait");
>  		exit(PTS_UNRESOLVED);
> -	} else if (rc == PTHREAD_BARRIER_SERIAL_THREAD) {
> -		printf("child: get PTHREAD_BARRIER_SERIAL_THREAD\n");
>  	}
>  
> -	thread_state = EXITING_THREAD;
> -	pthread_exit(0);
> -	return NULL;
> +	return arg;
>  }
>  
>  int main(void)
>  {
>  	int cnt = 0;
>  	int rc;
> -	pthread_t child_thread;
> +	pthread_t child_thread, watchdog_thread;
>  
>  	printf("main: Initialize barrier with count = 2\n");
>  	if (pthread_barrier_init(&barrier, NULL, 2) != 0) {
> -		printf("main: Error at pthread_barrier_init()\n");
> +		perror("main: pthread_barrier_init");
>  		return PTS_UNRESOLVED;
>  	}
>  
>  	printf("main: create child thread\n");
>  	thread_state = NOT_CREATED_THREAD;
>  	if (pthread_create(&child_thread, NULL, fn_chld, NULL) != 0) {
> -		printf("main: Error at pthread_create()\n");
> +		perror("main: pthread_create");
> +		return PTS_UNRESOLVED;
> +	}
> +
> +	printf("main: create watchdog thread\n");
> +	if (pthread_create(&watchdog_thread, NULL, watchdog, NULL) != 0) {
> +		perror("main: Error at pthread_create");
>  		return PTS_UNRESOLVED;
>  	}
>  
> -	/* Expect the child to block */
>  	cnt = 0;
> -	do {
> -		sleep(1);
> -	} while (thread_state != EXITING_THREAD && cnt++ < 2);
> +	for (cnt = 0; thread_state < ENTERED_THREAD && cnt < WAIT_LOOP; cnt++)
> +		sched_yield();
> +	/* Yield once more to increase the probability that the child thread
> +	 * will call pthread_barrier_wait() before this thread reaches
> +	 * pthread_barrier_destroy().
> +	 */
> +	sched_yield();
>  
>  	if (thread_state == EXITING_THREAD) {
> -		/* child thread did not block */
> -		printf("Test FAILED: child thread did not block on "
> -		       "pthread_barrier_wait()\n");
> +		printf("Test FAILED: child thread did not block on pthread_barrier_wait()\n");
>  		exit(PTS_FAIL);
> -	} else if (thread_state != ENTERED_THREAD) {
> -		printf("Unexpected thread state\n");
> +	} else if (thread_state == NOT_CREATED_THREAD) {
> +		printf("Child thread did not start (quick enough)\n");
>  		exit(PTS_UNRESOLVED);
>  	}
>  
>  	printf("main: destroy barrier while child is waiting\n");
> -
>  	rc = pthread_barrier_destroy(&barrier);
>  
> -	if (rc == EBUSY) {
> -		printf("main: correctly got EBUSY\n");
> -		printf("Test PASSED\n");
> -	} else {
> +	if (rc != EBUSY) {
>  		printf("main: got return code: %d, %s\n", rc, strerror(rc));
> -		printf
> -		    ("Test PASSED: Note*: Expected EBUSY, but standard says 'may' fail.\n");
> +		printf("Note: POSIX recommends returning EBUSY\n");
>  	}
>  
> -	/* Cleanup (cancel thread in case it is still blocking */
> +	printf("Test PASSED\n");

What about we fail the test in a case that we do not get either of
success or EBUSY? I doubt that there is any harm in making this kind of
check here with the watchdog thread in place.

Otherwise the patch looks good.

> +	pthread_cancel(watchdog_thread);
>  	pthread_cancel(child_thread);
>  
>  	return PTS_PASS;
> -- 
> 2.14.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
