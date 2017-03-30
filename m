From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 30 Mar 2017 18:48:57 +0800
Subject: [LTP] [PATCH v2] syscalls/memfd_create: Fix build failure when
	HAVE_FALLOCATE not defined
In-Reply-To: <58DCD4B1.5060705@cn.fujitsu.com>
References: <58DCD4B1.5060705@cn.fujitsu.com>
Message-ID: <1490870937-1160-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/lapi/fallocate.h                                     | 11 +++++++++--
 testcases/kernel/syscalls/memfd_create/memfd_create_common.c |  4 ++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/lapi/fallocate.h b/include/lapi/fallocate.h
index 79d0b7b..aa32ff3 100644
--- a/include/lapi/fallocate.h
+++ b/include/lapi/fallocate.h
@@ -48,13 +48,20 @@
 #endif
 
 #if !defined(HAVE_FALLOCATE)
+
+#ifdef __TEST_H__
+# define TST_SYSCALL_WRAPPER ltp_syscall
+#else
+# define TST_SYSCALL_WRAPPER tst_syscall
+#endif /* __TEST_H__ */
+
 static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
 	/* Deal with 32bit ABIs that have 64bit syscalls. */
 # if LTP_USE_64_ABI
-	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
+	return TST_SYSCALL_WRAPPER(__NR_fallocate, fd, mode, offset, len);
 # else
-	return (long)ltp_syscall(__NR_fallocate, fd, mode,
+	return (long)TST_SYSCALL_WRAPPER(__NR_fallocate, fd, mode,
 				 __LONG_LONG_PAIR((off_t) (offset >> 32),
 						  (off_t) offset),
 				 __LONG_LONG_PAIR((off_t) (len >> 32),
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
index 8612db7..ddf9f05 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
@@ -18,7 +18,6 @@
 #include <sys/types.h>
 #include <sys/syscall.h>
 #include <sys/uio.h>
-#include <lapi/fallocate.h>
 #include <lapi/fcntl.h>
 #include <lapi/memfd.h>
 #include <errno.h>
@@ -28,7 +27,8 @@
 #include <unistd.h>
 
 #define TST_NO_DEFAULT_MAIN
-#include <tst_test.h>
+#include "tst_test.h"
+#include "lapi/fallocate.h"
 
 #include "linux_syscall_numbers.h"
 
-- 
1.8.4.2



