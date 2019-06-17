From: Li Wang <liwan@redhat.com>
Date: Mon, 17 Jun 2019 16:05:50 +0800
Subject: [LTP] [PATCH v2] syscalls/tgkill03: wait for defunct tid to get
	detached
In-Reply-To: <ae6204b13cf5d2a8e2ebefd4ff448c33deeb26fd.1560756614.git.jstancek@redhat.com>
References: <ae6204b13cf5d2a8e2ebefd4ff448c33deeb26fd.1560756614.git.jstancek@redhat.com>
Message-ID: <CAEemH2dRpyPDJ2m0soKLumhY50RFypRHnihfzqUyc-GA-pfBgg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 17, 2019 at 3:34 PM Jan Stancek <jstancek@redhat.com> wrote:

> Case where defunct tid is used has been observed to sporadically fail:
>   tgkill03.c:96: FAIL: Defunct tid should have failed with ESRCH: SUCCESS
>
> glibc __pthread_timedjoin_ex() waits for CLONE_CHILD_CLEARTID to clear tid,
> and then resumes. Kernel clears it (glibc pd->tid) at:
>   do_exit
>     exit_mm
>       mm_release
>         put_user(0, tsk->clear_child_tid);
>
> but kernel tid is still valid, presumably until:
>   release_task
>     __exit_signal
>       __unhash_process
>         detach_pid
>
> To avoid race wait until /proc/<pid>/task/<tid> disappears.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/tgkill/tgkill03.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Changes in v2:
>   - use helper func suggested by Li (with higher timeout)
>   - not tested, trying to get s390x to confirm
>
> diff --git a/testcases/kernel/syscalls/tgkill/tgkill03.c
> b/testcases/kernel/syscalls/tgkill/tgkill03.c
> index f5bbdc5a8d4e..ce046f576b5f 100644
> --- a/testcases/kernel/syscalls/tgkill/tgkill03.c
> +++ b/testcases/kernel/syscalls/tgkill/tgkill03.c
> @@ -7,6 +7,7 @@
>
>  #include <pthread.h>
>  #include <pwd.h>
> +#include <stdio.h>
>  #include <sys/types.h>
>
>  #include "tst_safe_pthread.h"
> @@ -42,6 +43,7 @@ static void setup(void)
>  {
>         sigset_t sigusr1;
>         pthread_t defunct_thread;
> +       char defunct_tid_path[PATH_MAX];
>
>         sigemptyset(&sigusr1);
>         sigaddset(&sigusr1, SIGUSR1);
> @@ -55,8 +57,9 @@ static void setup(void)
>         TST_CHECKPOINT_WAIT(0);
>
>         SAFE_PTHREAD_CREATE(&defunct_thread, NULL, defunct_thread_func,
> NULL);
> -
>         SAFE_PTHREAD_JOIN(defunct_thread, NULL);
> +       sprintf(defunct_tid_path, "/proc/%d/task/%d", getpid(),
> defunct_tid);
> +       TST_RETRY_FN_EXP_BACKOFF(access(defunct_tid_path, R_OK), -1, 15);
>  }
>
>  static void cleanup(void)
> @@ -108,4 +111,5 @@ static struct tst_test test = {
>         .setup = setup,
>         .cleanup = cleanup,
>         .test = run,
> +       .timeout = 15,
>

I'd like to give a little bit more time here which larger than the
exponential backoff macro time.
Anyway, v2 looks good.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190617/947b6e8b/attachment-0001.html>
