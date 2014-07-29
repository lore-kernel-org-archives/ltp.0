Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XC6tP-0007O0-AW
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 12:52:35 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XC6tN-0003ON-3R
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 12:52:35 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6TCqQ7d026362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jul 2014 08:52:26 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s6TCqOp2018896
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jul 2014 08:52:25 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 29 Jul 2014 14:52:19 +0200
Message-Id: <1a3dd40e9f83bca2de34b08c8b0ac34874cae438.1406638271.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] extract pidns tests from runpidnstest.sh to
	runtest/container
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

Extract pinds testcases from container_test.sh and list
all separately in container runtest.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/containers                                 |   15 +++
 testcases/kernel/containers/container_test.sh      |    8 --
 testcases/kernel/containers/pidns/.gitignore       |    2 +-
 testcases/kernel/containers/pidns/Makefile         |    1 +
 .../kernel/containers/pidns/check_pidns_enabled.c  |   70 -------------
 testcases/kernel/containers/pidns/pidns01.c        |    9 ++
 testcases/kernel/containers/pidns/pidns02.c        |    9 ++
 testcases/kernel/containers/pidns/pidns03.c        |    3 +-
 testcases/kernel/containers/pidns/pidns04.c        |    9 ++
 testcases/kernel/containers/pidns/pidns05.c        |    9 ++
 testcases/kernel/containers/pidns/pidns06.c        |   10 ++
 testcases/kernel/containers/pidns/pidns10.c        |    9 ++
 testcases/kernel/containers/pidns/pidns12.c        |    9 ++
 testcases/kernel/containers/pidns/pidns13.c        |    9 ++
 testcases/kernel/containers/pidns/pidns16.c        |   10 ++
 testcases/kernel/containers/pidns/pidns17.c        |    9 ++
 testcases/kernel/containers/pidns/pidns20.c        |    9 ++
 testcases/kernel/containers/pidns/pidns30.c        |    9 ++
 testcases/kernel/containers/pidns/pidns31.c        |    9 ++
 testcases/kernel/containers/pidns/pidns_helper.c   |   37 +++++++
 testcases/kernel/containers/pidns/runpidnstest.sh  |  104 --------------------
 21 files changed, 175 insertions(+), 184 deletions(-)
 delete mode 100644 testcases/kernel/containers/pidns/check_pidns_enabled.c
 create mode 100644 testcases/kernel/containers/pidns/pidns_helper.c
 delete mode 100644 testcases/kernel/containers/pidns/runpidnstest.sh

diff --git a/runtest/containers b/runtest/containers
index 5665ec7..5f5eeab 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -1,2 +1,17 @@
 #DESCRIPTION:Resource namespaces
+pidns01 pidns01
+pidns02 pidns02
+pidns03 pidns03
+pidns04 pidns04
+pidns05 pidns05
+pidns06 pidns06
+pidns10 pidns10
+pidns12 pidns12
+pidns13 pidns13
+pidns16 pidns16
+pidns17 pidns17
+pidns20 pidns20
+pidns30 pidns30
+pidns31 pidns31
+
 Containers	container_test.sh
diff --git a/testcases/kernel/containers/container_test.sh b/testcases/kernel/containers/container_test.sh
index 5ad1414..cc570f0 100755
--- a/testcases/kernel/containers/container_test.sh
+++ b/testcases/kernel/containers/container_test.sh
@@ -46,14 +46,6 @@ else
 	echo "ipc namespaces not enabled in kernel.  Not running ipcns tests."
 fi
 
-check_pidns_enabled
-if [ $? -eq 0 ]; then
-	echo "Running pidns tests."
-	runpidnstest.sh
-else
-	echo "Process id namespaces not enabled in kernel.  Not running pidns tests."
-fi
-
 check_mqns_enabled
 if [ $? -eq 0 ]; then
     echo "Running POSIX message queue tests."
