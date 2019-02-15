From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Feb 2019 10:42:12 +0200
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <CAOQ4uxj-=5J2809-11_X4-zXPWOyrmLyFZd+acz692mB9YM3gw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Feb 15, 2019 at 9:17 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> syncfs01 tests to sync filesystem having large dirty file pages to block
> device. Also, it tests all supported filesystems on a test block device.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v2:
> 1. Remove unused header file include.
> 2. Remove redundant tst_device check.
> 3. Remove redundant flags from tst_test struct.
>
> Fixes: https://github.com/linux-test-project/ltp/issues/294
>
>  runtest/syscalls                            |   2 +
>  testcases/kernel/syscalls/syncfs/.gitignore |   1 +
>  testcases/kernel/syscalls/syncfs/Makefile   |   8 +++
>  testcases/kernel/syscalls/syncfs/syncfs01.c | 101 ++++++++++++++++++++++++++++
>  4 files changed, 112 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/syncfs/.gitignore
>  create mode 100644 testcases/kernel/syscalls/syncfs/Makefile
>  create mode 100644 testcases/kernel/syscalls/syncfs/syncfs01.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 668c87c..9442740 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1346,6 +1346,8 @@ symlinkat01 symlinkat01
>  sync01 sync01
>  sync02 sync02
>
> +syncfs01 syncfs01
> +
>  #testcases for sync_file_range
>  sync_file_range01 sync_file_range01
>
> diff --git a/testcases/kernel/syscalls/syncfs/.gitignore b/testcases/kernel/syscalls/syncfs/.gitignore
> new file mode 100644
> index 0000000..6066295
> --- /dev/null
> +++ b/testcases/kernel/syscalls/syncfs/.gitignore
> @@ -0,0 +1 @@
> +syncfs01
> diff --git a/testcases/kernel/syscalls/syncfs/Makefile b/testcases/kernel/syscalls/syncfs/Makefile
> new file mode 100644
> index 0000000..3e6c2f4
> --- /dev/null
> +++ b/testcases/kernel/syscalls/syncfs/Makefile
> @@ -0,0 +1,8 @@
> +# Copyright (c) 2019 - Linaro Limited. All rights reserved.
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir             ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/syncfs/syncfs01.c b/testcases/kernel/syscalls/syncfs/syncfs01.c
> new file mode 100644
> index 0000000..e2d3e80
> --- /dev/null
> +++ b/testcases/kernel/syscalls/syncfs/syncfs01.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Linaro Limited. All rights reserved.
> + * Author: Sumit Garg <sumit.garg@linaro.org>
> + */
> +
> +/*
> + * Test syncfs
> + *
> + * It basically tests syncfs() to sync filesystem having large dirty file
> + * pages to block device. Also, it tests all supported filesystems on a test
> + * block device.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include "tst_test.h"
> +#include "lapi/fs.h"
> +#include "lapi/stat.h"
> +
> +#define MNTPOINT               "mnt_point"
> +#define TST_FILE               MNTPOINT"/test"
> +#define TST_FILE_SIZE_MB       32
> +#define SIZE_MB                        (1024*1024)
> +#define MODE                   0644
> +
> +static char dev_stat_path[1024];
> +static char *buffer;
> +static int fd;
> +
> +static void verify_syncfs(void)
> +{
> +       char nwrite_sec_val[BUFSIZ];
> +       int counter;
> +       unsigned long prev_write_sec = 0, write_sec = 0;
> +
> +       SAFE_FILE_SCANF(dev_stat_path, "%*s %*s %*s %*s %*s %*s %s",
> +                       nwrite_sec_val);
> +
> +       prev_write_sec = SAFE_STRTOUL(nwrite_sec_val, 0, ULONG_MAX);

Why not let scanf read %ul?

> +
> +       fd =  SAFE_OPEN(TST_FILE, O_RDWR|O_CREAT, MODE);
> +
> +       /* Filling the test file */
> +       for (counter = 0; counter < TST_FILE_SIZE_MB; counter++)
> +               SAFE_WRITE(1, fd, buffer, SIZE_MB);
> +
> +       TEST(syncfs(fd));
> +       if (TST_RET != 0)
> +               tst_brk(TFAIL | TTERRNO, "syncfs(fd) failed");
> +
> +       SAFE_FILE_SCANF(dev_stat_path, "%*s %*s %*s %*s %*s %*s %s",
> +                       nwrite_sec_val);
> +
> +       write_sec = SAFE_STRTOUL(nwrite_sec_val, 0, ULONG_MAX);
> +
> +       if ((write_sec - prev_write_sec) * 512 >=
> +           (TST_FILE_SIZE_MB * SIZE_MB))
> +               tst_res(TPASS, "Test filesystem synced to device");
> +       else
> +               tst_res(TFAIL, "Failed to sync test filesystem to device");
> +
> +       SAFE_CLOSE(fd);
> +}
> +

It's good to have a tests that verified syncfs() actually does what it
is meant to do.
It's awkward that none of the tests for fsync() fdatasync() sync()
sync_file_range()
check that.

It would be very low hanging to have the exact same test that you wrote
iterate on several test cases where the only difference is the op called on
fd. (fsync,fdatasync,syncfs) should all have the same consequence wrt
minimal written sectors.
With a little more effort, sync() and sync_file_range() could also be
added to test cases.

I realize that LTP usually puts syscalls tests under the specific
kernel/syscalls directory, but in this case, I believe code reuse calls
for a single test that exercises all three syscalls.

Thanks,
Amir.
