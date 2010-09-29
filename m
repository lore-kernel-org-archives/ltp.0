Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@hallyn.com>) id 1P0xKk-0000fa-JK
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 14:08:34 +0000
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P0xKj-00087D-8p
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 14:08:34 +0000
Date: Wed, 29 Sep 2010 08:56:47 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
Message-ID: <20100929135647.GA4587@hallyn.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] securebits: add secure_keepcaps testcases
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sf.net
Cc: Subrata Modak1 <subrata.modak@in.ibm.com>

This adds basic tests of the keepcaps securebits settings.

Lots more securebits tests to come (see my email from one
or 1.5 years ago, and, heck, write them if you have time :).

Signed-off-by: Serge E. Hallyn <serge.hallyn@canonical.com>
---
 m4/ltp-securebits.m4                               |   24 +++
 runtest/securebits                                 |    2 +
 testcases/kernel/security/Makefile                 |    5 +-
 testcases/kernel/security/securebits/Makefile      |   28 ++++
 .../kernel/security/securebits/check_keepcaps.c    |  161 ++++++++++++++++++++
 .../kernel/security/securebits/run_securebits.sh   |   20 +++
 6 files changed, 239 insertions(+), 1 deletions(-)
 create mode 100644 m4/ltp-securebits.m4
 create mode 100644 runtest/securebits
 create mode 100644 testcases/kernel/security/securebits/Makefile
 create mode 100644 testcases/kernel/security/securebits/check_keepcaps.c
 create mode 100644 testcases/kernel/security/securebits/run_securebits.sh

diff --git a/m4/ltp-securebits.m4 b/m4/ltp-securebits.m4
new file mode 100644
index 0000000..6407eb8
--- /dev/null
+++ b/m4/ltp-securebits.m4
@@ -0,0 +1,24 @@
+dnl
+dnl Copyright (c) Serge Hallyn (2010)
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+dnl
+
+
+AC_DEFUN([LTP_CHECK_SECUREBITS],
+AC_CHECK_HEADERS(linux/securebits.h,[
+	LTP_SECUREBITS=yes
+])
+)
diff --git a/runtest/securebits b/runtest/securebits
new file mode 100644
index 0000000..d78a66f
--- /dev/null
+++ b/runtest/securebits
@@ -0,0 +1,2 @@
+#DESCRIPTION:securebits tests
+Securebits	run_securebits.sh
diff --git a/testcases/kernel/security/Makefile b/testcases/kernel/security/Makefile
index 52b8d06..a877836 100644
--- a/testcases/kernel/security/Makefile
+++ b/testcases/kernel/security/Makefile
@@ -27,11 +27,14 @@ include	$(top_srcdir)/include/mk/env_pre.mk
 # For broken compilers and toolchains, like Montavista, that improperly detect
 # system headers when running autoconf -_-... bleh.
 ifeq ($(strip $(CAP_LIBS)),)
-FILTER_OUT_DIRS		:= cap_bound filecaps
+FILTER_OUT_DIRS		:= cap_bound filecaps securebits
 endif
 ifeq ($(HAVE_SETCAP),false)
 FILTER_OUT_DIRS		+= filecaps
 endif
+ifeq ($(LTP_SECUREBITS),false)
+FILTER_OUT_DIRS		+= securebits
+endif
 
 # XXX (garrcoop): avoid compilation failures on RHEL 5.4, as reported by
 # Mitani-san, because of policy versioning issues...
