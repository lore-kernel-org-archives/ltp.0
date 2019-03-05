From: Matthias Maennich <maennich@google.com>
Date: Tue, 5 Mar 2019 13:29:10 +0000
Subject: [LTP] [PATCH v3] Add ltp pivot_root test
In-Reply-To: <20190304180406.65987-1-paullawrence@google.com>
References: <20190304180406.65987-1-paullawrence@google.com>
Message-ID: <20190305132910.GA192132@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Paul!

On Mon, Mar 04, 2019 at 10:04:06AM -0800, Paul Lawrence wrote:
> Use HAVE_LIBCAP to not break compiles on machines without libcap
> Moved constants
> Defined test array
> Changd to use /* ... */
> Added to runtest/syscalls
> 
> Signed-off-by: Paul Lawrence <paullawrence@google.com>
> ---
>  runtest/syscalls                              |   2 +
>  testcases/kernel/syscalls/pivot_root/Makefile |  11 +
>  .../kernel/syscalls/pivot_root/pivot_root01.c | 200 ++++++++++++++++++
>  3 files changed, 213 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/pivot_root/Makefile
>  create mode 100644 testcases/kernel/syscalls/pivot_root/pivot_root01.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 668c87cd1..debda74b8 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -835,6 +835,8 @@ pipe11 pipe11
>  pipe2_01 pipe2_01
>  pipe2_02 pipe2_02
>  
> +pivot_root01 pivot_root01
> +
>  poll01 poll01
>  poll02 poll02
>  
> diff --git a/testcases/kernel/syscalls/pivot_root/Makefile b/testcases/kernel/syscalls/pivot_root/Makefile
> new file mode 100644
> index 000000000..a16974d41
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pivot_root/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (c) 2019 Google, Inc.
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +LDLIBS := $(LDLIBS) $(CAP_LIBS)
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/pivot_root/pivot_root01.c b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
> new file mode 100644
> index 000000000..a23439250
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
> @@ -0,0 +1,200 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2019 Google, Inc.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <config.h>
> +
> +#include <errno.h>
> +#include <linux/unistd.h>
> +#include <sched.h>
> +
> +#include <sys/mount.h>
> +#include <stdlib.h>
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_LIBCAP
> +#include <sys/capability.h>
> +#endif
> +
> +static const char* chroot_dir = "chroot";
> +static const char* new_root = "/new_root";
> +static const char* put_old = "/new_root/put_old";
> +static const char* put_old_fs = "/put_old_fs";
> +static const char* put_old_bad = "/put_old_fs/put_old";
> +
> +/*
> + * Test consists of a series of steps that allow pivot_root to succeed, which is
nit: line length

> + * run when param is NORMAL. All other values tweak one of the steps to induce
> + * a failure, and check the errno is as expected.
> + */
> +#define NORMAL 0
> +
> +/*
> + * EBUSY
> + * new_root or put_old are on the current root file system
> + */
> +#define NEW_ROOT_ON_CURRENT_ROOT 1
> +
> +/*
> + * EINVAL
> + * put_old is not underneath new_root
> + * Note: if put_old and new_root are on the same fs,
> + * pivot_root fails with EBUSY before testing reachability
> + */
> +#define PUT_OLD_NOT_UNDERNEATH_NEW_ROOT 2
> +
> +/*
> + * ENOTDIR
> + * new_root or put_old is not a directory
> + */
> +#define PUT_OLD_NOT_DIR 3
> +
> +/*
> + * EPERM
> + * The calling process does not have the CAP_SYS_ADMIN capability.
> + */
> +#define NO_CAP_SYS_ADMIN 4
> +
> +static struct test_case {
> +	int test_case;
> +	int expected_error;
> +} test_cases[] = {
> +	{NORMAL, 0},
> +	{NEW_ROOT_ON_CURRENT_ROOT, EBUSY},
> +	{PUT_OLD_NOT_UNDERNEATH_NEW_ROOT, EINVAL},
> +	{PUT_OLD_NOT_DIR, ENOTDIR},
> +#ifdef HAVE_LIBCAP
> +	{NO_CAP_SYS_ADMIN, EPERM},
> +#endif
I would not disable this test here ...

> +};
> +
> +
> +#ifdef HAVE_LIBCAP
> +static void drop_cap_sys_admin(void)
> +{
> +	cap_value_t cap_value[] = { CAP_SYS_ADMIN };
> +	cap_t cap = cap_get_proc();
> +	if (!cap)
> +		tst_brk(TFAIL | TERRNO, "cap_get_proc failed");
> +
> +	if (cap_set_flag(cap, CAP_EFFECTIVE, 1, cap_value, CAP_CLEAR))
> +		tst_brk(TFAIL | TERRNO, "cap_set_flag failed");
> +
> +	if (cap_set_proc(cap))
> +		tst_brk(TFAIL | TERRNO, "cap_set_proc failed");
> +}
> +#endif
> +
> +#ifdef HAVE_UNSHARE
> +static void run(unsigned int test_case)
> +{
> +	/* Work in child process - needed to undo unshare and chroot */
> +	if (SAFE_FORK()) {
> +		tst_reap_children();
> +		return;
> +	}
> +
> +	/* pivot_root requires no shared mounts exist in process namespace */
> +	TEST(unshare(CLONE_NEWNS | CLONE_FS));
> +	if (TST_RET == -1)
> +		tst_brk(TFAIL | TERRNO, "unshare failed");
> +
> +	/*
> +	 * Create an initial root dir. pivot_root doesn't work if the initial root
> +	 * dir is a initramfs, so use chroot to create a safe environment
> +	 */
> +	SAFE_MOUNT("none", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> +	SAFE_MOUNT("none", chroot_dir, "tmpfs", 0, 0);
> +	SAFE_CHROOT(chroot_dir);
> +
> +	/* Create our new root location */
> +	SAFE_MKDIR(new_root, 0777);
> +
> +	/*
> +	 * pivot_root only works if new_root is a mount point, so mount a tmpfs
> +	 * unless testing for that fail mode
> +	 */
> +	if (test_cases[test_case].test_case != NEW_ROOT_ON_CURRENT_ROOT)
> +		SAFE_MOUNT("none", new_root, "tmpfs", 0, 0);
> +
> +	/*
> +	 * Create put_old under new_root, unless testing for that specific fail
> +	 * mode
> +	 */
> +	const char* actual_put_old = NULL;
> +	if (test_cases[test_case].test_case == PUT_OLD_NOT_UNDERNEATH_NEW_ROOT) {
> +		actual_put_old = put_old_bad;
> +		SAFE_MKDIR(put_old_fs, 0777);
> +		SAFE_MOUNT("none", put_old_fs, "tmpfs", 0, 0);
> +		SAFE_MKDIR(put_old_bad, 0777);
> +	} else {
> +		actual_put_old = put_old;
> +
> +		/* put_old must be a directory for success */
> +		if (test_cases[test_case].test_case == PUT_OLD_NOT_DIR)
> +			SAFE_CREAT(put_old, 0777);
> +		else
> +			SAFE_MKDIR(put_old, 0777);
> +	}
> +
> +#ifdef HAVE_LIBCAP
> +	if (test_cases[test_case].test_case == NO_CAP_SYS_ADMIN)
> +		drop_cap_sys_admin();
> +#endif
... and rather fail with a TCONF if unsupported. Something like

	if (test_cases[test_case].test_case == NO_CAP_SYS_ADMIN)
#ifdef HAVE_LIBCAP
		drop_cap_sys_admin();
#else
        tst_brk(TCONF, "System doesn't have POSIX capabilities support");
#endif

Otherwise the test is silently ignored on systems / infrastructure where
just the supporting library is missing.

> +
> +	/* Test the syscall */
> +	TEST(syscall(__NR_pivot_root, new_root, actual_put_old));
> +
> +	/* If NORMAL it should have succeeded */
> +	if (test_cases[test_case].test_case == NORMAL) {
> +		if (TST_RET) {
> +			tst_res(TFAIL | TERRNO, "pivot_root failed");
> +			exit(TBROK);
> +		} else {
> +			tst_res(TPASS, "pivot_root succeeded");
> +			exit(TPASS);
> +		}
> +	}
> +
> +	/* pivot_root is expected to fail */
> +	if (TST_RET == 0) {
> +		tst_res(TFAIL, "pivot_root succeeded unexpectedly");
> +		exit(TBROK);
> +	}
> +
> +	/* Check error code is correct */
> +	if (errno != test_cases[test_case].expected_error) {
> +		tst_res(TFAIL | TERRNO,	"pivot_root failed with wrong errno");
> +		exit(TBROK);
> +	}
> +
> +	tst_res(TPASS, "pivot_root failed as expected with %s",
> +		strerror(errno));
> +	exit(TPASS);
> +}
> +
> +#else
> +static void run(void)
> +{
> +	tst_brk(TCONF, NULL, "unshare is undefined.");
> +}
> +#endif
> +
> +static void setup(void)
> +{
> +	SAFE_MKDIR(chroot_dir, 0777);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(test_cases),
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +};
> -- 
> 2.21.0.352.gf09ad66450-goog
> 

Lgtm, besides the TCONF issue.
Reviewed-by: Matthias Maennich <maennich@google.com>

Thanks!

-- 
Cheers,
Matthias
