From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Jul 2021 10:35:27 +0200
Subject: [LTP] [PATCH v2] squashfs: Add regression test for sanity check
 bug
In-Reply-To: <20210714055253.1668374-1-lkml@jv-coder.de>
References: <20210714055253.1668374-1-lkml@jv-coder.de>
Message-ID: <YO6hz+OQLThjUQA1@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Adds a regression test for the fixes
> c1b2028315 ("squashfs: fix inode lookup sanity checks")
> and
> 8b44ca2b62 ("squashfs: fix xattr id and id lookup sanity checks")
> 
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ---
> 
> Changes to v1:
>  - Implement whole test in c
>  - Fixed whitespaces...
> 
>  runtest/fs                                    |  2 +
>  testcases/kernel/fs/squashfs/.gitignore       |  1 +
>  testcases/kernel/fs/squashfs/Makefile         |  9 ++
>  .../kernel/fs/squashfs/squashfs_regression.c  | 99 +++++++++++++++++++
>  4 files changed, 111 insertions(+)
>  create mode 100644 testcases/kernel/fs/squashfs/.gitignore
>  create mode 100644 testcases/kernel/fs/squashfs/Makefile
>  create mode 100644 testcases/kernel/fs/squashfs/squashfs_regression.c
> 
> diff --git a/runtest/fs b/runtest/fs
> index 17b1415eb..2091b00f8 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -85,3 +85,5 @@ fs_fill fs_fill
>  
>  binfmt_misc01 binfmt_misc01.sh
>  binfmt_misc02 binfmt_misc02.sh
> +
> +squashfs_regression squashfs_regression

I wonder if we should add a number suffix or just rename it to
squashfs01

> diff --git a/testcases/kernel/fs/squashfs/.gitignore b/testcases/kernel/fs/squashfs/.gitignore
> new file mode 100644
> index 000000000..45c908fff
> --- /dev/null
> +++ b/testcases/kernel/fs/squashfs/.gitignore
> @@ -0,0 +1 @@
> +squashfs_regression
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
> diff --git a/testcases/kernel/fs/squashfs/squashfs_regression.c b/testcases/kernel/fs/squashfs/squashfs_regression.c
> new file mode 100644
> index 000000000..23f681367
> --- /dev/null
> +++ b/testcases/kernel/fs/squashfs/squashfs_regression.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
> + */
> +
> +/*\
> + * [DESCRIPTION]
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
> +#include <stdio.h>
> +#include <sys/mount.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +
> +static void cleanup(void)
> +{
> +	umount("mnt");

We do have tst_umount() in the test library that retries the umount if
it failed because the mount point was bussy. This is because certain
damons scan all newly mounted filesystems and prevent us from umounting
shortly after mount.

Also we usually keep track if device was mounted in a global flag that
is set after succesful mount and unset after successful umount and the
cleanup does:

	if (device_mounted)
		tst_umount("mnt");

> +}
> +
> +static void run(void)
> +{
> +	int i;
> +
> +	tst_res(TINFO, "Test squashfs sanity check regressions");
> +
> +	SAFE_MKDIR("data", 0777);
> +
> +	for (i = 0; i < 2048; ++i) {
> +		int fd;
> +		char name[20];
> +
> +		sprintf(name, "data/%d", i);
> +		fd = SAFE_OPEN(name, O_CREAT | O_EXCL, 0666);
> +		SAFE_FCHOWN(fd, i, i);
> +
> +		/* This must be either "security", "user" or "trusted" namespace,
> +		 * because squashfs cannot store other namespaces.
> +		 * Since the files are most likely created on a tmpfs,
> +		 * "user" namespace is not possible, because it is not allowed.
> +		 */
> +		SAFE_FSETXATTR(fd, "security.x", &i, sizeof(i), 0);
> +		close(fd);
> +	}
> +
> +	/* Create squashfs without any comporession.
> +	 * This allows reasoning about block sizes
> +	 */
> +	TST_EXP_PASS(tst_system(
> +		"mksquashfs data image.raw -noI -noD -noX -noF >/dev/null 2>&1"
> +	), "Create squashfs");

We do have tst_cmd() that can do all this easily in C including the
redirection, it will look like:

	const char *argv[] = {"mksquashfs", "data", "image.raw", "-noI", "-noD", "-noX", "-noF"};

	tst_cmd(argv, "/dev/null", "/dev/null", 0);

And this will redirect stdout and stderr to "/dev/null" and also do all
the error checks and exit the test if mksquashfs has failed.

> +	SAFE_MKDIR("mnt", 0777);

This preparatory part should be in the test setup otherwise the test
will fail with '-i 2'.

> +	TST_EXP_PASS(tst_system("mount -tsquashfs -oloop image.raw mnt"));

Can we please use the mount() syscall here instead? That should be as
easy as mount("image.raw", "mnt", "squashfs", 0, "-oloop")

> +
> +	SAFE_UMOUNT("mnt");

Here as well, please use tst_umount();

> +	tst_res(TPASS, "Test passed");

This is redundant, isn't it? Or is the umount part that fails?

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_drivers = (const char *const []) {
> +		"squashfs",
> +		"loop",
> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "c1b2028315c"},
> +		{"linux-git", "8b44ca2b634"},
> +		{}
> +	},
> +	.needs_tmpdir = 1,
> +};
> -- 
> 2.25.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
