From: Federico Bonfiglio <fedebonfi95@gmail.com>
Date: Thu, 11 Apr 2019 21:25:34 +0200
Subject: [LTP] [PATCH v5] Test ioctl syscall for NS_GET_* requests
In-Reply-To: <20190403152245.GC26464@rei.lan>
References: <20190403152245.GC26464@rei.lan>
Message-ID: <20190411192534.30525-1-fedebonfi95@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Federico Bonfiglio <fedebonfi95@gmail.com>
---
Hi Cyril,

the missing test number 3 resulted from merging two other tests in a previous patch version. I numbered subsequent tests in this patch to fill the gap.

About the unshare call, I removed it entirely since placing it in the setup() caused: 

ioctl_ns05.c:35: BROK: fork() failed: ENOMEM

This seems to originate from the fact that unsharing in setup didn't make the testing framework reap forked processes correctly, since every forked test run after the setup thinks to have pid 0. So when it checks if the pid is different from the initial pid (also 0) it finds them equal. This is of course as I understood the problem, and being a beginner with the framework I'm not entirely sure.

To solve the issue I did what I was doing in ioctl_ns06.c (ex number 7), directly calling clone() and not unshare() and then fork().

Let me know if you like this solution, and thanks again

 include/lapi/ioctl_ns.h                      | 28 ++++++++++
 runtest/syscalls                             |  8 +++
 testcases/kernel/syscalls/ioctl/.gitignore   |  7 +++
 testcases/kernel/syscalls/ioctl/ioctl_ns01.c | 72 ++++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns02.c | 49 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns03.c | 50 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns04.c | 48 ++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c | 82 ++++++++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 78 ++++++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ns07.c | 48 ++++++++++++++++
 10 files changed, 470 insertions(+)
 create mode 100644 include/lapi/ioctl_ns.h
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns01.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns02.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns03.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns04.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns05.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns06.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns07.c

diff --git a/include/lapi/ioctl_ns.h b/include/lapi/ioctl_ns.h
new file mode 100644
index 000000000..2fb4f4cfb
--- /dev/null
+++ b/include/lapi/ioctl_ns.h
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
+ */
+
+#ifndef IOCTL_NS_H__
+#define IOCTL_NS_H__
+
+#include <asm-generic/ioctl.h>
+
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
+#endif /* IOCTL_NS_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index e8fe9785a..5267c4d93 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -504,6 +504,14 @@ ioctl06      ioctl06
 ioctl07      ioctl07
 ioctl08      ioctl08
 
+ioctl_ns01 ioctl_ns01
+ioctl_ns02 ioctl_ns02
+ioctl_ns03 ioctl_ns03
+ioctl_ns04 ioctl_ns04
+ioctl_ns05 ioctl_ns05
+ioctl_ns06 ioctl_ns06
+ioctl_ns07 ioctl_ns07
+
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
 
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 4d480a0ed..2551ffb7f 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -6,3 +6,10 @@
 /ioctl06
 /ioctl07
 /ioctl08
