From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 15 Jul 2021 08:21:53 +0000
Subject: [LTP] [PATCH v3] squashfs: Add regression test for sanity check
 bug
In-Reply-To: <20210715050812.1950884-1-lkml@jv-coder.de>
References: <20210715050812.1950884-1-lkml@jv-coder.de>
Message-ID: <60EFF034.6070800@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joery
> From: Joerg Vehlow<joerg.vehlow@aox-tech.de>
>
> Adds a regression test for the fixes
> c1b2028315 ("squashfs: fix inode lookup sanity checks")
> and
> 8b44ca2b62 ("squashfs: fix xattr id and id lookup sanity checks")
>
> Signed-off-by: Joerg Vehlow<joerg.vehlow@aox-tech.de>
> ---
>
> Changes to v2:
>   - Rename to squashfs01
>   - Add mksquashfs to needs_cmds
>   - Use needs_device and mount syscall instead of mount tool
>   - Moved test file creation to setup
>   - Use tst_cmd instead of tst_system
>   - Use flag to call umount conditionally in cleanup
>
> Changes to v1:
>   - Implement whole test in c
>   - Fixed whitespaces...
>
>   runtest/fs                                |   2 +
>   testcases/kernel/fs/squashfs/.gitignore   |   1 +
>   testcases/kernel/fs/squashfs/Makefile     |   9 ++
>   testcases/kernel/fs/squashfs/squashfs01.c | 121 ++++++++++++++++++++++
>   4 files changed, 133 insertions(+)
>   create mode 100644 testcases/kernel/fs/squashfs/.gitignore
>   create mode 100644 testcases/kernel/fs/squashfs/Makefile
>   create mode 100644 testcases/kernel/fs/squashfs/squashfs01.c
>
> diff --git a/runtest/fs b/runtest/fs
> index 17b1415eb..1d753e0dd 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -85,3 +85,5 @@ fs_fill fs_fill
>
>   binfmt_misc01 binfmt_misc01.sh
>   binfmt_misc02 binfmt_misc02.sh
> +
> +squashfs01 squashfs01
> diff --git a/testcases/kernel/fs/squashfs/.gitignore b/testcases/kernel/fs/squashfs/.gitignore
> new file mode 100644
> index 000000000..d28920fe8
> --- /dev/null
> +++ b/testcases/kernel/fs/squashfs/.gitignore
> @@ -0,0 +1 @@
> +squashfs01
> diff --git a/testcases/kernel/fs/squashfs/Makefile b/testcases/kernel/fs/squashfs/Makefile
> new file mode 100644
> index 000000000..67021139c
> --- /dev/null
> +++ b/testcases/kernel/fs/squashfs/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2009, Cisco Systems Inc.
> +# Ngie Cooper, July 2009
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/fs/squashfs/squashfs01.c b/testcases/kernel/fs/squashfs/squashfs01.c
> new file mode 100644
> index 000000000..f02c91f83
> --- /dev/null
> +++ b/testcases/kernel/fs/squashfs/squashfs01.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Joerg Vehlow<joerg.vehlow@aox-tech.de>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Kernel commits
> + *
> + * - f37aa4c7366 (squashfs: add more sanity checks in id lookup)
> + * - eabac19e40c (squashfs: add more sanity checks in inode lookup)
> + * - 506220d2ba2 (squashfs: add more sanity checks in xattr id lookup)
> + *
> + * added some sanity checks, that verify the size of
> + * inode lookup, id (uid/gid) and xattr blocks in the squashfs,
> + * but broke mounting filesystems with completely filled blocks.
> + * A block has a max size of 8192.
> + * An inode lookup entry has an uncompressed size of 8 bytes,
> + * an id block 4 bytes and an xattr block 16 bytes.
> + *
> + *
> + * To fill up at least one block for each of the three tables,
> + * 2048 files with unique uid/gid and xattr are created.
> + *
> + *
> + * The bugs are fixed in kernel commits
> + *
> + * - c1b2028315c (squashfs: fix inode lookup sanity checks)
> + * - 8b44ca2b634 (squashfs: fix xattr id and id lookup sanity checks)
> + */
> +
> +#include<stdio.h>
> +#include<sys/mount.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +
> +static const char *MOUNT_DIR = "mnt";
> +static const char *DATA_DIR = "data";
> +
> +static int mounted;
> +
> +static void cleanup(void)
> +{
> +	if (mounted)
> +		SAFE_UMOUNT("mnt");
> +}
> +
> +static void setup(void)
> +{
> +	int i;
> +
> +	SAFE_MKDIR(DATA_DIR, 0777);
> +
> +	for (i = 0; i<  2048; ++i) {
> +		int fd;
> +		char name[20];
> +
> +		sprintf(name, "%s/%d", DATA_DIR, i);
> +		fd = SAFE_OPEN(name, O_CREAT | O_EXCL, 0666);
> +		SAFE_FCHOWN(fd, i, i);
> +
> +		/* This must be either "security", "user" or "trusted" namespace,
> +		 * because squashfs cannot store other namespaces.
> +		 * Since the files are most likely created on a tmpfs,
> +		 * "user" namespace is not possible, because it is not allowed.
> +		 */
> +		SAFE_FSETXATTR(fd, "security.x",&i, sizeof(i), 0);
> +		close(fd);
> +	}
> +
> +	/* Create squashfs without any compression.
> +	 * This allows reasoning about block sizes.
> +	 * Redirect stdout, to get rid of undefined uid messages
> +	 */
> +	const char *argv[] = {
> +		"mksquashfs", DATA_DIR, tst_device->dev,
> +		"-noappend", "-noI", "-noD", "-noX", "-noF", NULL
> +	};
> +	tst_cmd(argv, "/dev/null", NULL, 0);
We have SAFE_CMD api.
> +
> +	SAFE_MKDIR(MOUNT_DIR, 0777);
> +}
> +
> +static void run(void)
> +{
> +	tst_res(TINFO, "Test squashfs sanity check regressions");
> +
> +	if (mount(tst_device->dev, MOUNT_DIR, "squashfs", 0, NULL) != 0)
> +		tst_brk(TFAIL | TERRNO, "Mount failed");
> +	mounted = 1;
> +
> +	SAFE_UMOUNT("mnt");
> +	mounted = 0;
> +
> +	tst_res(TPASS, "Test passed");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.needs_device = 1,
> +	.dev_min_size = 1,
> +	.needs_cmds = (const char *const []) {
> +		"mksquashfs",
> +		NULL
> +	},
> +	.needs_drivers = (const char *const []) {
> +		"squashfs",
> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "c1b2028315c"},
> +		{"linux-git", "8b44ca2b634"},
> +		{}
> +	},
> +	.needs_tmpdir = 1,
needs_device has enabled needs_tmpdir in internal, so we don't need to 
set it here.
> +};
