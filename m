From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Jun 2019 09:21:25 +0200
Subject: [LTP] [PATCH 1/2] inotify: Add SAFE_MYINOTIFY_INIT{,1}() helpers
Message-ID: <20190605072126.19856-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

should there be inc/tst_safe_inotify.h and
lib/tst_safe_inotify.c? I didn't do that as that would link to
everything, which is waste of space.

Kind regards,
Petr
---
 testcases/kernel/syscalls/inotify/inotify.h   | 51 ++++++++++---------
 testcases/kernel/syscalls/inotify/inotify01.c | 10 +---
 testcases/kernel/syscalls/inotify/inotify02.c | 10 +---
 testcases/kernel/syscalls/inotify/inotify03.c | 10 +---
 testcases/kernel/syscalls/inotify/inotify04.c | 11 +---
 testcases/kernel/syscalls/inotify/inotify05.c | 11 +---
 testcases/kernel/syscalls/inotify/inotify06.c |  4 +-
 testcases/kernel/syscalls/inotify/inotify07.c | 11 +---
 testcases/kernel/syscalls/inotify/inotify08.c | 11 +---
 testcases/kernel/syscalls/inotify/inotify09.c |  4 +-
 10 files changed, 35 insertions(+), 98 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify.h b/testcases/kernel/syscalls/inotify/inotify.h
index 0298ca715..c82a7e75e 100644
--- a/testcases/kernel/syscalls/inotify/inotify.h
+++ b/testcases/kernel/syscalls/inotify/inotify.h
@@ -1,27 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * inotify testcase common definitions.
  *
- * Copyright (c) 2012 Linux Test Project.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ * Copyright (c) 2012-2019 Linux Test Project.  All Rights Reserved.
  * Ngie Cooper, April 2012
  */
 
@@ -33,20 +14,40 @@
 /* inotify(7) wrappers */
 
 #if __NR_inotify_init != __LTP__NR_INVALID_SYSCALL
-#define	myinotify_init() \
+#define myinotify_init() \
 	tst_syscall(__NR_inotify_init)
 #else
-#define	myinotify_init() \
+#define myinotify_init() \
 	tst_syscall(__NR_inotify_init1, 0)
 #endif
 
 #define myinotify_init1(flags) \
 	tst_syscall(__NR_inotify_init1, flags)
 
-#define	myinotify_add_watch(fd, pathname, mask)	\
+#define myinotify_add_watch(fd, pathname, mask)	\
 	tst_syscall(__NR_inotify_add_watch, fd, pathname, mask)
 
-#define	myinotify_rm_watch(fd, wd) \
+#define myinotify_rm_watch(fd, wd) \
 	tst_syscall(__NR_inotify_rm_watch, fd, wd)
 
+static inline int safe_myinotify_init(const char *file, const int lineno, int fd)
+{
+	if (fd < 0) {
+		if (errno == ENOSYS) {
+			tst_brk(TCONF, "%s:%d: inotify is not configured in this kernel",
+				file, lineno);
+		} else {
+			tst_brk(TBROK | TERRNO, "%s:%d: inotify_init failed",
+				file, lineno);
+		}
+	}
+	return fd;
+}
+
+#define SAFE_MYINOTIFY_INIT() \
+	safe_myinotify_init(__FILE__, __LINE__, myinotify_init())
+
+#define SAFE_MYINOTIFY_INIT1(flags) \
+	safe_myinotify_init(__FILE__, __LINE__, myinotify_init1(flags))
+
 #endif /* _INOTIFY_H */
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index f0cf51297..f08a75dcf 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -167,15 +167,7 @@ static void setup(void)
 
 	SAFE_FILE_PRINTF(fname, "%s", fname);
 