diff --git a/testcases/kernel/containers/pidns/.gitignore b/testcases/kernel/containers/pidns/.gitignore
index a13cf60..e56c1f9 100644
--- a/testcases/kernel/containers/pidns/.gitignore
+++ b/testcases/kernel/containers/pidns/.gitignore
@@ -1,6 +1,6 @@
-/check_pidns_enabled
 /pidns01
 /pidns02
+/pidns03
 /pidns04
 /pidns05
 /pidns06
diff --git a/testcases/kernel/containers/pidns/Makefile b/testcases/kernel/containers/pidns/Makefile
index 6dfe694..c200066 100644
--- a/testcases/kernel/containers/pidns/Makefile
+++ b/testcases/kernel/containers/pidns/Makefile
@@ -24,5 +24,6 @@ include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
 LDLIBS			:= -lpthread -lrt -lclone -lltp
+FILTER_OUT_MAKE_TARGETS := pidns_helper
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/pidns/check_pidns_enabled.c b/testcases/kernel/containers/pidns/check_pidns_enabled.c
deleted file mode 100644
index 170be7f..0000000
--- a/testcases/kernel/containers/pidns/check_pidns_enabled.c
+++ /dev/null
@@ -1,70 +0,0 @@
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
-***************************************************************************
-
-* File: check_pidns_enabled.c
-*
-* Description:
-*	This testcase builds into the ltp framework to verify that kernel is
-* PID NS enabled or not.
-*
-* Verify that:
-* 1. Verify that the kernel version is 2.6.24.
-* 2. Verify that clone() function return value.
-*
-* Test Name: check_pidns_enabled
-*
-* Test Assertion & Strategy:
-* Check that the kernel version is 2.6.24 and clone returns no failure after passing
-* the clone falg as CLONE_NEWPID.
-*
-* History:
-*
-* FLAG DATE		 	NAME					 		DESCRIPTION
-* 27/12/07	RISHIKESH K RAJAK <risrajak@in.ibm.com> Created this test
-*
-*******************************************************************************************/
-#include <sched.h>
-#include <stdio.h>
-#include "../libclone/libclone.h"
-#include "test.h"
-
-char *TCID = "check_pidns_enabled";
-int TST_COUNT = 1;
-int TST_TOTAL = 1;
-
-int dummy(void *v)
-{
-	/* Simply return from the child */
-	return 0;
-}
-
-int main()
-{
-	int pid;
-
-	if (tst_kvercmp(2, 6, 24) < 0)
-		return 1;
-
-	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWPID, dummy, NULL);
-
-	/* Check for the clone function return value */
-	if (pid == -1) {
-		perror("do_clone_unshare_test");
-		return 3;
-	}
-	return 0;
-}
diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
index 02b4251..c495134 100644
--- a/testcases/kernel/containers/pidns/pidns01.c
+++ b/testcases/kernel/containers/pidns/pidns01.c
@@ -58,6 +58,7 @@
 #include "test.h"
 #define CLEANUP cleanup
 #include "libclone.h"
+#include "pidns_helper.c"
 
 char *TCID = "pid_namespace1";
 int TST_TOTAL = 1;
