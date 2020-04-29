From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Apr 2020 14:06:11 +0200
Subject: [LTP] [PATCH 2/2] fanotify: Test with tst_variant both raw
 syscall and libc
In-Reply-To: <CAOQ4uxjJ7qFZVf4YNNK=JYDSc=_+fRoU6v+OAwQ3Vp7soNSAbQ@mail.gmail.com>
References: <20200428113501.24711-1-pvorel@suse.cz>
 <20200428113501.24711-2-pvorel@suse.cz>
 <CAOQ4uxjTh5r3JWVzt6Gazh61Cb1Fr7Y90k1mXn=q2WbsSRs2NQ@mail.gmail.com>
 <20200428133748.GA5349@dell5510>
 <CAOQ4uxjJ7qFZVf4YNNK=JYDSc=_+fRoU6v+OAwQ3Vp7soNSAbQ@mail.gmail.com>
Message-ID: <20200429120611.GA10236@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> My confusion is because you removed the HAVE_SYS_FANOTIFY_H ifdef
> and now you include sys/fanotify.h unconditionally.
> So I meant if this code builds with all supported system configurations.
Thanks! I overlook an obvious error. Patch is wrong, because fanotify.h must be
included in tests below #if defined(HAVE_SYS_FANOTIFY_H).
Below is fix to posted patch, tested without <sys/fanotify.h>.

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fanotify/fanotify01.c testcases/kernel/syscalls/fanotify/fanotify01.c
index 77c18e67f..83bcfccb4 100644
--- testcases/kernel/syscalls/fanotify/fanotify01.c
+++ testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -18,10 +18,10 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git testcases/kernel/syscalls/fanotify/fanotify02.c testcases/kernel/syscalls/fanotify/fanotify02.c
index 32c842804..eedf00105 100644
--- testcases/kernel/syscalls/fanotify/fanotify02.c
+++ testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -18,10 +18,10 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git testcases/kernel/syscalls/fanotify/fanotify03.c testcases/kernel/syscalls/fanotify/fanotify03.c
index fdb0d0f58..cf7b30800 100644
--- testcases/kernel/syscalls/fanotify/fanotify03.c
+++ testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -22,10 +22,10 @@
 #include <sys/syscall.h>
 #include <stdlib.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git testcases/kernel/syscalls/fanotify/fanotify04.c testcases/kernel/syscalls/fanotify/fanotify04.c
index 8b738b3ae..725162f5b 100644
--- testcases/kernel/syscalls/fanotify/fanotify04.c
+++ testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -19,10 +19,10 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git testcases/kernel/syscalls/fanotify/fanotify05.c testcases/kernel/syscalls/fanotify/fanotify05.c
index 24edec19c..97c921886 100644
--- testcases/kernel/syscalls/fanotify/fanotify05.c
+++ testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -22,10 +22,10 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define MOUNT_PATH "fs_mnt"
 
diff --git testcases/kernel/syscalls/fanotify/fanotify06.c testcases/kernel/syscalls/fanotify/fanotify06.c
index 85dbe5b82..5aea43e33 100644
--- testcases/kernel/syscalls/fanotify/fanotify06.c
+++ testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -36,10 +36,10 @@
 #include <sys/mount.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git testcases/kernel/syscalls/fanotify/fanotify07.c testcases/kernel/syscalls/fanotify/fanotify07.c
index be42d1a0b..81fe8f443 100644
--- testcases/kernel/syscalls/fanotify/fanotify07.c
+++ testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -30,10 +30,10 @@
 #include <sys/syscall.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define BUF_SIZE 256
 static char fname[BUF_SIZE];
diff --git testcases/kernel/syscalls/fanotify/fanotify08.c testcases/kernel/syscalls/fanotify/fanotify08.c
index b61a5509a..b40f95cc9 100644
--- testcases/kernel/syscalls/fanotify/fanotify08.c
+++ testcases/kernel/syscalls/fanotify/fanotify08.c
@@ -18,10 +18,10 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 static int fd_notify;
 
diff --git testcases/kernel/syscalls/fanotify/fanotify09.c testcases/kernel/syscalls/fanotify/fanotify09.c
index a023cd8f6..4e2c6f3e1 100644
--- testcases/kernel/syscalls/fanotify/fanotify09.c
+++ testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -33,10 +33,10 @@
 #include <sys/syscall.h>
 #include <stdint.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git testcases/kernel/syscalls/fanotify/fanotify10.c testcases/kernel/syscalls/fanotify/fanotify10.c
index eb7e4efcf..cbef4b943 100644
--- testcases/kernel/syscalls/fanotify/fanotify10.c
+++ testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -30,10 +30,10 @@
 #include <sys/mount.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
diff --git testcases/kernel/syscalls/fanotify/fanotify11.c testcases/kernel/syscalls/fanotify/fanotify11.c
index b8da46eff..de72d10ef 100644
--- testcases/kernel/syscalls/fanotify/fanotify11.c
+++ testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -29,10 +29,10 @@
 #include <linux/limits.h>
 #include "tst_test.h"
 #include "tst_safe_pthread.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define gettid() syscall(SYS_gettid)
 static int tid;
diff --git testcases/kernel/syscalls/fanotify/fanotify12.c testcases/kernel/syscalls/fanotify/fanotify12.c
index 24fb712d4..916444f78 100644
--- testcases/kernel/syscalls/fanotify/fanotify12.c
+++ testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -21,10 +21,10 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define EVENT_MAX 1024
 #define EVENT_SIZE (sizeof (struct fanotify_event_metadata))
diff --git testcases/kernel/syscalls/fanotify/fanotify13.c testcases/kernel/syscalls/fanotify/fanotify13.c
index 065aac646..0fc82d6df 100644
--- testcases/kernel/syscalls/fanotify/fanotify13.c
+++ testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -25,10 +25,10 @@
 #include <errno.h>
 #include <unistd.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define PATH_LEN 128
 #define BUF_SIZE 256
diff --git testcases/kernel/syscalls/fanotify/fanotify14.c testcases/kernel/syscalls/fanotify/fanotify14.c
index d78c3f3ca..85c6cf401 100644
--- testcases/kernel/syscalls/fanotify/fanotify14.c
+++ testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -12,12 +12,12 @@
  */
 #define _GNU_SOURCE
 #include "tst_test.h"
-#include "fanotify.h"
 
 #include <errno.h>
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define MNTPOINT "mntpoint"
 #define FILE1 MNTPOINT"/file1"
diff --git testcases/kernel/syscalls/fanotify/fanotify15.c testcases/kernel/syscalls/fanotify/fanotify15.c
index 7aebe19c7..39c2c9275 100644
--- testcases/kernel/syscalls/fanotify/fanotify15.c
+++ testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -24,10 +24,10 @@
 #include <sys/types.h>
 
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
+#include "fanotify.h"
 
 #define EVENT_MAX 10
 
diff --git testcases/kernel/syscalls/fanotify/fanotify16.c testcases/kernel/syscalls/fanotify/fanotify16.c
index 35729aa7b..66dd4057d 100644
--- testcases/kernel/syscalls/fanotify/fanotify16.c
+++ testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -19,11 +19,11 @@
 #include <sys/mount.h>
 #include <sys/syscall.h>
 #include "tst_test.h"
-#include "fanotify.h"
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
 #include <sys/inotify.h>
+#include "fanotify.h"
 
 #define EVENT_MAX 10
 