-	if ((fd_notify = myinotify_init()) < 0) {
-		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"inotify is not configured in this kernel.");
-		} else {
-			tst_brk(TBROK | TERRNO,
-				"inotify_init failed");
-		}
-	}
+	fd_notify = SAFE_MYINOTIFY_INIT();
 
 	if ((wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS)) < 0) {
 		tst_brk(TBROK | TERRNO,
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 02eb85764..ca70b4e9e 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -234,15 +234,7 @@ void verify_inotify(void)
 
 static void setup(void)
 {
-	if ((fd_notify = myinotify_init()) < 0) {
-		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"inotify is not configured in this kernel.");
-		} else {
-			tst_brk(TBROK | TERRNO,
-				"inotify_init () failed");
-		}
-	}
+	fd_notify = SAFE_MYINOTIFY_INIT();
 
 	if ((wd = myinotify_add_watch(fd_notify, ".", IN_ALL_EVENTS)) < 0) {
 		tst_brk(TBROK | TERRNO,
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index ff7419944..772623125 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -171,15 +171,7 @@ static void setup(void)
 	/* close the file we have open */
 	SAFE_CLOSE(fd);
 
-	fd_notify = myinotify_init();
-	if (fd_notify < 0) {
-		if (errno == ENOSYS)
-			tst_brk(TCONF,
-				"inotify is not configured in this kernel.");
-		else
-			tst_brk(TBROK | TERRNO,
-				"inotify_init failed");
-	}
+	fd_notify = SAFE_MYINOTIFY_INIT();
 
 	tst_umount(mntpoint);
 	mount_flag = 0;
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index 36673d6eb..6adb41701 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -95,16 +95,7 @@ static void cleanup(void)
 
 static void setup(void)
 {
-	fd_notify = myinotify_init();
-	if (fd_notify == -1) {
-		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"inotify is not configured in this kernel.");
-		} else {
-			tst_brk(TBROK | TERRNO,
-				"inotify_init failed");
-		}
-	}
+	fd_notify = SAFE_MYINOTIFY_INIT();
 }
 
 void verify_inotify(void)
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index 2d8897e5d..b5813b25b 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -143,16 +143,7 @@ static void setup(void)
 	SAFE_WRITE(1, fd, buf, BUF_SIZE);
 	SAFE_CLOSE(fd);
 
-	fd_notify = myinotify_init1(O_NONBLOCK);
-	if (fd_notify < 0) {
-		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"inotify is not configured in this kernel.");
-		} else {
-			tst_brk(TBROK | TERRNO,
-				"inotify_init failed");
-		}
-	}
+	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
 
 	wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS);
 	if (wd < 0) {
diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
index 4475f5ea4..8ea504952 100644
--- a/testcases/kernel/syscalls/inotify/inotify06.c
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -82,9 +82,7 @@ static void verify_inotify(void)
 	}
 
 	for (tests = 0; tests < TEARDOWNS; tests++) {
-		inotify_fd = myinotify_init1(O_NONBLOCK);
-		if (inotify_fd < 0)
-			tst_brk(TBROK | TERRNO, "inotify_init failed");
+		inotify_fd = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
 
 		for (i = 0; i < FILES; i++) {
 			/*
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index ba17d2081..1111b43bf 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -165,16 +165,7 @@ static void setup(void)
 	SAFE_TOUCH(OVL_LOWER"/"DIR_NAME"/"FILE_NAME, 0644, NULL);
 	SAFE_MOUNT_OVERLAY();
 
-	fd_notify = myinotify_init1(O_NONBLOCK);
-	if (fd_notify < 0) {
-		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"inotify is not configured in this kernel");
-		} else {
-			tst_brk(TBROK | TERRNO,
-				"inotify_init () failed");
-		}
-	}
+	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
 
 	/* Setup a watch on an overlayfs lower directory */
 	if ((wd = myinotify_add_watch(fd_notify, DIR_PATH, IN_ALL_EVENTS)) < 0) {
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index b295ba48e..ee8e44fe1 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -157,16 +157,7 @@ static void setup(void)
 	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
 	SAFE_MOUNT_OVERLAY();
 
-	fd_notify = myinotify_init1(O_NONBLOCK);
-	if (fd_notify < 0) {
-		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"inotify is not configured in this kernel");
-		} else {
-			tst_brk(TBROK | TERRNO,
-				"inotify_init () failed");
-		}
-	}
+	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
 
 	/* Setup a watch on an overlayfs lower file */
 	if ((wd = myinotify_add_watch(fd_notify, FILE_PATH,
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index f587a3a3c..cf2d38f27 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -85,9 +85,7 @@ static void verify_inotify(void)
 	int inotify_fd;
 	int wd;
 
-	inotify_fd = myinotify_init1(0);
-	if (inotify_fd < 0)
-		tst_brk(TBROK | TERRNO, "inotify_init failed");
+	inotify_fd = SAFE_MYINOTIFY_INIT1(0);
 
 	tst_fzsync_pair_reset(&fzsync_pair, write_seek);
 	while (tst_fzsync_run_a(&fzsync_pair)) {
-- 
2.21.0