@@ -88,10 +89,18 @@ int child_fn1(void *ttype)
 	return exit_val;
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 int main(int argc, char *argv[])
 {
 	int status;
 
+	setup();
+
 	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, child_fn1, NULL));
 
 	if (TEST_RETURN == -1) {
diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
index d0ff9c8..039097e 100644
--- a/testcases/kernel/containers/pidns/pidns02.c
+++ b/testcases/kernel/containers/pidns/pidns02.c
@@ -54,6 +54,7 @@
 #include "test.h"
 #define CLEANUP cleanup
 #include "libclone.h"
+#include "pidns_helper.c"
 
 char *TCID = "pid_namespace2";
 int TST_TOTAL = 1;
@@ -85,10 +86,18 @@ int child_fn1(void *vtest)
 	}
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 int main(int argc, char *argv[])
 {
 	int status;
 
+	setup();
+
 	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, child_fn1, NULL));
 	if (TEST_RETURN == -1) {
 		tst_brkm(TFAIL | TTERRNO, CLEANUP, "clone failed");
diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
index 1acd790..30caf2a 100644
--- a/testcases/kernel/containers/pidns/pidns03.c
+++ b/testcases/kernel/containers/pidns/pidns03.c
@@ -35,7 +35,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "libclone.h"
-
+#include "pidns_helper.c"
 
 #define PROCDIR "proc"
 char *TCID	= "pidns03";
@@ -50,6 +50,7 @@ static void cleanup(void)
 static void setup(void)
 {
 	tst_require_root(NULL);
+	check_newpid();
 	tst_tmpdir();
 	SAFE_MKDIR(cleanup, PROCDIR, 0555);
 }
diff --git a/testcases/kernel/containers/pidns/pidns04.c b/testcases/kernel/containers/pidns/pidns04.c
index 8a4e696..920cdb5 100644
--- a/testcases/kernel/containers/pidns/pidns04.c
+++ b/testcases/kernel/containers/pidns/pidns04.c
@@ -60,6 +60,7 @@
 #include "test.h"
 #define CLEANUP cleanup
 #include "libclone.h"
+#include "pidns_helper.c"
 
 #define INIT_PID	1
 #define CHILD_PID       1
@@ -100,11 +101,19 @@ static int child_fn1(void *ttype)
 	exit(exit_val);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 int main(int argc, char *argv[])
 {
 	int nbytes, status;
 	char readbuffer[80];
 
+	setup();
+
 	pipe(fd);
 	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, child_fn1, NULL));
 	if (TEST_RETURN == -1) {
diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
index e70031d..4c53b13 100644
--- a/testcases/kernel/containers/pidns/pidns05.c
+++ b/testcases/kernel/containers/pidns/pidns05.c
@@ -50,6 +50,7 @@
 #include "usctest.h"
 #include "test.h"
 #include <libclone.h>
+#include "pidns_helper.c"
 
 #define INIT_PID	1
 #define CINIT_PID	1
@@ -191,6 +192,12 @@ void kill_nested_containers()
 	}
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 int main(int argc, char *argv[])
 {
 	int ret, nbytes, status;
@@ -198,6 +205,8 @@ int main(int argc, char *argv[])
 	pid_t pid, pgid;
 	int count = MAX_DEPTH;
 
+	setup();
+
 	/*
 	 * XXX (garrcoop): why in the hell is this fork-wait written this way?
 	 * This doesn't add up with the pattern used for the rest of the tests,
diff --git a/testcases/kernel/containers/pidns/pidns06.c b/testcases/kernel/containers/pidns/pidns06.c
index 695b9b8..e2695dc 100644
--- a/testcases/kernel/containers/pidns/pidns06.c
+++ b/testcases/kernel/containers/pidns/pidns06.c
@@ -45,6 +45,7 @@
 #include "test.h"
 #include <libclone.h>
 #include <signal.h>
+#include "pidns_helper.c"
 
 #define CINIT_PID       1
 #define PARENT_PID      0
@@ -113,9 +114,18 @@ static int kill_pid_in_childfun(void *vtest)
 	exit(0);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 int main()
 {
 	int status;
+
+	setup();
+
 	pid_t pid = getpid();
 
 	tst_resm(TINFO, "Parent: Passing the pid of the process %d", pid);
diff --git a/testcases/kernel/containers/pidns/pidns10.c b/testcases/kernel/containers/pidns/pidns10.c
index 533c3c8..bccd7dc 100644
--- a/testcases/kernel/containers/pidns/pidns10.c
+++ b/testcases/kernel/containers/pidns/pidns10.c
@@ -45,6 +45,7 @@
 #include "test.h"
 #define CLEANUP cleanup
 #include "libclone.h"
+#include "pidns_helper.c"
 
 char *TCID = "pidns10";
 int TST_TOTAL = 1;
@@ -83,11 +84,19 @@ int child_fn(void *arg)
 	exit(exit_val);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 int main(int argc, char *argv[])
 {
 	int status;
 	pid_t pid;
 
+	setup();
+
 	pid = getpid();
 
 	/* Container creation on PID namespace */
diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
index bd5ab06..5d50d53 100644
--- a/testcases/kernel/containers/pidns/pidns12.c
+++ b/testcases/kernel/containers/pidns/pidns12.c
@@ -45,6 +45,7 @@
 #include "usctest.h"
 #include "test.h"
 #include <libclone.h>
+#include "pidns_helper.c"
 
 char *TCID = "pidns12";
 int TST_TOTAL = 1;
@@ -124,6 +125,12 @@ int child_fn(void *arg)
 	exit(0);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 /***********************************************************************
 *   M A I N
 ***********************************************************************/
@@ -134,6 +141,8 @@ int main(int argc, char *argv[])
 	pid_t pid, cpid;
 	char buf[5];
 
+	setup();
+
 	pid = getpid();
 	tst_resm(TINFO, "parent: PID is %d", pid);
 
diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index ef31fc6..48cbc1c 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -48,6 +48,7 @@
 #include "usctest.h"
 #include "test.h"
 #include <libclone.h>
+#include "pidns_helper.c"
 
 char *TCID = "pidns13";
 int TST_TOTAL = 1;
@@ -185,6 +186,12 @@ int child_fn(void *arg)
 	exit(0);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 /***********************************************************************
 *   M A I N
 ***********************************************************************/
@@ -195,6 +202,8 @@ int main(int argc, char *argv[])
 	int *cinit_no = malloc(sizeof(int));
 	pid_t cpid1, cpid2;
 
+	setup();
+
 	/* create pipe */
 	if (pipe(pipe_fd) == -1) {
 		tst_resm(TBROK, "parent: pipe creation failed");
diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
index 70548e8..7b8d7a3 100644
--- a/testcases/kernel/containers/pidns/pidns16.c
+++ b/testcases/kernel/containers/pidns/pidns16.c
@@ -49,6 +49,8 @@
 #include "usctest.h"
 #include "test.h"
 #include <libclone.h>
+#include "pidns_helper.c"
+
 #define CHILD_PID	1
 #define PARENT_PID	0
 
@@ -129,6 +131,12 @@ int child_fn(void *ttype)
 	_exit(10);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 /***********************************************************************
 *   M A I N
 ***********************************************************************/
@@ -137,6 +145,8 @@ int main(int argc, char *argv[])
 	int status;
 	pid_t cpid;
 
+	setup();
+
 	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
 
 	if (cpid < 0) {
diff --git a/testcases/kernel/containers/pidns/pidns17.c b/testcases/kernel/containers/pidns/pidns17.c
index b27392a..8869683 100644
--- a/testcases/kernel/containers/pidns/pidns17.c
+++ b/testcases/kernel/containers/pidns/pidns17.c
@@ -46,6 +46,7 @@
 #include "test.h"
 #define CLEANUP cleanup
 #include "libclone.h"
+#include "pidns_helper.c"
 
 char *TCID = "pidns17";
 int TST_TOTAL = 1;
@@ -128,11 +129,19 @@ int child_fn(void *arg)
 	exit(exit_val);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 int main(int argc, char *argv[])
 {
 	int status;
 	pid_t pid;
 
+	setup();
+
 	pid = getpid();
 
 	/* Container creation on PID namespace */
diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
index e129659..d4dfb2e 100644
--- a/testcases/kernel/containers/pidns/pidns20.c
+++ b/testcases/kernel/containers/pidns/pidns20.c
@@ -49,6 +49,7 @@
 #include "usctest.h"
 #include "test.h"
 #include <libclone.h>
+#include "pidns_helper.c"
 
 char *TCID = "pidns20";
 int TST_TOTAL = 1;
@@ -152,12 +153,20 @@ int child_fn(void *arg)
 	exit(0);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 int main(int argc, char *argv[])
 {
 	int status;
 	char buf[5];
 	pid_t cpid;
 
+	setup();
+
 	/* Create pipes for intercommunication */
 	if (pipe(parent_cinit) == -1 || pipe(cinit_parent) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
index b29e6b7..8970a79 100644
--- a/testcases/kernel/containers/pidns/pidns30.c
+++ b/testcases/kernel/containers/pidns/pidns30.c
@@ -55,6 +55,7 @@
 #include "test.h"
 #include "linux_syscall_numbers.h"
 #include "libclone.h"
+#include "pidns_helper.c"
 
 char *TCID = "pidns30";
 int TST_TOTAL = 1;
@@ -234,12 +235,20 @@ int child_fn(void *arg)
 	exit(0);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 int main(int argc, char *argv[])
 {
 	int status;
 	char buf[5];
 	pid_t cpid;
 
+	setup();
+
 	if (pipe(child_to_father) == -1 || pipe(father_to_child) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
 	}
diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
index e87ef19..08b53aa 100644
--- a/testcases/kernel/containers/pidns/pidns31.c
+++ b/testcases/kernel/containers/pidns/pidns31.c
@@ -57,6 +57,7 @@
 #include "test.h"
 #include "linux_syscall_numbers.h"
 #include "libclone.h"
+#include "pidns_helper.c"
 
 char *TCID = "pidns31";
 int TST_TOTAL = 1;
@@ -243,6 +244,12 @@ static void father_signal_handler(int sig, siginfo_t * si, void *unused)
 		mq_receive(info->mqd, buf, attr.mq_msgsize, NULL);
 }
 
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newpid();
+}
+
 /***********************************************************************
 *   M A I N
 ***********************************************************************/
@@ -256,6 +263,8 @@ int main(int argc, char *argv[])
 	int status;
 	struct notify_info info;
 
+	setup();
+
 	if (pipe(father_to_child) == -1) {
 		tst_resm(TBROK, "parent: pipe() failed. aborting!");
 		cleanup_mqueue(TBROK, NO_STEP, 0);
diff --git a/testcases/kernel/containers/pidns/pidns_helper.c b/testcases/kernel/containers/pidns/pidns_helper.c
new file mode 100644
index 0000000..dad7a6d
--- /dev/null
+++ b/testcases/kernel/containers/pidns/pidns_helper.c
@@ -0,0 +1,37 @@
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
+*/
+
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
+static int check_newpid(void)
+{
+	int pid, status;
+
+	if (tst_kvercmp(2, 6, 24) < 0)
+		tst_brkm(TCONF, NULL, "CLONE_NEWPID not supported");
+
+	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWPID, dummy_child, NULL);
+	if (pid == -1)
+		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWPID not supported");
+	SAFE_WAIT(NULL, &status);
+
+	return 0;
+}
diff --git a/testcases/kernel/containers/pidns/runpidnstest.sh b/testcases/kernel/containers/pidns/runpidnstest.sh
deleted file mode 100644
index fa8d76c..0000000
--- a/testcases/kernel/containers/pidns/runpidnstest.sh
+++ /dev/null
@@ -1,104 +0,0 @@
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
-pidns01
-rc=$?
-if [ $rc -ne 0 ]; then
-	err_code=$rc
-fi
-
-pidns02
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-pidns04
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-pidns05
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-pidns06
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-pidns30
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-pidns31
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-pidns10
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-pidns12
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-pidns13
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-pidns16
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-pidns17
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-pidns20
-rc=$?
-if [ $rc -ne 0 ] && [ -z $err_code ]; then
-	err_code=$rc
-fi
-
-# If any test failed then exit with the value error-code.
-if ! [ -z $err_code ]; then
-	exit $err_code
-fi
-
-- 
1.7.1


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
