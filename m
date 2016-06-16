From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 16 Jun 2016 10:30:35 +0800
Subject: [LTP] [PATCH v2] syscalls/fanotify*: Cleanup
In-Reply-To: <20160517121121.GB12051@rei.lan>
References: <20160517121121.GB12051@rei.lan>
Message-ID: <1466044235-27952-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Skip the test compilation if both sys/fanotify.h and
   linux/fanotify.h are misssing.
2) Fix compiler warnings.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 configure.ac                                    |  2 +-
 m4/ltp-fanotify.m4                              | 22 ++++++++++
 testcases/kernel/syscalls/fanotify/fanotify.h   | 57 -------------------------
 testcases/kernel/syscalls/fanotify/fanotify01.c |  8 ++--
 testcases/kernel/syscalls/fanotify/fanotify02.c |  5 +--
 testcases/kernel/syscalls/fanotify/fanotify03.c |  7 ++-
 testcases/kernel/syscalls/fanotify/fanotify04.c |  9 ++--
 testcases/kernel/syscalls/fanotify/fanotify05.c |  5 +--
 testcases/kernel/syscalls/fanotify/fanotify06.c |  5 +--
 9 files changed, 40 insertions(+), 80 deletions(-)
 create mode 100644 m4/ltp-fanotify.m4
 delete mode 100644 testcases/kernel/syscalls/fanotify/fanotify.h

diff --git a/configure.ac b/configure.ac
index e0e9c1b..548bc3a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -43,7 +43,6 @@ AC_CHECK_HEADERS([ \
     linux/netlink.h \
     sys/epoll.h \
     sys/inotify.h \
-    sys/fanotify.h \
     sys/jfsdmapi.h \
     sys/prctl.h \
 ])
@@ -188,5 +187,6 @@ LTP_CHECK_PWRITEV
 LTP_CHECK_EPOLL_PWAIT
 LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_SYNC_ADD_AND_FETCH
+LTP_CHECK_FANOTIFY
 
 AC_OUTPUT
diff --git a/m4/ltp-fanotify.m4 b/m4/ltp-fanotify.m4
new file mode 100644
index 0000000..f9e26a0
--- /dev/null
+++ b/m4/ltp-fanotify.m4
@@ -0,0 +1,22 @@
+dnl
+dnl Copyright (c) 2016 Fujitsu Ltd.
+dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+dnl
+dnl This program is free software; you can redistribute it and/or modify it
+dnl under the terms of version 2 of the GNU General Public License as
+dnl published by the Free Software Foundation.
+dnl
+dnl This program is distributed in the hope that it would be useful, but
+dnl WITHOUT ANY WARRANTY; without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl alone with this program.
+dnl
+dnl
+dnl LTP_CHECK_FANOTIFY
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_FANOTIFY],[
+AC_CHECK_HEADERS([sys/fanotify.h linux/fanotify.h])
+])
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
deleted file mode 100644
index 518d05e..0000000
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * fanotify testcase common definitions.
- *
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
- * Jan Kara, November 2013
- */
-
-#ifndef	__FANOTIFY_H__
-#define	__FANOTIFY_H__
-
-#include "config.h"
-
-#if defined(HAVE_SYS_FANOTIFY_H)
-
-#include <sys/fanotify.h>
-
-#else /* HAVE_SYS_FANOTIFY_H */
-
-/* fanotify(7) wrappers */
-
-#include <stdint.h>
-#include "linux_syscall_numbers.h"
-
-static int fanotify_init(unsigned int flags, unsigned int event_f_flags)
-{
-	return syscall(__NR_fanotify_init, flags, event_f_flags);
-}
-
-static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
-                     int dfd, const char *pathname)
-{
-	return syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname);
-}
-
-#endif /* HAVE_SYS_FANOTIFY_H */
-
-#endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index fb0f6eb..e8c3c1d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -36,15 +36,14 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify01";
 int TST_TOTAL = 12;
 
-#if defined(HAVE_SYS_FANOTIFY_H)
+#if defined(HAVE_SYS_FANOTIFY_H) && defined(HAVE_LINUX_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include <linux/fanotify.h>
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
@@ -73,7 +72,8 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int ret, len, i = 0, test_num = 0;
+		int len, i = 0, test_num = 0;
+		unsigned int ret;
 
 		tst_count = 0;
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 5de49f2..593a251 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -36,15 +36,14 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify02";
 int TST_TOTAL = 8;
 
-#if defined(HAVE_SYS_FANOTIFY_H)
+#if defined(HAVE_SYS_FANOTIFY_H) && defined(HAVE_LINUX_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include <linux/fanotify.h>
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 8310198..54a6eb9 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -39,15 +39,14 @@
 #include <signal.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify03";
 int TST_TOTAL = 3;
 
-#if defined(HAVE_SYS_FANOTIFY_H)
+#if defined(HAVE_SYS_FANOTIFY_H) && defined(HAVE_LINUX_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include <linux/fanotify.h>
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
@@ -90,7 +89,7 @@ static void generate_events(void)
 		exit(4);
 }
 
-static void child_handler(int tmp)
+static void child_handler(int tmp LTP_ATTRIBUTE_UNUSED)
 {
 	/*
 	 * Close notification fd so that we cannot block while reading
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index 9451be3..41feea0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -37,15 +37,14 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify04";
 int TST_TOTAL = 9;
 
-#if defined(HAVE_SYS_FANOTIFY_H)
+#if defined(HAVE_SYS_FANOTIFY_H) && defined(HAVE_LINUX_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include <linux/fanotify.h>
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
@@ -111,7 +110,7 @@ static void check_mark(char *file, unsigned long long flag, char *flagstr,
 
 #define CHECK_MARK(file, flag, expect, func) check_mark(file, flag, #flag, expect, func)
 
-static void do_open(char *file, int flag, char *flagstr)
+static void do_open(char *file, int flag, char *flagstr LTP_ATTRIBUTE_UNUSED)
 {
 	int fd;
 
@@ -131,7 +130,7 @@ static void open_dir(char *file)
 	DO_OPEN(file, O_DIRECTORY);
 }
 
-static void verify_event(int mask)
+static void verify_event(unsigned int mask)
 {
 	int ret;
 	struct fanotify_event_metadata *event;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 517bd26..c2ecf9d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -35,15 +35,14 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify05";
 int TST_TOTAL = 1;
 
-#if defined(HAVE_SYS_FANOTIFY_H)
+#if defined(HAVE_SYS_FANOTIFY_H) && defined(HAVE_LINUX_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include <linux/fanotify.h>
 
 /* Currently this is fixed in kernel... */
 #define MAX_EVENTS 16384
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 93c9602..5fa982a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -44,14 +44,13 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "test.h"
-#include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify06";
 
-#if defined(HAVE_SYS_FANOTIFY_H)
+#if defined(HAVE_SYS_FANOTIFY_H) && defined(HAVE_LINUX_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include <linux/fanotify.h>
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
-- 
1.8.3.1



