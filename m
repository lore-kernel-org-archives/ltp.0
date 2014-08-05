Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <asavkov@redhat.com>) id 1XEgn6-0000VW-Ra
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 15:36:44 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XEgn2-0002UG-Os
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 15:36:44 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s75FaYhl003465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Aug 2014 11:36:34 -0400
From: Artem Savkov <asavkov@redhat.com>
Date: Tue,  5 Aug 2014 17:36:18 +0200
Message-Id: <1407252982-27023-2-git-send-email-asavkov@redhat.com>
In-Reply-To: <1407252982-27023-1-git-send-email-asavkov@redhat.com>
References: <1407252982-27023-1-git-send-email-asavkov@redhat.com>
Subject: [LTP] [PATCH 1/5] mqns tests: runmqnsstest.sh -> runtest/containers
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

Extracted mqns tests from runmqnstest.sh and container_test.sh and added them
one by one to runtest/containers.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 runtest/containers                                 |  9 ++++
 testcases/kernel/containers/container_test.sh      |  9 ----
 .../kernel/containers/mqns/check_mqns_enabled.c    | 57 ----------------------
 testcases/kernel/containers/mqns/mqns_01.c         | 11 +++++
 testcases/kernel/containers/mqns/mqns_02.c         | 11 +++++
 testcases/kernel/containers/mqns/mqns_03.c         | 11 +++++
 testcases/kernel/containers/mqns/mqns_04.c         | 11 +++++
 testcases/kernel/containers/mqns/mqns_helper.h     | 54 ++++++++++++++++++++
 testcases/kernel/containers/mqns/runmqnstest.sh    | 40 ---------------
 9 files changed, 107 insertions(+), 106 deletions(-)
 delete mode 100644 testcases/kernel/containers/mqns/check_mqns_enabled.c
 create mode 100644 testcases/kernel/containers/mqns/mqns_helper.h
 delete mode 100755 testcases/kernel/containers/mqns/runmqnstest.sh

diff --git a/runtest/containers b/runtest/containers
index 5f5eeab..f14817c 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -14,4 +14,13 @@ pidns20 pidns20
 pidns30 pidns30
 pidns31 pidns31
 
+mqns_01 mqns_01
+mqns_01_clone mqns_01 -clone
+mqns_02 mqns_02
+mqns_02_clone mqns_02 -clone
+mqns_03 mqns_03
+mqns_03_clone mqns_03 -clone
+mqns_04 mqns_04
+mqns_04_clone mqns_04 -clone
+
 Containers	container_test.sh
diff --git a/testcases/kernel/containers/container_test.sh b/testcases/kernel/containers/container_test.sh
index cc570f0..73d2527 100755
--- a/testcases/kernel/containers/container_test.sh
+++ b/testcases/kernel/containers/container_test.sh
@@ -46,15 +46,6 @@ else
 	echo "ipc namespaces not enabled in kernel.  Not running ipcns tests."
 fi
 
-check_mqns_enabled
-if [ $? -eq 0 ]; then
-    echo "Running POSIX message queue tests."
-    runmqnstest.sh
-else
-    echo "Posix message queues or ipc namespaces not enabled in kernel."
-    echo "Not running mqns tests."
-fi
-
 check_netns_enabled
 if [ $? -eq 0 ]; then
 	echo "Running netns tests."
