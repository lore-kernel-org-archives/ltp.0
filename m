From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 17 Sep 2018 10:53:55 +0200
Subject: [LTP] [PATCH] syscalls/fcntl: make OFD commands use fcntl64()
	syscall on 32-bit
Message-ID: <20d04a28a6254edd95f0bee0e3662c147603665b.1537174128.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

OFD commands require 64-bit argument (struct flock64). Until
glibc commit 06ab719d30b0 ("Fix Linux fcntl OFD locks for
non-LFS architectures (BZ#20251)") we relied on glibc passing
arg directly to syscall.

This creates problem for 32-bit version of the test, because old
glibc is passing arg directly, while new one is casting it to
struct flock.

We could add a configure check for glibc version, but that may
not help with other libc libraries.

We could do a runtime check that exploits non-zero l_pid returning
EINVAL. This however complicates SAFE_FCNTL macro substantially.

This patch changes 32-bit version of test to use syscall directly.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/fcntl/fcntl34.c      | 10 ++++++--
 testcases/kernel/syscalls/fcntl/fcntl36.c      | 19 +++++++++++----
 testcases/kernel/syscalls/fcntl/fcntl_common.h | 33 ++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 6 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl_common.h

diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index aa29cf9ea0d8..90c40f9cf4c6 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -28,6 +28,7 @@
 #include "lapi/fcntl.h"
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
+#include "fcntl_common.h"
 
 static int thread_cnt;
 static const int max_thread_cnt = 32;
@@ -68,7 +69,12 @@ void *thread_fn_01(void *arg)
 
 	memset(buf, (intptr_t)arg, write_size);
 
+/* see explanation in fcntl_common.h */
+#ifdef USE_STRUCT_FLOCK64
 	struct flock64 lck = {
+#else
+	struct flock lck = {
+#endif
 		.l_whence = SEEK_SET,
 		.l_start  = 0,
 		.l_len    = 1,
@@ -76,13 +82,13 @@ void *thread_fn_01(void *arg)
 
 	for (i = 0; i < writes_num; ++i) {
 		lck.l_type = F_WRLCK;
-		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+		my_fcntl(fd, F_OFD_SETLKW, &lck);
 
 		SAFE_LSEEK(fd, 0, SEEK_END);
 		SAFE_WRITE(1, fd, buf, write_size);
 
 		lck.l_type = F_UNLCK;
-		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+		my_fcntl(fd, F_OFD_SETLKW, &lck);
 
 		sched_yield();
 	}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
index 81bd5a647e4c..709fcd3a6239 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl36.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -57,6 +57,7 @@
 #include "lapi/fcntl.h"
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
+#include "fcntl_common.h"
 
 static int thread_cnt;
 static int fail_flag = 0;
@@ -87,7 +88,12 @@ static void *fn_ofd_w(void *arg)
 	int fd = SAFE_OPEN(fname, O_RDWR);
 	long wt = pa->cnt;
 
+/* see explanation in fcntl_common.h */
+#ifdef USE_STRUCT_FLOCK64
 	struct flock64 lck = {
+#else
+	struct flock lck = {
+#endif
 		.l_whence = SEEK_SET,
 		.l_start  = pa->offset,
 		.l_len    = pa->length,
@@ -99,13 +105,13 @@ static void *fn_ofd_w(void *arg)
 		memset(buf, wt, pa->length);
 
 		lck.l_type = F_WRLCK;
-		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+		my_fcntl(fd, F_OFD_SETLKW, &lck);
 
 		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
 		SAFE_WRITE(1, fd, buf, pa->length);
 
 		lck.l_type = F_UNLCK;
-		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+		my_fcntl(fd, F_OFD_SETLKW, &lck);
 
 		wt++;
 		if (wt >= 255)
@@ -166,7 +172,12 @@ static void *fn_ofd_r(void *arg)
 	int i;
 	int fd = SAFE_OPEN(fname, O_RDWR);
 
+/* see explanation in fcntl_common.h */
+#ifdef USE_STRUCT_FLOCK64
 	struct flock64 lck = {
+#else
+	struct flock lck = {
+#endif
 		.l_whence = SEEK_SET,
 		.l_start  = pa->offset,
 		.l_len    = pa->length,
@@ -178,7 +189,7 @@ static void *fn_ofd_r(void *arg)
 		memset(buf, 0, pa->length);
 
 		lck.l_type = F_RDLCK;
-		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
+		my_fcntl(fd, F_OFD_SETLKW, &lck);
 
 		/* rlock acquired */
 		SAFE_LSEEK(fd, pa->offset, SEEK_SET);
@@ -209,7 +220,7 @@ static void *fn_ofd_r(void *arg)
 		}
 
 		lck.l_type = F_UNLCK;
-		SAFE_FCNTL(fd, F_OFD_SETLK, &lck);
+		my_fcntl(fd, F_OFD_SETLK, &lck);
 
 		sched_yield();
 	}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl_common.h b/testcases/kernel/syscalls/fcntl/fcntl_common.h
new file mode 100644
index 000000000000..d73e4624f3f6
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl_common.h
@@ -0,0 +1,33 @@
+#include "lapi/syscalls.h"
+
+/*
+ * glibc commit:
+ *   06ab719d30b0 ("Fix Linux fcntl OFD locks for non-LFS architectures (BZ#20251)")
+ * changed behavior of arg parameter for OFD commands. It is no
+ * longer passing arg directly to syscall, but expects it to be
+ * 'struct flock'.
+ *
+ * On 64-bit or _FILE_OFFSET_BITS == 64 we can use fcntl() and
+ * struct flock with any glibc version. struct flock and flock64
+ * should be identical.
+ *
+ * On 32-bit, older glibc would pass arg directly, recent one treats
+ * it as 'struct flock' and converts it to 'struct flock64'.
+ * So, to support both version, on 32-bit we use fcntl64 syscall
+ * directly with struct flock64.
+ */
+#if __WORDSIZE == 64 || _FILE_OFFSET_BITS == 64
+static int my_fcntl(int fd, int cmd, void *lck)
+{
+	return SAFE_FCNTL(fd, cmd, lck);
+}
+#else
+#define USE_STRUCT_FLOCK64
+static int my_fcntl(int fd, int cmd, void *lck)
+{
+	int ret = tst_syscall(__NR_fcntl64, fd, cmd, lck);
+	if (ret == -1)
+		tst_brk(TBROK|TERRNO, "fcntl64");
+	return ret;
+}
+#endif
-- 
1.8.3.1

