From: Li Wang <liwang@redhat.com>
Date: Thu,  9 Jan 2020 15:15:10 +0800
Subject: [LTP] [PATCH] tst_device: use raw syscall in the tst_device.h
Message-ID: <20200109071510.11223-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To follow up commit 447c223dba538efc7be23edc.

Signed-off-by: Li Wang <liwang@redhat.com>
Tested-by: Li Wang <liwang@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_device.h                                | 6 ++++--
 testcases/kernel/syscalls/fadvise/posix_fadvise01.c | 1 +
 testcases/kernel/syscalls/fadvise/posix_fadvise02.c | 1 +
 testcases/kernel/syscalls/fadvise/posix_fadvise03.c | 1 +
 testcases/kernel/syscalls/fadvise/posix_fadvise04.c | 1 +
 testcases/kernel/syscalls/fstat/fstat03.c           | 1 +
 testcases/kernel/syscalls/pwrite/pwrite02.c         | 1 +
 7 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index f277afd77..b4067be52 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -18,7 +18,9 @@
 #ifndef TST_DEVICE_H__
 #define TST_DEVICE_H__
 
+#define _GNU_SOURCE
 #include <unistd.h>
+#include <sys/syscall.h>
 
 struct tst_device {
 	const char *dev;
@@ -75,9 +77,9 @@ int tst_detach_device(const char *dev_path);
  * simply before the tst_dev_bytes_written invocation. For easy to use,
  * we create this inline function tst_dev_sync.
  */
-static inline void tst_dev_sync(int fd)
+static inline int tst_dev_sync(int fd)
 {
-	syncfs(fd);
+	return syscall(__NR_syncfs, fd);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
index 2af040840..f5d7ca8ac 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
@@ -20,6 +20,7 @@
  *	None
  */
 
+#define _GNU_SOURCE
 #define _XOPEN_SOURCE 600
 #include <fcntl.h>
 
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
index d533a7953..899f58af8 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
@@ -20,6 +20,7 @@
  *	None
  */
 
+#define _GNU_SOURCE
 #define _XOPEN_SOURCE 600
 #include <fcntl.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
index 5bada5f3d..efd3ab378 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -20,6 +20,7 @@
  *	None
  */
 
+#define _GNU_SOURCE
 #define _XOPEN_SOURCE 600
 #include <fcntl.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
index d8d8fb601..58162c6fb 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
@@ -20,6 +20,7 @@
  *	None
  */
 
+#define _GNU_SOURCE
 #define _XOPEN_SOURCE 600
 #include <fcntl.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/fstat/fstat03.c b/testcases/kernel/syscalls/fstat/fstat03.c
index 68fae43df..51637cdd7 100644
--- a/testcases/kernel/syscalls/fstat/fstat03.c
+++ b/testcases/kernel/syscalls/fstat/fstat03.c
@@ -13,6 +13,7 @@
  *    -> EFAULT (or receive signal SIGSEGV)
  */
 
+#define _GNU_SOURCE
 #include <errno.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/pwrite/pwrite02.c b/testcases/kernel/syscalls/pwrite/pwrite02.c
index 056d44da2..4582d4e94 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite02.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite02.c
@@ -18,6 +18,7 @@
  *      accessible address space, returns EFAULT.
  */
 
+#define _GNU_SOURCE
 #define _XOPEN_SOURCE 500
 
 #include <errno.h>
-- 
2.20.1

