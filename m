From: Paul Lawrence <paullawrence@google.com>
Date: Thu, 28 Feb 2019 11:36:45 -0800
Subject: [LTP] [PATCH] Add ltp pivot_root test
Message-ID: <20190228193645.51244-1-paullawrence@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

pivot_root03.c is missing - it tests the claim that pivot_root fails
with EBUSY if a filesystem is mounted on put_old, but this is no longer
true.

Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 testcases/kernel/syscalls/pivot_root/Makefile | 23 +++++
 .../kernel/syscalls/pivot_root/pivot_root01.c | 66 +++++++++++++
 .../kernel/syscalls/pivot_root/pivot_root02.c | 78 +++++++++++++++
 .../kernel/syscalls/pivot_root/pivot_root04.c | 82 ++++++++++++++++
 .../kernel/syscalls/pivot_root/pivot_root05.c | 76 +++++++++++++++
 .../kernel/syscalls/pivot_root/pivot_root06.c | 94 +++++++++++++++++++
 6 files changed, 419 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pivot_root/Makefile
 create mode 100644 testcases/kernel/syscalls/pivot_root/pivot_root01.c
 create mode 100644 testcases/kernel/syscalls/pivot_root/pivot_root02.c
 create mode 100644 testcases/kernel/syscalls/pivot_root/pivot_root04.c
 create mode 100644 testcases/kernel/syscalls/pivot_root/pivot_root05.c
 create mode 100644 testcases/kernel/syscalls/pivot_root/pivot_root06.c

