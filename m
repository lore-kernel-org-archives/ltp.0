From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Fri, 30 Mar 2018 18:56:42 +0800
Subject: [LTP] [PATCH 1/3] syscalls/fchmod.h: Move common macros to fchmod.h
Message-ID: <1522407404-6877-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fchmod/fchmod.h   | 26 ++++++++++++++++++++++++++
 testcases/kernel/syscalls/fchmod/fchmod02.c |  7 +------
 testcases/kernel/syscalls/fchmod/fchmod03.c |  5 +----
 testcases/kernel/syscalls/fchmod/fchmod04.c |  8 +-------
 testcases/kernel/syscalls/fchmod/fchmod05.c | 15 +++++++--------
 testcases/kernel/syscalls/fchmod/fchmod07.c |  4 +---
 6 files changed, 37 insertions(+), 28 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fchmod/fchmod.h

diff --git a/testcases/kernel/syscalls/fchmod/fchmod.h b/testcases/kernel/syscalls/fchmod/fchmod.h
new file mode 100644
index 0000000..e52850d
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmod/fchmod.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Jinhui huang <huangjh.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License
+ * alone with this program.
+ */
+
+#ifndef FCHMOD_H
+#define FCHMOD_H
+
+#define FILE_MODE	(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
+#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IRWXO)
+#define PERMS	01777
+#define TESTFILE	"testfile"
+#define TESTDIR	"testdir"
+
+#endif /* FCHMOD_H */
diff --git a/testcases/kernel/syscalls/fchmod/fchmod02.c b/testcases/kernel/syscalls/fchmod/fchmod02.c
index ea2bdb4..aa3bab3 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod02.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -82,15 +82,10 @@
 
 #include "test.h"
 #include "safe_macros.h"
+#include "fchmod.h"
 
 #define LTPUSER		"nobody"
 #define LTPGRP		"users"
-#define FILE_MODE 	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define PERMS		01777	/*
-				 * Mode permissions of test file with sticky
-				 * bit set.
-				 */
-#define TESTFILE	"testfile"
 
 int fd;				/* file descriptor variable */
 char *TCID = "fchmod02";
diff --git a/testcases/kernel/syscalls/fchmod/fchmod03.c b/testcases/kernel/syscalls/fchmod/fchmod03.c
index 8d35bc1..a5824f3 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod03.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod03.c
@@ -81,10 +81,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
-
-#define FILE_MODE       (S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
-#define PERMS		01777
-#define TESTFILE	"testfile"
+#include "fchmod.h"
 
 int fd;				/* file descriptor for test file */
 char *TCID = "fchmod03";
diff --git a/testcases/kernel/syscalls/fchmod/fchmod04.c b/testcases/kernel/syscalls/fchmod/fchmod04.c
index 27e3bdc..befaadb 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod04.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod04.c
@@ -81,13 +81,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
-
-#define DIR_MODE 	S_IRWXU | S_IRWXG | S_IRWXO
-#define PERMS		01777	/*
-				 * Mode permissions of test directory with
-				 * sticky bit set.
-				 */
-#define TESTDIR		"testdir_4"
+#include "fchmod.h"
 
 int fd;				/* file descriptor for test directory */
 char *TCID = "fchmod04";
diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index cdd3d07..0ab2023 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -88,10 +88,9 @@
 
 #include "test.h"
 #include "safe_macros.h"
+#include "fchmod.h"
 
-#define MODE_RWX	(S_IRWXU | S_IRWXG | S_IRWXO)
-#define PERMS		043777
-#define TESTDIR		"testdir"
+#define PERMS_GID		043777
 
 int fd;				/* file descriptor for test directory */
 char *TCID = "fchmod05";
@@ -119,7 +118,7 @@ int main(int ac, char **av)
 		 * to set setgid bit on TESTDIR.
 		 */
 
-		TEST(fchmod(fd, PERMS));
+		TEST(fchmod(fd, PERMS_GID));
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL, "fchmod(%d, %#o) Failed, errno=%d : %s",
@@ -136,14 +135,14 @@ int main(int ac, char **av)
 				 TESTDIR, TEST_ERRNO);
 		}
 		dir_mode = stat_buf.st_mode;
-		if ((PERMS & ~S_ISGID) != dir_mode) {
+		if ((PERMS_GID & ~S_ISGID) != dir_mode) {
 			tst_resm(TFAIL, "%s: Incorrect modes 0%03o, "
 				 "Expected 0%03o",
-				 TESTDIR, dir_mode, PERMS & ~S_ISGID);
+				 TESTDIR, dir_mode, PERMS_GID & ~S_ISGID);
 		} else {
 			tst_resm(TPASS, "Functionality of fchmod(%d, "
 				 "%#o) successful", fd,
-				 PERMS & ~S_ISGID);
+				 PERMS_GID & ~S_ISGID);
 		}
 	}
 
@@ -188,7 +187,7 @@ void setup(void)
 	 * mode permissions and change the gid of test directory to that of
 	 * guest user.
 	 */
-	SAFE_MKDIR(cleanup, TESTDIR, MODE_RWX);
+	SAFE_MKDIR(cleanup, TESTDIR, DIR_MODE);
 
 	if (setgroups(1, &nobody_u->pw_gid) == -1)
 		tst_brkm(TBROK, cleanup,
diff --git a/testcases/kernel/syscalls/fchmod/fchmod07.c b/testcases/kernel/syscalls/fchmod/fchmod07.c
index 6973555..d7fe41f 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod07.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod07.c
@@ -75,9 +75,7 @@
 
 #include "test.h"
 #include "safe_macros.h"
-
-#define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
-#define TESTFILE	"testfile"
+#include "fchmod.h"
 
 int fd;				/* file descriptor for testfile */
 char *TCID = "fchmod07";
-- 
1.8.3.1