diff --git a/testcases/kernel/security/securebits/Makefile b/testcases/kernel/security/securebits/Makefile
new file mode 100644
index 0000000..a76f2e0
--- /dev/null
+++ b/testcases/kernel/security/securebits/Makefile
@@ -0,0 +1,28 @@
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2009                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ## ## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+################################################################################
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+LDLIBS			+= $(CAP_LIBS)
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/securebits/check_keepcaps.c b/testcases/kernel/security/securebits/check_keepcaps.c
new file mode 100644
index 0000000..e969ae4
--- /dev/null
+++ b/testcases/kernel/security/securebits/check_keepcaps.c
@@ -0,0 +1,161 @@
+#include <errno.h>
+#include "config.h"
+#if HAVE_SYS_CAPABILITY_H
+#include <sys/capability.h>
+#endif
+#include <sys/prctl.h>
+#include <linux/securebits.h>
+#include <test.h>
+
+int errno;
+
+/* Tests:
+	1. drop capabilities at setuid if KEEPCAPS is not set and
+	   new user is nonroot
+	2. keep capabilities if set and new user is nonroot
+	   a. do with prctl(PR_SET_KEEPCAPS)
+	   (call this test 2)
+	   b. do with prctl(PR_SET_SECUREBITS, SECURE_KEEP_CAPS)
+	   (call this test 3)
+   TODO: test that exec clears KEEPCAPS
+   	(just create a simple executable that checks PR_GET_KEEPCAPS
+	 results, and execute that as test 4 after doing PR_SET_KEEPCAPS).
+   TODO: all of the other securebits tests.
+ */
+
+char *TCID = "keepcaps";
+int TST_TOTAL=1;
+
+#ifdef HAVE_LIBCAP
+static int eff_caps_empty(cap_t c)
+{
+	int i, ret, v, empty=1;
+
+	for (i = 0; i < CAP_LAST_CAP; i++) {
+		ret = cap_get_flag(c, i, CAP_PERMITTED, &v);
+		if (ret || v)
+			empty = 0;
+	}
+
+	return empty;
+}
+
+static int am_privileged(void)
+{
+	int am_privileged = 1;
+
+	cap_t cap = cap_get_proc();
+	if (eff_caps_empty(cap))
+		am_privileged = 0;
+	cap_free(cap);
+
+	return am_privileged;
+}
+#else
+static int am_privileged(void)
+{
+	tst_resm(TBROK, "libcap not installed.");
+	tst_exit();
+}
+#endif
+
+#define EXPECT_NOPRIVS 0
+#define EXPECT_PRIVS 1
+static void do_setuid(int expect_privs)
+{
+	int ret;
+	int have_privs;
+
+	ret = setuid(1000);
+	if (ret) {
+		tst_resm(TERRNO | TFAIL, "setuid failed");
+		tst_exit();
+	}
+
+	have_privs = am_privileged();
+	if (have_privs && expect_privs == EXPECT_PRIVS) {
+		tst_resm(TPASS, "kept privs as expected");
+		tst_exit();
+	}
+	if (!have_privs && expect_privs == EXPECT_PRIVS) {
+		tst_resm(TFAIL, "expected to keep privs but did not");
+		tst_exit();
+	}
+	if (!have_privs && expect_privs == EXPECT_NOPRIVS) {
+		tst_resm(TPASS, "dropped privs as expected");
+		tst_exit();
+	}
+
+	/* have_privs && EXPECT_NOPRIVS */
+	tst_resm(TFAIL, "expected to drop privs but did not");
+	tst_exit();
+}
+
+static int am_root(void)
+{
+	uid_t uid = getuid();
+	if (uid != 0)
+		return 0;
+	if (!am_privileged())
+		return 0;
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, whichtest;
+
+	ret = prctl(PR_GET_KEEPCAPS);
+	if (ret) {
+		tst_resm(TBROK, "keepcaps was already set?\n");
+		tst_exit();
+	}
+	if (!am_root()) {
+		tst_resm(TBROK, "Run me as root and privileged\n");
+		tst_exit();
+	}
+
+	if (argc < 2) {
+		tst_resm(TBROK, "Usage: %s <tescase_num>", argv[0]);
+		tst_exit();
+	}
+	whichtest = atoi(argv[1]);
+	if (whichtest < 1 || whichtest > 3) {
+		tst_resm(TFAIL, "Valid tests are 1-3\n");
+		tst_exit();
+	}
+	switch(whichtest) {
+	case 1:
+		do_setuid(EXPECT_NOPRIVS); /* does not return */
+	case 2:
+		ret = prctl(PR_SET_KEEPCAPS, 1);
+		if (ret == -1) {
+			tst_resm(TFAIL|TERRNO, "PR_SET_KEEPCAPS failed\n");
+			tst_exit();
+		}
+		ret = prctl(PR_GET_KEEPCAPS);
+		if (!ret) {
+			tst_resm(TFAIL|TERRNO, "PR_SET_KEEPCAPS did not set keepcaps\n");
+			tst_exit();
+		}
+		do_setuid(EXPECT_PRIVS); /* does not return */
+	case 3:
+		ret = prctl(PR_GET_SECUREBITS);
+		ret = prctl(PR_SET_SECUREBITS, ret | SECBIT_KEEP_CAPS);
+		if (ret == -1) {
+			tst_resm(TFAIL|TERRNO, "PR_SET_SECUREBITS failed\n");
+			tst_exit();
+		}
+		ret = prctl(PR_GET_KEEPCAPS);
+		if (!ret) {
+			tst_resm(TFAIL|TERRNO, "PR_SET_SECUREBITS did not set keepcaps\n");
+			tst_exit();
+		}
+		do_setuid(EXPECT_PRIVS); /* does not return */
+	default:
+		tst_resm(TFAIL, "should not reach here\n");
+		tst_exit();
+	}
+	tst_resm(TFAIL, "should not reach here\n");
+	tst_exit();
+}
diff --git a/testcases/kernel/security/securebits/run_securebits.sh b/testcases/kernel/security/securebits/run_securebits.sh
new file mode 100644
index 0000000..4d9e272
--- /dev/null
+++ b/testcases/kernel/security/securebits/run_securebits.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+echo "testing keepcaps"
+check_keepcaps 1
+tmp=$?
+if [ $tmp -ne 0 ]; then
+	exit_code=$tmp
+fi
+check_keepcaps 2
+tmp=$?
+if [ $tmp -ne 0 ]; then
+	exit_code=$tmp
+fi
+check_keepcaps 3
+tmp=$?
+if [ $tmp -ne 0 ]; then
+	exit_code=$tmp
+fi
+
+exit $exit_code
-- 
1.7.1



------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
