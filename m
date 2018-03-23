From: Erick Reyes <erickreyes@google.com>
Date: Fri, 23 Mar 2018 13:57:15 -0700
Subject: [LTP] [PATCH] Make floating point tests Android-compatible
In-Reply-To: <CAFt2AZUhp9tuWOVd-t-ij-eG-21+DEqeXE5XCwK=tQ8DmOnAgg@mail.gmail.com>
References: <CAFt2AZUhp9tuWOVd-t-ij-eG-21+DEqeXE5XCwK=tQ8DmOnAgg@mail.gmail.com>
Message-ID: <CAFt2AZVFWwZt1JD0kZ-5s0SGkAbwo_igiDKJzkus-0sjQk_ARw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Any chance this can be reviewed? This would add support for 4 tests on
Android.

Thanks

On Wed, Feb 21, 2018 at 11:48 AM, Erick Reyes <erickreyes@google.com> wrote:

> Android does not implement pthread_cancel. The function is replaced
> by a no-op in a compatibility header. In most cases, the only side
> effect is that threads cannot be interrupted and have to exit normally.
> However, floating point tests are calling pthread_cancel and waiting for
> a thread doing pthread_sigwait to be finished (Which will never happen).
>
> This patch implements the same logic using pthread_kill with SIGUSR2
> instead, allowing the tests to run under Android.
>
> Signed-off-by: Erick Reyes <erickreyes@google.com>
> ---
>  testcases/misc/math/float/main.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/misc/math/float/main.c b/testcases/misc/math/float/
> main.c
> index d71ca18e6..64d1475e4 100644
> --- a/testcases/misc/math/float/main.c
> +++ b/testcases/misc/math/float/main.c
> @@ -115,6 +115,18 @@ int main(int argc, char *argv[])
>   /*int time=1; */
>   int i;
>
> + sigset_t signals_set;
> +
> + /*
> + * Use SIGUSR2 to terminate our signal handler
> + */
> + sigemptyset(&signals_set);
> + sigaddset(&signals_set, SIGUSR2);
> +
> + retval = pthread_sigmask(SIG_BLOCK, &signals_set, NULL);
> + if (retval != 0)
> + sys_error("main : pthread_sigmask FAILED", __LINE__);
> +
>   /* Generate test ID from invocation name */
>   if ((TCID = strrchr(argv[0], '/')) != NULL)
>   TCID++;
> @@ -299,7 +311,7 @@ finished:
>   SAFE_FREE(pcom);
>
>   }
> - pthread_cancel(sig_hand);
> + pthread_kill(sig_hand, SIGUSR2);
>   pthread_join(sig_hand, NULL);
>   SAFE_FREE(tabcom);
>   SAFE_FREE(threads);
> @@ -338,6 +350,7 @@ static void *handle_signals(void *arg)
>   sigaddset(&signals_set, SIGQUIT);
>   sigaddset(&signals_set, SIGTERM);
>   sigaddset(&signals_set, SIGUSR1);
> + sigaddset(&signals_set, SIGUSR2);
>   sigaddset(&signals_set, SIGALRM);
>   while (1) {
>   if (debug)
> @@ -348,6 +361,11 @@ static void *handle_signals(void *arg)
>   tst_resm(TINFO, "Signal handler caught signal %d", sig);
>
>   switch (sig) {
> + case SIGUSR2:
> +     if (debug)
> + tst_resm(TINFO, "Signal handler received termination request, exiting");
> +     pthread_exit(NULL);
> +     break;
>   case SIGALRM:
>   case SIGUSR1:
>   case SIGINT:
> --
> 2.16.1.291.g4437f3f132-goog
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180323/baac9241/attachment.html>
