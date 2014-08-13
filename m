Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <asavkov@redhat.com>) id 1XHajA-00082u-9v
	for ltp-list@lists.sourceforge.net; Wed, 13 Aug 2014 15:44:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XHaj7-0001Z4-4D
	for ltp-list@lists.sourceforge.net; Wed, 13 Aug 2014 15:44:40 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7DFiUce030691
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Aug 2014 11:44:30 -0400
From: Artem Savkov <asavkov@redhat.com>
Date: Wed, 13 Aug 2014 17:44:23 +0200
Message-Id: <1407944666-32659-4-git-send-email-asavkov@redhat.com>
In-Reply-To: <1407944666-32659-1-git-send-email-asavkov@redhat.com>
References: <1407944666-32659-1-git-send-email-asavkov@redhat.com>
Subject: [LTP] [PATCH v2 3/6] ipcns tests: runipcnstest.sh ->
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

Extracted sysvipc tests from runipcnstest.sh and container_test.sh and added
them one by one to runtest/containers.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 runtest/containers                                 | 16 ++++++
 testcases/kernel/containers/container_test.sh      |  8 ---
 .../containers/sysvipc/check_ipcns_enabled.c       | 42 ---------------
 testcases/kernel/containers/sysvipc/ipcns_helper.h | 41 ++++++++++++++
 testcases/kernel/containers/sysvipc/mesgq_nstest.c | 13 ++++-
 .../kernel/containers/sysvipc/runipcnstest.sh      | 62 ----------------------
 testcases/kernel/containers/sysvipc/sem_nstest.c   | 11 ++++
 testcases/kernel/containers/sysvipc/semtest_2ns.c  | 13 +++++
 .../kernel/containers/sysvipc/shmem_2nstest.c      | 15 ++++++
 testcases/kernel/containers/sysvipc/shmnstest.c    | 11 ++++
 10 files changed, 119 insertions(+), 113 deletions(-)
 delete mode 100644 testcases/kernel/containers/sysvipc/check_ipcns_enabled.c
 create mode 100644 testcases/kernel/containers/sysvipc/ipcns_helper.h
 delete mode 100644 testcases/kernel/containers/sysvipc/runipcnstest.sh

diff --git a/runtest/containers b/runtest/containers
index 5c4fc89..0f40716 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -29,4 +29,20 @@ crtchild_delchild crtchild_delchild
 par_chld_ipv6 par_chld_ipv6
 par_chld_ftp par_chld_ftp.sh
 
+shmnstest_none shmnstest none
+shmnstest_clone shmnstest clone
+shmnstest_unshare shmnstest unshare
+shmem_2nstest_none shmem_2nstest none
+shmem_2nstest_clone shmem_2nstest clone
+shmem_2nstest_unshare shmem_2nstest unshare
+mesgq_nstest_none mesgq_nstest none
+mesgq_nstest_clone mesgq_nstest clone
+mesgq_nstest_unshare mesgq_nstest unshare
+sem_nstest_none sem_nstest none
+sem_nstest_clone sem_nstest clone
+sem_nstest_unshare sem_nstest unshare
+semtest_2ns_none semtest_2ns none
+semtest_2ns_clone semtest_2ns clone
+semtest_2ns_unshare semtest_2ns unshare
+
 Containers	container_test.sh
diff --git a/testcases/kernel/containers/container_test.sh b/testcases/kernel/containers/container_test.sh
index 98e4851..ca67bb2 100755
--- a/testcases/kernel/containers/container_test.sh
+++ b/testcases/kernel/containers/container_test.sh
@@ -37,11 +37,3 @@ fi
 #else
 	#echo "User namespaces not enabled in kernel.  Not running userns tests."
 #fi
