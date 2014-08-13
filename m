Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <asavkov@redhat.com>) id 1XHaj9-0005Az-KL
	for ltp-list@lists.sourceforge.net; Wed, 13 Aug 2014 15:44:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XHaj6-0001Ht-Su
	for ltp-list@lists.sourceforge.net; Wed, 13 Aug 2014 15:44:39 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7DFiUaO014131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Aug 2014 11:44:30 -0400
From: Artem Savkov <asavkov@redhat.com>
Date: Wed, 13 Aug 2014 17:44:22 +0200
Message-Id: <1407944666-32659-3-git-send-email-asavkov@redhat.com>
In-Reply-To: <1407944666-32659-1-git-send-email-asavkov@redhat.com>
References: <1407944666-32659-1-git-send-email-asavkov@redhat.com>
Subject: [LTP] [PATCH v2 2/6] netns tests: runnetnstest.sh ->
	runtest/containers
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Artem Savkov <asavkov@redhat.com>

Extracted netns tests from runnetnstest.sh and container_test.sh and added them
one by one to runtest/containers.
vsftpd start/stop is moved to par_child_ftp.sh
iproute2 check is moved to check_iproute() function in netn_helper.h

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 runtest/containers                                 |   6 +
 testcases/kernel/containers/container_test.sh      |   8 --
 testcases/kernel/containers/netns/Makefile         |   4 +-
 .../kernel/containers/netns/check_netns_enabled.c  |  56 ---------
 testcases/kernel/containers/netns/childns.sh       |   2 +
 testcases/kernel/containers/netns/crtchild.c       |  16 ++-
 .../kernel/containers/netns/crtchild_delchild.c    |  15 ++-
 testcases/kernel/containers/netns/initialize.sh    |   7 +-
 testcases/kernel/containers/netns/netns_helper.h   |  72 +++++++++++
 testcases/kernel/containers/netns/par_chld_ftp.c   |  17 ++-
 testcases/kernel/containers/netns/par_chld_ftp.sh  |  54 +++++++++
 testcases/kernel/containers/netns/par_chld_ipv6.c  |  11 ++
 testcases/kernel/containers/netns/runnetnstest.sh  | 133 ---------------------
 .../kernel/containers/netns/two_children_ns.c      |  14 ++-
 14 files changed, 207 insertions(+), 208 deletions(-)
 delete mode 100644 testcases/kernel/containers/netns/check_netns_enabled.c
 create mode 100644 testcases/kernel/containers/netns/netns_helper.h
 create mode 100755 testcases/kernel/containers/netns/par_chld_ftp.sh
 delete mode 100755 testcases/kernel/containers/netns/runnetnstest.sh

diff --git a/runtest/containers b/runtest/containers
index f14817c..5c4fc89 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -23,4 +23,10 @@ mqns_03_clone mqns_03 -clone
 mqns_04 mqns_04
 mqns_04_clone mqns_04 -clone
 
+crtchild crtchild
+two_children_ns two_children_ns
+crtchild_delchild crtchild_delchild
+par_chld_ipv6 par_chld_ipv6
+par_chld_ftp par_chld_ftp.sh
+
 Containers	container_test.sh
diff --git a/testcases/kernel/containers/container_test.sh b/testcases/kernel/containers/container_test.sh
index 73d2527..98e4851 100755
--- a/testcases/kernel/containers/container_test.sh
+++ b/testcases/kernel/containers/container_test.sh
@@ -45,11 +45,3 @@ if [ $? -eq 0 ]; then
 else
 	echo "ipc namespaces not enabled in kernel.  Not running ipcns tests."
 fi
-
-check_netns_enabled
-if [ $? -eq 0 ]; then
-	echo "Running netns tests."
-	runnetnstest.sh
-else
-	echo "Network namespaces not enabled in kernel.  Not running netns tests."
-fi
diff --git a/testcases/kernel/containers/netns/Makefile b/testcases/kernel/containers/netns/Makefile
index 68cca80..189272e 100644
--- a/testcases/kernel/containers/netns/Makefile
+++ b/testcases/kernel/containers/netns/Makefile
@@ -26,11 +26,11 @@ include $(abs_srcdir)/../Makefile.inc
 
 INSTALL_TARGETS		:= *.sh container_ftp.pl
 
