From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 25 Sep 2019 14:21:36 +0200
Subject: [LTP] [Patch v4] fzsync: revoke thread_b if parent hits
 accidental break
In-Reply-To: <20190925103813.16078-1-liwang@redhat.com>
References: <20190925103813.16078-1-liwang@redhat.com>
Message-ID: <87blv8y3an.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> We shouldn't rely entirely on the pair->exit flag in tst_fzsync_pair_cleanup()
> since there is possible to call tst_brk() at anyplace of thread_a, that will
> lead to timeout eventually because of thread_b(tst_fzsync_wait_b) fall into
> an infinite(no explicit condition to exit) loop.
>
> Thread_a path trace:
>   tst_brk()
>     cleanup()
>       tst_fzsync_pair_cleanup()
>         SAFE_PTHREAD_JOIN(pair->thread_b, NULL)
>         #Or pthread_cancel(pair->thread_b)
>
> We fix the problem via a way to kill thread_b with pthread_cancel. With new
> wrap_run_b involves enabling thread cancel at the start of the thread B,
> then do asynchronous cancellation in tst_fzsync_pair_cleanup if pair->exit
> is not being set to 1.
>
> Workaround: [commit 2e74d996: Check recvmmsg exists before entering fuzzy loop]
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_fuzzy_sync.h | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index f9a1947c7..00c74e951 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -63,6 +63,7 @@
>  #include <time.h>
>  #include <math.h>
>  #include <stdlib.h>
> +#include <pthread.h>
>  #include "tst_atomic.h"
>  #include "tst_timer.h"
>  #include "tst_safe_pthread.h"
> @@ -218,12 +219,36 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
>  static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
>  {
>  	if (pair->thread_b) {
> -		tst_atomic_store(1, &pair->exit);
> +		/* Revoke thread B if parent hits accidental break */
> +		if (!pair->exit) {
> +			tst_atomic_store(1, &pair->exit);
> +			usleep(100000);
> +			pthread_cancel(pair->thread_b);
> +			pair->thread_b = 0;

We still need to join after using cancel, or?

> +			return;
> +		}
>  		SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
>  		pair->thread_b = 0;
>  	}
>  }
>
> +/**
> + * Wrap run_b for tst_fzsync_pair_reset to enable pthread cancel
> + * at the start of the thread B.
> + */
> +static void *wrap_run_b(void *run_b)
> +{
> +       void *(*real_run_b)(void *) = run_b;

The C standard doesn't actually allow this, except maybe C11. See my
other e-mail to patch V3.

> +
> +       if (real_run_b) {
> +	       pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> +	       pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> +	       (*real_run_b)(NULL);
> +       }
> +
> +       return NULL;
> +}
> +
>  /**
>   * Zero some stat fields
>   *
> @@ -272,7 +297,7 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
>  	pair->b_cntr = 0;
>  	pair->exit = 0;
>  	if (run_b)
> -		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
> +		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, wrap_run_b, run_b);
>
>  	pair->exec_time_start = (float)tst_timeout_remaining();
>  }


--
Thank you,
Richard.
