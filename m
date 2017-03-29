From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 29 Mar 2017 17:32:01 +0800
Subject: [LTP] [PATCH] syscalls/memfd_create: Fix build fail when
	HAVE_FALLOCATE not defined
In-Reply-To: <20170329091839.GD7089@rei.lan>
References: <20170329091839.GD7089@rei.lan>
Message-ID: <1490779921-7162-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/lapi/fallocate.h                                     | 12 ++++++++++++
 testcases/kernel/syscalls/memfd_create/memfd_create_common.c |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/lapi/fallocate.h b/include/lapi/fallocate.h
index 79d0b7b..20ba40c 100644
--- a/include/lapi/fallocate.h
+++ b/include/lapi/fallocate.h
@@ -52,13 +52,25 @@ static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
 	/* Deal with 32bit ABIs that have 64bit syscalls. */
 # if LTP_USE_64_ABI
+#ifdef __TEST_H__
 	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
+#else
+	return tst_syscall(__NR_fallocate, fd, mode, offset, len);
+#endif /* __TEST_H__ */
 # else
+#ifdef __TEST_H__
 	return (long)ltp_syscall(__NR_fallocate, fd, mode,
 				 __LONG_LONG_PAIR((off_t) (offset >> 32),
 						  (off_t) offset),
 				 __LONG_LONG_PAIR((off_t) (len >> 32),
 						  (off_t) len));
+#else
+	return (long)tst_syscall(__NR_fallocate, fd, mode,
+				 __LONG_LONG_PAIR((off_t) (offset >> 32),
+						  (off_t) offset),
+				 __LONG_LONG_PAIR((off_t) (len >> 32),
+						  (off_t) len));
+#endif /* __TEST_H__ */
 # endif
 }
 #endif
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