+LDLIBS			+= -lclone
+
 MAKE_TARGETS		:= create_container crtchild crtchild_delchild \
 			   par_chld_ftp par_chld_ipv6 sysfsview two_children_ns
 
 $(MAKE_TARGETS): %: common.o %.o
 
-MAKE_TARGETS		+= check_netns_enabled
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/netns/check_netns_enabled.c b/testcases/kernel/containers/netns/check_netns_enabled.c
deleted file mode 100644
index 9c1d84a..0000000
--- a/testcases/kernel/containers/netns/check_netns_enabled.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
-* Copyright (c) International Business Machines Corp., 2008
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-* Author: Veerendra C <vechandr@in.ibm.com>
-*
-* Net namespaces were introduced around 2.6.25.  Kernels before that,
-* assume they are not enabled.  Kernels after that, check for -EINVAL
-* when trying to use CLONE_NEWNET and CLONE_NEWNS.
-***************************************************************************/
-
-#define _GNU_SOURCE
-
-#include <stdio.h>
-#include <sched.h>
-#include "config.h"
-#include "libclone.h"
-#include "linux_syscall_numbers.h"
-#include "test.h"
-
-char *TCID = "check_netns_enabled";
-int TST_COUNT = 1;
-int TST_TOTAL = 1;
-
-#ifndef CLONE_NEWNET
-#define CLONE_NEWNET -1
-#endif
-
-#ifndef CLONE_NEWNS
-#define CLONE_NEWNS -1
-#endif
-
-int main(void)
-{
-	/* Checking if the kernel supports unshare with netns capabilities. */
-	if (CLONE_NEWNET == -1 || CLONE_NEWNS == -1)
-		tst_resm(TBROK | TERRNO,
-			 "CLONE_NEWNET (%d) or CLONE_NEWNS (%d) not supported",
-			 CLONE_NEWNET, CLONE_NEWNS);
-	else if (ltp_syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) == -1)
-		tst_resm(TFAIL | TERRNO, "unshare syscall smoke test failed");
-	else
-		tst_resm(TPASS, "unshare syscall smoke test passed");
-	tst_exit();
-}
diff --git a/testcases/kernel/containers/netns/childns.sh b/testcases/kernel/containers/netns/childns.sh
index 23be6cd..5f5f6a9 100755
--- a/testcases/kernel/containers/netns/childns.sh
+++ b/testcases/kernel/containers/netns/childns.sh
@@ -33,6 +33,8 @@
 # The test case ID, the test case count and the total number of test case
 
 export TCID=${TCID:-childns.sh}
+export TST_COUNT=1
+export TST_TOTAL=1
 . cmdlib.sh
 exists awk grep ip ping sshd
 . initialize.sh
diff --git a/testcases/kernel/containers/netns/crtchild.c b/testcases/kernel/containers/netns/crtchild.c
index d2769c7..6f60500 100644
--- a/testcases/kernel/containers/netns/crtchild.c
+++ b/testcases/kernel/containers/netns/crtchild.c
@@ -27,12 +27,26 @@
 * =============================================================================*/
 
 #include "common.h"
+#include "netns_helper.h"
 
 const char *TCID = "crtchild";
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_iproute();
+	check_netns();
+}
+
 int main(void)
 {
 	int status;
+
+	setup();
 	status = create_net_namespace("parent.sh", "child.sh");
-	return status;
+	if (status == 0)
+		tst_resm(TPASS, "create_net_namespace");
+	else
+		tst_resm(TFAIL, "create_net_namespace");
+	tst_exit();
 }
diff --git a/testcases/kernel/containers/netns/crtchild_delchild.c b/testcases/kernel/containers/netns/crtchild_delchild.c
index 6b82997..0e85883 100644
--- a/testcases/kernel/containers/netns/crtchild_delchild.c
+++ b/testcases/kernel/containers/netns/crtchild_delchild.c
@@ -30,12 +30,25 @@
 * =========================================================================*/
 
 #include "common.h"
