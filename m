From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 14 Apr 2016 17:22:05 +0800
Subject: [LTP] [PATCH v3 1/2] request_key/request_key01.c: add new testcase
In-Reply-To: <20160413160302.GG11529@rei.lan>
References: <20160413160302.GG11529@rei.lan>
Message-ID: <1460625726-3659-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase checks basic functionality of the request_key(2).
request_key(2) asks the kernel to find a key which matches the
specified description. If successful, it attaches it to the
nominated keyring and returns its serial number.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 configure.ac                                       |  1 +
 include/mk/config.mk.in                            |  1 +
 m4/ltp-keyutils.m4                                 | 24 ++++++
 runtest/ltplite                                    |  2 +
 runtest/syscalls                                   |  2 +
 testcases/kernel/syscalls/.gitignore               |  1 +
 testcases/kernel/syscalls/request_key/Makefile     | 24 ++++++
 .../kernel/syscalls/request_key/request_key01.c    | 95 ++++++++++++++++++++++
 8 files changed, 150 insertions(+)
 create mode 100644 m4/ltp-keyutils.m4
 create mode 100644 testcases/kernel/syscalls/request_key/Makefile
 create mode 100644 testcases/kernel/syscalls/request_key/request_key01.c

diff --git a/configure.ac b/configure.ac
index 2fb1ebc..7b98332 100644
--- a/configure.ac
+++ b/configure.ac
@@ -185,5 +185,6 @@ LTP_CHECK_KCMP_TYPE
 LTP_CHECK_PREADV
 LTP_CHECK_PWRITEV
 LTP_CHECK_EPOLL_PWAIT
+LTP_CHECK_KEYUTILS_SUPPORT
 
 AC_OUTPUT
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 73bd964..04b34e2 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -46,6 +46,7 @@ NUMA_LIBS		:= @NUMA_LIBS@
 SELINUX_LIBS		:= @SELINUX_LIBS@
 TIRPC_CPPFLAGS		:= @TIRPC_CPPFLAGS@
 TIRPC_LIBS		:= @TIRPC_LIBS@
+KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
 
 prefix			:= @prefix@
 
diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
new file mode 100644
index 0000000..74b7d32
--- /dev/null
+++ b/m4/ltp-keyutils.m4
@@ -0,0 +1,24 @@
+dnl
+dnl Copyright (c) 2016 Fujitsu Ltd.
+dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+dnl
+dnl This program is free software; you can redistribute it and/or modify it
+dnl under the terms of version 2 of the GNU General Public License as
+dnl published by the Free Software Foundation.
+dnl
+dnl This program is distributed in the hope that it would be useful, but
+dnl WITHOUT ANY WARRANTY; without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl alone with this program.
+dnl
+
+dnl
+dnl LTP_CHECK_KEYUTILS_SUPPORT
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT],[
+AC_CHECK_HEADERS([keyutils.h], [keyutils_libs="-lkeyutils"])
+AC_SUBST([KEYUTILS_LIBS], [$keyutils_libs])
+])
diff --git a/runtest/ltplite b/runtest/ltplite
index 3c256a9..ebd5e77 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -664,6 +664,8 @@ rename12 rename12
 rename13 rename13
 rename14 rename14
 
+request_key01 request_key01
+
 rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
diff --git a/runtest/syscalls b/runtest/syscalls
index ca922e6..8c87161 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -895,6 +895,8 @@ renameat01 renameat01
 renameat201 renameat201
 renameat202 renameat202 -i 10
 
+request_key01 request_key01
+
 rmdir01 rmdir01
 rmdir02 rmdir02
 rmdir03 rmdir03
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index ad2618c..21130d2 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -742,6 +742,7 @@
 /renameat/renameat01
 /renameat2/renameat201
 /renameat2/renameat202
+/request_key/request_key01
 /rmdir/rmdir01
 /rmdir/rmdir02
 /rmdir/rmdir03
diff --git a/testcases/kernel/syscalls/request_key/Makefile b/testcases/kernel/syscalls/request_key/Makefile
new file mode 100644
index 0000000..9add429
--- /dev/null
+++ b/testcases/kernel/syscalls/request_key/Makefile
@@ -0,0 +1,24 @@
+#  Copyright (c) 2016 Fujitsu Ltd.
+#  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+LDLIBS		+= $(KEYUTILS_LIBS)
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/request_key/request_key01.c b/testcases/kernel/syscalls/request_key/request_key01.c
new file mode 100644
index 0000000..e7c1f38
--- /dev/null
+++ b/testcases/kernel/syscalls/request_key/request_key01.c
@@ -0,0 +1,95 @@
+/*
+* Copyright (c) 2016 Fujitsu Ltd.
+* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it would be useful, but
+* WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+*
+* You should have received a copy of the GNU General Public License
+* alone with this program.
+*/
+
+/*
+* Test Name: request_key01
+*
+* Description:
+* The testcase checks basic functionality of the request_key(2).
+* request_key(2) asks the kernel to find a key which matches the
+* specified description. If successful, it attaches it to the
+* nominated keyring and returns its serial number.
+*
+*/
+
+#include "config.h"
+#include <errno.h>
+#include <sys/types.h>
+#ifdef HAVE_KEYUTILS_H
+#include <keyutils.h>
+#endif
+
+#include "test.h"
+
+char *TCID = "request_key01";
+
+#ifdef HAVE_KEYUTILS_H
+
+static int res;
+
+static void verify_request_key(void);
+static void setup(void);
+
+int TST_TOTAL = 1;
+
+int main(int ac, char **av)
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		verify_request_key();
+	}
+
+	tst_exit();
+}
+
+static void verify_request_key(void)
+{
+	TEST(request_key("keyring", "ltp", NULL, KEY_REQKEY_DEFL_DEFAULT));
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TERRNO, "request_key() failed");
+		return;
+	}
+
+	if (TEST_RETURN != res)
+		tst_resm(TFAIL, "serial number mismatched");
+	else
+		tst_resm(TPASS, "request_key() succeed");
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, NULL);
+
+	TEST_PAUSE;
+
+	res = add_key("keyring", "ltp", NULL, 0, KEY_SPEC_THREAD_KEYRING);
+	if (res == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "add_key() failed");
+}
+
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "keyutils.h was missing at compilation");
+}
+#endif /* HAVE_LINUX_KEYCTL_H */
-- 
1.8.3.1



