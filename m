From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 15 Feb 2019 15:55:12 +0800
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <5C667060.7020405@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sumit,

Sorry for the late reply. :-)

1) Compilation failed on older kernel(e.g. v2.6.32) because of the
undefined syncfs().
According to manpage, syncfs() was first appeared in Linux 2.6.39 and
library
support was added to glibc in version 2.14. Perhaps, we need to check if
syncfs()
is defined.

2) Running this test got TBROK on older kernel(e.g. v3.10.0), as below:
-------------------------------------------------------------------
syncfs01.c:63: FAIL: Failed to sync test filesystem to device
-------------------------------------------------------------------
It seems that the content of /sys/block/<loopX>/stat is always zero and
doesn't update even though write and sync have been done. I am looking
into it, but i am not sure if this is a known bug on older kernel.

Best Regards,
Xiao Yang
On 2019/02/15 15:17, Sumit Garg wrote:
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
> +#define MNTPOINT		"mnt_point"
> +#define TST_FILE		MNTPOINT"/test"
> +#define TST_FILE_SIZE_MB	32
> +#define SIZE_MB			(1024*1024)
> +#define MODE			0644
> +
> +static char dev_stat_path[1024];
> +static char *buffer;
> +static int fd;
> +
> +static void verify_syncfs(void)
> +{
> +	char nwrite_sec_val[BUFSIZ];
> +	int counter;
> +	unsigned long prev_write_sec = 0, write_sec = 0;
> +
> +	SAFE_FILE_SCANF(dev_stat_path, "%*s %*s %*s %*s %*s %*s %s",
> +			nwrite_sec_val);
> +
> +	prev_write_sec = SAFE_STRTOUL(nwrite_sec_val, 0, ULONG_MAX);
> +
> +	fd =  SAFE_OPEN(TST_FILE, O_RDWR|O_CREAT, MODE);
> +
> +	/* Filling the test file */
> +	for (counter = 0; counter < TST_FILE_SIZE_MB; counter++)
> +		SAFE_WRITE(1, fd, buffer, SIZE_MB);
> +
> +	TEST(syncfs(fd));
> +	if (TST_RET != 0)
> +		tst_brk(TFAIL | TTERRNO, "syncfs(fd) failed");
> +
> +	SAFE_FILE_SCANF(dev_stat_path, "%*s %*s %*s %*s %*s %*s %s",
> +			nwrite_sec_val);
> +
> +	write_sec = SAFE_STRTOUL(nwrite_sec_val, 0, ULONG_MAX);
> +
> +	if ((write_sec - prev_write_sec) * 512 >=
> +	    (TST_FILE_SIZE_MB * SIZE_MB))
> +		tst_res(TPASS, "Test filesystem synced to device");
> +	else
> +		tst_res(TFAIL, "Failed to sync test filesystem to device");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void setup(void)
> +{
> +	struct stat st;
> +
> +	snprintf(dev_stat_path, sizeof(dev_stat_path), "/sys/block/%s/stat",
> +		 strrchr(tst_device->dev, '/') + 1);
> +
> +	if (stat(dev_stat_path, &st) != 0)
> +		tst_brk(TCONF, "Test device stat file: %s not found",
> +			dev_stat_path);
> +
> +	buffer = SAFE_MALLOC(SIZE_MB);
> +
> +	memset(buffer, 0, SIZE_MB);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (buffer)
> +		free(buffer);
> +
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +	.mntpoint = MNTPOINT,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_syncfs,
> +};



