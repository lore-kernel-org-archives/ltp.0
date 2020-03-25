From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 25 Mar 2020 14:52:50 +0100
Subject: [LTP] [PATCH] Fix use after stack unwind in fzsync lib
In-Reply-To: <20200325103734.31295-1-mdoucha@suse.cz>
References: <20200325103734.31295-1-mdoucha@suse.cz>
Message-ID: <875zeszglp.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Martin Doucha <mdoucha@suse.cz> writes:

> tst_fzsync_pair_reset() passes a local variable to thread B which may be
> already unwinded by the time the thread wrapper function executes. If new
> variables get allocated and initialized on stack between pthread_create()
> and thread wrapper execution, thread B will segfault.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  include/tst_fuzzy_sync.h | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index c1d0b00f9..32b9859a0 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -242,11 +242,14 @@ struct tst_fzsync_run_thread {
>   */
>  static void *tst_fzsync_thread_wrapper(void *run_thread)
>  {
> -       struct tst_fzsync_run_thread t = *(struct tst_fzsync_run_thread *)run_thread;
> +       struct tst_fzsync_run_thread *t = run_thread;
> +       void *ret;
>  
>         pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>         pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
> -       return t.func(t.arg);
> +       ret = t->func(t->arg);
> +       free(t);

Why not use SAFE_FREE?

> +       return ret;
>  }
>  
>  /**
> @@ -297,8 +300,12 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
>  	pair->b_cntr = 0;
>  	pair->exit = 0;
>  	if (run_b) {
> -		struct tst_fzsync_run_thread wrap_run_b = {.func = run_b, .arg = NULL};
> -		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, tst_fzsync_thread_wrapper, &wrap_run_b);
> +		struct tst_fzsync_run_thread *wrap_run_b;
> +
> +		wrap_run_b = SAFE_MALLOC(sizeof(struct tst_fzsync_run_thread));
> +		wrap_run_b->func = run_b;
> +		wrap_run_b->arg = NULL;
> +		SAFE_PTHREAD_CREATE(&pair->thread_b, 0,
>  tst_fzsync_thread_wrapper, wrap_run_b);

I suppose there is a memory leak here if thread create fails, but we
probably don't care because the test will exit shortly afterwards.

>  	}
>  
>  	pair->exec_time_start = (float)tst_timeout_remaining();


-- 
Thank you,
Richard.
