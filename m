From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Feb 2020 14:52:06 +0100
Subject: [LTP] [PATCH v7 4/4] syscalls/fsmount01: Add test for fsmount
 series API
In-Reply-To: <20200217084622.11199-5-pvorel@suse.cz>
References: <20200217084622.11199-1-pvorel@suse.cz>
 <20200217084622.11199-5-pvorel@suse.cz>
Message-ID: <20200217135205.GA25504@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
> new file mode 100644
> index 000000000..464458080
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> + * Author: Zorro Lang <zlang@redhat.com>
> + *
> + * Use new mount API from v5.2 (fsopen(), fsconfig(), fsmount(), move_mount())
> + * to mount a filesystem without any specified mount options.
> + */
> +
> +#include <sys/mount.h>
> +
> +#include "tst_test.h"
> +#include "lapi/fcntl.h"
> +#include "lapi/fsmount.h"
> +#include "tst_safe_stdio.h"
> +
> +#define LINELENGTH 256
> +#define MNTPOINT "newmount_point"
> +static int sfd, mfd, is_mounted;
> +
> +static int ismount(char *mntpoint)
> +{
> +	int ret = 0;
> +	FILE *file;
> +	char line[LINELENGTH];
> +
> +	file = SAFE_FOPEN("/proc/mounts", "r");
> +
> +	while (fgets(line, sizeof(line), file)) {
> +		if (strstr(line, mntpoint) != NULL) {
> +			ret = 1;
> +			break;
> +		}
> +	}
> +	SAFE_FCLOSE(file);
> +	return ret;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (is_mounted)
> +		SAFE_UMOUNT(MNTPOINT);
> +}
> +
> +static void test_fsmount(void)
> +{
> +	TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "fsopen %s", tst_device->fs_type);
> +	sfd = TST_RET;
> +	tst_res(TPASS, "fsopen %s", tst_device->fs_type);
> +
> +	TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO,
> +		        "fsconfig set source to %s", tst_device->dev);
> +	tst_res(TPASS, "fsconfig set source to %s", tst_device->dev);
> +
> +
> +	TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "fsconfig create superblock");
> +	tst_res(TPASS, "fsconfig create superblock");
> +
> +	TEST(fsmount(sfd, FSMOUNT_CLOEXEC, 0));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "fsmount");
> +	mfd = TST_RET;
> +	tst_res(TPASS, "fsmount");
> +	SAFE_CLOSE(sfd);
> +
> +	TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "move_mount attach to mount point");
> +	is_mounted = 1;
> +	tst_res(TPASS, "move_mount attach to mount point");
> +	SAFE_CLOSE(mfd);
> +
> +	if (ismount(MNTPOINT)) {
> +		tst_res(TPASS, "new mount API works");
> +		SAFE_UMOUNT(MNTPOINT);
> +		is_mounted = 0;
> +	} else
> +		tst_res(TFAIL, "new mount API works");
                                  ^
				"device not mounted" ?

Also LKML coding style prefers curly braces over both branches if they
are required over one of them.


Other than this the patchset looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
