From: Matthias Maennich <maennich@google.com>
Date: Mon, 4 Mar 2019 12:26:39 +0000
Subject: [LTP] [PATCH v2] Add ltp pivot_root test
In-Reply-To: <20190301185534.37513-1-paullawrence@google.com>
References: <20190301185534.37513-1-paullawrence@google.com>
Message-ID: <20190304122639.GA90147@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Paul!

On Fri, Mar 01, 2019 at 10:55:34AM -0800, Paul Lawrence wrote:
> Replaced license
> Merged all files into one parameterized file
> Modified touse test_brk where appropriate
> 
> For the actual test results, using tst_brk from the child process
> meant failures were not counted correctly, so I still use tst_res
> and exit. Please let me know if there is a correct way of doing this.
> 
> Signed-off-by: Paul Lawrence <paullawrence@google.com>
> ---
>  testcases/kernel/syscalls/pivot_root/Makefile |  11 ++
>  .../kernel/syscalls/pivot_root/pivot_root01.c | 168 ++++++++++++++++++
>  2 files changed, 179 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/pivot_root/Makefile
>  create mode 100644 testcases/kernel/syscalls/pivot_root/pivot_root01.c
> 
> diff --git a/testcases/kernel/syscalls/pivot_root/Makefile b/testcases/kernel/syscalls/pivot_root/Makefile
> new file mode 100644
> index 000000000..ce8f8cb68
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
> +CFLAGS += -lcap
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/pivot_root/pivot_root01.c b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
> new file mode 100644
> index 000000000..3aa939ac9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +//
> +// Copyright (c) 2019 Google, Inc.
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <linux/unistd.h>
> +#include <sched.h>
> +#include <sys/capability.h>
This include is not available on systems without libcap-devel or similar
installed. I suggest you compile this test conditional. A similar
mechanism is implemented for libaio-devel (HAVE_LIBAIO).

> +#include <sys/mount.h>
> +#include <stdlib.h>
> +
> +#include "tst_test.h"
> +
> +static const char* chroot_dir = "chroot";
> +static const char* new_root = "/new_root";
> +static const char* put_old = "/new_root/put_old";
> +
> +// Test consists of a series of steps that allow pivot_root to succeed, which is
> +// run when param is NORMAL. All other values tweak one of the steps to induce
> +// a failure, and check the errno is as expected.
> +#define NORMAL 0
> +
> +// EBUSY
> +// new_root or put_old are on the current root file system
> +#define NEW_ROOT_ON_CURRENT_ROOT 1
> +
> +// EINVAL
> +// put_old is not underneath new_root
> +// Note: if put_old and new_root are on the same fs,
> +// pivot_root fails with EBUSY before testing reachability
> +#define PUT_OLD_NOT_UNDERNEATH_NEW_ROOT 2
> +
> +static const char* put_old_fs = "/put_old_fs";
> +static const char* put_old_bad = "/put_old_fs/put_old";
Even though these constants belong to this define, I would move them up
to have all string constants defined in a single place.

> +
> +// ENOTDIR
> +// new_root or put_old is not a directory
> +#define PUT_OLD_NOT_DIR 3
> +
> +// EPERM
> +// The calling process does not have the CAP_SYS_ADMIN capability.
> +#define NO_CAP_SYS_ADMIN 4
> +
> +#define TEST_COUNT 5
== ARRAY_SIZE(expected_error) ...  and can be defined directly in the
tst_test struct.

> +
> +static int expected_error[] = {
> +	0,
> +	EBUSY,
> +	EINVAL,
> +	ENOTDIR,
> +	EPERM,
> +};
Maybe you are able to combine the defines, the documentation and this array
into one array of testcase structs.
(see e.g.  testcases/kernel/syscalls/umount/umount02.c)
That would be a bit more descriptive and easier to add more test cases.

> +
> +static void drop_cap_sys_admin(void) {
braces

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
> +
> +#ifdef HAVE_UNSHARE
> +static void run(unsigned int param)
'param' is a bit bit generic, how about 'testcase' ?

> +{
> +	// Work in child process - needed to undo unshare and chroot
> +	if (SAFE_FORK()) {
> +		tst_reap_children();
> +		return;
> +	}
> +
> +	// pivot_root requires no shared mounts exist in process namespace
> +	TEST(unshare(CLONE_NEWNS | CLONE_FS));
> +	if (TST_RET == -1)
> +		tst_brk(TFAIL | TERRNO, "unshare failed");
> +
> +	// Create an initial root dir. pivot_root doesn't work if the initial root
> +	// dir is a initramfs, so use chroot to create a safe environment
> +	SAFE_MOUNT("none", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> +	SAFE_MOUNT("none", chroot_dir, "tmpfs", 0, 0);
> +	SAFE_CHROOT(chroot_dir);
> +
> +	// Create our new root location
> +	SAFE_MKDIR(new_root, 0777);
> +
> +	// pivot_root only works if new_root is a mount point, so mount a tmpfs
> +	// unless testing for that fail mode
> +	if (param != NEW_ROOT_ON_CURRENT_ROOT)
> +		SAFE_MOUNT("none", new_root, "tmpfs", 0, 0);
> +
> +	// Create put_old under new_root, unless testing for that specific fail
> +	// mode
> +	const char* actual_put_old = NULL;
> +	if (param == PUT_OLD_NOT_UNDERNEATH_NEW_ROOT) {
> +		actual_put_old = put_old_bad;
> +		SAFE_MKDIR(put_old_fs, 0777);
> +		SAFE_MOUNT("none", put_old_fs, "tmpfs", 0, 0);
> +		SAFE_MKDIR(put_old_bad, 0777);
> +	} else {
> +		actual_put_old = put_old;
> +
> +		// put_old must be a directory for success
> +		if (param == PUT_OLD_NOT_DIR)
> +			SAFE_CREAT(put_old, 0777);
> +		else
> +			SAFE_MKDIR(put_old, 0777);
> +	}
> +
> +	if (param == NO_CAP_SYS_ADMIN)
> +		drop_cap_sys_admin();
> +
> +	// Test the syscall
> +	TEST(syscall(__NR_pivot_root, new_root, actual_put_old));
> +
> +	// If NORMAL it should have succeeded
> +	if (param == NORMAL) {
> +		if (TST_RET) {
> +			tst_res(TFAIL | TERRNO, "pivot_root failed");
> +			exit(TBROK);
> +		} else {
> +			tst_res(TPASS, "pivot_root succeeded");
> +			exit(TPASS);
> +		}
> +	}
> +
> +	// pivot_root is expected to fail
> +	if (TST_RET == 0) {
> +		tst_res(TFAIL, "pivot_root succeeded unexpectedly");
> +		exit(TBROK);
> +	}
> +
> +	// Check error code is correct
> +	if (errno != expected_error[param]) {
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
> +	.tcnt = TEST_COUNT,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +};
> -- 
> 2.21.0.352.gf09ad66450-goog

Thanks for addressing all the previous comments!

-- 
Cheers,
Matthias

