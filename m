From: Alessio Balsini <balsini@android.com>
Date: Wed, 23 Jun 2021 14:40:41 +0100
Subject: [LTP] [PATCH] getrlimit/getrlimit03: fix unavailable __NR_getrlimit
 for arm
Message-ID: <20210623134041.366838-1-balsini@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

__NR_getrlimit has been deprecated from arm EABI, and is only available
if the OABI_COMPAT config option is defined.
This causes failures with the current test as it assumes that
__NR_getrlimit exists if __NR_ugetrlimit is defined, while this
assumption does not hold anymore.

Catch this exception by testing if __NR_getrlimit is defined and the
target is arm.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 testcases/kernel/syscalls/getrlimit/getrlimit03.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
index 319bc494a..e46a25f7b 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
@@ -45,6 +45,14 @@
 #define __NR_getrlimit_ulong_str	"__NR_getrlimit"
 #endif
 
+/**
+ * __NR_getrlimit has been deprecated from arm EABI and moved to OABI_COMPAT,
+ * so the syscall may or may not be available.
+ */
+#if defined(__arm__) && __NR_getrlimit == __LTP__NR_INVALID_SYSCALL
+#define DEPRECATED_GETRLIMIT
+#endif
+
 #ifndef HAVE_STRUCT_RLIMIT64
 struct rlimit64 {
 	uint64_t rlim_cur;
@@ -167,7 +175,7 @@ static void run(unsigned int resource)
 	tst_res(TPASS, "__NR_prlimit64(%d) and %s(%d) gave consistent results",
 		resource, __NR_getrlimit_ulong_str, resource);
 
-#if SIGNED_GETRLIMIT
+#if SIGNED_GETRLIMIT && !defined(DEPRECATED_GETRLIMIT)
 	errno = 0;
 	ret_l = getrlimit_long(resource, &rlim_l);
 	errno_l = errno;
-- 
2.32.0.288.g62a8d224e6-goog

