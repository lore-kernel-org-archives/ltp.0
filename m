From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Sun, 19 May 2019 15:25:55 +1000
Subject: [LTP] [PATCH v3 2/3] syscalls/fanotify14: new test to validate
 FAN_REPORT_FID return values
In-Reply-To: <cover.1558242368.git.mbobrowski@mbobrowski.org>
References: <cover.1558242368.git.mbobrowski@mbobrowski.org>
Message-ID: <eae729339e46a3a30017a896624241a6e3634c58.1558242368.git.mbobrowski@mbobrowski.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A newly defined test file has been introduced to validate that the
fanotify interface returns the correct error values upon specifying
invalid flags and masks in conjunction with FAN_REPORT_FID. A new line
entry within runtest/syscalls for this new test file.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  25 +++
 .../kernel/syscalls/fanotify/fanotify14.c     | 171 ++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify14.c

diff --git a/runtest/syscalls b/runtest/syscalls
index dfdc6cbf9..5c62895b0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -538,6 +538,7 @@ fanotify10 fanotify10
 fanotify11 fanotify11
 fanotify12 fanotify12
 fanotify13 fanotify13
+fanotify14 fanotify14
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index 16bdd99e5..bf389c96a 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -11,4 +11,5 @@
 /fanotify11
 /fanotify12
 /fanotify13
+/fanotify14
 /fanotify_child
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index d6e259002..92fc78dcc 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -69,6 +69,31 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 #ifndef FAN_MARK_FILESYSTEM
 #define FAN_MARK_FILESYSTEM	0x00000100
 #endif
