From: Murphy Zhou <xzhou@redhat.com>
Date: Tue, 30 Apr 2019 23:29:49 +0800
Subject: [LTP] [PATCH v2] syscalls/swap{on,
	off}: skip if FIBMAP ioctl trial fails
In-Reply-To: <20190430095404.ipt3tuhyfd4hqz6w@XZHOUW.usersys.redhat.com>
References: <20190430095404.ipt3tuhyfd4hqz6w@XZHOUW.usersys.redhat.com>
Message-ID: <20190430152949.17723-1-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

That means swapfile in the test filesystem is not supported.
Add a test helper to do a FIBMAP ioctl test. Remove old fs type whitelist code.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 include/tst_fs.h                              |  5 +++
 lib/tst_ioctl.c                               | 41 +++++++++++++++++++
 testcases/kernel/syscalls/swapoff/swapoff01.c | 13 ++----
 testcases/kernel/syscalls/swapoff/swapoff02.c | 10 ++---
 testcases/kernel/syscalls/swapon/swapon01.c   | 13 ++----
 testcases/kernel/syscalls/swapon/swapon02.c   | 16 ++------
 testcases/kernel/syscalls/swapon/swapon03.c   | 20 ++-------
 7 files changed, 64 insertions(+), 54 deletions(-)
 create mode 100644 lib/tst_ioctl.c

diff --git a/include/tst_fs.h b/include/tst_fs.h
index b2b19ada6..cc38b3547 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -172,6 +172,11 @@ const char **tst_get_supported_fs_types(void);
  */
 void tst_fill_fs(const char *path, int verbose);
 
+/*
+ * test if FIBMAP ioctl is supported
+ */
+int tst_fibmap(void);
+
 #ifdef TST_TEST_H__
 static inline long tst_fs_type(const char *path)
 {
diff --git a/lib/tst_ioctl.c b/lib/tst_ioctl.c
new file mode 100644
index 000000000..d468d5898
--- /dev/null
+++ b/lib/tst_ioctl.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <linux/fs.h>
+
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+
+int tst_fibmap(void)
+{
+	/* test if FIBMAP ioctl is supported */
+	int fd, block = 0;
+	const char *tmpdir = getenv("TMPDIR");
+	char buf[128];
+
+	tst_res(TINFO, "Testing if FIBMAP ioctl is supported in %s", tmpdir);
+
+	sprintf(buf, "%s/tst_fibmap", tmpdir);
+
+	fd = open(buf, O_RDWR | O_CREAT, 0666);
+	if (fd < 0) {
+		tst_res(TWARN | TERRNO,
+			 "open(%s, O_RDWR | O_CREAT, 0666) failed", buf);
+		return 1;
+	}
+
+	if (ioctl(fd, FIBMAP, &block)) {
+		close(fd);
+		return 1;
+	}
+
+	if (close(fd)) {
+		tst_res(TWARN | TERRNO, "close(fd) failed");
+		return 1;
+	}
+	return 0;
+}
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index a63e661a5..a37cd9be1 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -55,11 +55,6 @@ int main(int ac, char **av)
 static void verify_swapoff(void)
 {
 	if (ltp_syscall(__NR_swapon, "./swapfile01", 0) != 0) {
-		if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
-			tst_brkm(TCONF, cleanup,
-			         "Swapfiles on BTRFS are not implemented");
-		}
-
 		tst_resm(TBROK, "Failed to turn on the swap file"
 			 ", skipping test iteration");
 		return;
@@ -86,13 +81,11 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
+	fs_type = tst_fs_type(cleanup, ".");
+	if (tst_fibmap()) {
 		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapoff on a file on %s filesystem",
+			 "Cannot do FIBMAP ioctl on a file on %s filesystem",
 			 tst_fs_type_name(fs_type));
-	break;
 	}
 
 	if (!tst_fs_has_free(NULL, ".", 64, TST_MB)) {
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index b5c6312a1..d14b1c7ab 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -138,13 +138,11 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
+	fs_type = tst_fs_type(cleanup, ".");
+	if (tst_fibmap()) {
 		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapoff on a file on %s filesystem",
-			 tst_fs_type_name(type));
-	break;
+			 "Cannot do FIBMAP ioctl on a file on %s filesystem",
+			 tst_fs_type_name(fs_type));
 	}
 
 	if (!tst_fs_has_free(NULL, ".", 1, TST_KB)) {
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index 32538f82b..0a5a3de86 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -39,11 +39,6 @@ static void verify_swapon(void)
 	TEST(ltp_syscall(__NR_swapon, "./swapfile01", 0));
 
 	if (TEST_RETURN == -1) {
-		if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
-			tst_brkm(TCONF, cleanup,
-			         "Swapfile on BTRFS not implemeted");
-			return;
-		}
 		tst_resm(TFAIL | TTERRNO, "Failed to turn on swapfile");
 	} else {
 		tst_resm(TPASS, "Succeeded to turn on swapfile");
@@ -84,13 +79,11 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
+	fs_type = tst_fs_type(cleanup, ".");
+	if (tst_fibmap()) {
 		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapon on a file on %s filesystem",
+			 "Cannot do FIBMAP ioctl on a file on %s filesystem",
 			 tst_fs_type_name(fs_type));
-	break;
 	}
 
 	make_swapfile(cleanup, "swapfile01");
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index 4af5105c6..31f0c66ac 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -81,11 +81,6 @@ static void verify_swapon(struct test_case_t *test)
 		return;
 	}
 
