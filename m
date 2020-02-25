From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Feb 2020 14:46:48 +0100
Subject: [LTP] [PATCH V3 05/10] syscalls/fsconfig: New tests
In-Reply-To: <ccb816c7032270dd2ef51ab14290aacb2c89db38.1582612624.git.viresh.kumar@linaro.org>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
 <ccb816c7032270dd2ef51ab14290aacb2c89db38.1582612624.git.viresh.kumar@linaro.org>
Message-ID: <20200225134648.GB62318@gacrux.arch.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Add tests to check working of fsconfig() syscall.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, minor comments below.
...
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Basic fsconfig() test which tries to configure and mount the filesystem as
> + * well.
> + */
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +
> +#define MNTPOINT	"mntpoint"
> +
> +static void run(void)
> +{
> +	int fd, fsmfd;
> +
> +	TEST(fsopen(tst_device->fs_type, 0));
> +	fd = TST_RET;
Just
TEST(fd = fsopen(tst_device->fs_type, 0));

> +
> +	if (fd == -1)
> +		tst_brk(TBROK | TERRNO, "fsopen() failed");
> +
> +	TEST(fsconfig(fd, FSCONFIG_SET_FLAG, "rw", NULL, 0));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TERRNO, "fsconfig() failed");
> +		goto out;
> +	}
> +
> +	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TERRNO, "fsconfig() failed");
> +		goto out;
> +	}
> +
> +	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "sync", tst_device->dev, 0));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EOPNOTSUPP) {
> +			tst_res(TINFO, "fsconfig(): FSCONFIG_SET_PATH not supported");
This should be TCONF. It'd be nice to have this check in functions in lapi/fsmount.h
(just DRY). But don't want to block these tests just because DRY.

> +		} else {
> +			tst_res(TFAIL | TERRNO, "fsconfig() failed");
> +			goto out;
> +		}
> +	}
> +
> +	TEST(fsconfig(fd, FSCONFIG_SET_PATH_EMPTY, "sync", tst_device->dev, 0));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EOPNOTSUPP) {
> +			tst_res(TINFO, "fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported");
> +		} else {
> +			tst_res(TFAIL | TERRNO, "fsconfig() failed");
> +			goto out;
> +		}
> +	}
> +
> +	TEST(fsconfig(fd, FSCONFIG_SET_FD, "sync", NULL, 0));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EOPNOTSUPP) {
> +			tst_res(TINFO, "fsconfig(): FSCONFIG_SET_FD not supported");
> +		} else {
> +			tst_res(TFAIL | TERRNO, "fsconfig() failed");
> +			goto out;
> +		}
> +	}
> +
> +	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TERRNO, "fsconfig() failed");
> +		goto out;
> +	}
> +
> +	TEST(fsmount(fd, 0, 0));
> +	if (TST_RET == -1) {
> +		tst_res(TBROK | TERRNO, "fsmount() failed");
> +		goto out;
> +	}
> +
> +	fsmfd = TST_RET;
> +	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> +			MOVE_MOUNT_F_EMPTY_PATH));
> +	SAFE_CLOSE(fsmfd);
> +
> +	if (TST_RET == -1) {
> +		tst_res(TBROK | TERRNO, "move_mount() failed");
> +		goto out;
> +	}
> +
> +	if (tst_is_mounted(MNTPOINT))
> +		tst_res(TPASS, "fsconfig() passed");
> +
> +	SAFE_UMOUNT(MNTPOINT);
> +
> +out:
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = fsopen_supported_by_kernel,
> +	.needs_root = 1,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.dev_fs_flags = TST_FS_SKIP_FUSE,
> +};
> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig02.c b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
> new file mode 100644
> index 000000000000..d51a869ac3ff
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Basic fsconfig() failure tests.
> + */
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +
> +int fd = -1, temp_fd = -1, invalid_fd = -1;
> +int aux_0 = 0, aux_1 = 1, aux_fdcwd = AT_FDCWD, aux_minus1 = -1;
These 2 should be static (also fd could be default 0, but who cares :)).

Kind regards,
Petr