+#include "netns_helper.h"
 
 const char *TCID = "crtchild_delchild";
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_iproute();
+	check_netns();
+}
+
 int main(void)
 {
 	int status;
+	setup();
 	status = create_net_namespace("delchild.sh", "rename_net.sh");
-	return status;
+	if (status == 0)
+		tst_resm(TPASS, "create_net_namespace");
+	else
+		tst_resm(TFAIL, "create_net_namespace");
+	tst_exit();
 }
diff --git a/testcases/kernel/containers/netns/initialize.sh b/testcases/kernel/containers/netns/initialize.sh
index 5333e7b..a7d8a21 100755
--- a/testcases/kernel/containers/netns/initialize.sh
+++ b/testcases/kernel/containers/netns/initialize.sh
@@ -29,6 +29,8 @@ export TCID=${TCID:-initialize}
 export TST_TOTAL=1
 export TST_COUNT=1
 
+. test.sh
+
 TEST_SUBNET=${TEST_SUBNET:=192.168.0}
 i=1
 while [ $i -le 4 ] ; do
@@ -52,11 +54,6 @@ else
     exit 1
 fi
 
-IPver=`ip -V | awk  -F"-" ' { print $2 } '` ;
-if ! printf "%s\n%s\n" "ss080417" "$IPver" | sort -c ; then
-    tst_resm  TINFO "ip version should be atleast ss080417"
-    exit 1
-fi
 i=1
 while [ $i -le 6 ] ; do
     mkfifo /tmp/FIFO$i 2> /dev/null
diff --git a/testcases/kernel/containers/netns/netns_helper.h b/testcases/kernel/containers/netns/netns_helper.h
new file mode 100644
index 0000000..7f301ce
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_helper.h
@@ -0,0 +1,72 @@
+/*
+* Copyright (c) International Business Machines Corp., 2008
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+* the GNU General Public License for more details.
+* You should have received a copy of the GNU General Public License
+* along with this program; if not, write to the Free Software
+* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+*
+* Author: Veerendra C <vechandr@in.ibm.com>
+*
+* Net namespaces were introduced around 2.6.25.  Kernels before that,
+* assume they are not enabled.  Kernels after that, check for -EINVAL
+* when trying to use CLONE_NEWNET and CLONE_NEWNS.
+***************************************************************************/
+
+#define _GNU_SOURCE
+
+#include <sched.h>
+#include "config.h"
+#include "libclone.h"
+#include "linux_syscall_numbers.h"
+#include "test.h"
+#include "safe_macros.h"
+
+#ifndef CLONE_NEWNS
+#define CLONE_NEWNS -1
+#endif
+
+#define IPROUTE_MIN_VER 80725
+
+static void check_iproute(void)
+{
+	FILE *ipf;
+	int n;
+	unsigned int ipver = 0;
+
+	ipf = popen("ip -V", "r");
+	if (ipf == NULL)
+		tst_brkm(TCONF, NULL,
+				"Failed while opening pipe for iproute check");
+
+	n = fscanf(ipf, "ip utility, iproute2-ss%u", &ipver);
+	if (n < 1 || ipver < IPROUTE_MIN_VER)
+		tst_brkm(TCONF, NULL,
+			"iproute tools do not support setting network namespaces");
+
+	pclose(ipf);
+}
+
+static void check_netns(void)
+{
+	int pid, status;
+	/* Checking if the kernel supports unshare with netns capabilities. */
+	if (CLONE_NEWNS == -1)
+		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWNS (%d) not supported",
+			 CLONE_NEWNS);
+
+	pid = do_clone_unshare_test(T_UNSHARE, CLONE_NEWNET | CLONE_NEWNS, NULL,
+			NULL);
+	if (pid == -1)
+		tst_brkm(TCONF | TERRNO, NULL,
+				"unshare syscall smoke test failed");
+
+	SAFE_WAIT(NULL, &status);
+}
diff --git a/testcases/kernel/containers/netns/par_chld_ftp.c b/testcases/kernel/containers/netns/par_chld_ftp.c
index 605be19..acee21f 100644
--- a/testcases/kernel/containers/netns/par_chld_ftp.c
+++ b/testcases/kernel/containers/netns/par_chld_ftp.c
@@ -27,12 +27,27 @@
 * =============================================================================*/
 
 #include "common.h"