+/ioctl_ns01
+/ioctl_ns02
+/ioctl_ns03
+/ioctl_ns04
+/ioctl_ns05
+/ioctl_ns06
+/ioctl_ns07
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
new file mode 100644
index 000000000..59b215f2b
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
@@ -0,0 +1,72 @@
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
+#define STACK_SIZE (1024 * 1024)
+
+static char child_stack[STACK_SIZE];
+
+static void setup(void)
+{
+	int exists = access("/proc/self/ns/pid", F_OK);
+
+	if (exists < 0)
+		tst_res(TCONF, "namespace not available");
+}
+
+static void test_ns_get_parent(void)
+{
+	int fd, parent_fd;
+
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
+static int child(void *arg)
+{
+	test_ns_get_parent();
+	return 0;
+}
+
+static void run(void)
+{
+	test_ns_get_parent();
+
+	ltp_clone(CLONE_NEWPID, &child, 0,
+		STACK_SIZE, child_stack);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_root = 1,
+	.min_kver = "4.9",
+	.setup = setup
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns02.c b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
new file mode 100644
index 000000000..4f5cb1427
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns02.c
@@ -0,0 +1,49 @@
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
+static void setup(void)
+{
+	int exists = access("/proc/self/ns/uts", F_OK);
+
+	if (exists < 0)
+		tst_res(TCONF, "namespace not available");
+}
+
+static void run(void)
+{
+	int fd, parent_fd;
+
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
+	.setup = setup
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns03.c b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
new file mode 100644
index 000000000..2e19cff3a
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns03.c
@@ -0,0 +1,50 @@
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
+static void setup(void)
+{
+	int exists = access("/proc/self/ns/uts", F_OK);
+
+	if (exists < 0)
+		tst_res(TCONF, "namespace not available");
+}
+
+static void run(void)
+{
+	int fd, owner_fd;
+
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
+	.setup = setup
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns04.c b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
new file mode 100644
index 000000000..b9181cb3d
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns04.c
@@ -0,0 +1,48 @@
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
+static void setup(void)
+{
+	int exists = access("/proc/self/ns/user", F_OK);
+
+	if (exists < 0)
+		tst_res(TCONF, "namespace not available");
+}
+
+static void run(void)
+{
+	int fd, parent_fd;
+
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
+	.setup = setup
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
new file mode 100644
index 000000000..5d89c03b0
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -0,0 +1,82 @@
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
+#define STACK_SIZE (1024 * 1024)
+
+static char child_stack[STACK_SIZE];
+
+static void setup(void)
+{
+	int exists = access("/proc/self/ns/pid", F_OK);
+
+	if (exists < 0)
+		tst_res(TCONF, "namespace not available");
+}
+
+static int child(void *arg)
+{
+	if (getpid() != 1)
+		tst_res(TFAIL, "child should think its pid is 1");
+	else
+		tst_res(TPASS, "child thinks its pid is 1");
+	TST_CHECKPOINT_WAIT(0);
+	return 0;
+}
+
+static void run(void)
+{
+	pid_t pid = ltp_clone(CLONE_NEWPID, &child, 0,
+		STACK_SIZE, child_stack);
+
+	char child_namespace[20];
+	int my_fd, child_fd, parent_fd;
+
+	sprintf(child_namespace, "/proc/%i/ns/pid", pid);
+	my_fd = SAFE_OPEN("/proc/self/ns/pid", O_RDONLY);
+	child_fd = SAFE_OPEN(child_namespace, O_RDONLY);
+	parent_fd = SAFE_IOCTL(child_fd, NS_GET_PARENT);
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
+	SAFE_CLOSE(child_fd);
+	SAFE_CLOSE(parent_fd);
+	TST_CHECKPOINT_WAKE(0);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.min_kver = "4.9",
+	.setup = setup
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
new file mode 100644
index 000000000..f077a3bb7
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
@@ -0,0 +1,78 @@
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
+static void setup(void)
+{
+	int exists = access("/proc/self/ns/user", F_OK);
+
+	if (exists < 0)
+		tst_res(TCONF, "namespace not available");
+}
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
+	int my_fd, child_fd, parent_fd;
+
+	my_fd = SAFE_OPEN("/proc/self/ns/user", O_RDONLY);
+	child_fd = SAFE_OPEN(child_namespace, O_RDONLY);
+	parent_fd = SAFE_IOCTL(child_fd, NS_GET_USERNS);
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
+	.setup = setup
+};
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns07.c b/testcases/kernel/syscalls/ioctl/ioctl_ns07.c
new file mode 100644
index 000000000..06cf70a17
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns07.c
@@ -0,0 +1,48 @@
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
+	int fd, ns_fd;
+
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
+	.min_kver = "4.11"
+};
-- 
2.11.0

