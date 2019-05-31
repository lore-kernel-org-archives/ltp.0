From: Li Wang <liwang@redhat.com>
Date: Fri, 31 May 2019 18:02:36 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02.c: Compatible with new
 and old kernels
In-Reply-To: <1559292243-2882-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1559292243-2882-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <CAEemH2eupy=uOYFpUFg3mDF0M06SZ07XW9+kw2e_B=wrY5-QOQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 31, 2019 at 4:44 PM Jinhui huang <huangjh.jy@cn.fujitsu.com>
wrote:

> On new kernels, copy_file_range() returned EISDIR when copyed contents
> to directory, but on old kernels, it returned EBADF, we should accept
> EBADF to be compatible with new and old kernels.
>
> The patch as follows:
> commit 11cbfb10775a ("vfs: deny copy_file_range() for non regular files")
>

Patch makes sense.

Reviewed-by: Li Wang <liwang@redhat.com>

>
> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
> ---
>  .../syscalls/copy_file_range/copy_file_range02.c   | 33
> +++++++++++++++-------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> index 07c0207..9e6356c 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> @@ -54,19 +54,32 @@ static void verify_copy_file_range(unsigned int n)
>         TEST(sys_copy_file_range(fd_src, 0, *tc->copy_to_fd,
>                                 0, CONTSIZE, tc->flags));
>
> -       if (TST_RET == -1) {
> -               if (tc->exp_err == TST_ERR) {
> +       if (TST_RET != -1) {
> +               tst_res(TFAIL,
> +                       "copy_file_range returned wrong value: %ld",
> TST_RET);
> +               return;
> +       }
> +
> +       if (tc->exp_err == TST_ERR) {
> +               tst_res(TPASS | TTERRNO,
> +                       "copy_file_range failed as expected");
> +       } else {
> +               /* copy_file_range() returned EISDIR when copyed contents
> to
> +                * directory on new kernels, but on old kernels, it
> returned
> +                * EBADF.
> +                *
> +                * the patch as follws:
> +                * commit 11cbfb10775a ("vfs: deny copy_file_range() for
> non regular files")
> +                */
> +               if (tc->exp_err == EISDIR && TST_ERR == EBADF) {
>                         tst_res(TPASS | TTERRNO,
> -                                       "copy_file_range failed as
> expected");
> -               } else {
> -                       tst_res(TFAIL | TTERRNO,
> -                               "copy_file_range failed unexpectedly;
> expected %s, but got",
> -                               tst_strerrno(tc->exp_err));
> +                               "copy_file_range failed as expected");
>                         return;
>                 }
> -       } else {
> -               tst_res(TFAIL,
> -                       "copy_file_range returned wrong value: %ld",
> TST_RET);
> +
> +               tst_res(TFAIL | TTERRNO,
> +                       "copy_file_range failed unexpectedly; expected %s,
> but got",
> +                       tst_strerrno(tc->exp_err));
>         }
>  }
>
> --
> 1.8.3.1
>
>
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190531/9c287c61/attachment.html>
