Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <asavkov@redhat.com>) id 1XEgn5-0000VA-Hh
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 15:36:43 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XEgn2-0008U1-Ov
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 15:36:43 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s75FaYHl005016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Aug 2014 11:36:34 -0400
From: Artem Savkov <asavkov@redhat.com>
Date: Tue,  5 Aug 2014 17:36:21 +0200
Message-Id: <1407252982-27023-5-git-send-email-asavkov@redhat.com>
In-Reply-To: <1407252982-27023-1-git-send-email-asavkov@redhat.com>
References: <1407252982-27023-1-git-send-email-asavkov@redhat.com>
Subject: [LTP] [PATCH 4/5] uts tests: runutstest.sh -> runtest/containers
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

Extracted utsname tests from runutstest.sh and container_test.sh and added
them one by one to runtest/containers.
hostname recovery moved to utstest.c. tst_exits removed from P2 so that
hostname is actually recovered.
README is removed as it was mostly duplicating utstest.c's header.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 runtest/containers                                 | 11 +++++
 testcases/kernel/containers/container_test.sh      |  7 ---
 testcases/kernel/containers/utsname/README         | 53 ----------------------
 .../containers/utsname/check_utsns_enabled.c       | 50 --------------------
 testcases/kernel/containers/utsname/runutstest.sh  | 33 --------------
 testcases/kernel/containers/utsname/utstest.c      | 49 ++++++++++++++++----
 6 files changed, 51 insertions(+), 152 deletions(-)
 delete mode 100644 testcases/kernel/containers/utsname/README
 delete mode 100644 testcases/kernel/containers/utsname/check_utsns_enabled.c
 delete mode 100755 testcases/kernel/containers/utsname/runutstest.sh

diff --git a/runtest/containers b/runtest/containers
index 0f40716..827a5d7 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -45,4 +45,15 @@ semtest_2ns_none semtest_2ns none
 semtest_2ns_clone semtest_2ns clone
 semtest_2ns_unshare semtest_2ns unshare
 
+utstest_unshare_1 utstest unshare 1
+utstest_unshare_2 utstest unshare 2
+utstest_unshare_3 utstest unshare 3
+utstest_unshare_4 utstest unshare 4
+utstest_unshare_5 utstest unshare 5
+utstest_clone_1 utstest clone 1
+utstest_clone_2 utstest clone 2
+utstest_clone_3 utstest clone 3
+utstest_clone_4 utstest clone 4
+utstest_clone_5 utstest clone 5
+
 Containers	container_test.sh
diff --git a/testcases/kernel/containers/container_test.sh b/testcases/kernel/containers/container_test.sh
index ca67bb2..9e515e4 100755
--- a/testcases/kernel/containers/container_test.sh
+++ b/testcases/kernel/containers/container_test.sh
@@ -15,13 +15,6 @@ if [ $? -eq 1 ]; then
 	echo "Unshare not supported.  Not running container tests"
 	exit 0
 fi
-check_utsns_enabled
-if [ $? -eq 0 ]; then
-	echo "Running utsns tests."
-	runutstest.sh
-else
-	echo "Uts namespaces not enabled in kernel.  Not running utsns tests."
-fi
 
 #check_userns_enabled
 #if [ $? -eq 0 ]; then
