From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Feb 2020 13:41:19 +0800
Subject: [LTP] [PATCH V2 05/10] syscalls/fsconfig: New tests
In-Reply-To: <6ac7573e8ea5ab6f0ab9256b73802126d72b5156.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <6ac7573e8ea5ab6f0ab9256b73802126d72b5156.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2f6gudJjZ1HAsVFVKkuR3FUyBVHf1JQDHeQMdavQqc+2A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Feb 19, 2020 at 5:28 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> Add tests to check working of fsconfig() syscall.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  runtest/syscalls                              |   3 +
>  testcases/kernel/syscalls/fsconfig/.gitignore |   2 +
>  testcases/kernel/syscalls/fsconfig/Makefile   |   6 +
>  .../kernel/syscalls/fsconfig/fsconfig01.c     | 110 ++++++++++++++++++
>  .../kernel/syscalls/fsconfig/fsconfig02.c     | 100 ++++++++++++++++
>  5 files changed, 221 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fsconfig/.gitignore
>  create mode 100644 testcases/kernel/syscalls/fsconfig/Makefile
>  create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig01.c
>  create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig02.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index f113342f0ded..4fcbd5f710eb 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -341,6 +341,9 @@ fpathconf01 fpathconf01
>  fremovexattr01 fremovexattr01
>  fremovexattr02 fremovexattr02
>
> +fsconfig01 fsconfig01
> +fsconfig02 fsconfig02
> +
>  fsmount01 fsmount01
>
>  fsopen01 fsopen01
> diff --git a/testcases/kernel/syscalls/fsconfig/.gitignore
> b/testcases/kernel/syscalls/fsconfig/.gitignore
> new file mode 100644
> index 000000000000..2bc54b82751b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/.gitignore
> @@ -0,0 +1,2 @@
> +/fsconfig01
> +/fsconfig02
> diff --git a/testcases/kernel/syscalls/fsconfig/Makefile
> b/testcases/kernel/syscalls/fsconfig/Makefile
> new file mode 100644
> index 000000000000..5ea7d67db123
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir             ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig01.c
> b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
> new file mode 100644
> index 000000000000..96bf8eef8e4b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Description:
> + * Basic fsconfig() test which tries to configure and mount the
> filesystem as
> + * well.
> + */
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +
> +#define MNTPOINT       "mntpoint"
> +
> +static void setup(void)
> +{
> +       fsopen_supported_by_kernel();
> +}
> +
> +static void run(void)
> +{
> +       int fd, fsmfd;
> +
> +       TEST(fsopen(tst_device->fs_type, 0));
> +       fd = TST_RET;
> +
> +       if (fd == -1)
> +               tst_brk(TBROK | TERRNO, "fsopen() failed");
> +
> +       TEST(fsconfig(fd, FSCONFIG_SET_FLAG, "rw", NULL, 0));
> +       if (TST_RET == -1) {
> +               tst_res(TFAIL | TERRNO, "fsconfig() failed");
> +               goto out;
> +       }
> +
> +       TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev,
> 0));
> +       if (TST_RET == -1) {
> +               tst_res(TFAIL | TERRNO, "fsconfig() failed");
> +               goto out;
> +       }
> +
> +       TEST(fsconfig(fd, FSCONFIG_SET_PATH, "foo", tst_device->dev,
> AT_FDCWD));
> +       if (TST_RET == -1) {
> +               if (TST_ERR == EOPNOTSUPP) {
> +                       tst_res(TINFO, "fsconfig(): FSCONFIG_SET_PATH not
> supported");
> +               } else {
> +                       tst_res(TFAIL | TERRNO, "fsconfig() failed");
>

The test reports an EINVAL error when testing fsconfig() with
'FSCONFIG_SET_PATH' on XFS. I'm now trying to look close to this issue.

kernel: 5.6.0-rc2+ x86_64

tst_test.c:1278: INFO: Testing on xfs
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
tst_test.c:1217: INFO: Timeout per run is 0h 05m 00s
fsconfig01.c:46: FAIL: fsconfig() failed: EINVAL (22)
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200220/a2e38d20/attachment-0001.htm>
