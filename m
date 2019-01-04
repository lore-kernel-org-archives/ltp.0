From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 04 Jan 2019 16:02:54 +0100
Subject: [LTP] [PATCH RFC] fzsync: tst_fzsync_pair_wait exit when parent
	hit accidental break
In-Reply-To: <20190104095256.12266-1-liwang@redhat.com>
References: <20190104095256.12266-1-liwang@redhat.com>
Message-ID: <878t00mpnl.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> For system(rhel7.6, s390x) without __NR_recvmmsg supported, run
> cve-2016-7117 result in timeout and killed by LTP framework. The
> root reason is tst_syscall break with cleanup() function calling
> in this trace path:
>
>   tst_syscall(__NR_recvmmsg, ...)
>     tst_brk()
>       cleanup()
>         tst_fzsync_pair_cleanup()
>           SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
>
> cve-2016-7117 hung at here to wait for thread_b send_and_close() finishing.
> But thread_b fall into infinite loop because of tst_fzsync_wait_b without
> an extra condition to exit. Eventually, test get timeout error like:
>
>   cve-2016-7117.c:145: CONF: syscall(-1) __NR_recvmmsg not supported
>   Test timeouted, sending SIGKILL!
>   tst_test.c:1125: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
>   tst_test.c:1126: BROK: Test killed! (timeout?)
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  include/tst_fuzzy_sync.h | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index de0402c9b..7e4d48f0a 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -517,7 +517,8 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
>   * @return A non-zero value if the thread should continue otherwise the
>   * calling thread should exit.
>   */
> -static inline void tst_fzsync_pair_wait(int *our_cntr,
> +static inline void tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
> +					int *our_cntr,
>  					int *other_cntr,
>  					int *spins)
>  {
> @@ -530,7 +531,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
>  		 * then our counter may already have been set to zero.
>  		 */
>  		while (tst_atomic_load(our_cntr) > 0
> -		       && tst_atomic_load(our_cntr) < INT_MAX) {
> +		       && tst_atomic_load(our_cntr) < INT_MAX
> +		       && !tst_atomic_load(&pair->exit)) {
>  			if (spins)
>  				(*spins)++;
>  		}
> @@ -540,14 +542,16 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
>  		 * Once both counters have been set to zero the invariant
>  		 * is restored and we can continue.
>  		 */
> -		while (tst_atomic_load(our_cntr) > 1)
> +		while (tst_atomic_load(our_cntr) > 1
> +			&& !tst_atomic_load(&pair->exit))
>  			;
>  	} else {
>  		/*
>  		 * If our counter is less than the other thread's we are ahead
>  		 * of it and need to wait.
>  		 */
> -		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)) {
> +		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)
> +			&& !tst_atomic_load(&pair->exit)) {
>  			if (spins)
>  				(*spins)++;
>  		}

This is how it worked before, so it is fairly safe. However I don't like
atomically checking for the exit value on every spin of the delay
loop. Also because setting exit just causes it to drop through there is
still the (theoretical) risk of it getting stuck on another operation
before breaking out of thread B's main loop.

Also removing the exit variable makes formal verification a bit easier.

Another option might be to use pthread_kill with a realtime signal and
a signal handler which immediately exits the current thread. I am not
sure how much complexity that will introduce though?

--
Thank you,
Richard.
