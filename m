From: Federico Bonfiglio <fedebonfi95@gmail.com>
Date: Mon, 11 Mar 2019 08:25:37 +0100
Subject: [LTP] [PATCH v2] Test ioctl syscall for NS_GET_* requests
In-Reply-To: <20190304161602.GB15696@rei>
References: <20190304161602.GB15696@rei>
Message-ID: <20190311072537.22080-1-fedebonfi95@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
Thanks Cyril for your review. I hope this one is better, also I could't use 
SAFE_IOCTL because compilations fails this way:

ioctl_ns06.c: In function 'run':
ioctl_ns06.c:46:13: error: void value not ignored as it ought to be
   parent_fd = SAFE_IOCTL(child_fd, NS_GET_PARENT);
             ^
<builtin>: recipe for target 'ioctl_ns06' failed
make: *** [ioctl_ns06] Error 1

I need the return value since it's the process pid. Am I doing somthing wrong
with this safe call?

 include/lapi/ioctl_ns.h                      | 29 +++++++++++
 include/tst_safe_macros.h                    |  4 ++
 lib/tst_safe_macros.c                        | 17 +++++++
 runtest/syscalls                             |  8 +++
 testcases/kernel/syscalls/ioctl/.gitignore   |  7 +++
 testcases/kernel/syscalls/ioctl/ioctl_ns01.c | 59 ++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns02.c | 43 ++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns04.c | 44 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c | 42 ++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 72 +++++++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns07.c | 73 ++++++++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns08.c | 51 +++++++++++++++++++
 12 files changed, 449 insertions(+)
 create mode 100644 include/lapi/ioctl_ns.h
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns01.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns02.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns04.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns05.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns06.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns07.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns08.c

diff --git a/include/lapi/ioctl_ns.h b/include/lapi/ioctl_ns.h
new file mode 100644
index 000000000..ebaf43a24
--- /dev/null
+++ b/include/lapi/ioctl_ns.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ */
+
+#ifndef __IOCTL_NS_H__
+#define __IOCTL_NS_H__
+
+#ifndef _IO
+#define _IO			volatile
+#endif
+#ifndef NSIO
+#define NSIO	0xb7
+#endif
+#ifndef NS_GET_PARENT
+#define NS_GET_PARENT		_IO(NSIO, 0x2)
+#endif
+#ifndef NS_GET_OWNER_UID
+#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
+#endif
+#ifndef NS_GET_USERNS
+#define NS_GET_USERNS		_IO(NSIO, 0x1)
+#endif
+#ifndef NS_GET_NSTYPE
+#define NS_GET_NSTYPE		_IO(NSIO, 0x3)
+#endif
+
+
+#endif /* __IOCTL_NS_H__ */
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d31762f4a..b63e7493a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -526,4 +526,8 @@ int safe_personality(const char *filename, unsigned int lineno,
 	}							\
 	} while (0)
 
+void safe_unshare(const char *file, const int lineno, int flags);
+#define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
+
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index c375030a4..761d1d3dd 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -18,6 +18,7 @@
 #define _GNU_SOURCE
 #include <unistd.h>
 #include <errno.h>
+#include <sched.h>
 #include "config.h"
 #ifdef HAVE_SYS_FANOTIFY_H
 # include <sys/fanotify.h>
@@ -197,3 +198,19 @@ int safe_chroot(const char *file, const int lineno, const char *path)
 
 	return rval;
 }
+
+void safe_unshare(const char *file, const int lineno, int flags)
+{
+	int res;
+
+	res = unshare(flags);
+	if (res == -1) {
+		if (errno == EINVAL) {
+			tst_brk_(file, lineno, TCONF,
+				 "unshare(%d) failed", flags);
+		} else {
+			tst_brk_(file, lineno, TBROK | TERRNO,
+				 "dup(%d) failed", flags);
+		}
+	}
+}
diff --git a/runtest/syscalls b/runtest/syscalls
index 978a56a07..f8fa2dfc4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -500,6 +500,14 @@ ioctl06      ioctl06
 
 ioctl07      ioctl07
 
