From: Li Wang <liwang@redhat.com>
Date: Sun, 29 Sep 2019 11:47:21 +0800
Subject: [LTP] [PATCH] umip_basic_test.c: update umip basic test for new
 kernel v5.4
In-Reply-To: <20190927034635.28521-1-pengfei.xu@intel.com>
References: <20190927034635.28521-1-pengfei.xu@intel.com>
Message-ID: <CAEemH2dGOcpSmD=BkvQZW=JTtbpkoUSN+tqffkDu+jV=vJsUqA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 27, 2019 at 11:39 AM Pengfei Xu <pengfei.xu@intel.com> wrote:

> After linux kernel v5.4 mainline, 64bit SGDT SIDT SMSW will return
> dummy value and not trigger SIGSEGV due to kernel code change.
> For detailed kernel update info, you could check v5.4 commit:
> x86/umip: Add emulation (spoofing) for UMIP covered instructions in
> 64-bit processes as well
>
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  testcases/kernel/security/umip/umip_basic_test.c | 25
> ++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/security/umip/umip_basic_test.c
> b/testcases/kernel/security/umip/umip_basic_test.c
> index 37850ef9f..278ae92f6 100644
> --- a/testcases/kernel/security/umip/umip_basic_test.c
> +++ b/testcases/kernel/security/umip/umip_basic_test.c
> @@ -21,6 +21,7 @@
>  #include <string.h>
>  #include <sys/wait.h>
>  #include <signal.h>
> +#include <linux/version.h>
>
>  #include "tst_test.h"
>  #include "tst_safe_stdio.h"
> @@ -112,11 +113,31 @@ static void verify_umip_instruction(unsigned int n)
>
>         SAFE_WAITPID(pid, &status, 0);
>
> +       switch (n) {
> +       case 0:
> +       case 1:
> +       case 3:
> +               /* after linux kernel v5.4 mainline, 64bit SGDT SIDT SMSW
> will return
> +                  dummy value and not trigger SIGSEGV due to kernel code
> change */
> +               #if LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0)
> +                       tst_res(TINFO, "Linux kernel version is after than
> v5.4");
> +                       if (WIFSIGNALED(status) && WTERMSIG(status) ==
> SIGSEGV) {
> +                               tst_res(TFAIL, "Got SIGSEGV\n\n");
> +                               return;
> +                       }
> +                       tst_res(TPASS, "Didn't receive SIGSEGV, child
> exited with %s\n\n",
> +                               tst_strstatus(status));
> +                               return;
> +               #else
> +                       tst_res(TINFO, "Linux kernel version is before
> than v5.4");
>

Thank you for fixing this.

My concern is that if an LTS distro backports the patch(commit e86c2c8b93),
then it will break this hardcode kernel-version comparing.



> +               #endif
> +       }
> +
>         if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> -               tst_res(TPASS, "Got SIGSEGV");
> +               tst_res(TPASS, "Got SIGSEGV\n\n");
>

Why we need two '\n' here?


>                 return;
>         }
> -       tst_res(TFAIL, "Didn't receive SIGSEGV, child exited with %s",
> +       tst_res(TFAIL, "Didn't receive SIGSEGV, child exited with %s\n\n",
>                 tst_strstatus(status));
>  }
>
> --
> 2.14.1
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190929/3280a602/attachment.htm>