+/* New dirent event masks */
+#ifndef FAN_ATTRIB
+#define FAN_ATTRIB		0x00000004
+#endif
+#ifndef FAN_MOVED_FROM
+#define FAN_MOVED_FROM		0x00000040
+#endif
+#ifndef FAN_MOVED_TO
+#define FAN_MOVED_TO		0x00000080
+#endif
+#ifndef FAN_CREATE
+#define FAN_CREATE		0x00000100
+#endif
+#ifndef FAN_DELETE
+#define FAN_DELETE		0x00000200
+#endif
+#ifndef FAN_DELETE_SELF
+#define FAN_DELETE_SELF		0x00000400
+#endif
+#ifndef FAN_MOVE_SELF
+#define FAN_MOVE_SELF		0x00000800
+#endif
+#ifndef FAN_MOVE
+#define FAN_MOVE		(FAN_MOVED_FROM | FAN_MOVED_TO)
+#endif
 #ifndef FAN_OPEN_EXEC
 #define FAN_OPEN_EXEC		0x00001000
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
new file mode 100644
index 000000000..735d6accf
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Matthew Bobrowski. All Rights Reserved.
+ *
+ * Started by Matthew Bobrowski <mbobrowski@mbobrowski.org>
+ *
+ * DESCRIPTION
+ *	This test file has been designed to ensure that the fanotify
+ *	system calls fanotify_init(2) and fanotify_mark(2) return the
+ *	correct error code to the calling process when an invalid flag or
+ *	mask value has been specified in conjunction with FAN_REPORT_FID.
+ */
+
+#include "tst_test.h"
+#include "fanotify.h"
+
+#include <errno.h>
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+
+#define MNTPOINT "mntpoint"
+#define FILE1 MNTPOINT"/file1"
+
+/* List of inode events that are only available when notification group is
+ * set to report fid
+ */
+#define INODE_EVENTS (FAN_ATTRIB | FAN_CREATE | FAN_DELETE | FAN_MOVE | \
+		      FAN_DELETE_SELF | FAN_MOVE_SELF)
+
+static int fanotify_fd;
+
+/* Each test case has been designed in a manner whereby the values defined
+ * within should result in the interface to return an error to the calling
+ * process.
+ */
+static struct test_case_t {
+	unsigned int init_flags;
+	unsigned int mark_flags;
+	unsigned long long mask;
+} test_cases[] = {
+	{
+		FAN_CLASS_CONTENT | FAN_REPORT_FID, 0, 0
+	},
+	{
+		FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, 0, 0
+	},
+	{
+		FAN_CLASS_NOTIF, 0, INODE_EVENTS
+	},
+	{
+		FAN_CLASS_NOTIF | FAN_REPORT_FID, FAN_MARK_MOUNT, INODE_EVENTS
+	}
+};
+
+static void do_setup(void)
+{
+	int fd;
+
+	/* Check for kernel fanotify support */
+	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
+	SAFE_CLOSE(fd);
+
+	/* Create temporary test file to place marks on */
+	SAFE_FILE_PRINTF(FILE1, "0");
+}
+
+static void do_test(unsigned int number)
+{
+	int ret;
+	struct test_case_t *tc = &test_cases[number];
+
+	fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY);
+
+	if (fanotify_fd < 0) {
+		/* EINVAL is to be returned to the calling process when
+		 * an invalid notification class is specified in
+		 * conjunction with FAN_REPORT_FID
+		 */
+		if (errno == EINVAL) {
+			tst_res(TPASS,
+				"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
+				"failed with error EINVAL as expected",
+				fanotify_fd,
+				tc->init_flags);
+			return;
+		}
+		tst_brk(TBROK | TERRNO,
+			"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) failed",
+			fanotify_fd,
+			tc->init_flags);
+	}
+
+	/* A test case with a mask set to zero indicate that they've been
+	 * specifically designed to test and fail on the fanotify_init()
+	 * system call.
+	 */
+	if (tc->mask == 0) {
+		tst_res(TFAIL,
+			"fanotify_fd=%d fanotify_init(%x, O_RDONLY) "
+			"unexpectedly succeeded when tests with mask 0 are"
+			"expected to fail when calling fanotify_init()",
+			fanotify_fd,
+			tc->init_flags);
+		return;
+	}
+
+	ret = fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
+				tc->mask, AT_FDCWD, FILE1);
+
+	if (ret < 0) {
+		/* EINVAL is to be returned to the calling process when
+		 * attempting to use INODE_EVENTS without FAN_REPORT_FID
+		 * specified on the notification group, or using
+		 * INODE_EVENTS with mark type FAN_MARK_MOUNT.
+		 */
+		if (errno == EINVAL) {
+			tst_res(TPASS,
+				"ret=%d, fanotify_mark(%d, FAN_MARK_ADD | %x, "
+				"%llx, AT_FDCWD, %s) failed with error EINVAL "
+				"as expected",
+				ret,
+				fanotify_fd,
+				tc->mark_flags,
+				tc->mask,
+				FILE1);
+			return;
+		}
+		tst_brk(TBROK | TERRNO,
+			"ret=%d, fanotify_mark(%d, FAN_MARK_ADD | %x, %llx, "
+			"AT_FDCWD, %s) failed",
+			ret,
+			fanotify_fd,
+			tc->mark_flags,
+			tc->mask,
+			FILE1);
+	}
+
+	tst_res(TFAIL,
+		"fanotify_fd=%d, ret=%d, fanotify_init(%x, O_RDONLY) and "
+		"fanotify_mark(%d, FAN_MARK_ADD | %x, %llx, AT_FDCWD, %s) did "
+		"not return any errors as expected",
+		fanotify_fd,
+		ret,
+		tc->init_flags,
+		fanotify_fd,
+		tc->mark_flags,
+		tc->mask,
+		FILE1);
+}
+
+static void do_cleanup(void)
+{
+	if (fanotify_fd > 0)
+		SAFE_CLOSE(fanotify_fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = do_setup,
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.cleanup = do_cleanup,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1
+};
+
+#else
+	TST_TEST_CONF("System does not have required fanotify support")
+#endif
-- 
2.21.0


-- 
Matthew Bobrowski
