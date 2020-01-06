From: Li Wang <liwang@redhat.com>
Date: Mon, 6 Jan 2020 16:06:30 +0800
Subject: [LTP] [PATCH v2] syscalls/userfaultfd01: add hint about
 unprivileged_userfaultfd
In-Reply-To: <1576641763-18305-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1576641763-18305-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2eKbbXjonuiKMdHcRda98hJikmGW4=YtWft0-1QAj0oBQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Dec 18, 2019 at 12:02 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> Since commit cefdca0a86be ("userfaultfd/sysctl: add
> vm.unprivileged_userfaultfd").
> , it adds a global sysctl knob "vm.unprivileged_userfaultfd" to control
> whether
> unprivileged users can use the userfaultfd system calls. Set this to 1 to
> allow
> unprivileged users to use the userfaultfd system calls, or set this to 0 to
> restrict userfaultfd to only privileged users (with SYS_CAP_PTRACE
> capability). The
> default value is 1. Add hint about it.
>

Can we do the "vm.unprivileged_userfaultfd" check in the setup() and do set
to 1 if it exists?
And maybe we need more tests for the global sysctl knob
"vm.unprivileged_userfaultfd".


> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  .../syscalls/userfaultfd/userfaultfd01.c      | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> index a5e142209..4e178b4f8 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> @@ -82,12 +82,19 @@ static void run(void)
>
>         set_pages();
>
> -       uffd = sys_userfaultfd(O_CLOEXEC | O_NONBLOCK);
> -
> -       if (uffd == -1)
> -               tst_brk(TBROK | TERRNO,
> -                       "Could not create userfault file descriptor");
> -
> +       TEST(sys_userfaultfd(O_CLOEXEC | O_NONBLOCK));
> +
> +       if (TST_RET == -1) {
> +               if (TST_ERR == EPERM) {
> +                       tst_res(TCONF, "Hint: check
> /proc/sys/vm/unprivileged_userfaultfd");
> +                       tst_brk(TCONF | TTERRNO,
> +                               "userfaultfd() requires CAP_SYS_PTRACE on
> this system");
> +               } else
> +                       tst_brk(TBROK | TTERRNO,
> +                               "Could not create userfault file
> descriptor");
> +       }
> +
> +       uffd = TST_RET;
>         uffdio_api.api = UFFD_API;
>         uffdio_api.features = 0;
>         SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> --
> 2.18.0
>
>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200106/90744333/attachment.htm>
