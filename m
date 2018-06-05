From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Jun 2018 11:36:34 +0800
Subject: [LTP] [PATCH] pty/pty02.c: Fix compiler error
In-Reply-To: <1527734724-348-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1527734724-348-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <CAEemH2fBpq0qC-4r_LP42dsXijSFjR9jPUxwmgRLUCDbdhtKKQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, May 31, 2018 at 10:45 AM, Jinhui huang <huangjh.jy@cn.fujitsu.com>
wrote:

> Compilation failed because of undefined EXTPROC on old distros(e.g.
> RHEL5/6).
>
> Based on the fix patch[1] and added EXTPROC, tcgetattr() still could not
> detect
> invalid EXTPROC on old distros.  So we wanted to skip the case if EXTPROC
> was not
> defined on current distros.
>
> [1] http://lists.linux.it/pipermail/ltp/2018-May/008253.html
>
> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/pty/pty02.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
> index fd3d26b..548f8d1 100644
> --- a/testcases/kernel/pty/pty02.c
> +++ b/testcases/kernel/pty/pty02.c
> @@ -29,6 +29,8 @@
>
>  #include "tst_test.h"
>
> +#ifdef EXTPROC
>

​This fix is fine. But image that a distribution defined both EXTPROC and
ICANON, if the ICANON(enables canonical input processing, also called line
mode) ​needs newline('\n') to ptmx there, this test will hung there forever.



> +
>  static void do_test(void)
>  {
>         struct termios io = { .c_lflag = EXTPROC | ICANON };
> @@ -60,3 +62,7 @@ static void do_test(void)
>  static struct tst_test test = {
>         .test_all = do_test,
>  };
> +
> +#else
> +       TST_TEST_TCONF("EXTPROC is not defined");
> +#endif
> --
> 1.8.3.1
>
>
>
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180605/3ee5cc39/attachment-0001.html>
