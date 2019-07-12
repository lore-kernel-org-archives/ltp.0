From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 12 Jul 2019 17:54:35 +0800
Subject: [LTP] [PATCH v2] syscalls/prctl07: New test for prctl() with
 PR_CAP_AMBIENT
In-Reply-To: <20190709112046.GC4914@rei.lan>
References: <20190709112046.GC4914@rei.lan>
Message-ID: <1562925275-2390-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since Linux 4.3, PR_CAP_AMBIENT has been supported. We can read or change
the ambient capability set of the calling thread by using the following
option: PR_CAP_AMBIENT_RAISE, PR_CAP_AMBIENT_LOWER,PR_CAP_AMBIENT_IS_SET,
PR_CAP_AMBIENT_CLEAR_ALL.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac                               |   1 +
 include/lapi/prctl.h                       |   8 +
 include/lapi/securebits.h                  |  15 ++
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/prctl/.gitignore |   1 +
 testcases/kernel/syscalls/prctl/Makefile   |   2 +
 testcases/kernel/syscalls/prctl/prctl07.c  | 194 +++++++++++++++++++++
 7 files changed, 222 insertions(+)
 create mode 100644 include/lapi/securebits.h
 create mode 100644 testcases/kernel/syscalls/prctl/prctl07.c

diff --git a/configure.ac b/configure.ac
index f78db90ce..56291fc2f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -47,6 +47,7 @@ AC_CHECK_HEADERS([ \
     linux/module.h \
     linux/netlink.h \
     linux/seccomp.h \
+    linux/securebits.h \
     linux/userfaultfd.h \
     mm.h \
     netinet/sctp.h \
diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
index 54b3da20f..8ee492259 100644
--- a/include/lapi/prctl.h
+++ b/include/lapi/prctl.h
@@ -29,4 +29,12 @@
 # define PR_GET_NO_NEW_PRIVS 39
 #endif
 
+#ifndef PR_CAP_AMBIENT
+# define PR_CAP_AMBIENT             47
+# define PR_CAP_AMBIENT_IS_SET      1
+# define PR_CAP_AMBIENT_RAISE       2
+# define PR_CAP_AMBIENT_LOWER       3
+# define PR_CAP_AMBIENT_CLEAR_ALL   4
+#endif
+
 #endif /* LAPI_PRCTL_H__ */
diff --git a/include/lapi/securebits.h b/include/lapi/securebits.h
new file mode 100644
index 000000000..9c9216e13
--- /dev/null
+++ b/include/lapi/securebits.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+#ifndef LAPI_SECUREBITS_H
+#define LAPI_SECUREBITS_H
+
+# ifdef HAVE_LINUX_SECUREBITS_H
+#  include <linux/securebits.h>
+# endif /* HAVE_LINUX_SECUREBITS_H*/
+# ifndef SECBIT_NO_CAP_AMBIENT_RAISE
+#  define SECBIT_NO_CAP_AMBIENT_RAISE  6
+# endif
+#endif /* LAPI_SECUREBITS_H */
diff --git a/runtest/syscalls b/runtest/syscalls
index ef7af41b5..c35add35f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -866,6 +866,7 @@ prctl03 prctl03
 prctl04 prctl04
 prctl05 prctl05
 prctl06 prctl06
+prctl07 prctl07
 
 pread01 pread01
 pread01_64 pread01_64
diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
index ee994086f..2178db366 100644
--- a/testcases/kernel/syscalls/prctl/.gitignore
+++ b/testcases/kernel/syscalls/prctl/.gitignore
@@ -5,3 +5,4 @@
 /prctl05
 /prctl06
 /prctl06_execve
+/prctl07
diff --git a/testcases/kernel/syscalls/prctl/Makefile b/testcases/kernel/syscalls/prctl/Makefile
index bd617d806..1399122e8 100644
--- a/testcases/kernel/syscalls/prctl/Makefile
+++ b/testcases/kernel/syscalls/prctl/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+LDLIBS += $(CAP_LIBS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/prctl/prctl07.c b/testcases/kernel/syscalls/prctl/prctl07.c
new file mode 100644
index 000000000..bbb9161dd
--- /dev/null
+++ b/testcases/kernel/syscalls/prctl/prctl07.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ *
+ * Test the PR_CAP_AMBIENT of prctl(2).
+ * Reads or changes the ambient capability set of the calling thread,
+ * according to the value of arg2, which must be one of the following:
+ * 1)PR_CAP_AMBIENT_RAISE:
+ * The capability specified in arg3 is added to the ambient set.
+ * The specified capability must already be present in both pE and pI.
+ * If we set SECBIT_NO_CAP_AMBIENT_RAISE bit, raise option will be rejected
+ * and retrun EPERM. We also raise a CAP twice.
+ * 2)PR_CAP_AMBIENT_LOWER:
+ * The capability specified in arg3 is removed from the ambient set.
+ * Even though this cap is not in set, it also should return 0.
+ * 3)PR_CAP_AMBIENT_IS_SET:
+ * Returns 1 if the capability in arg3 is in the ambient set and 0 if it
+ * is not.
+ * 4)PR_CAP_AMBIENT_CLEAR_ALL:
+ * All capabilities will be removed from the ambient set. This operation
+ * requires setting arg3 to zero.
+ */
+
+#include <sys/prctl.h>
+#include <stdlib.h>
+#include "config.h"
+#ifdef HAVE_LIBCAP
+#include <sys/capability.h>
+#endif
+#include "lapi/syscalls.h"
+#include "lapi/prctl.h"
+#include "lapi/securebits.h"
+#include "tst_test.h"
+
+static void check_proc_capamb(char *message, int flag)
+{
+	unsigned int cap_num;
+	char CapAmb[20];
+	char path[50];
+
+	strcpy(path, "/proc/self/status");
+	SAFE_FILE_LINES_SCANF(path, "CapAmb:%s", CapAmb);
+	cap_num = atoi(CapAmb);
+	if (flag == 2) {
+		if (cap_num == 0)
+			tst_res(TPASS,
+				"%s, %s CapAmb has been clear as %d",
+				message, path, cap_num);
+		else
+			tst_res(TFAIL,
+				"%s, %s CapAmb has been clear expect 0, got %d",
+				message, path, cap_num);
+		return;
+	}
+	/*1 <<  CAP_NET_BIND_SERVICE*/
+	if (cap_num ==  400)
+		tst_res(flag ? TPASS : TFAIL,
+			"%s, CapAmb in %s has CAP_NET_BIND_SERVICE",
+			message, path);
+	else
+		tst_res(flag ? TFAIL : TPASS,
+			"%s, CapAmb in %s doesn't have CAP_NET_BIND_SERVICE",
+			message, path);
+}
+
+static void check_cap_raise(unsigned int cap, char *message, int fail_flag)
+{
+	TEST(prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, cap, 0, 0, 0));
+	switch (fail_flag) {
+	case 0:
+	if (TST_RET == 0)
+		tst_res(TPASS, "PR_CAP_AMBIENT_RAISE %s succeeded", message);
+	else
+		tst_res(TFAIL, "PR_CAP_AMBIENT_RAISE %s failed unexpectedly",
+			message);
+	break;
+	case 1:
+	if (TST_RET == 0)
+		tst_res(TFAIL,
+			"PR_CAP_AMBIENT_RAISE succeeded unexpectedly %s",
+			message);
+	else if (TST_ERR == EPERM)
+		tst_res(TPASS,
+			"PR_CAP_AMBIENT_RAISE failed with EPERM %s", message);
+	else
+		tst_res(TFAIL | TERRNO,
+			"PR_CAP_AMBIENT_RAISE failed %s", message);
+	break;
+	}
+}
+
+static void check_cap_is_set(unsigned int cap, char *message, int val)
+{
+	TEST(prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_IS_SET, cap, 0, 0, 0));
+	if (TST_RET == 1)
+		tst_res(val ? TPASS : TFAIL,
+			"PR_CAP_AMBIENT_IS_SET %s in AmbientCap", message);
+	else if (TST_RET == 0)
+		tst_res(val ? TFAIL : TPASS,
+			"PR_CAP_AMBIENT_IS_SET %s not in AmbientCap", message);
+	else
+		tst_res(TFAIL | TERRNO, "PR_CAP_AMBIENT_IS_SET failed");
+}
+
+static void check_cap_lower(unsigned int cap, char *message)
+{
+	TEST(prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_LOWER, cap, 0, 0, 0));
+	if (TST_RET == -1)
+		tst_res(TFAIL | TERRNO,
+			"PR_CAP_AMBIENT_LOWER %s failed", message);
+	else
+		tst_res(TPASS, "PR_CAP_AMBIENT_LOWER %s succeeded", message);
+}
+
+static void verify_prctl(void)
+{
+#ifdef HAVE_LIBCAP
+	cap_t caps = cap_init();
+
+	cap_value_t caplist[3] = {CAP_NET_RAW, CAP_NET_BIND_SERVICE, CAP_SETPCAP};
+	unsigned int numcaps = 3;
+
+	cap_set_flag(caps, CAP_EFFECTIVE, numcaps, caplist, CAP_SET);
+	cap_set_flag(caps, CAP_INHERITABLE, numcaps, caplist, CAP_SET);
+	cap_set_flag(caps, CAP_PERMITTED, numcaps, caplist, CAP_SET);
+	cap_set_proc(caps);
+
+	check_proc_capamb("At the beginning", 0);
+
+	cap_clear_flag(caps, CAP_INHERITABLE);
+	cap_set_proc(caps);
+	check_cap_raise(CAP_NET_BIND_SERVICE, "on non-inheritable cap", 1);
+
+	cap_set_flag(caps, CAP_INHERITABLE, numcaps, caplist, CAP_SET);
+	cap_clear_flag(caps, CAP_PERMITTED);
+	cap_set_proc(caps);
+	check_cap_raise(CAP_NET_RAW, "on non-permitted cap", 1);
+
+	cap_set_flag(caps, CAP_PERMITTED, numcaps, caplist, CAP_SET);
+	cap_set_proc(caps);
+	prctl(PR_SET_SECUREBITS, SECBIT_NO_CAP_AMBIENT_RAISE);
+	check_cap_raise(CAP_NET_BIND_SERVICE, "because of NO_RAISE_SECBIT set", 1);
+	prctl(PR_SET_SECUREBITS, 0);
+
+	check_cap_raise(CAP_NET_BIND_SERVICE, "CAP_NET_BIND_SERVICE", 0);
+	/*Even this cap has been in ambient set, raise succeeds and return 0*/
+	check_cap_raise(CAP_NET_BIND_SERVICE, "CAP_NET_BIND_SERIVCE twice", 0);
+
+	check_proc_capamb("After PR_CAP_AMBIENT_RAISE", 1);
+
+	check_cap_is_set(CAP_NET_BIND_SERVICE, "CAP_NET_BIND_SERVICE was", 1);
+	check_cap_is_set(CAP_NET_RAW, "CAP_NET_RAW was", 0);
+	/*move a cap what was not in ambient set, it also return 0*/
+	check_cap_lower(CAP_NET_RAW, "CAP_NET_RAW(it wasn't in ambient set)");
+	check_cap_lower(CAP_NET_BIND_SERVICE, "CAP_NET_BIND_SERVICE(it was in ambient set)");
+	check_proc_capamb("After PR_CAP_AMBIENT_LORWER", 0);
+
+	prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_RAISE, CAP_NET_BIND_SERVICE, 0, 0, 0);
+	tst_res(TINFO, "raise cap for clear");
+	TEST(prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_CLEAR_ALL, 0, 0, 0, 0));
+	if (TST_RET == 0)
+		tst_res(TPASS, "PR_CAP_AMBIENT_CLEAR ALL succeeded");
+	else
+		tst_res(TFAIL | TERRNO, "PR_AMBIENT_CLEAR_ALL failed");
+
+	check_proc_capamb("After PR_CAP_AMBIENT_CLEAN_ALL", 2);
+
+	cap_free(caps);
+#else
+	tst_res(TCONF, "System doesn't have POSIX capabilities support");
+#endif
+}
+
+static void setup(void)
+{
+	TEST(prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_CLEAR_ALL, 0, 0, 0, 0));
+	if (TST_RET == 0) {
+		tst_res(TINFO, "kernel supports PR_CAP_AMBIENT");
+		return;
+	}
+
+	if (TST_ERR == EINVAL)
+		tst_brk(TCONF, "kernel doesn't support PR_CAP_AMBIENT");
+
+	tst_brk(TBROK | TERRNO,
+		"current environment doesn't permit PR_CAP_AMBIENT");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_prctl,
+	.needs_root = 1,
+};
-- 
2.18.1