+ioctl_ns01 ioctl_ns01
+ioctl_ns02 ioctl_ns02
+ioctl_ns04 ioctl_ns04
+ioctl_ns05 ioctl_ns05
+ioctl_ns06 ioctl_ns06
+ioctl_ns07 ioctl_ns07
+ioctl_ns08 ioctl_ns08
+
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
 
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 79516a17c..57d6a58fa 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -5,3 +5,10 @@
 /ioctl05
 /ioctl06
 /ioctl07
+/ioctl_ns01
+/ioctl_ns02
+/ioctl_ns04
+/ioctl_ns05
+/ioctl_ns06
+/ioctl_ns07
+/ioctl_ns08
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
new file mode 100644
index 000000000..88f3fb043
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_PARENT request.
+ *
+ * Parent process tries to get parent of initial namespace, which should
+ * fail with EPERM because it has no parent.
+ *
+ * Child process has a new pid namespace, which should make the call fail
+ * with EPERM error.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <sched.h>
+#include "tst_test.h"
+#include "lapi/ioctl_ns.h"
+
+static void test_ns_get_parent(void)
+{
+	int exists, fd, parent_fd;
+
+	exists = access("/proc/self/ns/pid", F_OK);
+	if (exists < 0)
+		tst_res(TCONF, "namespace not available");
+	fd = SAFE_OPEN("/proc/self/ns/pid", O_RDONLY);
+	parent_fd = ioctl(fd, NS_GET_PARENT);
+	if (parent_fd == -1) {
+		if (errno == EPERM)
+			tst_res(TPASS, "NS_GET_PARENT fails with EPERM");
+		else
+			tst_res(TFAIL | TERRNO, "unexpected ioctl error");
+	} else {
+		SAFE_CLOSE(fd);
+		tst_res(TFAIL, "call to ioctl succeded");
+	}
+}
+
+static void run(void)
+{
+	test_ns_get_parent();
+	SAFE_UNSHARE(CLONE_NEWPID);
+
+	pid_t pid = SAFE_FORK();
+
+	if (pid == 0)
+		test_ns_get_parent();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_root = 1,
+	.min_kver = "4.9",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns02.c b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
new file mode 100644
index 000000000..420e1708f
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_PARENT request.
+ *
+ * Tries to get namespace parent for UTS namespace, which
+ * should make the call fail with EINVAL, being a nonhierarchical
+ * namespace.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include "tst_test.h"
+#include "lapi/ioctl_ns.h"
+
+static void run(void)
+{
+	int exists, fd, parent_fd;
+
+	exists = access("/proc/self/ns/uts", F_OK);
+	if (exists < 0)
+		tst_res(TCONF, "namespace not available");
+	fd = SAFE_OPEN("/proc/self/ns/uts", O_RDONLY);
+	parent_fd = ioctl(fd, NS_GET_PARENT);
+	if (parent_fd == -1) {
+		if (errno == EINVAL)
+			tst_res(TPASS, "NS_GET_PARENT fails with EINVAL");
+		else
+			tst_res(TFAIL | TERRNO, "unexpected ioctl error");
+	} else {
+		SAFE_CLOSE(fd);
+		tst_res(TFAIL, "call to ioctl succeded");
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.9",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns04.c b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
new file mode 100644
index 000000000..a4465ef1e
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_OWNER_UID request.
+ *
+ * Calls ioctl for a UTS namespace, which isn't a user namespace.
+ * This should make the call fail with EINVAL.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include "tst_test.h"
+#include "lapi/ioctl_ns.h"
+
+static void run(void)
+{
+	int exists, fd, owner_fd;
+
+	exists = access("/proc/self/ns/uts", F_OK);
+	if (exists < 0)
+		tst_res(TCONF, "namespace not available");
+	fd = SAFE_OPEN("/proc/self/ns/uts", O_RDONLY);
+	uid_t uid;
+
+	owner_fd = ioctl(fd, NS_GET_OWNER_UID, &uid);
+	if (owner_fd == -1) {
+		if (errno == EINVAL)
+			tst_res(TPASS, "NS_GET_OWNER_UID fails, UTS namespace");
+		else
+			tst_res(TFAIL | TERRNO, "unexpected ioctl error");
+	} else {
+		SAFE_CLOSE(fd);
+		tst_res(TFAIL, "call to ioctl succeded");
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.11",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
new file mode 100644
index 000000000..c12f345e7
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_USERNS request.
+ *
+ * Owning user namespace of process calling ioctl is out of scope,
+ * which should make the call fail with EPERM.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include "tst_test.h"
+#include "lapi/ioctl_ns.h"
+
+static void run(void)
+{
+	int exists, fd, parent_fd;
+
+	exists = access("/proc/self/ns/user", F_OK);
+	if (exists < 0)
+		tst_res(TCONF, "namespace not available");
+	fd = SAFE_OPEN("/proc/self/ns/user", O_RDONLY);
+	parent_fd = ioctl(fd, NS_GET_USERNS);
+	if (parent_fd == -1) {
+		if (errno == EPERM)
+			tst_res(TPASS, "NS_GET_USERNS fails with EPERM");
+		else
+			tst_res(TFAIL | TERRNO, "unexpected ioctl error");
+	} else {
+		SAFE_CLOSE(fd);
+		tst_res(TFAIL, "call to ioctl succeded");
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.9",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
new file mode 100644
index 000000000..6fd6f758d
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_PARENT request.
+ *
+ * After the call to unshare with the CLONE_NEWPID flag,
+ * next new child is created in a new pid namespace. That's checked by
+ * comparing its /proc/self/ns/pid symlink and the parent's one.
+ * Also child thinks its pid is 1.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stdio.h>
+#include <sched.h>
+#include "tst_test.h"
+#include "lapi/ioctl_ns.h"
+
+static void run(void)
+{
+	SAFE_UNSHARE(CLONE_NEWPID);
+
+	pid_t pid = SAFE_FORK();
+
+	if (pid == 0) {
+		if (getpid() != 1)
+			tst_res(TFAIL, "child should think its pid is 1");
+		else
+			tst_res(TPASS, "child thinks its pid is 1");
+		TST_CHECKPOINT_WAIT(0);
+	} else {
+		char child_namespace[20];
+		int exists_1, exists_2, my_fd, child_fd, parent_fd;
+
+		sprintf(child_namespace, "/proc/%i/ns/pid", pid);
+		exists_1 = access("/proc/self/ns/pid", F_OK);
+		exists_2 = access(child_namespace, F_OK);
+		if (exists_1 < 0 || exists_2 < 0)
+			tst_res(TCONF, "namespace not available");
+		my_fd = SAFE_OPEN("/proc/self/ns/pid", O_RDONLY);
+		child_fd = SAFE_OPEN(child_namespace, O_RDONLY);
+		parent_fd = ioctl(child_fd, NS_GET_PARENT);
+
+		struct stat my_stat, child_stat, parent_stat;
+
+		SAFE_FSTAT(my_fd, &my_stat);
+		SAFE_FSTAT(child_fd, &child_stat);
+		SAFE_FSTAT(parent_fd, &parent_stat);
+		if (my_stat.st_ino != parent_stat.st_ino)
+			tst_res(TFAIL, "parents have different inodes");
+		else if (parent_stat.st_ino == child_stat.st_ino)
+			tst_res(TFAIL, "child and parent have same inode");
+		else
+			tst_res(TPASS, "child and parent are consistent");
+		SAFE_CLOSE(my_fd);
+		SAFE_CLOSE(child_fd);
+		SAFE_CLOSE(parent_fd);
+		TST_CHECKPOINT_WAKE(0);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.min_kver = "4.9",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns07.c b/testcases/kernel/syscalls/ioctl/ioctl_ns07.c
new file mode 100644
index 000000000..88efb41a4
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns07.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_USERNS request.
+ *
+ * After the call to clone with the CLONE_NEWUSER flag,
+ * child is created in a new user namespace. That's checked by
+ * comparing its /proc/self/ns/user symlink and the parent's one,
+ * which should be different.
+ *
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stdio.h>
+#include <sched.h>
+#include "tst_test.h"
+#include "lapi/ioctl_ns.h"
+
+#define STACK_SIZE (1024 * 1024)
+
+static char child_stack[STACK_SIZE];
+
+static int child(void *arg)
+{
+	TST_CHECKPOINT_WAIT(0);
+	return 0;
+}
+
+static void run(void)
+{
+	pid_t pid = ltp_clone(CLONE_NEWUSER, &child, 0,
+		STACK_SIZE, child_stack);
+	char child_namespace[20];
+
+	sprintf(child_namespace, "/proc/%i/ns/user", pid);
+	int exists_1, exists_2, my_fd, child_fd, parent_fd;
+
+	exists_1 = access("/proc/self/ns/user", F_OK);
+	exists_2 = access(child_namespace, F_OK);
+	if (exists_1 < 0 || exists_2 < 0)
+		tst_res(TCONF, "namespace not available");
+	my_fd = SAFE_OPEN("/proc/self/ns/user", O_RDONLY);
+	child_fd = SAFE_OPEN(child_namespace, O_RDONLY);
+	parent_fd = ioctl(child_fd, NS_GET_USERNS);
+
+	struct stat my_stat, child_stat, parent_stat;
+
+	SAFE_FSTAT(my_fd, &my_stat);
+	SAFE_FSTAT(child_fd, &child_stat);
+	SAFE_FSTAT(parent_fd, &parent_stat);
+	if (my_stat.st_ino != parent_stat.st_ino)
+		tst_res(TFAIL, "parents have different inodes");
+	else if (parent_stat.st_ino == child_stat.st_ino)
+		tst_res(TFAIL, "child and parent have same inode");
+	else
+		tst_res(TPASS, "child and parent are consistent");
+	SAFE_CLOSE(my_fd);
+	SAFE_CLOSE(parent_fd);
+	SAFE_CLOSE(child_fd);
+	TST_CHECKPOINT_WAKE(0);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.min_kver = "4.9",
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns08.c b/testcases/kernel/syscalls/ioctl/ioctl_ns08.c
new file mode 100644
index 000000000..bc2026213
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns08.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ */
+
+/*
+ * Test ioctl_ns with NS_GET_* request for file descriptors
+ * that aren't namespaces.
+ *
+ * Calling ioctl with test directory's file descriptor
+ * should make the call fail with ENOTTY.
+ *
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include "tst_test.h"
+#include "lapi/ioctl_ns.h"
+
+static int requests[] = {NS_GET_PARENT, NS_GET_USERNS,
+	NS_GET_OWNER_UID, NS_GET_NSTYPE};
+
+static void test_request(unsigned int n)
+{
+	int request = requests[n];
+	int exists, fd, ns_fd;
+
+	exists = access(".", F_OK);
+	if (exists < 0)
+		tst_res(TCONF, "namespace not available");
+	fd = SAFE_OPEN(".", O_RDONLY);
+	ns_fd = ioctl(fd, request);
+	if (ns_fd == -1) {
+		if (errno == ENOTTY)
+			tst_res(TPASS, "request failed with ENOTTY");
+		else
+			tst_res(TFAIL | TERRNO, "unexpected ioctl error");
+	} else {
+		tst_res(TFAIL, "request success for invalid fd");
+		SAFE_CLOSE(ns_fd);
+	}
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(requests),
+	.test = test_request,
+	.needs_tmpdir = 1,
+	.min_kver = "4.11",
+};
-- 
2.11.0