+#include "netns_helper.h"
 
 const char *TCID = "par_chld_ftp";
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_iproute();
+	check_netns();
+}
+
 int main(void)
 {
 	int status;
+
+	setup();
+
 	status = create_net_namespace("par_ftp.sh", "ch_ftp.sh");
-	return status;
+	if (status == 0)
+		tst_resm(TPASS, "create_net_namespace");
+	else
+		tst_resm(TFAIL, "create_net_namespace");
+	tst_exit();
 }
diff --git a/testcases/kernel/containers/netns/par_chld_ftp.sh b/testcases/kernel/containers/netns/par_chld_ftp.sh
new file mode 100755
index 0000000..5d461dc
--- /dev/null
+++ b/testcases/kernel/containers/netns/par_chld_ftp.sh
@@ -0,0 +1,54 @@
+#!/bin/bash
+
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2008                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+##                                                                            ##
+## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
+################################################################################
+
+export TCID=${TCID:-par_chld_ftp.sh}
+export TST_COUNT=1
+export TST_TOTAL=1
+
+. test.sh
+. daemonlib.sh
+
+flag=0
+
+status_daemon vsftpd
+if [ $? -ne 0 ]; then
+	start_daemon vsftpd
+	if [ $? -ne 0 ]; then
+		TST_CLEANUP=""
+		tst_brkm TCONF "Can't start vsftp"
+	fi
+	flag=1
+fi
+
+par_chld_ftp
+if [ $? -eq 0 ]; then
+	tst_resm TPASS "par_child_ftp"
+else
+	tst_resm TFAIL "par_child_ftp"
+fi
+
+if [ $flag -eq 1 ]; then
+	stop_daemon vsftpd
+fi
+
+tst_exit
diff --git a/testcases/kernel/containers/netns/par_chld_ipv6.c b/testcases/kernel/containers/netns/par_chld_ipv6.c
index f45ce5a..c9f7ad2 100644
--- a/testcases/kernel/containers/netns/par_chld_ipv6.c
+++ b/testcases/kernel/containers/netns/par_chld_ipv6.c
@@ -45,16 +45,26 @@
 #include "test.h"
 #include "config.h"
 #include "common.h"
+#include "netns_helper.h"
 
 char *TCID = "netns_ipv6";
 int TST_TOTAL = 1;
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_iproute();
+	check_netns();
+}
+
 int main(void)
 {
 	int pid, status = 0, ret;
 	long int flags = 0;
 	char *ltproot, *par, *child;
 
+	setup();
+
 	flags |= CLONE_NEWNS;
 	flags |= CLONE_NEWNET;
 
@@ -116,6 +126,7 @@ parent & child NS");
 				 errno);
 			status = errno;
 		}
+		tst_resm(TPASS, "par child ipv6");
 		return status;
 	}
 }
