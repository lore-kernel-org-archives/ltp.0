Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vr2TB-0001JV-UC
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 09:22:10 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vr2TA-0004kQ-TH
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 09:22:09 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBC9M2bh003298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Dec 2013 09:22:03 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBC9M2Ef024464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Dec 2013 09:22:02 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBC9M2fZ024449
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Dec 2013 09:22:02 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 12 Dec 2013 13:21:55 +0400
Message-Id: <1386840115-9703-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1383124058-13133-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1383124058-13133-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V3 2/2] setpgid03: use tst_checkpoint interface
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
Cc: vasily.isaenko@oracle.com

I came accross the following rare issue:

setpgid03    1  TPASS  :  setpgid SUCCESS to set errno to EPERM
setpgid03    2  TFAIL  :  setpgid FAILED, expect EACCES got 1

I suppose it may happen if the test host is under stress.

To prevent this it would be better to use tst_checkpoint interface
for parent-child synchronisations.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/.gitignore               |    1 +
 testcases/kernel/syscalls/setpgid/setpgid03.c      |   57 ++++++++++++++++----
 .../kernel/syscalls/setpgid/setpgid03_child.c      |   31 +++++++++++
 3 files changed, 78 insertions(+), 11 deletions(-)
 create mode 100644 testcases/kernel/syscalls/setpgid/setpgid03_child.c

diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index bbefb25..6ce8900 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -777,6 +777,7 @@
 /setpgid/setpgid01
 /setpgid/setpgid02
 /setpgid/setpgid03
+/setpgid/setpgid03_child
 /setpgrp/setpgrp01
 /setpgrp/setpgrp02
 /setpriority/setpriority01
diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 2c47bc4..b9ecddd 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -31,12 +32,17 @@
 #include "test.h"
 #include "usctest.h"
 
+#define TEST_APP "setpgid03_child"
+
 char *TCID = "setpgid03";
 int TST_TOTAL = 1;
 
+static struct tst_checkpoint checkpoint;
+
 static void do_child(void);
 static void setup(void);
 static void cleanup(void);
+static void alarm_handler(int signo);
 
 int main(int ac, char **av)
 {
@@ -76,7 +82,7 @@ int main(int ac, char **av)
 #endif
 		}
 
-		sleep(1);
+		TST_CHECKPOINT_PARENT_WAIT(cleanup, &checkpoint);
 		rval = setpgid(pid, getppid());
 		if (errno == EPERM) {
 			tst_resm(TPASS,
@@ -86,7 +92,7 @@ int main(int ac, char **av)
 				"setpgid FAILED, expect %d, return %d",
 				EPERM, errno);
 		}
-		sleep(1);
+		TST_CHECKPOINT_SIGNAL_CHILD(cleanup, &checkpoint);
 
 		if (wait(&status) < 0)
 			tst_resm(TFAIL | TERRNO, "wait() for child 1 failed");
@@ -105,13 +111,13 @@ int main(int ac, char **av)
 
 		}
 		if (pid == 0) {
-			if (execlp("sleep", "sleep", "3", NULL) < 0) {
+			if (execlp(TEST_APP, TEST_APP, NULL) < 0)
 				perror("exec failed");
-			}
+
 			exit(127);
 		}
 
-		sleep(1);
+		TST_CHECKPOINT_PARENT_WAIT(cleanup, &checkpoint);
 		rval = setpgid(pid, getppid());
 		if (errno == EACCES) {
 			tst_resm(TPASS,
@@ -120,6 +126,7 @@ int main(int ac, char **av)
 			tst_resm(TFAIL,
 				"setpgid FAILED, expect EACCES got %d", errno);
 		}
+		TST_CHECKPOINT_SIGNAL_CHILD(cleanup, &checkpoint);
 
 		if (wait(&status) < 0)
 			tst_resm(TFAIL | TERRNO, "wait() for child 2 failed");
@@ -133,23 +140,49 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
+static void alarm_handler(int signo)
+{
+	printf("CHILD: checkpoint timed out\n");
+
+	exit(3);
+}
+
 static void do_child(void)
 {
-	int exno = 0;
+	unsigned int timeout = checkpoint.timeout / 1000;
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(struct sigaction));
+	sa.sa_handler = alarm_handler;
+
+	if (sigaction(SIGALRM, &sa, NULL) < 0) {
+		printf("CHILD: sigaction() failed, errno: %d\n", errno);
+		exit(1);
+	}
 
 	if (setsid() < 0) {
-		printf("setsid() failed, errno: %d\n", errno);
-		exno = 1;
+		printf("CHILD: setsid() failed, errno: %d\n", errno);
+		exit(2);
 	}
-	sleep(2);
-	exit(exno);
+
+	alarm(timeout);
+	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint);
+
+	alarm(timeout);
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint);
+
+	exit(0);
 }
 
 static void setup(void)
 {
-
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
+	tst_tmpdir();
+
+	TST_CHECKPOINT_INIT(&checkpoint);
+	checkpoint.timeout = 10000;
+
 	umask(0);
 
 	TEST_PAUSE;
@@ -157,5 +190,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	tst_rmdir();
+
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/syscalls/setpgid/setpgid03_child.c b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
new file mode 100644
index 0000000..c4cf892
--- /dev/null
+++ b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "test.h"
+
+char *TCID = "setpgid03_child";
+
+static struct tst_checkpoint checkpoint = { .timeout = 10000, .retval = 1};
+
+int main(void)
+{
+	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint);
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint);
+
+	return 0;
+}
-- 
1.7.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
