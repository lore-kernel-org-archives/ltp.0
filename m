From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 2 Aug 2021 18:54:32 +0200
Subject: [LTP] [PATCH 1/1] openposix/pthread_cancel/3-1: Move sleep loop
 into separate function
In-Reply-To: <20210802163007.2282-1-pvorel@suse.cz>
References: <20210802163007.2282-1-pvorel@suse.cz>
Message-ID: <CAASaF6y+nGtyH_OGdcJAa-UmnKW_6+HE6ZB=kDyWNpHu_c-Nug@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 2, 2021 at 6:30 PM Petr Vorel <pvorel@suse.cz> wrote:

> to fix warning:
> pthread_cancel/3-1.c:40:13: warning: variable ?waited_for_cancel_ms? might
> be clobbered by ?longjmp? or ?vfork? [-Wclobbered]
>    40 |         int waited_for_cancel_ms = 0;
>
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>

 Acked-by: Jan Stancek <jstancek@redhat.com>

---
>  .../conformance/interfaces/pthread_cancel/3-1.c  | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c
> index 3527d57fd..90500b371 100644
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c
> @@ -35,19 +35,25 @@ static void cleanup_func(PTS_ATTRIBUTE_UNUSED void
> *unused)
>         } while (after_cancel == 0 && thread_sleep_time < TIMEOUT_MS);
>  }
>
> -static void *thread_func(PTS_ATTRIBUTE_UNUSED void *unused)
> +static void sleep_loop(void)
>  {
>         int waited_for_cancel_ms = 0;
>         struct timespec cancel_wait_ts = {0, SLEEP_MS*1000000};
>
> -       SAFE_PFUNC(pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS,
> NULL));
> -       pthread_cleanup_push(cleanup_func, NULL);
> -
> -       SAFE_FUNC(sem_post(&sem));
>         while (waited_for_cancel_ms < TIMEOUT_MS) {
>                 nanosleep(&cancel_wait_ts, NULL);
>                 waited_for_cancel_ms += SLEEP_MS;
>         }
> +}
> +
> +static void *thread_func(PTS_ATTRIBUTE_UNUSED void *unused)
> +{
> +       SAFE_PFUNC(pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS,
> NULL));
> +       pthread_cleanup_push(cleanup_func, NULL);
> +
> +       SAFE_FUNC(sem_post(&sem));
> +
> +       sleep_loop();
>
>         /* shouldn't be reached */
>         printf("Error: cancel never arrived\n");
> --
> 2.32.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210802/45239f35/attachment.htm>