-
-check_ipcns_enabled
-if [ $? -eq 0 ]; then
-	echo "Running ipcns tests."
-	runipcnstest.sh
-else
-	echo "ipc namespaces not enabled in kernel.  Not running ipcns tests."
-fi
diff --git a/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c b/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c
deleted file mode 100644
index 45cbbd1..0000000
--- a/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c
+++ /dev/null
@@ -1,42 +0,0 @@
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
-* Author: Rishikesh K Rajak <risrajak@in.ibm.com>
-***************************************************************************/
-#include <sched.h>
-#include <stdio.h>
-#include "../libclone/libclone.h"
-#include "test.h"
-
-const char *TCID = "check_ipcns_enabled";
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
-	pid = ltp_clone_quick(CLONE_NEWIPC, dummy, NULL);
-
-	if (pid == -1)
-		return 3;
-	return 0;
-}
diff --git a/testcases/kernel/containers/sysvipc/ipcns_helper.h b/testcases/kernel/containers/sysvipc/ipcns_helper.h
new file mode 100644
index 0000000..01ad0ff
--- /dev/null
+++ b/testcases/kernel/containers/sysvipc/ipcns_helper.h
@@ -0,0 +1,41 @@
+/*
+* Copyright (c) International Business Machines Corp., 2007
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
+* Author: Rishikesh K Rajak <risrajak@in.ibm.com>
+***************************************************************************/
+#include <sched.h>
+#include "../libclone/libclone.h"
+#include "test.h"
+#include "safe_macros.h"
+
+static int dummy_child(void *v)
+{
+	(void) v;
+	return 0;
+}
+
+static void check_newipc(void)
+{
+	int pid, status;
+
+	if (tst_kvercmp(2, 6, 19) < 0)
+		tst_brkm(TCONF, NULL, "CLONE_NEWIPC not supported");
+
+	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, dummy_child, NULL);
+	if (pid == -1)
+		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWIPC not supported");
+
+	SAFE_WAIT(NULL, &status);
+}
diff --git a/testcases/kernel/containers/sysvipc/mesgq_nstest.c b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
index 5e5a74f..70ea636 100644
--- a/testcases/kernel/containers/sysvipc/mesgq_nstest.c
+++ b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
@@ -32,6 +32,7 @@
 #include <sys/msg.h>
 #include <libclone.h>
 #include "test.h"
+#include "ipcns_helper.h"
 
 #define KEY_VAL		154326L
 #define UNSHARESTR	"unshare"
@@ -47,7 +48,7 @@ struct msg_buf {
 	char mtext[80];		/* text of the message */
 } msg;
 
