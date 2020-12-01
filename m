From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  1 Dec 2020 18:42:14 +0100
Subject: [LTP] [PATCH] fanotify: Cleanup <sys/fanotify.h> use
In-Reply-To: <20201201174214.24625-1-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
Message-ID: <20201201174214.24625-11-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fanotify.h is included only by fanotify tests. That's why fb2cd7934
moved safe_fanotify_{init,mark}() was moved into this header.
All fanotify tests require <sys/fanotify.h> anyway, thus move inclusion
behind HAVE_SYS_FANOTIFY_H guard and remove checks and raw syscall
fallbacks from the header.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v5.

It should be pretty obvious. There are probably some unused includes,
but again, let's don't prolong this patchset.

 testcases/kernel/syscalls/fanotify/fanotify.h | 27 -------------------
 .../kernel/syscalls/fanotify/fanotify01.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify02.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify03.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify04.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify05.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify06.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify07.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify08.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify09.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify10.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify11.c     |  7 +++--
 .../kernel/syscalls/fanotify/fanotify12.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify13.c     |  5 ++--
 .../kernel/syscalls/fanotify/fanotify14.c     |  6 ++---
 .../kernel/syscalls/fanotify/fanotify15.c     |  6 ++---
 .../kernel/syscalls/fanotify/fanotify16.c     |  5 ++--
 17 files changed, 33 insertions(+), 78 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 540c2b0fc..ea3771cce 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -13,37 +13,13 @@
 #include <sys/stat.h>
 #include <errno.h>
 #include <fcntl.h>
-
-#if defined(HAVE_SYS_FANOTIFY_H)
-
 #include <sys/fanotify.h>
 
-#else /* HAVE_SYS_FANOTIFY_H */
-
-/* fanotify(7) wrappers */
-
-#include <stdint.h>
-#include "lapi/syscalls.h"
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
 int safe_fanotify_init(const char *file, const int lineno,
 	unsigned int flags, unsigned int event_f_flags)
 {
 	int rval;
 
-#ifdef HAVE_SYS_FANOTIFY_H
 	rval = fanotify_init(flags, event_f_flags);
 
 	if (rval == -1) {
@@ -59,9 +35,6 @@ int safe_fanotify_init(const char *file, const int lineno,
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			 "invalid fanotify_init() return %d", rval);
 	}
-#else
-	tst_brk_(file, lineno, TCONF, "Header <sys/fanotify.h> is not present");
-#endif /* HAVE_SYS_FANOTIFY_H */
 
 	return rval;
 }
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index a1eafb277..d6d72dad9 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -18,10 +18,9 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 36c87648e..155875dd0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -18,10 +18,9 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 2cd90e8b0..1368bf0e2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -22,10 +22,9 @@
 #include <sys/syscall.h>
 #include <stdlib.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+# include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index a24e7f7c3..7ac2645bb 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -19,10 +19,9 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index c13b9ad7b..851cb6c8f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -22,10 +22,9 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define MOUNT_PATH "fs_mnt"
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index ac4901f6f..0d70a955f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -36,10 +36,9 @@
 #include <sys/mount.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 4bf17661a..830af32b6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -30,10 +30,9 @@
 #include <sys/syscall.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define BUF_SIZE 256
 static char fname[BUF_SIZE];
diff --git a/testcases/kernel/syscalls/fanotify/fanotify08.c b/testcases/kernel/syscalls/fanotify/fanotify08.c
index a4031b4ad..f63b5a931 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify08.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify08.c
@@ -18,10 +18,9 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 static int fd_notify;
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 9c9938619..daeb712d2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -33,10 +33,9 @@
 #include <sys/syscall.h>
 #include <stdint.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 4d081a843..404e57daa 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -39,10 +39,9 @@
 #include <sys/mount.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
index 56b7153f8..785b5c5a5 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify11.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -29,10 +29,9 @@
 #include <linux/limits.h>
 #include "tst_test.h"
 #include "tst_safe_pthread.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define gettid() syscall(SYS_gettid)
 static int tid;
@@ -112,5 +111,5 @@ static struct tst_test test = {
 };
 
 #else
-TST_TEST_TCONF("system doesn't have required fanotify support");
+	TST_TEST_TCONF("system doesn't have required fanotify support");
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index 18b96c430..17086ef71 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -21,10 +21,9 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 #define EVENT_SIZE (sizeof (struct fanotify_event_metadata))
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index d28d1a6de..a402cdb13 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -25,10 +25,9 @@
 #include <errno.h>
 #include <unistd.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define PATH_LEN 128
 #define BUF_SIZE 256
diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 349177d9a..817d5ecd5 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -12,12 +12,10 @@
  */
 #define _GNU_SOURCE
 #include "tst_test.h"
-#include "fanotify.h"
-
 #include <errno.h>
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define MNTPOINT "mntpoint"
 #define FILE1 MNTPOINT"/file1"
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index 6dd5de699..9e3748bc2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -22,12 +22,10 @@
 #include <fcntl.h>
 #include <sys/statfs.h>
 #include <sys/types.h>
-
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define EVENT_MAX 10
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index 0e4afac13..a554c7d39 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -24,10 +24,9 @@
 #include <sys/mount.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
-#if defined(HAVE_SYS_FANOTIFY_H)
-#include <sys/fanotify.h>
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
 
 #define EVENT_MAX 20
 
-- 
2.29.2

