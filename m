From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 12 May 2016 15:18:14 +0800
Subject: [LTP] [PATCH 2/2] syscalls/fanotify*: Cleanup && fix compiler
	warnings
In-Reply-To: <1463037494-7284-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1463037494-7284-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1463037494-7284-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h   | 57 -------------------------
 testcases/kernel/syscalls/fanotify/fanotify01.c |  4 +-
 testcases/kernel/syscalls/fanotify/fanotify02.c |  1 -
 testcases/kernel/syscalls/fanotify/fanotify03.c |  3 +-
 testcases/kernel/syscalls/fanotify/fanotify04.c |  5 +--
 testcases/kernel/syscalls/fanotify/fanotify05.c |  1 -
 testcases/kernel/syscalls/fanotify/fanotify06.c |  1 -
 7 files changed, 5 insertions(+), 67 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/fanotify/fanotify.h

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
index fb0f6eb..24e702a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -37,7 +37,6 @@
 #include <sys/syscall.h>
 #include "test.h"
 #include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify01";
@@ -73,7 +72,8 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int ret, len, i = 0, test_num = 0;
+		int len, i = 0, test_num = 0;
+		unsigned int ret;
 
 		tst_count = 0;
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 5de49f2..997d806 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -37,7 +37,6 @@
 #include <sys/syscall.h>
 #include "test.h"
 #include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify02";
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 8310198..ab26ed5 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -40,7 +40,6 @@
 #include <sys/syscall.h>
 #include "test.h"
 #include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify03";
@@ -90,7 +89,7 @@ static void generate_events(void)
 		exit(4);
 }
 
-static void child_handler(int tmp)
+static void child_handler(int tmp LTP_ATTRIBUTE_UNUSED)
 {
 	/*
 	 * Close notification fd so that we cannot block while reading
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index 9451be3..c92718d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -38,7 +38,6 @@
 #include <sys/syscall.h>
 #include "test.h"
 #include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify04";
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
index 517bd26..4cd162c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -36,7 +36,6 @@
 #include <sys/syscall.h>
 #include "test.h"
 #include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify05";
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 93c9602..e8b1652 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -45,7 +45,6 @@
 #include <sys/syscall.h>
 #include "test.h"
 #include "linux_syscall_numbers.h"
-#include "fanotify.h"
 #include "safe_macros.h"
 
 char *TCID = "fanotify06";
-- 
1.8.3.1