-void mesgq_read(id)
+void mesgq_read(int id)
 {
 	int READMAX = 80;
 	int n;
@@ -66,6 +67,8 @@ int check_mesgq(void *vtest)
 	char buf[3];
 	int id;
 
+	(void) vtest;
+
 	close(p1[1]);
 	close(p2[0]);
 
@@ -82,12 +85,20 @@ int check_mesgq(void *vtest)
 	return 0;
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newipc();
+}
+
 int main(int argc, char *argv[])
 {
 	int ret, use_clone = T_NONE, id, n;
 	char *tsttype = NONESTR;
 	char buf[7];
 
+	setup();
+
 	if (argc != 2) {
 		tst_resm(TFAIL, "Usage: %s <clone|unshare|none>", argv[0]);
 		tst_resm(TFAIL, " where clone, unshare, or fork specifies"
diff --git a/testcases/kernel/containers/sysvipc/runipcnstest.sh b/testcases/kernel/containers/sysvipc/runipcnstest.sh
deleted file mode 100644
index 46863a3..0000000
--- a/testcases/kernel/containers/sysvipc/runipcnstest.sh
+++ /dev/null
@@ -1,62 +0,0 @@
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
-exit_code=0
-ret=0
-echo "****************** sysvipc tests ******************"
-for type in none clone unshare; do
-      echo "sysvipc: SharedMemory $type"
-      shmnstest $type
-      ret=$?
-      if [ $ret -ne 0 ]; then
-              exit_code=$ret
-      fi
-      shmem_2nstest $type
-      ret=$?
-      if [ $ret -ne 0 ]; then
-              exit_code=$ret
-      fi
-done
-echo
-for type in none clone unshare; do
-      echo "sysvipc: MesgQ $type"
-      mesgq_nstest $type
-	  ret=$?
-      if [ $exit_code -ne 0 ]; then
-              exit_code=$ret
-      fi
-done
-echo
-for type in none clone unshare; do
-      echo "sysvipc: Semaphore $type"
-      sem_nstest $type
-	  ret=$?
-      if [ $exit_code -ne 0 ]; then
-              exit_code=$ret
-      fi
-      semtest_2ns $type
-      ret=$?
-      if [ $ret -ne 0 ]; then
-              exit_code=$ret
-      fi
-done
-echo
-exit $exit_code
diff --git a/testcases/kernel/containers/sysvipc/sem_nstest.c b/testcases/kernel/containers/sysvipc/sem_nstest.c
index 2405b24..ae49477 100644
--- a/testcases/kernel/containers/sysvipc/sem_nstest.c
+++ b/testcases/kernel/containers/sysvipc/sem_nstest.c
@@ -32,6 +32,7 @@
 #include <sys/sem.h>
 #include <libclone.h>
 #include "test.h"
+#include "ipcns_helper.h"
 
 #define MY_KEY     154326L
 #define UNSHARESTR "unshare"
@@ -48,6 +49,8 @@ int check_semaphore(void *vtest)
 	char buf[3];
 	int id;
 
+	(void) vtest;
+
 	close(p1[1]);
 	close(p2[0]);
 
@@ -65,12 +68,20 @@ int check_semaphore(void *vtest)
 	return 0;
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newipc();
+}
+
 int main(int argc, char *argv[])
 {
 	int ret, use_clone = T_NONE, id;
 	char *tsttype = NONESTR;
 	char buf[7];
 
+	setup();
+
 	if (argc != 2) {
 		tst_resm(TFAIL, "Usage: %s <clone| unshare| none>", argv[0]);
 		tst_resm(TFAIL, " where clone, unshare, or fork specifies"
diff --git a/testcases/kernel/containers/sysvipc/semtest_2ns.c b/testcases/kernel/containers/sysvipc/semtest_2ns.c
index d9afc25..3d97bd4 100644
--- a/testcases/kernel/containers/sysvipc/semtest_2ns.c
+++ b/testcases/kernel/containers/sysvipc/semtest_2ns.c
@@ -45,6 +45,7 @@
 #include <sys/sem.h>
 #include <libclone.h>
 #include "test.h"
+#include "ipcns_helper.h"
 
 #define MY_KEY     124326L
 #define UNSHARESTR "unshare"
@@ -93,6 +94,8 @@ int check_sem1(void *vtest)
 {
 	int id1;
 
+	(void) vtest;
+
 	close(p1[0]);
 	/* 1. Create (or fetch if existing) the binary semaphore */
 	id1 = semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666);
@@ -126,6 +129,8 @@ int check_sem2(void *vtest)
 	char buf[3];
 	int id2;
 
+	(void) vtest;
+
 	close(p1[1]);
 	close(p2[0]);
 	read(p1[0], buf, 3);
@@ -154,12 +159,20 @@ int check_sem2(void *vtest)
 	return 0;
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newipc();
+}
+
 int main(int argc, char *argv[])
 {
 	int ret, id, use_clone = T_NONE;
 	char *tsttype = NONESTR;
 	char buf[7];
 
+	setup();
+
 	if (argc != 2) {
 		tst_resm(TINFO, "Usage: %s <clone| unshare| none>", argv[0]);
 		tst_resm(TINFO, " where clone, unshare, or fork specifies"
diff --git a/testcases/kernel/containers/sysvipc/shmem_2nstest.c b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
index 3833261..8c0d2f9 100644
--- a/testcases/kernel/containers/sysvipc/shmem_2nstest.c
+++ b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
@@ -45,6 +45,7 @@
 #include <sys/shm.h>
 #include <libclone.h>
 #include "test.h"
+#include "ipcns_helper.h"
 
 #define TESTKEY    124426L
 #define UNSHARESTR "unshare"
@@ -62,6 +63,9 @@ int p1[2];
 int check_shmem1(void *vtest)
 {
 	int id1;
+
+	(void) vtest;
+
 	close(p1[0]);
 
 	/* first create the key */
@@ -81,6 +85,9 @@ int check_shmem2(void *vtest)
 {
 	char buf[3];
 	int id2;
+
+	(void) vtest;
+
 	close(p1[1]);
 	close(p2[0]);
 
@@ -102,6 +109,12 @@ int check_shmem2(void *vtest)
 	tst_exit();
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newipc();
+}
+
 int main(int argc, char *argv[])
 {
 	int ret, use_clone = T_NONE;
@@ -109,6 +122,8 @@ int main(int argc, char *argv[])
 	char buf[7];
 	int id;
 
+	setup();
+
 	if (argc != 2) {
 		tst_resm(TINFO, "Usage: %s <clone| unshare| none>", argv[0]);
 		tst_resm(TINFO, " where clone, unshare, or fork specifies"
diff --git a/testcases/kernel/containers/sysvipc/shmnstest.c b/testcases/kernel/containers/sysvipc/shmnstest.c
index 2188183..deccc04 100644
--- a/testcases/kernel/containers/sysvipc/shmnstest.c
+++ b/testcases/kernel/containers/sysvipc/shmnstest.c
@@ -33,6 +33,7 @@
 #include <sys/shm.h>
 #include "test.h"
 #include <libclone.h>
+#include "ipcns_helper.h"
 
 char *TCID = "sysvipc_namespace";
 int TST_TOTAL = 1;
@@ -46,6 +47,8 @@ int check_shmid(void *vtest)
 	char buf[3];
 	int id;
 
+	(void) vtest;
+
 	close(p1[1]);
 	close(p2[0]);
 
@@ -61,6 +64,12 @@ int check_shmid(void *vtest)
 	tst_exit();
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newipc();
+}
+
 #define UNSHARESTR "unshare"
 #define CLONESTR "clone"
 #define NONESTR "none"
@@ -71,6 +80,8 @@ int main(int argc, char *argv[])
 	char *tsttype = NONESTR;
 	char buf[7];
 
+	setup();
+
 	if (argc != 2) {
 		tst_resm(TFAIL, "Usage: %s <clone|unshare|none>", argv[0]);
 		tst_resm(TFAIL,
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
