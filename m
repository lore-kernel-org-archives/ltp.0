From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 25 Oct 2019 20:39:43 +0800
Subject: [LTP] [PATCH] syscalls/prctl02: add more error tests
Message-ID: <1572007183-13661-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/prctl.h                      | 10 ++++
 testcases/kernel/syscalls/prctl/prctl02.c | 68 ++++++++++++++++++++---
 2 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
index 8ee492259..ea52ecac3 100644
--- a/include/lapi/prctl.h
+++ b/include/lapi/prctl.h
@@ -29,6 +29,11 @@
 # define PR_GET_NO_NEW_PRIVS 39
 #endif
 
+#ifndef PR_SET_THP_DISABLE
+# define PR_SET_THP_DISABLE 41
+# define PR_GET_THP_DISABLE 42
+#endif
+
 #ifndef PR_CAP_AMBIENT
 # define PR_CAP_AMBIENT             47
 # define PR_CAP_AMBIENT_IS_SET      1
@@ -37,4 +42,9 @@
 # define PR_CAP_AMBIENT_CLEAR_ALL   4
 #endif
 
+#ifndef PR_GET_SPECULATION_CTRL
+# define PR_GET_SPECULATION_CTRL 52
+# define PR_SET_SPECULATION_CTRL 53
+#endif
+
 #endif /* LAPI_PRCTL_H__ */
diff --git a/testcases/kernel/syscalls/prctl/prctl02.c b/testcases/kernel/syscalls/prctl/prctl02.c
index ec45911fd..8739b4fab 100644
--- a/testcases/kernel/syscalls/prctl/prctl02.c
+++ b/testcases/kernel/syscalls/prctl/prctl02.c
@@ -4,32 +4,77 @@
  *
  * 1) prctl() fails with EINVAL when an invalid value is given for option
  * 2) prctl() fails with EINVAL when option is PR_SET_PDEATHSIG & arg2 is
- * not zero or a valid signal number
+ * not zero or a valid signal number.
+ * 3) prctl() fails with EINVAL when option is PR_SET_DUMPABLE & arg2 is
+ * neither SUID_DUMP_DISABLE nor SUID_DUMP_USER.
+ * 4) prctl() fails with EFAULT when arg2 is an invalid address.
+ * 5) prctl() fails with EFAULT when option is PR_SET_SECCOMP & arg2 is
+ * SECCOMP_MODE_FILTER & arg3 is an invalid address.
+ * 6) prctl() fails with EINVAL when option is PR_SET_TIMING & arg2 is not
+ * not PR_TIMING_STATISTICAL.
+ * 7,8) prctl() fails with EINVAL when option is PR_SET_NO_NEW_PRIVS & arg2
+ * is not equal to 1 or arg3 is nonzero.
+ * 9) prctl() fails with EINVAL when options is PR_GET_NO_NEW_PRIVS & arg2,
+ * arg3, arg4, or arg5 is nonzero.
+ * 10) prctl() fails with EINVAL when options is PR_SET_THP_DISABLE & arg3,
+ * arg4, arg5 is non-zero.
+ * 11) prctl() fails with EINVAL when options is PR_GET_THP_DISABLE & arg2,
+ * arg3, arg4, or arg5 is nonzero.
+ * 12) prctl() fails with EINVAL when options is PR_CAP_AMBIENT & an unused
+ * argument such as arg4 is nonzero.
+ * 13) prctl() fails with EINVAL when option is PR_GET_SPECULATION_CTRL and
+ * unused arguments is nonzero.
+ * 14) prctl() fails with EPERM when option is PR_SET_SECUREBITS and the
+ * caller does not have the CAP_SETPCAP capability.
+ * 15) prctl() fails with EPERM when option is PR_CAPBSET_DROP and the caller
+ * does not have the CAP_SETPCAP capability.
  */
 
 #include <errno.h>
 #include <signal.h>
 #include <sys/prctl.h>
-
+#include "lapi/prctl.h"
+#include "lapi/seccomp.h"
 #include "tst_test.h"
+#include "tst_capability.h"
 
 #define OPTION_INVALID 999
 #define INVALID_ARG 999
-
 static struct tcase {
 	int option;
 	unsigned long arg2;
+	unsigned long arg3;
 	int exp_errno;
+	int bad_addr;
 } tcases[] = {
-	{OPTION_INVALID, 0, EINVAL},
-	{PR_SET_PDEATHSIG, INVALID_ARG, EINVAL},
+	{OPTION_INVALID, 0, 0, EINVAL, 0},
+	{PR_SET_PDEATHSIG, INVALID_ARG, 0, EINVAL, 0},
+	{PR_SET_DUMPABLE, 2, 0, EINVAL, 0},
+	{PR_SET_NAME, 0, 0, EFAULT, 1},
+	{PR_SET_SECCOMP, 2, 0, EFAULT, 1},
+	{PR_SET_TIMING, 1, 0, EINVAL, 0},
+	{PR_SET_NO_NEW_PRIVS, 0, 0, EINVAL, 0},
+	{PR_SET_NO_NEW_PRIVS, 1, 1, EINVAL, 0},
+	{PR_GET_NO_NEW_PRIVS, 1, 0, EINVAL, 0},
+	{PR_SET_THP_DISABLE, 0, 1, EINVAL, 0},
+	{PR_GET_THP_DISABLE, 1, 0, EINVAL, 0},
+	{PR_CAP_AMBIENT, 2, 1, EINVAL, 0},
+	{PR_GET_SPECULATION_CTRL, 1, 0, EINVAL, 0},
+	{PR_SET_SECUREBITS, 0, 0, EPERM, 0},
+	{PR_CAPBSET_DROP, 1, 0, EPERM, 0},
 };
 
 static void verify_prctl(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	TEST(prctl(tc->option, tc->arg2));
+	if (tc->bad_addr) {
+		if (tc->arg2)
+			tc->arg3 = (unsigned long)tst_get_bad_addr(NULL);
+		else
+			tc->arg2 = (unsigned long)tst_get_bad_addr(NULL);
+	}
+	TEST(prctl(tc->option, tc->arg2, tc->arg3));
 	if (TST_RET == 0) {
 		tst_res(TFAIL, "prctl() succeeded unexpectedly");
 		return;
@@ -38,7 +83,11 @@ static void verify_prctl(unsigned int n)
 	if (tc->exp_errno == TST_ERR) {
 		tst_res(TPASS | TTERRNO, "prctl() failed as expected");
 	} else {
-		tst_res(TFAIL | TTERRNO, "prctl() failed unexpectedly, expected %s",
+		if (TST_ERR == ENOSYS)
+			tst_res(TINFO,
+				"This prctl() option is not supported on current system");
+		else
+			tst_res(TFAIL | TTERRNO, "prctl() failed unexpectedly, expected %s",
 				tst_strerrno(tc->exp_errno));
 	}
 }
@@ -46,4 +95,9 @@ static void verify_prctl(unsigned int n)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_prctl,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+		TST_CAP(TST_CAP_DROP, CAP_SETPCAP),
+		{}
+	},
 };
-- 
2.18.0



