From: Li Wang <liwang@redhat.com>
Date: Sun, 19 Jul 2020 10:51:57 +0800
Subject: [LTP] [PATCH 1/9] syscalls/ipc: shmctl02: Convert to the new
 library
In-Reply-To: <20200717163453.9587-2-chrubis@suse.cz>
References: <20200717163453.9587-1-chrubis@suse.cz>
 <20200717163453.9587-2-chrubis@suse.cz>
Message-ID: <CAEemH2fj27_UtgapsRTisv6CcNzChdNuUHFDuG_YE3Tm7tQv7Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

This patch looks quite good except for some typos.
(Test get passed on both RHEL8(x86_64) and RHEL7(ppc64))

On Sat, Jul 18, 2020 at 12:34 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>


> ---
>  testcases/kernel/syscalls/ipc/shmctl/Makefile |   4 +-
>  .../kernel/syscalls/ipc/shmctl/shmctl02.c     | 263 ++++++------------
>  2 files changed, 89 insertions(+), 178 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile
> b/testcases/kernel/syscalls/ipc/shmctl/Makefile
> index 0172bb495..bc5bd7c2e 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
> +++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
> @@ -10,7 +10,7 @@ shmctl05: LDLIBS += -lrt
>
>  include $(top_srcdir)/include/mk/testcases.mk
>
> -shmctl01 shmctl02 shmctl03 shmctl04 shmctl05: LDLIBS += -lltpipc
> -shmctl06: LDLIBS += -lltpnewipc
> +shmctl01 shmctl03 shmctl04 shmctl05: LDLIBS += -lltpipc
> +shmctl02 shmctl06: LDLIBS += -lltpnewipc
>
> ...
> + * * EFAULT - IPC_SET & buf isn't valid
> + * * EFAULT - IPC_STAT & buf isn't valid
> + * * EINVAL - the command is not valid
> + * * EINVAL - the shmid is not valid
> + * * EINVAL - the shmid belongs to removed shm
>   *
> - * RESTRICTIONS
> - *     none
> + * * EPERM - attempt to stat root owned shm
>

^ EACCES

> + * * EPERM - attempt delete root owned shm
> + * * EPERM - attempt to change root owned shm
> + * * EPERM - attempt to lock root owned shm
> + * * EPERM - attempt to unlock root owned shm
>   */
>
> ...
>
> -       cleanup();
> +       if (TST_ERR == tc[i].error) {
> +               tst_res(TPASS | TTERRNO, "msgctl(%i, %i, %p)",
>

Here should be shmctl() but not msgctl().


> +                       *tc[i].shm_id, tc[i].cmd, tc[i].buf);
> +               return;
> +       }
>
> -       tst_exit();
> +       tst_res(TFAIL | TTERRNO, "msgctl(%i, %i, %p) expected %s",
>

msgctl -- > shmctl().

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200719/be70d645/attachment.htm>
