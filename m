From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 11 Nov 2019 16:59:12 +0800
Subject: [LTP] [PATCH v4] syscalls/prctl02: add more error tests
In-Reply-To: <20191108142434.GA5913@rei>
References: <20191108142434.GA5913@rei>
Message-ID: <1573462752-6679-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/prctl.h                      |  10 ++
 m4/ltp-prctl.m4                           |   3 +-
 testcases/kernel/syscalls/prctl/prctl02.c | 106 ++++++++++++++++++++--
 3 files changed, 109 insertions(+), 10 deletions(-)

diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
index 0b4e196c3..4499df030 100644
--- a/include/lapi/prctl.h
+++ b/include/lapi/prctl.h
@@ -34,6 +34,11 @@
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
@@ -42,4 +47,9 @@
 # define PR_CAP_AMBIENT_CLEAR_ALL   4
 #endif
 
+#ifndef PR_GET_SPECULATION_CTRL
+# define PR_GET_SPECULATION_CTRL 52
+# define PR_SET_SPECULATION_CTRL 53
+#endif
+
 #endif /* LAPI_PRCTL_H__ */
diff --git a/m4/ltp-prctl.m4 b/m4/ltp-prctl.m4
index e429db8fe..b592789ee 100644
--- a/m4/ltp-prctl.m4
+++ b/m4/ltp-prctl.m4
@@ -4,7 +4,8 @@ dnl Author: Ngie Cooper <yaneurabeya@gmail.com>
 
 AC_DEFUN([LTP_CHECK_PRCTL_SUPPORT],[
 AC_CHECK_HEADERS(sys/prctl.h,[
-	AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ], [],[],[
+	AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ, PR_CAP_AMBIENT,
+PR_SET_NO_NEW_PRIVS, PR_GET_SPECULATION_CTRL, PR_SET_THP_DISABLE], [],[],[
 #include <sys/prctl.h>
 ]) dnl AC_CHECK_DECLS
 ])]
diff --git a/testcases/kernel/syscalls/prctl/prctl02.c b/testcases/kernel/syscalls/prctl/prctl02.c
index ec45911fd..d266dda3c 100644
--- a/testcases/kernel/syscalls/prctl/prctl02.c
+++ b/testcases/kernel/syscalls/prctl/prctl02.c
@@ -4,46 +4,134 @@
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
+ * 6) prctl() fails with EACCES when option is PR_SET_SECCOMP & arg2 is
+ * SECCOMP_MODE_FILTER & the process does not have the CAP_SYS_ADMIN
+ * capability.
+ * 7) prctl() fails with EINVAL when option is PR_SET_TIMING & arg2 is not
+ * not PR_TIMING_STATISTICAL.
+ * 8,9) prctl() fails with EINVAL when option is PR_SET_NO_NEW_PRIVS & arg2
+ * is not equal to 1 or arg3 is nonzero.
+ * 10) prctl() fails with EINVAL when options is PR_GET_NO_NEW_PRIVS & arg2,
+ * arg3, arg4, or arg5 is nonzero.
+ * 11) prctl() fails with EINVAL when options is PR_SET_THP_DISABLE & arg3,
+ * arg4, arg5 is non-zero.
+ * 12) prctl() fails with EINVAL when options is PR_GET_THP_DISABLE & arg2,
+ * arg3, arg4, or arg5 is nonzero.
+ * 13) prctl() fails with EINVAL when options is PR_CAP_AMBIENT & an unused
+ * argument such as arg4 is nonzero.
+ * 14) prctl() fails with EINVAL when option is PR_GET_SPECULATION_CTRL and
+ * unused arguments is nonzero.
+ * 15) prctl() fails with EPERM when option is PR_SET_SECUREBITS and the
+ * caller does not have the CAP_SETPCAP capability.
+ * 16) prctl() fails with EPERM when option is PR_CAPBSET_DROP and the caller
+ * does not have the CAP_SETPCAP capability.
  */
 
 #include <errno.h>
 #include <signal.h>
 #include <sys/prctl.h>
-
+#include <linux/filter.h>
+#include <linux/capability.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stddef.h>
+#include "config.h"
+#include "lapi/prctl.h"
+#include "lapi/seccomp.h"
+#include "lapi/syscalls.h"
 #include "tst_test.h"
