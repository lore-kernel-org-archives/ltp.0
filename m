From: Li Wang <liwang@redhat.com>
Date: Mon, 25 Feb 2019 18:34:10 +0800
Subject: [LTP] [PATCH] syscalls/cma: fix the failure of compiling with
	O2 option
In-Reply-To: <1551082945-75385-1-git-send-email-kerneljasonxing@linux.alibaba.com>
References: <20190223062135.GB49700@linux.alibaba.com>
 <1551082945-75385-1-git-send-email-kerneljasonxing@linux.alibaba.com>
Message-ID: <CAEemH2cbFhJyRHgoRH5ydu3QrcUAcF-_bk+iwg5m-_30m+sUpA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Feb 25, 2019 at 4:22 PM Jason Xing <
kerneljasonxing@linux.alibaba.com> wrote:

> This issue is triggered by the commit 9b02cd465f70 which I wrote. If
> compile the process_vm_readv03.c with O2 option and run, it will return
> TFAIL. By casting the int type to long type in the ltp_syscall calling
> functions can we avoid this failure.
>
> Signed-off-by: Jason Xing <kerneljasonxing@linux.alibaba.com>
> ---
>  testcases/kernel/syscalls/cma/process_vm_readv03.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c
> b/testcases/kernel/syscalls/cma/process_vm_readv03.c
> index 45f7c92..e15ffee 100644
> --- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
> +++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
> @@ -181,7 +181,7 @@ static long *fetch_remote_addrs(void)
>         remote.iov_len = len;
>
>         TEST(ltp_syscall(__NR_process_vm_readv, pids[0], &local,
> -                        1, &remote, 1, 0));
> +                        1L, &remote, 1L, 0L));
>         if (TEST_RETURN != len)
>                 tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
>
> @@ -213,8 +213,8 @@ static void child_invoke(int *bufsz_arr)
>         tst_resm(TINFO, "child 1: %d local iovecs initialized.",
>                  NUM_LOCAL_VECS);
>
> -       TEST(ltp_syscall(__NR_process_vm_readv, pids[0], local,
> NUM_LOCAL_VECS,
> -                                  remote, nr_iovecs, 0));
> +       TEST(ltp_syscall(__NR_process_vm_readv, pids[0], local,
> (long)NUM_LOCAL_VECS,
> +                                  remote, (long)nr_iovecs, 0L));
>

Maybe cast them into 'unsigned long' type is better? otherwise this patch
LGTM.

Cut from linux manual page:
------------------
ssize_t process_vm_readv(pid_t pid,
                                           const struct iovec *local_iov,
                                           unsigned long liovcnt,
                                           const struct iovec *remote_iov,
                                           unsigned long riovcnt,
                                           unsigned long flags);

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190225/b534ae24/attachment.html>