diff --git a/testcases/kernel/containers/netns/runnetnstest.sh b/testcases/kernel/containers/netns/runnetnstest.sh
deleted file mode 100755
index 15ee006..0000000
--- a/testcases/kernel/containers/netns/runnetnstest.sh
+++ /dev/null
@@ -1,133 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
-################################################################################
-
-
-rc=0
-exit_code=0
-
-# Check the iproute2 version (aka "SnapShot")
-IPROUTEV=`ip -V | cut -d ',' -f 2 | cut -d '-' -f 2 | sed -e 's/^ss//'`
-
-# We need to strip leading 0s else bash thinks we're giving it octal numbers.
-IPROUTEY=$(echo ${IPROUTEV:0:2} | sed -e 's/^0\+//') # Year
-IPROUTEM=$(echo ${IPROUTEV:2:2} | sed -e 's/^0\+//') # Month
-IPROUTED=$(echo ${IPROUTEV:4:2} | sed -e 's/^0\+//') # Day
-
-V=$((${IPROUTEY}*12*32 + ${IPROUTEM}*32 + ${IPROUTED}))
-
-#
-# iproute-ss080725 and later support setting the network namespace of an
-# interface.
-#
-NETNSV=$((8*12*32 + 7*32 + 25))
-if [ ${V} -lt ${NETNSV} ]; then
-	echo "INFO: iproute tools do not support setting network namespaces. Skipping network namespace tests."
-	exit $exit_code
-fi
-
-crtchild
-rc=$?
-if [ $rc -ne 0 ]; then
-    exit_code=$rc
-    errmesg="crtchild: return code is $exit_code ; "
-    echo $errmesg
-else
-   echo "crtchild: PASS"
-fi
-echo
-
-two_children_ns
-rc=$?
-if [ $rc -ne 0 ]; then
-    exit_code=$rc
-    errmesg="$errmesg two_children_ns: return code is $exit_code ; "
-    echo $errmesg
-else
-   echo "two_children_ns: PASS"
-fi
-echo
-
-crtchild_delchild
-rc=$?
-if [ $rc -ne 0 ]; then
-    exit_code=$rc
-    errmesg="$errmesg crtchild_delchild: return code is $exit_code ; "
-    echo $errmesg
-else
-   echo "crtchild_delchild: PASS"
-fi
-echo
-
-
-par_chld_ipv6
-rc=$?
-if [ $rc -ne 0 ]; then
-    exit_code=$rc
-    errmesg="$errmesg par_chld_ipv6: return code is $exit_code ; "
-    echo $errmesg
-else
-   echo "par_chld_ipv6: PASS"
-fi
-echo
-
-# sysfs tagging does not exist, so this test can't pass.  In
-# fact at the moment it fails when mount -t sysfs none /sys is
-# refused, fails in a bad state, leaving the system hard to
-# reboot.  Revisit enabling this test when per-container sysfs
-# views are supported.
-#sysfsview
-#rc=$?
-#if [ $rc -ne 0 ]; then
-#    exit_code=$rc
-#    errmesg="$errmesg sysfsview: return code is $exit_code ; "
-#    echo $errmesg
-#else
-#   echo "sysfsview: PASS"
-#fi
-#echo
-
-. cmdlib.sh
-flag=0
-
-status_daemon vsftpd
-if [ $? -ne 0 ]; then
-	start_daemon vsftpd
-	flag=1
-fi
-
-par_chld_ftp
-rc=$?
-if [ $rc -ne 0 ]; then
-    exit_code=$rc
-    errmesg="$errmesg par_chld_ftp: FAIL $exit_code ; "
-    echo $errmesg
-else
-   echo "par_chld_ftp: PASS"
-fi
-
-if [ $flag -eq 1 ]; then
-	stop_daemon vsftpd
-fi
-
-echo
-exit $exit_code
diff --git a/testcases/kernel/containers/netns/two_children_ns.c b/testcases/kernel/containers/netns/two_children_ns.c
index 13ae1e6..8cc0e5d 100644
--- a/testcases/kernel/containers/netns/two_children_ns.c
+++ b/testcases/kernel/containers/netns/two_children_ns.c
@@ -47,10 +47,18 @@
 #include "libclone.h"
 #include "config.h"
 #include "common.h"
+#include "netns_helper.h"
 
 char *TCID = "netns_2children";
 int TST_TOTAL = 1;
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_iproute();
+	check_netns();
+}
+
 int main(void)
 {
 	int ret, pid[2], status, i;
@@ -58,6 +66,8 @@ int main(void)
 	char *child[2], *par[2];
 	char *ltproot;
 
+	setup();
+
 	flags |= CLONE_NEWNS;
 	flags |= CLONE_NEWNET;
 
@@ -133,5 +143,7 @@ int main(void)
 			exit(status);
 		}
 	}
-	exit(0);
+
+	tst_resm(TPASS, "two children ns");
+	tst_exit();
 }
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