+#include "tst_capability.h"
 
 #define OPTION_INVALID 999
-#define INVALID_ARG 999
+
+static const struct sock_filter  strict_filter[] = {
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW)
+};
+
+static const struct sock_fprog strict = {
+	.len = (unsigned short)ARRAY_SIZE(strict_filter),
+	.filter = (struct sock_filter *)strict_filter
+};
+
+static const struct sock_fprog *strict_addr = &strict;
+
+static unsigned long bad_addr;
+static unsigned long num_0;
+static unsigned long num_1 = 1;
+static unsigned long num_2 = 2;
+static unsigned long num_invalid = 999;
 
 static struct tcase {
 	int option;
-	unsigned long arg2;
+	unsigned long *arg2;
+	unsigned long *arg3;
 	int exp_errno;
 } tcases[] = {
-	{OPTION_INVALID, 0, EINVAL},
-	{PR_SET_PDEATHSIG, INVALID_ARG, EINVAL},
+	{OPTION_INVALID, &num_1, &num_0, EINVAL},
+	{PR_SET_PDEATHSIG, &num_invalid, &num_0, EINVAL},
+	{PR_SET_DUMPABLE, &num_2, &num_0, EINVAL},
+	{PR_SET_NAME, &bad_addr, &num_0, EFAULT},
+	{PR_SET_SECCOMP, &num_2, &bad_addr, EFAULT},
+	{PR_SET_SECCOMP, &num_2, &strict_addr, EACCES},
+	{PR_SET_TIMING, &num_1, &num_0, EINVAL},
+#ifdef HAVE_DECL_PR_SET_NO_NEW_PRIVS
+	{PR_SET_NO_NEW_PRIVS, &num_0, &num_0, EINVAL},
+	{PR_SET_NO_NEW_PRIVS, &num_1, &num_0, EINVAL},
+	{PR_GET_NO_NEW_PRIVS, &num_1, &num_0, EINVAL},
+#endif
+#ifdef HAVE_DECL_PR_SET_THP_DISABLE
+	{PR_SET_THP_DISABLE, &num_0, &num_1, EINVAL},
+	{PR_GET_THP_DISABLE, &num_1, &num_1, EINVAL},
+#endif
+#ifdef HAVE_DECL_PR_CAP_AMBIENT
+	{PR_CAP_AMBIENT, &num_2, &num_1, EINVAL},
+#endif
+#ifdef HAVE_DECL_PR_GET_SPECULATION_CTRL
+	{PR_GET_SPECULATION_CTRL, &num_1, &num_0, EINVAL},
+#endif
+	{PR_SET_SECUREBITS, &num_0, &num_0, EPERM},
+	{PR_CAPBSET_DROP, &num_1, &num_0, EPERM},
 };
 
 static void verify_prctl(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	TEST(prctl(tc->option, tc->arg2));
+	TEST(prctl(tc->option, *tc->arg2, *tc->arg3));
 	if (TST_RET == 0) {
 		tst_res(TFAIL, "prctl() succeeded unexpectedly");
 		return;
 	}
 
 	if (tc->exp_errno == TST_ERR) {
-		tst_res(TPASS | TTERRNO, "prctl() failed as expected");
+		tst_res(TPASS | TTERRNO, "prctl() %d failed as expected", tc->option);
 	} else {
-		tst_res(TFAIL | TTERRNO, "prctl() failed unexpectedly, expected %s",
+		if (tc->option == PR_SET_SECCOMP && TST_ERR == EINVAL)
+			tst_res(TCONF, "current system was not built with CONFIG_SECCOMP.");
+		else
+			tst_res(TFAIL | TTERRNO, "prctl() failed unexpectedly, expected %s",
 				tst_strerrno(tc->exp_errno));
 	}
 }
 
+static void setup(void)
+{
+	bad_addr = (unsigned long)tst_get_bad_addr(NULL);
+}
+
 static struct tst_test test = {
+	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_prctl,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+		TST_CAP(TST_CAP_DROP, CAP_SETPCAP),
+		{}
+	},
 };
-- 
2.18.0



