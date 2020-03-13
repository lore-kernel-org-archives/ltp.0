From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Mar 2020 13:35:09 +0100
Subject: [LTP] [PATCH V6 09/10] syscalls/fspick: New tests
In-Reply-To: <105dcaba496248a8e2b4a93bd61d90d3ee88f6af.1584014172.git.viresh.kumar@linaro.org>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
 <105dcaba496248a8e2b4a93bd61d90d3ee88f6af.1584014172.git.viresh.kumar@linaro.org>
Message-ID: <20200313123508.GB6597@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Acked-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  runtest/syscalls                            |  3 +
>  testcases/kernel/syscalls/fspick/.gitignore |  2 +
>  testcases/kernel/syscalls/fspick/Makefile   |  6 ++
>  testcases/kernel/syscalls/fspick/fspick.h   | 60 ++++++++++++++++++++
>  testcases/kernel/syscalls/fspick/fspick01.c | 62 +++++++++++++++++++++
>  testcases/kernel/syscalls/fspick/fspick02.c | 54 ++++++++++++++++++
>  6 files changed, 187 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fspick/.gitignore
>  create mode 100644 testcases/kernel/syscalls/fspick/Makefile
>  create mode 100644 testcases/kernel/syscalls/fspick/fspick.h
>  create mode 100644 testcases/kernel/syscalls/fspick/fspick01.c
>  create mode 100644 testcases/kernel/syscalls/fspick/fspick02.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 077e724b62e4..32f11f4bc9ab 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -351,6 +351,9 @@ fsmount02 fsmount02
>  fsopen01 fsopen01
>  fsopen02 fsopen02
>  
> +fspick01 fspick01
> +fspick02 fspick02
> +
>  fstat02 fstat02
>  fstat02_64 fstat02_64
>  fstat03 fstat03
> diff --git a/testcases/kernel/syscalls/fspick/.gitignore b/testcases/kernel/syscalls/fspick/.gitignore
> new file mode 100644
> index 000000000000..a8aa61dce18b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fspick/.gitignore
> @@ -0,0 +1,2 @@
> +/fspick01
> +/fspick02
> diff --git a/testcases/kernel/syscalls/fspick/Makefile b/testcases/kernel/syscalls/fspick/Makefile
> new file mode 100644
> index 000000000000..5ea7d67db123
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fspick/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/fspick/fspick.h b/testcases/kernel/syscalls/fspick/fspick.h
> new file mode 100644
> index 000000000000..ca84269ee7a9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fspick/fspick.h
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + */
> +
> +#ifndef FSPICK_H__
> +#define FSPICK_H__
> +
> +#define MNTPOINT	"mntpoint"
> +
> +static int ismounted;
> +
> +static void cleanup(void)
> +{
> +	if (ismounted)
> +		SAFE_UMOUNT(MNTPOINT);
> +}
> +
> +static void setup(void)
> +{
> +	int fd, fsmfd;
> +
> +	fsopen_supported_by_kernel();
> +
> +	TEST(fd = fsopen(tst_device->fs_type, 0));
> +	if (fd == -1)
> +		tst_brk(TBROK | TERRNO, "fsopen() failed");
> +
> +	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
> +	if (TST_RET == -1) {
> +		SAFE_CLOSE(fd);
> +		tst_brk(TBROK | TERRNO, "fsconfig() failed");
> +	}
> +
> +	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> +	if (TST_RET == -1) {
> +		SAFE_CLOSE(fd);
> +		tst_brk(TBROK | TERRNO, "fsconfig() failed");
> +	}
> +
> +	TEST(fsmfd = fsmount(fd, 0, 0));
> +	SAFE_CLOSE(fd);
> +
> +	if (fsmfd == -1)
> +		tst_brk(TBROK | TERRNO, "fsmount() failed");
> +
> +	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> +			MOVE_MOUNT_F_EMPTY_PATH));
> +	SAFE_CLOSE(fsmfd);
> +
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TERRNO, "move_mount() failed");
> +
> +	if (!tst_is_mounted_at_tmpdir(MNTPOINT))
> +		tst_brk(TBROK | TERRNO, "device not mounted");
> +
> +	ismounted = 1;

