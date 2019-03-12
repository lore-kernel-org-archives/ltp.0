From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Mar 2019 21:29:57 +0800
Subject: [LTP] [PATCH 1/3] syscalls/tgkill01: add new test
In-Reply-To: <1551943728-16222-2-git-send-email-sumit.garg@linaro.org>
References: <1551943728-16222-1-git-send-email-sumit.garg@linaro.org>
 <1551943728-16222-2-git-send-email-sumit.garg@linaro.org>
Message-ID: <CAEemH2f5qaH+SiJQUkHn=32c9xPMO3YDQDFmH6Aa8HJXEG-4mA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 7, 2019 at 3:29 PM Sumit Garg <sumit.garg@linaro.org> wrote:

> From: Greg Hackmann <ghackmann@google.com>
>
> tgkill() delivers a signal to a specific thread.  Test this by
> installing a SIGUSR1 handler which records the current pthread ID.
> Start a number of threads in parallel, then one-by-one call tgkill(...,
> tid, SIGUSR1) and check that the expected pthread ID was recorded.
>
> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
Reviewed-by: Li Wang <liwang@redhat.com>

This patch set looks pretty good to me. Just have a tiny comments for PATCH
1/3 in below.


> ---
>  runtest/syscalls                            |   2 +
>  testcases/kernel/syscalls/tgkill/.gitignore |   1 +
>  testcases/kernel/syscalls/tgkill/Makefile   |  10 ++
>  testcases/kernel/syscalls/tgkill/tgkill.h   |  22 +++++
>  testcases/kernel/syscalls/tgkill/tgkill01.c | 138
> ++++++++++++++++++++++++++++
>  5 files changed, 173 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/tgkill/.gitignore
>  create mode 100644 testcases/kernel/syscalls/tgkill/Makefile
>  create mode 100644 testcases/kernel/syscalls/tgkill/tgkill.h
>  create mode 100644 testcases/kernel/syscalls/tgkill/tgkill01.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b43de7a..9ed1214 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1395,6 +1395,8 @@ syslog10 syslog10
>  syslog11 syslog11
>  syslog12 syslog12
>
> +tgkill01 tgkill01
> +
>  time01 time01
>  time02 time02
>
> diff --git a/testcases/kernel/syscalls/tgkill/.gitignore
> b/testcases/kernel/syscalls/tgkill/.gitignore
> new file mode 100644
> index 0000000..f4566fd
> --- /dev/null
> +++ b/testcases/kernel/syscalls/tgkill/.gitignore
> @@ -0,0 +1 @@
> +tgkill01
> diff --git a/testcases/kernel/syscalls/tgkill/Makefile
> b/testcases/kernel/syscalls/tgkill/Makefile
> new file mode 100644
> index 0000000..a51080c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/tgkill/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2018 Google, Inc.
> +
> +top_srcdir             ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +LDLIBS                 += -pthread
> diff --git a/testcases/kernel/syscalls/tgkill/tgkill.h
> b/testcases/kernel/syscalls/tgkill/tgkill.h
> new file mode 100644
> index 0000000..a7d96f4
> --- /dev/null
> +++ b/testcases/kernel/syscalls/tgkill/tgkill.h
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2018 Google, Inc.
> + */
> +
> +#ifndef TGKILL_H
> +#define TGKILL_H
> +
> +#include "config.h"
> +#include "lapi/syscalls.h"
> +
> +static inline int sys_tgkill(int tgid, int tid, int sig)
> +{
> +       return tst_syscall(__NR_tgkill, tgid, tid, sig);
> +}
> +
> +static inline pid_t sys_gettid(void)
> +{
> +       return tst_syscall(__NR_gettid);
> +}
> +
> +#endif /* TGKILL_H */
> diff --git a/testcases/kernel/syscalls/tgkill/tgkill01.c
> b/testcases/kernel/syscalls/tgkill/tgkill01.c
> new file mode 100644
> index 0000000..1fb1171
> --- /dev/null
> +++ b/testcases/kernel/syscalls/tgkill/tgkill01.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2018 Google, Inc.
> + *
> + * tgkill() delivers a signal to a specific thread.  Test this by
> installing
> + * a SIGUSR1 handler which records the current pthread ID.  Start a number
> + * of threads in parallel, then one-by-one call tgkill(..., tid, SIGUSR1)
> + * and check that the expected pthread ID was recorded.
> + */
> +
> +#include <pthread.h>
> +
> +#include "tst_safe_pthread.h"
> +#include "tst_test.h"
> +#include "tgkill.h"
> +
> +struct thread_state {
> +       pthread_t thread;
> +       pid_t tid;
> +};
> +
> +static char *str_threads;
> +static int n_threads = 10;
> +static struct thread_state *threads;
> +
> +static pthread_t sigusr1_thread;
> +
> +static int test_running;
> +static pthread_cond_t test_running_cond = PTHREAD_COND_INITIALIZER;
> +static pthread_mutex_t test_running_mutex = PTHREAD_MUTEX_INITIALIZER;
> +
> +static void sigusr1_handler(int signum __attribute__((unused)))
> +{
> +       sigusr1_thread = pthread_self();
> +}
> +
> +static void *thread_func(void *arg)
> +{
> +       struct thread_state *thread = arg;
> +
> +       /**
> +        * There is no standard way to map pthread -> tid, so we will have
> the
> +        * child stash its own tid then notify the parent that the stashed
> tid
> +        * is available.
> +        */
> +       thread->tid = sys_gettid();
> +
> +       TST_CHECKPOINT_WAKE(0);
> +
> +       pthread_mutex_lock(&test_running_mutex);
> +       while (test_running)
> +               pthread_cond_wait(&test_running_cond, &test_running_mutex);
> +       pthread_mutex_unlock(&test_running_mutex);
> +
> +       return arg;
> +}
> +
> +static void start_thread(struct thread_state *thread)
> +{
> +       SAFE_PTHREAD_CREATE(&thread->thread, NULL, thread_func, thread);
> +
> +       TST_CHECKPOINT_WAIT(0);
> +}
> +
> +static void stop_threads(void)
> +{
> +       int i;
> +
> +       test_running = 0;
> +       pthread_cond_broadcast(&test_running_cond);
> +
> +       for (i = 0; i < n_threads; i++) {
> +               if (threads[i].tid == -1)
> +                       continue;
> +
> +               SAFE_PTHREAD_JOIN(threads[i].thread, NULL);
> +               threads[i].tid = -1;
> +       }
>

Maybe we can add free() to release the allocated memory here.

  if (threads)
        free(threads);



> +}
> +
> +static void run(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < n_threads; i++)
> +               threads[i].tid = -1;
> +
> +       test_running = 1;
> +       for (i = 0; i < n_threads; i++)
> +               start_thread(&threads[i]);
> +
> +       for (i = 0; i < n_threads; i++) {
> +               sigusr1_thread = pthread_self();
> +
> +               TEST(sys_tgkill(getpid(), threads[i].tid, SIGUSR1));
> +               if (TST_RET) {
> +                       tst_res(TFAIL | TTERRNO, "tgkill() failed");
> +                       return;
> +               }
> +
> +               while (pthread_equal(sigusr1_thread, pthread_self()))
> +                       usleep(1000);
> +
> +               if (!pthread_equal(sigusr1_thread, threads[i].thread)) {
> +                       tst_res(TFAIL, "SIGUSR1 delivered to wrong
> thread");
> +                       return;
> +               }
> +       }
> +
> +       stop_threads();
>

Since we have set the .cleanup function as stop_threads() in tst_test
struct, I think
we can remove it here.

> +       tst_res(TPASS, "SIGUSR1 delivered to correct threads");
> +}
> +
> +static void setup(void)
> +{
> +       if (tst_parse_int(str_threads, &n_threads, 1, INT_MAX))
> +               tst_brk(TBROK, "Invalid number of threads '%s'",
> str_threads);
> +
> +       threads = SAFE_MALLOC(sizeof(*threads) * n_threads);
> +
> +       struct sigaction sigusr1 = {
> +               .sa_handler = sigusr1_handler,
> +       };
> +       SAFE_SIGACTION(SIGUSR1, &sigusr1, NULL);
> +}
> +
> +static struct tst_option options[] = {
> +       {"t:", &str_threads, "-t       Number of threads (default 10)"},
> +       {NULL, NULL, NULL},
> +};
> +
> +static struct tst_test test = {
> +       .options = options,
> +       .needs_checkpoints = 1,
> +       .setup = setup,
> +       .test_all = run,
> +       .cleanup = stop_threads,
> +};
> --
> 2.7.4
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190312/8ac27a72/attachment.html>
