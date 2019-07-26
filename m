From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 26 Jul 2019 11:25:23 -0700
Subject: [LTP] [PATCH 1/2] Add configure time check for getdents/getdents64
 APIs
Message-ID: <20190726182524.43149-1-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

glibc 2.30 has added wrapper for getdents64 this will help in detecting
right condition to use fallback

Check for getdents API as well while here

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 configure.ac                                  | 2 ++
 testcases/kernel/syscalls/getdents/getdents.h | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/configure.ac
+++ b/configure.ac
@@ -65,6 +65,8 @@ AC_CHECK_FUNCS([ \
     fallocate \
     fchownat \
     fstatat \
+    getdents \
+    getdents64 \
     kcmp \
     mkdirat \
     mknodat \
--- a/testcases/kernel/syscalls/getdents/getdents.h
+++ b/testcases/kernel/syscalls/getdents/getdents.h
@@ -23,7 +23,7 @@
 #include <stdint.h>
 #include "test.h"
 #include "lapi/syscalls.h"
-
+#include "config.h"
 /*
  * See fs/compat.c struct compat_linux_dirent
  */
@@ -34,12 +34,17 @@ struct linux_dirent {
 	char            d_name[];
 };
 
+#if HAVE_GETDENTS
+#include <unistd.h>
+#else
 static inline int
 getdents(unsigned int fd, struct linux_dirent *dirp, unsigned int size)
 {
 	return ltp_syscall(__NR_getdents, fd, dirp, size);
 }
 
+#endif /* HAVE_GETDENTS */
+
 struct linux_dirent64 {
 	uint64_t	d_ino;
 	int64_t		d_off;
@@ -48,10 +53,13 @@ struct linux_dirent64 {
 	char		d_name[];
 };
 
+#if HAVE_GETDENTS64
+#include <unistd.h>
+#else
 static inline int
 getdents64(unsigned int fd, struct linux_dirent64 *dirp64, unsigned int size)
 {
 	return ltp_syscall(__NR_getdents64, fd, dirp64, size);
 }
-
+#endif /* HAVE_GETDENTS64 */
 #endif /* GETDENTS_H */
