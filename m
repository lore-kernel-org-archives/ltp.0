From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Jan 2019 14:48:15 +0100
Subject: [LTP] [PATCH v2] fzsync: revoke thread_B when parent hit
 accidental break
In-Reply-To: <20190108132618.25965-1-liwang@redhat.com>
References: <20190108132618.25965-1-liwang@redhat.com>
Message-ID: <20190108134815.GC30528@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  include/tst_fuzzy_sync.h | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index de0402c9b..6814d8d34 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -63,6 +63,8 @@
>  #include <time.h>
>  #include <math.h>
>  #include <stdlib.h>
> +#include <pthread.h>
> +#include <errno.h>
>  #include "tst_atomic.h"
>  #include "tst_timer.h"
>  #include "tst_safe_pthread.h"
> @@ -156,7 +158,7 @@ struct tst_fzsync_pair {
>  	int a_cntr;
>  	/** Internal; Atomic counter used by fzsync_pair_wait() */
>  	int b_cntr;
> -	/** Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
> +	/** Internal; Used by tst_fzsync_run_b() to exit normally */
>  	int exit;
>  	/**
>  	 * The maximum desired execution time as a proportion of the timeout
> @@ -217,13 +219,30 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
>   */
>  static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
>  {
> +	int kill_ret;
> +
>  	if (pair->thread_b) {
>  		tst_atomic_store(1, &pair->exit);
> +
> +		kill_ret = pthread_kill(pair->thread_b, 0);
> +		if (kill_ret == 0)
> +			pthread_kill(pair->thread_b, SIGUSR1);
> +		else if (kill_ret == ESRCH)
> +			tst_res(TINFO, "thread_b is not exist");
> +		else if (kill_ret == EINVAL)
> +			tst_res(TINFO, "Invalid signal was specified");
> +
>  		SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
>  		pair->thread_b = 0;
>  	}
>  }
>  
> +static void sighandler(int sig)
> +{
> +	if (sig == SIGUSR1)
> +		pthread_exit(NULL);
> +}

As far as I can tell pthread_exit() is not async-signal-safe, so it
shouldn't be called from signal context.

>  /**
>   * Zero some stat fields
>   *
> @@ -235,6 +254,22 @@ static void tst_init_stat(struct tst_fzsync_stat *s)
>  	s->avg_dev = 0;
>  }
>  
> +/**
> + * Wrap run_b for tst_fzsync_pair_reset to set the singal handler
> + * at the start of the thread B.
> + */
> +static void *wrap_run_b(void * run_b)
> +{
> +	void *(*real_run_b)(void *) = run_b;
> +
> +	if (real_run_b) {
> +		SAFE_SIGNAL(SIGUSR1, sighandler);
> +		(*real_run_b)(NULL);
> +	}
> +
> +	return NULL;
> +}

As far as I can tell the call to signal() will set the signal handler
for all threads in the process, so there is no point in wrapping the run
function like that, we can as well set up the signal handler before we
start the b thread.

>  /**
>   * Reset or initialise fzsync.
>   *
> @@ -272,7 +307,7 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
>  	pair->b_cntr = 0;
>  	pair->exit = 0;
>  	if (run_b)
> -		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
> +		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, wrap_run_b, run_b);
>  
>  	pair->exec_time_start = (float)tst_timeout_remaining();
>  }
> -- 
> 2.14.5
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
