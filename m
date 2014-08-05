Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <asavkov@redhat.com>) id 1XEgn8-0001n1-S0
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 15:36:46 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XEgn2-0008U2-Ov
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 15:36:46 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s75FaYBn005018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Aug 2014 11:36:34 -0400
From: Artem Savkov <asavkov@redhat.com>
Date: Tue,  5 Aug 2014 17:36:19 +0200
Message-Id: <1407252982-27023-3-git-send-email-asavkov@redhat.com>
In-Reply-To: <1407252982-27023-1-git-send-email-asavkov@redhat.com>
References: <1407252982-27023-1-git-send-email-asavkov@redhat.com>
Subject: [LTP] [PATCH 2/5] netns tests: runnetnstest.sh -> runtest/containers
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
iproute2 check is moved to check_iproute.sh

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 runtest/containers                                 |   6 +
 testcases/kernel/containers/container_test.sh      |   8 --
 testcases/kernel/containers/netns/Makefile         |   4 +-
 testcases/kernel/containers/netns/check_iproute.sh |  52 ++++++++
 .../kernel/containers/netns/check_netns_enabled.c  |  56 ---------
 testcases/kernel/containers/netns/childns.sh       |   2 +
 testcases/kernel/containers/netns/crtchild.c       |  14 +++
 .../kernel/containers/netns/crtchild_delchild.c    |  13 ++
 testcases/kernel/containers/netns/initialize.sh    |   7 +-
 testcases/kernel/containers/netns/netns_helper.h   |  71 +++++++++++
 testcases/kernel/containers/netns/par_chld_ftp.c   |  15 +++
 testcases/kernel/containers/netns/par_chld_ftp.sh  |  52 ++++++++
 testcases/kernel/containers/netns/par_chld_ipv6.c  |  11 ++
 testcases/kernel/containers/netns/runnetnstest.sh  | 133 ---------------------
 .../kernel/containers/netns/two_children_ns.c      |  12 ++
 15 files changed, 252 insertions(+), 204 deletions(-)
 create mode 100755 testcases/kernel/containers/netns/check_iproute.sh
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
diff --git a/testcases/kernel/containers/netns/check_iproute.sh b/testcases/kernel/containers/netns/check_iproute.sh
new file mode 100755
index 0000000..597b043
--- /dev/null
+++ b/testcases/kernel/containers/netns/check_iproute.sh
@@ -0,0 +1,52 @@
+#!/bin/bash
+
+################################################################################
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
+################################################################################
+
+export TCID=${TCID:-check_iproute.sh}
+export TST_COUNT=1
+export TST_TOTAL=1
+
+. test.sh
+
+check_iproute2()
+{
+    # Check the iproute2 version (aka "SnapShot")
+    IPROUTEV=`ip -V | cut -d ',' -f 2 | cut -d '-' -f 2 | sed -e 's/^ss//'`
+
+    # We need to strip leading 0s else bash thinks we're giving it
+    # octal numbers.
+    IPROUTEY=$(echo ${IPROUTEV:0:2} | sed -e 's/^0\+//') # Year
+    IPROUTEM=$(echo ${IPROUTEV:2:2} | sed -e 's/^0\+//') # Month
+    IPROUTED=$(echo ${IPROUTEV:4:2} | sed -e 's/^0\+//') # Day
+
+    V=$((${IPROUTEY}*12*32 + ${IPROUTEM}*32 + ${IPROUTED}))
+
+    #
+    # iproute-ss080725 and later support setting the network namespace of an
+    # interface.
+    #
+    NETNSV=$((8*12*32 + 7*32 + 25))
+    if [ ${V} -lt ${NETNSV} ]; then
+        msg="INFO: iproute tools do not support setting network namespaces. "
+        msg+="Skipping network namespace test."
+        tst_brkm TCONF "$msg"
+    fi
+}
+
+check_iproute2
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
index d2769c7..c36e121 100644
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
+	if (status == 0)
+		tst_resm(TPASS, "create_net_namespace");
+	else
+		tst_resm(TFAIL, "create_net_namespace");
 	return status;
 }
diff --git a/testcases/kernel/containers/netns/crtchild_delchild.c b/testcases/kernel/containers/netns/crtchild_delchild.c
index 6b82997..6530923 100644
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
+	if (status == 0)
+		tst_resm(TPASS, "create_net_namespace");
+	else
+		tst_resm(TFAIL, "create_net_namespace");
 	return status;
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
index 0000000..e7dd528
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_helper.h
@@ -0,0 +1,71 @@
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
+
+#ifndef CLONE_NEWNS
+#define CLONE_NEWNS -1
+#endif
+
+static void check_iproute(void)
+{
+	int ret, status;
+	char iprt_script[FILENAME_MAX];
+	char *ltproot;
+
+	ltproot = getenv("LTPROOT");
+	if (!ltproot)
+		tst_brkm(TCONF, NULL, "LTPROOT env var is not set");
+
+	if (iprt_script == NULL)
+		tst_brkm(TCONF, NULL, "error while allocating mem");
+
+	sprintf(iprt_script, "%s/testcases/bin/check_iproute.sh", ltproot);
+	ret = system(iprt_script);
+	status = WEXITSTATUS(ret);
+
+	if (ret == -1 || status != 0) {
+		if (status == TCONF)
+			tst_brkm(TCONF, NULL,
+					"Configuration error while running the script");
+		tst_brkm(TBROK, NULL, "Configuration script failed; status: %d",
+				status);
+	}
+}
+
+static void check_netns(void)
+{
+	/* Checking if the kernel supports unshare with netns capabilities. */
+	if (CLONE_NEWNS == -1)
+		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWNS (%d) not supported",
+			 CLONE_NEWNS);
+	else if (do_clone_unshare_test(T_UNSHARE, CLONE_NEWNET | CLONE_NEWNS,
+				NULL, NULL) == -1)
+		tst_brkm(TCONF | TERRNO, NULL,
+						 "unshare syscall smoke test failed");
+}
diff --git a/testcases/kernel/containers/netns/par_chld_ftp.c b/testcases/kernel/containers/netns/par_chld_ftp.c
index 605be19..5c4846c 100644
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
+	if (status == 0)
+		tst_resm(TPASS, "create_net_namespace");
+	else
+		tst_resm(TFAIL, "create_net_namespace");
 	return status;
 }
diff --git a/testcases/kernel/containers/netns/par_chld_ftp.sh b/testcases/kernel/containers/netns/par_chld_ftp.sh
new file mode 100755
index 0000000..f2950ee
--- /dev/null
+++ b/testcases/kernel/containers/netns/par_chld_ftp.sh
@@ -0,0 +1,52 @@
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
+. cmdlib.sh
+. test.sh
+
+flag=0
+exit_code=0
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
+exit_code=$?
+
+if [ $flag -eq 1 ]; then
+	stop_daemon vsftpd
+fi
+
+echo
+exit $exit_code
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
index 13ae1e6..00efbec 100644
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
+
+	tst_resm(TPASS, "two children ns");
 	exit(0);
 }
-- 
1.9.3


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
