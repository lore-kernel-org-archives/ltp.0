From: Li Wang <liwang@redhat.com>
Date: Sun, 16 Feb 2020 18:11:23 +0800
Subject: [LTP] [PATCH 2/7] syscalls/fsopen: New tests
In-Reply-To: <e4955c8edfb29c1d0f74a8cd24b1dcc68f3b6814.1581680021.git.viresh.kumar@linaro.org>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <e4955c8edfb29c1d0f74a8cd24b1dcc68f3b6814.1581680021.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2emOw=Abnvk-3EOVFyCoY=c6HtC_1o0gih5n+aL-WfXLw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Feb 14, 2020 at 7:36 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> Add tests to check working of fsopen() syscall.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  configure.ac                                |  1 +
>  runtest/syscalls                            |  3 +
>  testcases/kernel/syscalls/fsopen/.gitignore |  2 +
>  testcases/kernel/syscalls/fsopen/Makefile   |  6 ++
>  testcases/kernel/syscalls/fsopen/fsopen01.c | 71 +++++++++++++++++++++
>  testcases/kernel/syscalls/fsopen/fsopen02.c | 56 ++++++++++++++++
>  6 files changed, 139 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fsopen/.gitignore
>  create mode 100644 testcases/kernel/syscalls/fsopen/Makefile
>  create mode 100644 testcases/kernel/syscalls/fsopen/fsopen01.c
>  create mode 100644 testcases/kernel/syscalls/fsopen/fsopen02.c
>
> diff --git a/configure.ac b/configure.ac
> index df4e8c8322fc..4125160a19bb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -80,6 +80,7 @@ AC_CHECK_FUNCS([ \
>      execveat \
>      fallocate \
>      fchownat \
> +    fsopen \
>      fstatat \
>      getdents \
>      getdents64 \
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 0743cf4e3f74..0a56599ebad9 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -542,6 +542,9 @@ fanotify13 fanotify13
>  fanotify14 fanotify14
>  fanotify15 fanotify15
>
> +fsopen01 fsopen01
> +fsopen02 fsopen02
> +
>  ioperm01 ioperm01
>  ioperm02 ioperm02
>
> diff --git a/testcases/kernel/syscalls/fsopen/.gitignore
> b/testcases/kernel/syscalls/fsopen/.gitignore
> new file mode 100644
> index 000000000000..80089dd137a7
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsopen/.gitignore
> @@ -0,0 +1,2 @@
> +fsopen01
> +fsopen02
> diff --git a/testcases/kernel/syscalls/fsopen/Makefile
> b/testcases/kernel/syscalls/fsopen/Makefile
> new file mode 100644
> index 000000000000..5ea7d67db123
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsopen/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir             ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/fsopen/fsopen01.c
> b/testcases/kernel/syscalls/fsopen/fsopen01.c
> new file mode 100644
> index 000000000000..3587c67636ea
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsopen/fsopen01.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Description:
> + * Basic fsopen() test which tries to configure and mount the filesystem
> as
> + * well.
> + */
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +
> +#define MNTPOINT       "mntpoint"
> +
> +static void run(void)
> +{
> +       int fd, fsmfd;
> +
> +       TEST(fsopen(tst_device->fs_type, 0));
> +       fd = TST_RET;
> +
> +       if (fd == -1)
> +               tst_brk(TFAIL | TERRNO, "fsopen() failed");
> +
> +       TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev,
> 0));
> +       if (TST_RET == -1) {
> +               tst_res(TBROK | TERRNO, "fsconfig() failed");
> +               goto out;
> +       }
> +
> +       TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> +       if (TST_RET == -1) {
> +               tst_res(TBROK | TERRNO, "fsconfig() failed");
> +               goto out;
> +       }
> +
> +       TEST(fsmount(fd, 0, 0));
> +       if (TST_RET == -1) {
> +               tst_res(TBROK | TERRNO, "fsmount() failed");
> +               goto out;
> +       }
> +
> +       fsmfd = TST_RET;
> +
> +       TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> +                       MOVE_MOUNT_F_EMPTY_PATH));
> +
> +       SAFE_CLOSE(fsmfd);
> +
> +       if (TST_RET == -1) {
> +               tst_res(TBROK | TERRNO, "move_mount() failed");
> +               goto out;
> +       }
> +
> +       SAFE_CLOSE(TST_RET);
> +
> +       TEST(umount(MNTPOINT));
> +
> +       tst_res(TPASS, "fsopen() passed");
> +
> +out:
> +       SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +       .min_kver = "5.2",
>

I suggest removing .min_kver check in all of the tests to let they can be
running on many distributions(which backport the features).

+       .test_all = run,
> +       .needs_root = 1,
> +       .needs_tmpdir = 1,
>

.needs_tmpdir is not necessary because tst_test->mntpoint helps create that
too.


> +       .format_device = 1,
> +       .mntpoint = MNTPOINT,
>

Maybe to test more filesystems and skip on FUSE? Just like the way in zlang@'s
patch.

+       .all_filesystems = 1,
+       .dev_fs_flags = TST_FS_SKIP_FUSE,

+};
> diff --git a/testcases/kernel/syscalls/fsopen/fsopen02.c
> b/testcases/kernel/syscalls/fsopen/fsopen02.c
> new file mode 100644
> index 000000000000..6831a12c696b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsopen/fsopen02.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Description:
> + * Basic fsopen() failure tests.
> + */
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +
> +const char *invalid_fs = "invalid";
> +const char *valid_fs;
> +
> +static struct tcase {
> +       char *name;
> +       const char **fs;
> +       unsigned int flags;
> +       int exp_errno;
> +} tcases[] = {
> +       {"invalid-fs", &invalid_fs, 0, ENODEV},
> +       {"invalid-flags", &valid_fs, 0x10, EINVAL},
> +};
> +
> +static void setup(void)
> +{
> +       valid_fs = tst_device->fs_type;
> +}
> +
> +static void run(unsigned int n)
> +{
> +       struct tcase *tc = &tcases[n];
> +
> +       TEST(fsopen(*tc->fs, tc->flags));
> +
> +       if (TST_RET != -1) {
> +               SAFE_CLOSE(TST_RET);
> +               tst_brk(TFAIL, "%s: fsopen() succeeded unexpectedly
> (index: %d)",
> +                       tc->name, n);
> +       }
> +
> +       if (tc->exp_errno != TST_ERR) {
> +               tst_brk(TFAIL | TTERRNO, "%s: fsopen() should fail with
> %s",
> +                       tc->name, tst_strerrno(tc->exp_errno));
> +       }
> +
> +       tst_res(TPASS | TTERRNO, "%s: fsopen() failed as expected",
> tc->name);
> +}
> +
> +static struct tst_test test = {
> +       .min_kver = "5.2",
>

To delete .min_kver.


> +       .tcnt = ARRAY_SIZE(tcases),
> +       .test = run,
> +       .setup = setup,
> +       .needs_root = 1,
> +       .needs_device = 1,
> +};
> --
> 2.21.0.rc0.269.g1a574e7a288b
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200216/427b4b5f/attachment.htm>