-	if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
-		tst_resm(TCONF, "Swapfile on BTRFS not implemeted");
-			return;
-	}
-
 	tst_resm(TFAIL, "swapon(2) failed to produce expected error:"
 	         " %d, errno: %s and got %d.", test->exp_errno,
 	         test->exp_errval, TEST_ERRNO);
@@ -132,13 +127,11 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
+	fs_type = tst_fs_type(cleanup, ".");
+	if (tst_fibmap()) {
 		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapon on a file on %s filesystem",
+			 "Cannot do FIBMAP ioctl on a file on %s filesystem",
 			 tst_fs_type_name(fs_type));
-	break;
 	}
 
 	SAFE_TOUCH(cleanup, "notswap", 0777, NULL);
@@ -146,8 +139,7 @@ static void setup(void)
 	make_swapfile(cleanup, "alreadyused");
 
 	if (ltp_syscall(__NR_swapon, "alreadyused", 0)) {
-		if (fs_type != TST_BTRFS_MAGIC || errno != EINVAL)
-			tst_resm(TWARN | TERRNO, "swapon(alreadyused) failed");
+		tst_resm(TWARN | TERRNO, "swapon(alreadyused) failed");
 	} else {
 		do_swapoff = 1;
 	}
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 955ac247b..391391fbf 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -215,9 +215,6 @@ static int setup_swap(void)
 			/* turn on the swap file */
 			res = ltp_syscall(__NR_swapon, filename, 0);
 			if (res != 0) {
-				if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL)
-					exit(2);
-
 				if (errno == EPERM) {
 					printf("Successfully created %d "
 					       "swapfiles\n", j);
@@ -233,15 +230,8 @@ static int setup_swap(void)
 	} else
 		waitpid(pid, &status, 0);
 
-	switch (WEXITSTATUS(status)) {
-	case 0:
-	break;
-	case 2:
-		tst_brkm(TCONF, cleanup, "Swapfile on BTRFS not implemeted");
-	break;
-	default:
+	if (WEXITSTATUS(status)) {
 		tst_brkm(TFAIL, cleanup, "Failed to setup swaps");
-	break;
 	}
 
 	/* Create all needed extra swapfiles for testing */
@@ -333,13 +323,11 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	switch ((fs_type = tst_fs_type(cleanup, "."))) {
-	case TST_NFS_MAGIC:
-	case TST_TMPFS_MAGIC:
+	fs_type = tst_fs_type(cleanup, ".");
+	if (tst_fibmap()) {
 		tst_brkm(TCONF, cleanup,
-			 "Cannot do swapon on a file on %s filesystem",
+			 "Cannot do FIBMAP ioctl on a file on %s filesystem",
 			 tst_fs_type_name(fs_type));
-	break;
 	}
 
 	TEST_PAUSE;
-- 
2.21.0

