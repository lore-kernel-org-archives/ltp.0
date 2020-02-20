From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Feb 2020 14:34:44 +0800
Subject: [LTP] [PATCH V2 06/10] syscalls/fsmount: Improve fsmount01 test
In-Reply-To: <9706f359006ea409d2f85c111d3e001ca6f6d128.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <9706f359006ea409d2f85c111d3e001ca6f6d128.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2cG-OCNmAybYOebbmr=HNoSQ-gBsd7xa9ANGPiOXEHyDg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Feb 19, 2020 at 5:28 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> This patch updates the fsmount01.c file to make it look similar to all
> other fsmount related syscall tests and here is the list of all changes:
>
> - Test all fsmount flags and mount attributes
> - Remove extra PASS messages as all we want to test here is fsmount()
>   and not other syscalls.
> - On the same lines, print TFAIL for fsmount() syscall and TBROK for
>   other calls.
> - close sfd on failures
> - Make the file look similar to other fsmount related tests
> - General cleanup
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  testcases/kernel/syscalls/fsmount/fsmount01.c | 92 ++++++++++++-------
>  1 file changed, 60 insertions(+), 32 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c
> b/testcases/kernel/syscalls/fsmount/fsmount01.c
> index c3cf8106f63b..b746a14ba472 100644
> --- a/testcases/kernel/syscalls/fsmount/fsmount01.c
> +++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
> @@ -3,67 +3,95 @@
>   * Copyright (C) 2020 Red Hat, Inc.  All rights reserved.
>   * Author: Zorro Lang <zlang@redhat.com>
>   *
> - * Use new mount API from v5.2 (fsopen(), fsconfig(), fsmount(),
> move_mount())
> - * to mount a filesystem without any specified mount options.
> + * Description:
> + * Basic fsmount() test.
>   */
>
> -#include <sys/mount.h>
> -
>  #include "tst_test.h"
>  #include "lapi/fsmount.h"
>
> -#define MNTPOINT "newmount_point"
> -static int sfd, mfd, is_mounted;
> +#define MNTPOINT       "mntpoint"
> +
> +static struct tcase {
> +       char *name;
> +       unsigned int flags;
> +       unsigned int mount_attrs;
> +} tcases[] = {
> +       {"Flag 0, attr RDONLY", 0, MOUNT_ATTR_RDONLY},
> +       {"Flag 0, attr NOSUID", 0, MOUNT_ATTR_NOSUID},
> +       {"Flag 0, attr NODEV", 0, MOUNT_ATTR_NODEV},
> +       {"Flag 0, attr NOEXEC", 0, MOUNT_ATTR_NOEXEC},
> +       {"Flag 0, attr RELATIME", 0, MOUNT_ATTR_RELATIME},
> +       {"Flag 0, attr NOATIME", 0, MOUNT_ATTR_NOATIME},
> +       {"Flag 0, attr STRICTATIME", 0, MOUNT_ATTR_STRICTATIME},
> +       {"Flag 0, attr NODIRATIME", 0, MOUNT_ATTR_NODIRATIME},
> +       {"Flag CLOEXEC, attr RDONLY", FSMOUNT_CLOEXEC, MOUNT_ATTR_RDONLY},
> +       {"Flag CLOEXEC, attr NOSUID", FSMOUNT_CLOEXEC, MOUNT_ATTR_NOSUID},
> +       {"Flag CLOEXEC, attr NODEV", FSMOUNT_CLOEXEC, MOUNT_ATTR_NODEV},
> +       {"Flag CLOEXEC, attr NOEXEC", FSMOUNT_CLOEXEC, MOUNT_ATTR_NOEXEC},
> +       {"Flag CLOEXEC, attr RELATIME", FSMOUNT_CLOEXEC,
> MOUNT_ATTR_RELATIME},
> +       {"Flag CLOEXEC, attr NOATIME", FSMOUNT_CLOEXEC,
> MOUNT_ATTR_NOATIME},
> +       {"Flag CLOEXEC, attr STRICTATIME", FSMOUNT_CLOEXEC,
> MOUNT_ATTR_STRICTATIME},
> +       {"Flag CLOEXEC, attr NODIRATIME", FSMOUNT_CLOEXEC,
> MOUNT_ATTR_NODIRATIME},
> +};
>

Again, if you move the 'Flag & attr' to print info, this patch looks pretty
good to me.

> +       if (!tst_ismount(MNTPOINT))
> +               tst_res(TPASS, "%s: fsmount() passed", tc->name);
>

What about:
        tst_res(TPASS, "'Flag & mount_attr: %s': fsmount() passed",
tc->name);

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200220/2c5c3798/attachment.htm>
