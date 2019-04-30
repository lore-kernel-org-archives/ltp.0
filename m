From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Apr 2019 15:18:32 +0800
Subject: [LTP] [PATCH] fcntl33: weakup child before exit if fail in
	parent
In-Reply-To: <20190430045746.1332-1-xzhou@redhat.com>
References: <20190430045746.1332-1-xzhou@redhat.com>
Message-ID: <CAEemH2diyxXisD=f2DX7ptq3c_+XhNe3=xjXU+KXS2BPohaT0A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 30, 2019 at 12:58 PM Murphy Zhou <xzhou@redhat.com> wrote:

> Now it failis on overlayfs this way:
> fcntl33.c:120: INFO: .... failed on overlapfs as expected:
> EAGAIN/EWOULDBLOCK
> tst_checkpoint.c:149: BROK: fcntl33.c:178: tst_checkpoint_wait(0, 10000):
> ETIMEDOUT
> tst_test.c:357: BROK: Reported by child (12066)
>

I'm wondering that if the parent failed to set lease, should child
still valuable to run the remaining test after it being wakened?


>
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
>  testcases/kernel/syscalls/fcntl/fcntl33.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c
> b/testcases/kernel/syscalls/fcntl/fcntl33.c
> index 43dc5a2af..ce27e1006 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl33.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
> @@ -121,6 +121,7 @@ static void do_test(unsigned int i)
>                 } else {
>                         tst_res(TFAIL | TTERRNO, "fcntl() failed to set
> lease");
>                 }
> +               TST_CHECKPOINT_WAKE(0);
>                 goto exit;
>         }
>
> --
> 2.21.0
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190430/356e929d/attachment-0001.html>