diff --git a/testcases/kernel/containers/mqns/check_mqns_enabled.c b/testcases/kernel/containers/mqns/check_mqns_enabled.c
deleted file mode 100644
index b263604..0000000
--- a/testcases/kernel/containers/mqns/check_mqns_enabled.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * Copyright (c) International Business Machines Corp., 2009
- * Copyright (c) Nadia Derbey, 2009
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * Author: Serge Hallyn <serue@us.ibm.com>
- ***************************************************************************/
-#include <sys/mount.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <stdio.h>
-#include "../libclone/libclone.h"
-#include "test.h"
-#include "mqns.h"
-
-const char *TCID = "check_mqns_enabled";
-
-int dummy(void *v)
-{
-	return 0;
-}
-
-int main(void)
-{
-	int pid;
-	mqd_t mqd;
-
-	if (tst_kvercmp(2, 6, 30) < 0)
-		return 1;
-
-	mq_unlink("/checkmqnsenabled");
-	mqd =
-	    mq_open("/checkmqnsenabled", O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
-	if (mqd == -1) {
-		perror("mq_open");
-		return 3;
-	}
-	mq_close(mqd);
-	mq_unlink("/checkmqnsenabled");
-
-	pid = ltp_clone_quick(CLONE_NEWIPC, dummy, NULL);
-	if (pid == -1)
-		return 5;
-
-	return 0;
-}
diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index a8d2748..a8e481d 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -37,6 +37,7 @@
 #include <string.h>
 #include <unistd.h>
 #include "mqns.h"
+#include "mqns_helper.h"
 
 char *TCID = "posixmq_namespace_01";
 int TST_TOTAL = 1;
@@ -49,6 +50,8 @@ int check_mqueue(void *vtest)
 	char buf[30];
 	mqd_t mqd;
 
+	(void) vtest;
+
 	close(p1[1]);
 	close(p2[0]);
 
@@ -75,6 +78,12 @@ int check_mqueue(void *vtest)
 	exit(0);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_mqns();
+}
+
 int main(int argc, char *argv[])
 {
 	int r;
@@ -82,6 +91,8 @@ int main(int argc, char *argv[])
 	char buf[30];
 	int use_clone = T_UNSHARE;
 
+	setup();
+
 	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
 		tst_resm(TINFO,
 			 "Testing posix mq namespaces through clone(2).");
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index 8fab439..b7f6e32 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -40,6 +40,7 @@
 #include <string.h>
 #include <unistd.h>
 #include "mqns.h"
+#include "mqns_helper.h"
 
 char *TCID = "posixmq_namespace_02";
 int TST_TOTAL = 1;
@@ -52,6 +53,8 @@ int check_mqueue(void *vtest)
 	char buf[30];
 	mqd_t mqd;
 
+	(void) vtest;
+
 	close(p1[1]);
 	close(p2[0]);
 
@@ -108,6 +111,12 @@ int check_mqueue(void *vtest)
 
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_mqns();
+}
+
 int main(int argc, char *argv[])
 {
 	int r;
@@ -115,6 +124,8 @@ int main(int argc, char *argv[])
 	char buf[30];
 	int use_clone = T_UNSHARE;
 
+	setup();
+
 	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
 		tst_resm(TINFO,
 			 "Testing posix mq namespaces through clone(2).");
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index f9b3cd4..0fa90bb 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -43,6 +43,7 @@
 #include <string.h>
 #include <errno.h>
 #include "mqns.h"
+#include "mqns_helper.h"
 
 char *TCID = "posixmq_namespace_03";
 int TST_TOTAL = 1;
@@ -60,6 +61,8 @@ int check_mqueue(void *vtest)
 	int rc;
 	struct stat statbuf;
 
+	(void) vtest;
+
 	close(p1[1]);
 	close(p2[0]);
 
@@ -126,12 +129,20 @@ int check_mqueue(void *vtest)
 	exit(0);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_mqns();
+}
+
 int main(int argc, char *argv[])
 {
 	int r;
 	char buf[30];
 	int use_clone = T_UNSHARE;
 
+	setup();
+
 	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
 		tst_resm(TINFO, "Testing posix mq namespaces through clone(2)");
 		use_clone = T_CLONE;
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index 80d25a6..7cd7c9d 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -40,6 +40,7 @@
 #include <string.h>
 #include <errno.h>
 #include "mqns.h"
+#include "mqns_helper.h"
 
 char *TCID = "posixmq_namespace_04";
 int TST_TOTAL = 1;
@@ -56,6 +57,8 @@ int check_mqueue(void *vtest)
 	mqd_t mqd;
 	int rc;
 
+	(void) vtest;
+
 	close(p1[1]);
 	close(p2[0]);
 
@@ -83,6 +86,12 @@ int check_mqueue(void *vtest)
 	tst_exit();
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_mqns();
+}
+
 int main(int argc, char *argv[])
 {
 	int rc;
@@ -91,6 +100,8 @@ int main(int argc, char *argv[])
 	struct stat statbuf;
 	int use_clone = T_UNSHARE;
 
+	setup();
+
 	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
 		tst_resm(TINFO,
 			 "Testing posix mq namespaces through clone(2).");
diff --git a/testcases/kernel/containers/mqns/mqns_helper.h b/testcases/kernel/containers/mqns/mqns_helper.h
new file mode 100644
index 0000000..f1281fa
--- /dev/null
+++ b/testcases/kernel/containers/mqns/mqns_helper.h
@@ -0,0 +1,54 @@
+/*
+ * Copyright (c) International Business Machines Corp., 2009
+ * Copyright (c) Nadia Derbey, 2009
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author: Serge Hallyn <serue@us.ibm.com>
+ ***************************************************************************/
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include "../libclone/libclone.h"
+#include "test.h"
+#include "mqns.h"
+
+static int dummy_child(void *v)
+{
+	(void) v;
+	return 0;
+}
+
+static int check_mqns(void)
+{
+	int pid;
+	mqd_t mqd;
+
+	if (tst_kvercmp(2, 6, 30) < 0)
+		tst_brkm(TCONF, NULL, "Kernel version is lower than expected");
+
+	mq_unlink("/checkmqnsenabled");
+	mqd =
+	    mq_open("/checkmqnsenabled", O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
+	if (mqd == -1)
+		tst_brkm(TCONF, NULL, "mq_open check failed");
+
+	mq_close(mqd);
+	mq_unlink("/checkmqnsenabled");
+
+	pid = ltp_clone_quick(CLONE_NEWIPC, dummy_child, NULL);
+	if (pid == -1)
+		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWIPC not supported");
+
+	return 0;
+}
diff --git a/testcases/kernel/containers/mqns/runmqnstest.sh b/testcases/kernel/containers/mqns/runmqnstest.sh
deleted file mode 100755
index 625976e..0000000
--- a/testcases/kernel/containers/mqns/runmqnstest.sh
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2009                 ##
-## Copyright (c) Nadia Derbey, 2009                                           ##
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
-exit_code=0
-tests_list='mqns_01 mqns_02 mqns_03 mqns_04'
-
-for t in $tests_list
-do
-	$t
-	if [ $? -ne 0 ]; then
-		exit_code="$?"
-		exit $exit_code
-	fi
-	$t -clone
-	if [ $? -ne 0 ]; then
-		exit_code="$?"
-		exit $exit_code
-	fi
-done
-
-exit $exit_code
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
