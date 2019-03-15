From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Mar 2019 15:45:04 +0800
Subject: [LTP] [PATCH v2 1/3] syscalls/tgkill01: add new test
In-Reply-To: <20190314135837.GA2536@rei.lan>
References: <1552457573-1354-1-git-send-email-sumit.garg@linaro.org>
 <1552457573-1354-2-git-send-email-sumit.garg@linaro.org>
 <20190314122232.GA17823@rei.lan>
 <CAFA6WYPFiJArJvcDGLmxF5XK-q_6Yu24o=st10LE0Lz7d1Lesg@mail.gmail.com>
 <20190314135837.GA2536@rei.lan>
Message-ID: <CAEemH2fHQ2Jq1o3UxbmD=Qxtwbob48aVeXnMNJWZrVS-jKWX7Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 14, 2019 at 9:59 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > I am not sure how we would manage actual "msec_timeout" in case we get
> > EINTR and need to retry again as we may need to take care of elapsed
> > time till we receive asynchronous signal.
>
> I would have just restarted the timeout after we got signal, the worst case
> that can happen is that in an unlikely case we will send a signals fast
> enough
>

Maybe we can print something useful there at least for friendly debugging
if that unlikely case happens.

> so that the checkpoint will never timeout. But even then the test library
> will
> timeout and would kill the process anyways.
>
> Another option is to switch checkpoints so that they use absolute timeout
> and
> pass clock_gettime() + msec_timeout as timeout.
>
> I would go for something as simple as:
>
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index 5455d0378..5e5b11496 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -85,6 +85,7 @@ void tst_checkpoint_init(const char *file, const int
> lineno,
>  int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
>  {
>         struct timespec timeout;
> +       int ret;
>
>         if (id >= tst_max_futexes) {
>                 errno = EOVERFLOW;
> @@ -94,8 +95,12 @@ int tst_checkpoint_wait(unsigned int id, unsigned int
> msec_timeout)
>         timeout.tv_sec = msec_timeout/1000;
>         timeout.tv_nsec = (msec_timeout%1000) * 1000000;
>
> -       return syscall(SYS_futex, &tst_futexes[id], FUTEX_WAIT,
> -                      tst_futexes[id], &timeout);
> +       do {
> +               ret = syscall(SYS_futex, &tst_futexes[id], FUTEX_WAIT,
> +                             tst_futexes[id], &timeout);

    if (ret == -1 && errno == EINTR)
        tst_res(TWARN | TERRNO, "FUTEX_WAIT operation was interrupted by a
signal, retry again");

+       } while (ret == -1 && errno == EINTR);
> +
> +       return ret;
>  }
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190315/e104e07e/attachment-0001.html>
