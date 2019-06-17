From: Li Wang <liwan@redhat.com>
Date: Mon, 17 Jun 2019 10:22:59 +0800
Subject: [LTP] [PATCH] syscalls/tgkill03: wait for defunct tid to get
	detached
In-Reply-To: <a15d4137b63e4202751bea4e726658aa14be7351.1560678643.git.jstancek@redhat.com>
References: <a15d4137b63e4202751bea4e726658aa14be7351.1560678643.git.jstancek@redhat.com>
Message-ID: <CAEemH2dAr_6q8cfkBhRamUJNcP5=W=PcOp1UTEttBsXkhgNABA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, Jun 16, 2019 at 5:52 PM Jan Stancek <jstancek@redhat.com> wrote:

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
> diff --git a/testcases/kernel/syscalls/tgkill/tgkill03.c
> b/testcases/kernel/syscalls/tgkill/tgkill03.c
> index f5bbdc5a8d4e..5ac1d2651f7a 100644
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
> @@ -55,8 +57,10 @@ static void setup(void)
>         TST_CHECKPOINT_WAIT(0);
>
>         SAFE_PTHREAD_CREATE(&defunct_thread, NULL, defunct_thread_func,
> NULL);
> -
>         SAFE_PTHREAD_JOIN(defunct_thread, NULL);
> +       sprintf(defunct_tid_path, "/proc/%d/task/%d", getpid(),
> defunct_tid);
> +       while (access(defunct_tid_path, R_OK) == 0)
> +               usleep(10000);
>

To be on the safe side, I think maybe TST_RETRY_FUNC is a better choice
here.

    TST_RETRY_FUNC(access(defunct_tid_path, R_OK), -1);

 }
>
>  static void cleanup(void)
> --
> 1.8.3.1
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190617/c96117d2/attachment.html>
