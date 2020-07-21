From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Jul 2020 15:46:47 +0800
Subject: [LTP] [PATCH 1/3] lib: add function to check for kernel lockdown
In-Reply-To: <20200720194920.22784-1-ernunes@redhat.com>
References: <20200720194920.22784-1-ernunes@redhat.com>
Message-ID: <CAEemH2c1Sz+pkcLnCoWWCaMCte7QsmUTOoUxU6fzCF32nrrG+w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Erico,

Thanks for working on this fix. Comments as below:

On Tue, Jul 21, 2020 at 3:50 AM Erico Nunes <ernunes@redhat.com> wrote:

> Some syscalls are not available if the kernel is booted using the
> 'lockdown' feature. That can cause some tests to report fail, showing
> a message like:
>
>   Lockdown: iopl01: iopl is restricted; see man kernel_lockdown.7
>
> This patch adds a function that can be used by tests to check for this
> case, so tests can be skipped rather than reporting a test failure.
>
> Signed-off-by: Erico Nunes <ernunes@redhat.com>
> ---
>  include/tst_lockdown.h |  8 ++++++++
>  include/tst_test.h     |  1 +
>  lib/tst_lockdown.c     | 28 ++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>  create mode 100644 include/tst_lockdown.h
>  create mode 100644 lib/tst_lockdown.c
>
> diff --git a/include/tst_lockdown.h b/include/tst_lockdown.h
> new file mode 100644
> index 000000000..8db26d943
> --- /dev/null
> +++ b/include/tst_lockdown.h
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#ifndef TST_LOCKDOWN_H
> +#define TST_LOCKDOWN_H
> +
> +void tst_lockdown_skip(void);
> +
> +#endif /* TST_LOCKDOWN_H */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index b84f7b9dd..b02de4597 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -40,6 +40,7 @@
>  #include "tst_hugepage.h"
>  #include "tst_assert.h"
>  #include "tst_cgroup.h"
> +#include "tst_lockdown.h"
>
>  /*
>   * Reports testcase result.
> diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
> new file mode 100644
> index 000000000..d57a6bdf3
> --- /dev/null
> +++ b/lib/tst_lockdown.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define TST_NO_DEFAULT_MAIN
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mount.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "tst_safe_stdio.h"
> +#include "tst_lockdown.h"
> +
> +void tst_lockdown_skip(void)
>

Maybe renaming the function to tst_lockdown_enabled() is better? Then we
can return 1 if confirm kernel under lockdown mode otherwise 0.

+{
> +       char line[BUFSIZ];
> +       FILE *file;
> +
> +       if (access("/sys/kernel/security/lockdown", F_OK) != 0)
>

After thinking over, I guess it's not enough to only check /sys/../lockdown
file. Seems we need to consider the situation that system without
supporting this file?

i.e.
  Test on RHEL8 (no /sys/../lockdown file) with kernel parameter "lockdown"
and got the restriction error too.

# cat /proc/cmdline
BOOT_IMAGE=(hd0,msdos1)/vmlinuz-4.18.0-226.el8.x86_64
root=/dev/mapper/rhel_bootp--73--3--209-root ro console=ttyS0,115200 ...
 lockdown

# ll /sys/kernel/security/lockdown
ls: cannot access '/sys/kernel/security/lockdown': No such file or directory

# ./iopl01
...
iopl01.c:37: FAIL: iopl() failed for level 1, errno=1 : EPERM: EPERM (1)
iopl01.c:37: FAIL: iopl() failed for level 2, errno=1 : EPERM: EPERM (1)



> +               return;
> +
> +       file = SAFE_FOPEN("/sys/kernel/security/lockdown", "r");
> +       fgets(line, sizeof(line), file);
> +       SAFE_FCLOSE(file);
> +
> +       if (strstr(line, "[none]") == NULL)
> +               tst_brk(TCONF, "Kernel is locked down, skip this test.");
> +}
> --
> 2.26.2
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200721/c9de85e0/attachment.htm>