I just wonder if we can set the .mount_device = 1 flag instead and omit
the setup and cleanup.

> +}
> +
> +#endif /* FSPICK_H__ */
> diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
> new file mode 100644
> index 000000000000..4e1daeaee14a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fspick/fspick01.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Basic fspick() test.
> + */
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +#include "fspick.h"
> +
> +#define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
> +
> +static struct tcase {
> +	char *name;
> +	unsigned int flags;
> +} tcases[] = {
> +	TCASE_ENTRY(FSPICK_CLOEXEC),
> +	TCASE_ENTRY(FSPICK_SYMLINK_NOFOLLOW),
> +	TCASE_ENTRY(FSPICK_NO_AUTOMOUNT),
> +	TCASE_ENTRY(FSPICK_EMPTY_PATH),
> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int fspick_fd;
> +
> +	TEST(fspick_fd = fspick(AT_FDCWD, MNTPOINT, tc->flags));
> +	if (fspick_fd == -1) {
> +		tst_res(TFAIL | TERRNO, "fspick() failed");
> +		return;
> +	}
> +
> +	TEST(fsconfig(fspick_fd, FSCONFIG_SET_STRING, "sync", "false", 0));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TERRNO, "fsconfig() failed");
> +		goto out;
> +	}
> +
> +	TEST(fsconfig(fspick_fd, FSCONFIG_SET_FLAG, "ro", NULL, 0));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TERRNO, "fsconfig() failed");
> +		goto out;
> +	}

I guess that we should as well call the FSCONFIG_CMD_RECONFIGURE and
check that the MNTPOINT is read only, right?

> +	tst_res(TPASS, "%s: fspick() passed", tc->name);
> +
> +out:
> +	SAFE_CLOSE(fspick_fd);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.dev_fs_flags = TST_FS_SKIP_FUSE,
> +};
> diff --git a/testcases/kernel/syscalls/fspick/fspick02.c b/testcases/kernel/syscalls/fspick/fspick02.c
> new file mode 100644
> index 000000000000..dc8f153ccc48
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fspick/fspick02.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Basic fspick() failure tests.
> + */
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +#include "fspick.h"
> +
> +static struct tcase {
> +	char *name;
> +	int dirfd;
> +	const char *pathname;
> +	unsigned int flags;
> +	int exp_errno;
> +} tcases[] = {
> +	{"invalid-fd", -1, MNTPOINT, FSPICK_NO_AUTOMOUNT | FSPICK_CLOEXEC, EBADF},
> +	{"invalid-path", AT_FDCWD, "invalid", FSPICK_NO_AUTOMOUNT | FSPICK_CLOEXEC, ENOENT},
> +	{"invalid-flags", AT_FDCWD, MNTPOINT, 0x10, EINVAL},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	TEST(fspick(tc->dirfd, tc->pathname, tc->flags));
> +	if (TST_RET != -1) {
> +		SAFE_CLOSE(TST_RET);
> +		tst_res(TFAIL, "%s: fspick() succeeded unexpectedly (index: %d)",
> +			tc->name, n);
> +		return;
> +	}
> +
> +	if (tc->exp_errno != TST_ERR) {
> +		tst_res(TFAIL | TTERRNO, "%s: fspick() should fail with %s",
> +			tc->name, tst_strerrno(tc->exp_errno));
> +		return;
> +	}
> +
> +	tst_res(TPASS | TTERRNO, "%s: fspick() failed as expected", tc->name);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.dev_fs_flags = TST_FS_SKIP_FUSE,
> +};
> -- 
> 2.21.0.rc0.269.g1a574e7a288b
> 

-- 
Cyril Hrubis
chrubis@suse.cz
