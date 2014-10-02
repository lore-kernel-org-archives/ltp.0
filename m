Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XZhfF-0008PP-40
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 14:47:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XZhfD-0002RB-E8
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 14:47:29 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s92ElKJU004892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 10:47:20 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s92ElJxs024860
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 10:47:20 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Thu,  2 Oct 2014 16:47:10 +0200
Message-Id: <1412261230-26027-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1409837612-27052-1-git-send-email-mmarhefk@redhat.com>
References: <1409837612-27052-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 1/3 v2] containers: added sysvipc/shm_comm.c
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

* Tests communication over shared memory segments (shm)
  with identical keys between two separate IPC namespaces

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                             |   1 +
 testcases/kernel/containers/sysvipc/.gitignore |   1 +
 testcases/kernel/containers/sysvipc/shm_comm.c | 184 +++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 testcases/kernel/containers/sysvipc/shm_comm.c

diff --git a/runtest/containers b/runtest/containers
index fc61ada..84ae736 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -39,6 +39,7 @@ shmnstest_unshare shmnstest unshare
 shmem_2nstest_none shmem_2nstest none
 shmem_2nstest_clone shmem_2nstest clone
 shmem_2nstest_unshare shmem_2nstest unshare
+shm_comm shm_comm
 mesgq_nstest_none mesgq_nstest none
 mesgq_nstest_clone mesgq_nstest clone
 mesgq_nstest_unshare mesgq_nstest unshare
diff --git a/testcases/kernel/containers/sysvipc/.gitignore b/testcases/kernel/containers/sysvipc/.gitignore
index 58cfbee..b5a4cbd 100644
--- a/testcases/kernel/containers/sysvipc/.gitignore
+++ b/testcases/kernel/containers/sysvipc/.gitignore
@@ -3,3 +3,4 @@
 /semtest_2ns
 /shmem_2nstest
 /shmnstest
+/shm_comm
diff --git a/testcases/kernel/containers/sysvipc/shm_comm.c b/testcases/kernel/containers/sysvipc/shm_comm.c
new file mode 100644
index 0000000..6475155
--- /dev/null
+++ b/testcases/kernel/containers/sysvipc/shm_comm.c
@@ -0,0 +1,184 @@
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
+ * File: shm_comm.c
+ *
+ * Description:
+ * 1. Clones two child processes with CLONE_NEWIPC flag, each child
+ *    allocates System V shared memory segment (shm) with the _identical_
+ *    key and attaches that segment into its address space.
+ * 2. Child1 writes into the shared memory segment.
+ * 3. Child2 writes into the shared memory segment.
+ * 4. Writes to the shared memory segment with the identical key but from
+ *    two different IPC namespaces should not interfere with each other
+ *    and so child1 checks whether its shared segment wasn't changed
+ *    by child2, if it wasn't test passes, otherwise test fails.
+ */
+
+#define _GNU_SOURCE
+#include <sys/ipc.h>
+#include <sys/shm.h>
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
+#define SHMSIZE 50
+char *TCID	= "shm_comm";
+int TST_TOTAL	= 1;
+struct tst_checkpoint checkpoint1;
+struct tst_checkpoint checkpoint2;
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
+int chld1_shm(void *arg)
+{
+	int id, rval = 0;
+	char *shmem;
+
+	id = shmget(TESTKEY, SHMSIZE, IPC_CREAT);
+	if (id == -1) {
+		perror("shmget");
+		return 2;
+	}
+
+	if ((shmem = shmat(id, NULL, 0)) == (char *) -1) {
+		perror("shmat");
+		shmctl(id, IPC_RMID, NULL);
+		return 2;
+	}
+
+	*shmem = 'A';
+
+	/* tell child2 to continue */
+	TST_CHECKPOINT_SIGNAL_CHILD(NULL, &checkpoint1);
+
+	/* wait for child2 */
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint2);
+
+	/* if child1 shared segment has changed (by child2) report fail */
+	if (*shmem != 'A')
+		rval = 1;
+
+	/* tell child2 to continue */
+	TST_CHECKPOINT_SIGNAL_CHILD(NULL, &checkpoint1);
+
+	shmdt(shmem);
+	shmctl(id, IPC_RMID, NULL);
+	return rval;
+}
+
+int chld2_shm(void *arg)
+{
+	int id;
+	char *shmem;
+
+	id = shmget(TESTKEY, SHMSIZE, IPC_CREAT);
+	if (id == -1) {
+		perror("shmget");
+		return 2;
+	}
+
+	if ((shmem = shmat(id, NULL, 0)) == (char *) -1) {
+		perror("shmat");
+		shmctl(id, IPC_RMID, NULL);
+		return 2;
+	}
+
+	/* wait for child1 to write to his segment */
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint1);
+
+	*shmem = 'B';
+
+	/* tell child1 to continue */
+	TST_CHECKPOINT_SIGNAL_CHILD(NULL, &checkpoint2);
+
+	/* wait for child1 */
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint1);
+
+	shmdt(shmem);
+	shmctl(id, IPC_RMID, NULL);
+	return 0;
+}
+
+static void test(void)
+{
+	int status, ret = 0;
+
+	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_shm, NULL);
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+
+	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_shm, NULL);
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
+		tst_resm(TFAIL, "SysV shm: communication with identical keys"
+				" between namespaces");
+	else
+		tst_resm(TPASS, "SysV shm: communication with identical keys"
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
