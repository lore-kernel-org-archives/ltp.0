From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 31 Oct 2019 16:59:07 +0800
Subject: [LTP] [PATCH v2] syscalls/prctl02: add more error tests
In-Reply-To: <1572007183-13661-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1572007183-13661-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1572512347-30116-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

------
v1->v2:
1. add EACCES tests
2. remove ENOSYS, if kernel doesn't support option, it reports EINVAL.
 use ltp-prctl.m4 to distinguish.
------
---
 include/lapi/prctl.h                      |  10 +++
 m4/ltp-prctl.m4                           |   3 +-
 testcases/kernel/syscalls/prctl/prctl02.c | 104 ++++++++++++++++++++--
 3 files changed, 110 insertions(+), 7 deletions(-)

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
index ec45911fd..1798c4bd5 100644
--- a/testcases/kernel/syscalls/prctl/prctl02.c
+++ b/testcases/kernel/syscalls/prctl/prctl02.c
@@ -4,32 +4,116 @@
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
 #define INVALID_ARG 999
 
+static const struct sock_filter  strict_filter[] = {
+	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, (offsetof (struct seccomp_data, nr))),
+
+	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_close, 5, 0),
+	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_exit,  4, 0),
+	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_wait4, 3, 0),
+	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_write, 2, 0),
+	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_clone, 1, 0),
+
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL),
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW)
+};
+
+static const struct sock_fprog  strict = {
+	.len = (unsigned short)ARRAY_SIZE(strict_filter),
+	.filter = (struct sock_filter *)strict_filter
+};
+
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
+	{PR_SET_SECCOMP, 2, 2, EACCES, 0},
+	{PR_SET_TIMING, 1, 0, EINVAL, 0},
+#ifdef HAVE_DECL_PR_SET_NO_NEW_PRIVS
+	{PR_SET_NO_NEW_PRIVS, 0, 0, EINVAL, 0},
+	{PR_SET_NO_NEW_PRIVS, 1, 1, EINVAL, 0},
+	{PR_GET_NO_NEW_PRIVS, 1, 0, EINVAL, 0},
+#endif
+#ifdef HAVE_DECL_PR_SET_THP_DISABLE
+	{PR_SET_THP_DISABLE, 0, 1, EINVAL, 0},
+	{PR_GET_THP_DISABLE, 1, 0, EINVAL, 0},
+#endif
+#ifdef HAVE_DECL_PR_CAP_AMBIENT
+	{PR_CAP_AMBIENT, 2, 1, EINVAL, 0},
+#endif
+#ifdef HAVE_DECL_PR_GET_SPECULATION_CTR
+	{PR_GET_SPECULATION_CTRL, 1, 0, EINVAL, 0},
+#endif
+	{PR_SET_SECUREBITS, 0, 0, EPERM, 0},
+	{PR_CAPBSET_DROP, 1, 0, EPERM, 0},
 };
 
 static void verify_prctl(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	TEST(prctl(tc->option, tc->arg2));
+	if (tc->arg3 == 2)
+		tc->arg3 = (unsigned long)&strict;
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
@@ -38,7 +122,10 @@ static void verify_prctl(unsigned int n)
 	if (tc->exp_errno == TST_ERR) {
 		tst_res(TPASS | TTERRNO, "prctl() failed as expected");
 	} else {
-		tst_res(TFAIL | TTERRNO, "prctl() failed unexpectedly, expected %s",
+		if (tc->option == PR_SET_SECCOMP && TST_ERR == EINVAL)
+			tst_res(TCONF, "current system was not built with CONFIG_SECCOMP.");
+		else
+			tst_res(TFAIL | TTERRNO, "prctl() failed unexpectedly, expected %s",
 				tst_strerrno(tc->exp_errno));
 	}
 }
@@ -46,4 +133,9 @@ static void verify_prctl(unsigned int n)
 static struct tst_test test = {
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