diff --git a/testcases/kernel/containers/utsname/README b/testcases/kernel/containers/utsname/README
deleted file mode 100644
index 5734f88..0000000
--- a/testcases/kernel/containers/utsname/README
+++ /dev/null
@@ -1,53 +0,0 @@
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2007                 ##
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
-################################################################################
-
-This contains five tests for the uts namespace unsharing functionality.
-
-To enable this functionality, you currently must use a -mm kernel (see
-kernel.org). Then to run these tests, just type
-
-	sh runutstest.sh
-
-The tests are intended to do the following:
-
-test 1: check that after fork, two children see the same utsname
-	P1: A=gethostname
-	P2: B=gethostname
-	Ensure(A==B)
-test 2: check that after fork, two children are in the same utsname namespace.
-	P1: sethostname(newname); A=gethostname
-	P2: (wait); B=gethostname
-	Ensure (A==B)
-
-test 3: check that after unshare, processes are in different utsname namespaces.
-	P1: A=gethostname; unshare(utsname); sethostname(newname); C=gethostname
-	P2: B=gethostname; (wait); (wait); D=gethostname
-	Ensure (A==B && A==D && C!=D)
-
-test 4: similar to test 3, but other child changes hostname.
-	P1: A=gethostname; unshare(utsname); (wait); C=gethostname
-	P2: B=gethostname; (wait); sethostname(newname); D=gethostname
-	Ensure (A==B && A==C && C!=D)
-
-test 5: check that unsharing utsname without required permissions (CAP_SYS_AUDIT)
-	fails.
-	P1: A=gethostname; unshare(utsname) without suff. perms; (wait); C=gethostname
-	P2: B=gethostname; (wait); sethostname(newname); D=gethostname
-	Ensure (A==B==C==D) and state is ok.
diff --git a/testcases/kernel/containers/utsname/check_utsns_enabled.c b/testcases/kernel/containers/utsname/check_utsns_enabled.c
deleted file mode 100644
index 8834052..0000000
--- a/testcases/kernel/containers/utsname/check_utsns_enabled.c
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
-* Copyright (c) International Business Machines Corp., 2007
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
-* Author: Serge Hallyn <serue@us.ibm.com>
-*
-* uts namespaces were introduced around 2.6.19.  Kernels before that,
-* assume they are not enabled.  Kernels after that, check for -EINVAL
-* when trying to use CLONE_NEWUTS.
-***************************************************************************/
-
-#include <sys/utsname.h>
-#include <sched.h>
-#include <stdio.h>
-#include "../libclone/libclone.h"
-#include "test.h"
-
-const char *TCID = "check_utsns_enabled";
-
-int dummy(void *v)
-{
-	return 0;
-}
-
-int main(void)
-{
-	int pid;
-
-	if (tst_kvercmp(2, 6, 19) < 0)
-		return 1;
-
-	pid = ltp_clone_quick(CLONE_NEWUTS, dummy, NULL);
-
-	if (pid == -1) {
-		perror("ltp_clone_quick");
-		return 3;
-	}
-	return 0;
-}
diff --git a/testcases/kernel/containers/utsname/runutstest.sh b/testcases/kernel/containers/utsname/runutstest.sh
deleted file mode 100755
index d3a8021..0000000
--- a/testcases/kernel/containers/utsname/runutstest.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2007                 ##
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
-################################################################################
-
-oldhostname=`hostname`
-echo "unshare tests"
-for i in `seq 1 5`; do
-	echo "test $i (unshare)"
-	utstest unshare $i
-done
-echo "clone tests"
-for i in `seq 1 5`; do
-	echo "test $i (clone)"
-	utstest clone $i
-done
-hostname "$oldhostname"
diff --git a/testcases/kernel/containers/utsname/utstest.c b/testcases/kernel/containers/utsname/utstest.c
index a399605..c6ffdb0 100644
--- a/testcases/kernel/containers/utsname/utstest.c
+++ b/testcases/kernel/containers/utsname/utstest.c
@@ -58,7 +58,26 @@
 char *TCID = "uts_namespace";
 int TST_TOTAL = 1;
 
-int drop_root()
+static int dummy_child(void *v)
+{
+	(void) v;
+	return 0;
+}
+
+static int check_newuts(void)
+{
+	int pid;
+
+	if (tst_kvercmp(2, 6, 19) < 0)
+		tst_brkm(TCONF, NULL, "CLONE_NEWUTS not supported");
+
+	pid = ltp_clone_quick(CLONE_NEWUTS, dummy_child, NULL);
+	if (pid == -1)
+		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWUTS not supported");
+	return 0;
+}
+
+int drop_root(void)
 {
 	int ret;
 	ret = setresuid(1000, 1000, 1000);
@@ -69,13 +88,14 @@ int drop_root()
 	return 1;
 }
 
-int p1fd[2], p2fd[2];
-pid_t cpid;
-
 #define HLEN 100
 #define NAME1 "serge1"
 #define NAME2 "serge2"
 
+int p1fd[2], p2fd[2];
+static char oldhost[HLEN];
+pid_t cpid;
+
 void picknewhostname(char *orig, char *new)
 {
 	memset(new, 0, HLEN);
@@ -198,7 +218,7 @@ int P1(void *vtest)
 	default:
 		break;
 	}
-	return -1;
+	tst_exit();
 }
 
 int P2(void *vtest)
@@ -234,8 +254,7 @@ int P2(void *vtest)
 		}
 		if (hostname[0] == '0') {
 			tst_resm(TPASS, "P2: P1 claims error");
-			tst_exit();
-			exit(0);
+			return 0;
 		}
 		gethostname(hostname, HLEN);
 		picknewhostname(hostname, newhostname);
@@ -246,10 +265,21 @@ int P2(void *vtest)
 		tst_resm(TFAIL, "undefined test: %d", testnum);
 		break;
 	}
-	tst_exit();
 	return 0;
 }
 
+static void setup()
+{
+	gethostname(oldhost, HLEN);
+	tst_require_root(NULL);
+	check_newuts();
+}
+
+static void cleanup()
+{
+	sethostname(oldhost, strlen(oldhost));
+}
+
 #define UNSHARESTR "unshare"
 #define CLONESTR "clone"
 int main(int argc, char *argv[])
@@ -258,6 +288,7 @@ int main(int argc, char *argv[])
 	int testnum;
 	void *vtest;
 
+	setup();
 	if (argc != 3) {
 		tst_resm(TFAIL, "Usage: %s <clone|unshare> <testnum>",
 			 argv[0]);
@@ -304,7 +335,6 @@ int main(int argc, char *argv[])
 			if (!drop_root()) {
 				tst_resm(TFAIL, "failed to drop root.");
 				tst_exit();
-				exit(1);
 			}
 			r = do_clone_unshare_test(use_clone, CLONE_NEWUTS,
 						  P1, vtest);
@@ -320,5 +350,6 @@ int main(int argc, char *argv[])
 		break;
 	}
 
+	cleanup();
 	tst_exit();
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
