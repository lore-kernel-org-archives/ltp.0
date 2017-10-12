From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Oct 2017 16:01:11 +0200
Subject: [LTP] [PATCH 2/2] POSIX: Allow pthread_cond_destroy to block
In-Reply-To: <20171009101824.17251-3-rpalethorpe@suse.com>
References: <20171009101824.17251-1-rpalethorpe@suse.com>
 <20171009101824.17251-3-rpalethorpe@suse.com>
Message-ID: <20171012140111.GC21253@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Do I understand this correctly that this is a preemptive fix? Since this
test seems to work fine for me, while the barrier one blocks.

Can we have this kind of information included in the commit message as
well?

>  int main(void)
>  {
> -	pthread_t low_id;
> +	pthread_t low_id, watchdog_thread;
>  	int rc = 0;
>  
> -	/* Create a new thread with default attributes */
>  	rc = pthread_create(&low_id, NULL, thread, NULL);
>  	if (rc != 0) {
> -		printf(ERROR_PREFIX "pthread_create\n");
> +		perror("main: pthread_create");
>  		exit(PTS_UNRESOLVED);
>  	}
>  
> -	/* Let the other thread run */
> -	sleep(2);
> +	sleep(1);
> +
> +	rc = pthread_create(&watchdog_thread, NULL, watchdog, NULL);
> +	if (rc != 0) {
> +		perror("main: pthread_create");
> +		exit(PTS_UNRESOLVED);
> +	}
>  
> -	/* Try to destroy the cond var. This should return an error */
>  	rc = pthread_cond_destroy(&cond);
>  	if (rc != EBUSY) {
> -		printf(ERROR_PREFIX "Test PASS: Expected %d(EBUSY) got %d, "
> -		       "though the standard states 'may' fail\n", EBUSY, rc);
> -
> -		exit(PTS_PASS);
> +		printf("The standard recommends returning %d, EBUSY, but got %d, %s\n",
> +		       EBUSY, rc, strerror(rc));
>  	}

Here as well, I would consider checking either for succes or for EBUSY,
it does not make any sense to return any other error than the one
specified in the standard in a case that we do not return 0.

> +	pthread_cancel(watchdog_thread);
> +	pthread_cancel(low_id);
> +
>  	printf("Test PASSED\n");
>  	exit(PTS_PASS);
>  }
> -- 
> 2.14.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
