Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XZhfy-0000mg-7y
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 14:48:14 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XZhfw-0002Pi-UZ
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 14:48:14 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s92Em5mU011365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 10:48:06 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s92Em4uW030928
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 10:48:04 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Thu,  2 Oct 2014 16:47:59 +0200
Message-Id: <1412261279-26066-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1409837612-27052-2-git-send-email-mmarhefk@redhat.com>
References: <1409837612-27052-2-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 2/3 v2] containers: added sysvipc/msg_comm.c
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

* Tests communication over message queues with identical
  keys between two separate IPC namespaces

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                             |   1 +
 testcases/kernel/containers/sysvipc/.gitignore |   1 +
 testcases/kernel/containers/sysvipc/msg_comm.c | 190 +++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 testcases/kernel/containers/sysvipc/msg_comm.c

diff --git a/runtest/containers b/runtest/containers
index 84ae736..7dbf049 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -43,6 +43,7 @@ shm_comm shm_comm
 mesgq_nstest_none mesgq_nstest none
 mesgq_nstest_clone mesgq_nstest clone
 mesgq_nstest_unshare mesgq_nstest unshare
+msg_comm msg_comm
 sem_nstest_none sem_nstest none
 sem_nstest_clone sem_nstest clone
 sem_nstest_unshare sem_nstest unshare
diff --git a/testcases/kernel/containers/sysvipc/.gitignore b/testcases/kernel/containers/sysvipc/.gitignore
index b5a4cbd..68f18bf 100644
--- a/testcases/kernel/containers/sysvipc/.gitignore
+++ b/testcases/kernel/containers/sysvipc/.gitignore
@@ -4,3 +4,4 @@
 /shmem_2nstest
 /shmnstest
 /shm_comm
+/msg_comm
diff --git a/testcases/kernel/containers/sysvipc/msg_comm.c b/testcases/kernel/containers/sysvipc/msg_comm.c
new file mode 100644
index 0000000..b3c62df
--- /dev/null
+++ b/testcases/kernel/containers/sysvipc/msg_comm.c
@@ -0,0 +1,190 @@
+/* Copyright (c) 2014 Red Hat, Inc.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of version 2 the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ ***********************************************************************
+ * File: msg_comm.c
+ *
+ * Description:
+ * 1. Clones two child processes with CLONE_NEWIPC flag, each child
+ *    gets System V message queue (msg) with the _identical_ key.
+ * 2. Child1 appends a message with identifier #1 to the message queue.
+ * 3. Child2 appends a message with identifier #2 to the message queue.
+ * 4. Appends to the message queue with the identical key but from
+ *    two different IPC namespaces should not interfere with each other
+ *    and so child1 checks whether its message queue doesn't contain
+ *    a message with identifier #2, if it doesn't test passes, otherwise
+ *    test fails.
+ */
+
+#define _GNU_SOURCE
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdio.h>
+#include <errno.h>
+#include "usctest.h"
+#include "test.h"
+#include "safe_macros.h"
+#include "libclone.h"
+#include "ipcns_helper.h"
+
+
+#define TESTKEY 124426L
+#define MSGSIZE 50
+char *TCID	= "msg_comm";
+int TST_TOTAL	= 1;
+struct tst_checkpoint checkpoint1;
+struct tst_checkpoint checkpoint2;
+struct sysv_msg {
+	long mtype;
+	char mtext[MSGSIZE];
+};
+
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newipc();
+	tst_tmpdir();
+	TST_CHECKPOINT_INIT(&checkpoint1);
+	TST_CHECKPOINT_INIT(&checkpoint2);
+}
+
+int chld1_msg(void *arg)
+{
+	int id, n, rval = 0;
+	struct sysv_msg m;
+	struct sysv_msg rec;
+
+	id = msgget(TESTKEY, IPC_CREAT | 0600);
+	if (id == -1) {
+		perror("msgget");
+		return 2;
+	}
+
+	m.mtype = 1;
+	m.mtext[0] = 'A';
+	if (msgsnd(id, &m, sizeof(struct sysv_msg) - sizeof(long), 0) == -1) {
+		perror("msgsnd");
+		msgctl(id, IPC_RMID, NULL);
+		return 2;
+	}
+
+	/* wait for child2 to write into the message queue */
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint2);
+
+	/* if child1 message queue has changed (by child2) report fail */
+	n = msgrcv(id, &rec, sizeof(struct sysv_msg) - sizeof(long),
+		   2, IPC_NOWAIT);
+	if (n == -1 && errno != ENOMSG) {
+		perror("msgrcv");
+		msgctl(id, IPC_RMID, NULL);
+		return 2;
+	}
+	/* if mtype #2 was found in the message queue, it is fail */
+	if (n > 0) {
+		rval = 1;
+	}
+
+	/* tell child2 to continue */
+	TST_CHECKPOINT_SIGNAL_CHILD(NULL, &checkpoint1);
+
+	msgctl(id, IPC_RMID, NULL);
+	return rval;
+}
+
+int chld2_msg(void *arg)
+{
+	int id;
+	struct sysv_msg m;
+
+	id = msgget(TESTKEY, IPC_CREAT | 0600);
+	if (id == -1) {
+		perror("msgget");
+		return 2;
+	}
+
+	m.mtype = 2;
+	m.mtext[0] = 'B';
+	if (msgsnd(id, &m, sizeof(struct sysv_msg) - sizeof(long), 0) == -1) {
+		perror("msgsnd");
+		msgctl(id, IPC_RMID, NULL);
+		return 2;
+	}
+
+	/* tell child1 to continue */
+	TST_CHECKPOINT_SIGNAL_CHILD(NULL, &checkpoint2);
+
+	/* wait for child1 */
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint1);
+
+	msgctl(id, IPC_RMID, NULL);
+	return 0;
+}
+
+static void test(void)
+{
+	int status, ret = 0;
+
+	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_msg, NULL);
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+
+	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_msg, NULL);
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+
+
+	while (wait(&status) > 0) {
+		if (WIFEXITED(status) && WEXITSTATUS(status) == 1)
+			ret = 1;
+		if (WIFEXITED(status) && WEXITSTATUS(status) == 2)
+			tst_brkm(TBROK | TERRNO, cleanup, "error in child");
+		if (WIFSIGNALED(status)) {
+			tst_resm(TFAIL, "child was killed with signal %s",
+					tst_strsig(WTERMSIG(status)));
+			return;
+		}
+	}
+
+	if (ret)
+		tst_resm(TFAIL, "SysV msg: communication with identical keys"
+				" between namespaces");
+	else
+		tst_resm(TPASS, "SysV msg: communication with identical keys"
+				" between namespaces");
+}
+
+int main(int argc, char *argv[])
+{
+	const char *msg;
+	int lc;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++)
+		test();
+
+	cleanup();
+	tst_exit();
+}
-- 
1.8.3.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