diff --git a/testcases/kernel/syscalls/pivot_root/Makefile b/testcases/kernel/syscalls/pivot_root/Makefile
new file mode 100644
index 000000000..a6f0e1499
--- /dev/null
+++ b/testcases/kernel/syscalls/pivot_root/Makefile
@@ -0,0 +1,23 @@
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS += -lcap
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/pivot_root/pivot_root01.c b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
new file mode 100644
index 000000000..f0b884774
--- /dev/null
+++ b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Copyright (c) 2019 Google, Inc.
+
+#define _GNU_SOURCE
+
+#include <linux/unistd.h>
+#include <sched.h>
+#include <sys/mount.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+
+#ifdef HAVE_UNSHARE
+
+static void run(void)
+{
+	const char* chroot_dir = "chroot";
+	const char* new_root = "/new_root";
+	const char* put_old = "/new_root/put_old";
+
+	int pid;
+
+	if ((pid = SAFE_FORK()) == -1) {
+		tst_brk(TBROK, "Could not fork");
+	}
+
+	if (pid == 0) {
+		if (unshare(CLONE_NEWNS | CLONE_FS)) {
+			tst_res(TFAIL | TERRNO, "unshare failed");
+			exit (1);
+		}
+
+		SAFE_MOUNT("none", "/", NULL, MS_REC|MS_PRIVATE, NULL);
+		SAFE_MKDIR(chroot_dir, 0777);
+		SAFE_MOUNT("none", chroot_dir, "tmpfs", 0, 0);
+		SAFE_CHROOT(chroot_dir);
+		SAFE_MKDIR(new_root, 0777);
+		SAFE_MOUNT("none", new_root, "tmpfs", 0, 0);
+		SAFE_MKDIR(put_old, 0777);
+
+		if (syscall(__NR_pivot_root, new_root, put_old) == -1) {
+			tst_res(TFAIL | TERRNO, "pivot_root failed");
+			exit (1);
+		}
+
+		tst_res(TPASS, "pivot_root succeeded");
+		exit(0);
+	}
+
+	tst_reap_children();
+}
+
+#else
+static void run(void)
+{
+	tst_brk(TCONF, NULL, "unshare is undefined.");
+}
+#endif
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/pivot_root/pivot_root02.c b/testcases/kernel/syscalls/pivot_root/pivot_root02.c
new file mode 100644
index 000000000..41339c768
--- /dev/null
+++ b/testcases/kernel/syscalls/pivot_root/pivot_root02.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Copyright (c) 2019 Google, Inc.
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/unistd.h>
+#include <sched.h>
+#include <sys/mount.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+
+#ifdef HAVE_UNSHARE
+
+static void run(void)
+{
+	const char* chroot_dir = "chroot";
+	const char* new_root = "/new_root";
+	const char* put_old = "/new_root/put_old";
+
+	int pid;
+
+	if ((pid = SAFE_FORK()) == -1)
+		tst_brk(TBROK, "Could not fork");
+
+	if (pid == 0) {
+		if (unshare(CLONE_NEWNS | CLONE_FS)) {
+			tst_res(TFAIL | TERRNO, "unshare failed");
+			exit (1);
+		}
+
+		SAFE_MOUNT("none", "/", NULL, MS_REC|MS_PRIVATE, NULL);
+		SAFE_MKDIR(chroot_dir, 0777);
+		SAFE_MOUNT("none", chroot_dir, "tmpfs", 0, 0);
+		SAFE_CHROOT(chroot_dir);
+		SAFE_MKDIR(new_root, 0777);
+
+		// EBUSY
+		// new_root or put_old are on the current root file system
+		//
+		// Comment out to trigger this error
+		// SAFE_MOUNT("none", new_root, "tmpfs", 0, 0);
+
+		SAFE_MKDIR(put_old, 0777);
+
+		if (syscall(__NR_pivot_root, new_root, put_old) == 0) {
+			tst_res(TFAIL, "pivot_root succeeded unexpectedly");
+			exit (1);
+		}
+
+		if (errno != EBUSY) {
+			tst_res(TFAIL | TERRNO,
+				"pivot_root failed with wrong errno");
+			exit (1);
+		}
+
+		tst_res(TPASS, "pivot_root failed with EBUSY as expected");
+		exit(0);
+	}
+
+	tst_reap_children();
+}
+
+#else
+static void run(void)
+{
+	tst_brk(TCONF, NULL, "unshare is undefined.");
+}
+#endif
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/pivot_root/pivot_root04.c b/testcases/kernel/syscalls/pivot_root/pivot_root04.c
new file mode 100644
index 000000000..d2959130d
--- /dev/null
+++ b/testcases/kernel/syscalls/pivot_root/pivot_root04.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Copyright (c) 2019 Google, Inc.
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/unistd.h>
+#include <sched.h>
+#include <sys/mount.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+
+#ifdef HAVE_UNSHARE
+
+static void run(void)
+{
+	const char* chroot_dir = "chroot";
+	const char* new_root = "/new_root";
+
+	// EINVAL
+	// put_old is not underneath new_root
+	// Note: if put_old and new_root are on the same fs,
+	// pivot_root fails with EBUSY before testing reachability
+	const char* put_old_fs = "/put_old_fs";
+	const char* put_old = "/put_old_fs/put_old";
+
+	int pid;
+
+	if ((pid = SAFE_FORK()) == -1) {
+		tst_brk(TBROK, "Could not fork");
+	}
+
+	if (pid == 0) {
+		if (unshare(CLONE_NEWNS | CLONE_FS)) {
+			tst_res(TFAIL | TERRNO, "unshare failed");
+			exit (1);
+		}
+
+		SAFE_MOUNT("none", "/", NULL, MS_REC|MS_PRIVATE, NULL);
+		SAFE_MKDIR(chroot_dir, 0777);
+		SAFE_MOUNT("none", chroot_dir, "tmpfs", 0, 0);
+		SAFE_CHROOT(chroot_dir);
+		SAFE_MKDIR(new_root, 0777);
+		SAFE_MOUNT("none", new_root, "tmpfs", 0, 0);
+
+		SAFE_MKDIR(put_old_fs, 0777);
+		SAFE_MOUNT("none", put_old_fs, "tmpfs", 0, 0);
+		SAFE_MKDIR(put_old, 0777);
+
+		if (syscall(__NR_pivot_root, new_root, put_old) == 0) {
+			tst_res(TFAIL, "pivot_root succeeded unexpectedly");
+			exit (1);
+		}
+
+		if (errno != EINVAL) {
+			tst_res(TFAIL | TERRNO,
+				"pivot_root failed with wrong errno");
+			exit (1);
+		}
+
+		tst_res(TPASS, "pivot_root failed with EINVAL as expected");
+		exit(0);
+	}
+
+	tst_reap_children();
+}
+
+#else
+static void run(void)
+{
+	tst_brk(TCONF, NULL, "unshare is undefined.");
+}
+#endif
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/pivot_root/pivot_root05.c b/testcases/kernel/syscalls/pivot_root/pivot_root05.c
new file mode 100644
index 000000000..7f58fccfc
--- /dev/null
+++ b/testcases/kernel/syscalls/pivot_root/pivot_root05.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Copyright (c) 2019 Google, Inc.
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/unistd.h>
+#include <sched.h>
+#include <sys/mount.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+
+#ifdef HAVE_UNSHARE
+
+static void run(void)
+{
+	const char* chroot_dir = "chroot";
+	const char* new_root = "/new_root";
+	const char* put_old = "/new_root/put_old";
+
+	int pid;
+
+	if ((pid = SAFE_FORK()) == -1) {
+		tst_brk(TBROK, "Could not fork");
+	}
+
+	if (pid == 0) {
+		if (unshare(CLONE_NEWNS | CLONE_FS)) {
+			tst_res(TFAIL | TERRNO, "unshare failed");
+			exit (1);
+		}
+
+		SAFE_MOUNT("none", "/", NULL, MS_REC|MS_PRIVATE, NULL);
+		SAFE_MKDIR(chroot_dir, 0777);
+		SAFE_MOUNT("none", chroot_dir, "tmpfs", 0, 0);
+		SAFE_CHROOT(chroot_dir);
+		SAFE_MKDIR(new_root, 0777);
+		SAFE_MOUNT("none", new_root, "tmpfs", 0, 0);
+
+		// ENOTDIR
+		// new_root or put_old is not a directory
+		SAFE_CREAT(put_old, 0777);
+
+		if (syscall(__NR_pivot_root, new_root, put_old) == 0) {
+			tst_res(TFAIL, "pivot_root succeeded unexpectedly");
+			exit (1);
+		}
+
+		if (errno != ENOTDIR) {
+			tst_res(TFAIL | TERRNO,
+				"pivot_root failed with wrong errno");
+			exit (1);
+		}
+
+		tst_res(TPASS, "pivot_root failed with EBUSY as expected");
+		exit(0);
+	}
+
+	tst_reap_children();
+}
+
+#else
+static void run(void)
+{
+	tst_brk(TCONF, NULL, "unshare is undefined.");
+}
+#endif
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/pivot_root/pivot_root06.c b/testcases/kernel/syscalls/pivot_root/pivot_root06.c
new file mode 100644
index 000000000..ac3b08321
--- /dev/null
+++ b/testcases/kernel/syscalls/pivot_root/pivot_root06.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Copyright (c) 2019 Google, Inc.
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/unistd.h>
+#include <sched.h>
+#include <sys/capability.h>
+#include <sys/mount.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+
+#ifdef HAVE_UNSHARE
+
+static void run(void)
+{
+	const char* chroot_dir = "chroot";
+	const char* new_root = "/new_root";
+	const char* put_old = "/new_root/put_old";
+
+	int pid;
+
+	if ((pid = SAFE_FORK()) == -1) {
+		tst_brk(TBROK, "Could not fork");
+	}
+
+
+	if (pid == 0) {
+		if (unshare(CLONE_NEWNS | CLONE_FS)) {
+			tst_res(TFAIL | TERRNO, "unshare failed");
+			exit (1);
+		}
+
+		SAFE_MOUNT("none", "/", NULL, MS_REC|MS_PRIVATE, NULL);
+		SAFE_MKDIR(chroot_dir, 0777);
+		SAFE_MOUNT("none", chroot_dir, "tmpfs", 0, 0);
+		SAFE_CHROOT(chroot_dir);
+		SAFE_MKDIR(new_root, 0777);
+		SAFE_MOUNT("none", new_root, "tmpfs", 0, 0);
+		SAFE_MKDIR(put_old, 0777);
+
+		// EPERM
+		// The calling process does not have the CAP_SYS_ADMIN capability.
+		cap_value_t cap_value[] = { CAP_SYS_ADMIN };
+		cap_t cap = cap_get_proc();
+		if (!cap) {
+			tst_res(TFAIL | TERRNO, "cap_get_proc failed");
+			exit (1);
+		}
+
+		if (cap_set_flag(cap, CAP_EFFECTIVE, 1, cap_value, CAP_CLEAR)) {
+			tst_res(TFAIL | TERRNO, "cap_set_flag failed");
+			exit (1);
+		}
+
+		if (cap_set_proc(cap)) {
+			tst_res(TFAIL | TERRNO, "cap_set_proc failed");
+			exit (1);
+		}
+
+		if (syscall(__NR_pivot_root, new_root, put_old) == 0) {
+			tst_res(TFAIL, "pivot_root succeeded unexpectedly");
+			exit (1);
+		}
+
+		if (errno != EPERM) {
+			tst_res(TFAIL | TERRNO,
+				"pivot_root failed with wrong errno");
+			exit (1);
+		}
+
+		tst_res(TPASS, "pivot_root failed with EPERM as expected");
+		exit(0);
+	}
+
+	tst_reap_children();
+}
+
+#else
+static void run(void)
+{
+	tst_brk(TCONF, NULL, "unshare is undefined.");
+}
+#endif
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.21.0.352.gf09ad66450-goog

