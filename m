Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XPXCA-0000ZM-4C
	for ltp-list@lists.sourceforge.net; Thu, 04 Sep 2014 13:35:26 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XPXC7-0007l9-Lb
	for ltp-list@lists.sourceforge.net; Thu, 04 Sep 2014 13:35:26 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s84DZFNj032742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Sep 2014 09:35:16 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s84DXlY8016485
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Sep 2014 09:35:14 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Thu,  4 Sep 2014 15:33:32 +0200
Message-Id: <1409837612-27052-3-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1409837612-27052-1-git-send-email-mmarhefk@redhat.com>
References: <1409837612-27052-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 3/3] containers: added sysvipc/sem_comm.c
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

* Tests communication over semaphore sets with identical
  keys between two separate IPC namespaces

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                             |   1 +
 testcases/kernel/containers/sysvipc/.gitignore |   1 +
 testcases/kernel/containers/sysvipc/sem_comm.c | 243 +++++++++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 testcases/kernel/containers/sysvipc/sem_comm.c

diff --git a/runtest/containers b/runtest/containers
index 7dbf049..6535628 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -50,6 +50,7 @@ sem_nstest_unshare sem_nstest unshare
 semtest_2ns_none semtest_2ns none
 semtest_2ns_clone semtest_2ns clone
 semtest_2ns_unshare semtest_2ns unshare
+sem_comm sem_comm
 
 utstest_unshare_1 utstest unshare 1
 utstest_unshare_2 utstest unshare 2
diff --git a/testcases/kernel/containers/sysvipc/.gitignore b/testcases/kernel/containers/sysvipc/.gitignore
index 68f18bf..815a717 100644
--- a/testcases/kernel/containers/sysvipc/.gitignore
+++ b/testcases/kernel/containers/sysvipc/.gitignore
@@ -5,3 +5,4 @@
 /shmnstest
 /shm_comm
 /msg_comm
+/sem_comm
diff --git a/testcases/kernel/containers/sysvipc/sem_comm.c b/testcases/kernel/containers/sysvipc/sem_comm.c
new file mode 100644
index 0000000..0b69a15
--- /dev/null
+++ b/testcases/kernel/containers/sysvipc/sem_comm.c
@@ -0,0 +1,243 @@
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
+ * File: sem_comm.c
+ *
+ * Description:
+ * 1. Clones two child processes with CLONE_NEWIPC flag, each child
+ *    creates System V semaphore (sem) with the _identical_ key.
+ * 2. Child1 locks the semaphore.
+ * 3. Child2 locks the semaphore.
+ * 4. Locking the semaphore with the identical key but from two different
+ *    IPC namespaces should not interfere with each other, so if child2
+ *    is able to lock the semaphore (after child1 locked it), test passes,
+ *    otherwise test fails.
+ */
+
+#define _GNU_SOURCE
+#include <sys/ipc.h>
+#include <sys/sem.h>
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
+char *TCID	= "sem_comm";
+int TST_TOTAL	= 1;
+int p1[2];
+int p2[2];
+
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newipc();
+}
+
+int chld1_sem(void *arg)
+{
+	int id;
+	char buf;
+	struct sembuf sm;
+
+	close(p1[0]);
+	close(p2[1]);
+
+	/* get a System V semaphore set identifier */
+	id = semget(TESTKEY, 1, IPC_CREAT);
+	if (id == -1) {
+		perror("semget");
+		close(p1[1]);
+		close(p2[0]);
+		return 2;
+	}
+
+	/* set semval to 1 */
+	if (semctl(id, 0, SETVAL, 1) == -1) {
+		perror("semctl");
+		close(p1[1]);
+		close(p2[0]);
+		semctl(id, 0, IPC_RMID);
+		return 2;
+	}
+
+	/* tell child2 to continue */
+	write(p1[1], "1", 1);
+
+	/* wait for child2 to create the semaphore */
+	read(p2[0], &buf, 1);
+
+	/* lock the semaphore */
+	sm.sem_num = 0;
+	sm.sem_op = -1;
+	sm.sem_flg = IPC_NOWAIT;
+	if (semop(id, &sm, 1) == -1) {
+		perror("semop");
+		close(p1[1]);
+		close(p2[0]);
+		semctl(id, 0, IPC_RMID);
+		return 2;
+	}
+
+	/* tell child2 to continue */
+	write(p1[1], "1", 1);
+
+	/* wait for child2 to lock the semaphore */
+	read(p2[0], &buf, 1);
+	
+	close(p1[1]);
+	close(p2[0]);
+
+	/* unlock the semaphore */
+	sm.sem_op = 1;
+	semop(id, &sm, 1);
+
+	/* remove the semaphore */
+	semctl(id, 0, IPC_RMID);
+
+	return 0;
+}
+
+int chld2_sem(void *arg)
+{
+	int id, rval = 0;
+	char buf;
+	struct sembuf sm;
+
+	close(p1[1]);
+	close(p2[0]);
+
+	/* wait for child1 to create the semaphore */
+	read(p1[0], &buf, 1);
+
+	/* get a System V semaphore set identifier */
+	id = semget(TESTKEY, 1, IPC_CREAT);
+	if (id == -1) {
+		perror("semget");
+		close(p1[1]);
+		close(p2[0]);
+		return 2;
+	}
+
+	/* set semval to 1 */
+	if (semctl(id, 0, SETVAL, 1) == -1) {
+		perror("semctl");
+		close(p1[1]);
+		close(p2[0]);
+		semctl(id, 0, IPC_RMID);
+		return 2;
+	}
+
+	/* tell child1 to continue */
+	write(p2[1], "1", 1);
+
+	/* wait for child1 to lock the semaphore */
+	read(p1[0], &buf, 1);
+
+	/* lock the semaphore */
+	sm.sem_num = 0;
+	sm.sem_op = -1;
+	sm.sem_flg = IPC_NOWAIT;
+	if (semop(id, &sm, 1) == -1) {
+		if (errno == EAGAIN) {
+			rval = 1;
+		} else {
+			perror("semop");
+			close(p1[1]);
+			close(p2[0]);
+			semctl(id, 0, IPC_RMID);
+			return 2;
+		}
+	}
+
+	/* tell child1 to continue */
+	write(p2[1], "1", 1);
+
+	close(p1[0]);
+	close(p2[1]);
+
+	/* unlock the semaphore */
+	sm.sem_op = 1;
+	semop(id, &sm, 1);
+
+	/* remove the semaphore */
+	semctl(id, 0, IPC_RMID);
+
+	return rval;
+}
+
+static void test(void)
+{
+	int status, ret = 0;
+
+	SAFE_PIPE(NULL, p1);
+	SAFE_PIPE(NULL, p2);
+
+	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld1_sem, NULL);
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "clone failed");
+
+	ret = do_clone_unshare_test(T_CLONE, CLONE_NEWIPC, chld2_sem, NULL);
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "clone failed");
+
+	close(p1[0]);
+	close(p1[1]);
+	close(p2[0]);
+	close(p2[1]);
+
+	/* wait for child processes */
+	while (wait(&status) > 0) {
+		if (WIFEXITED(status) && WEXITSTATUS(status) == 1)
+			ret = 1;
+		if (WIFEXITED(status) && WEXITSTATUS(status) == 2)
+			tst_brkm(TBROK | TERRNO, NULL, "error in child");
+		if (WIFSIGNALED(status)) {
+			tst_resm(TFAIL, "child was killed with signal %s",
+					tst_strsig(WTERMSIG(status)));
+			return;
+		}
+	}
+
+	if (ret)
+		tst_resm(TFAIL, "SysV sem: communication with identical keys"
+				" between namespaces");
+	else
+		tst_resm(TPASS, "SysV sem: communication with identical keys"
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
+	tst_exit();
+}
-- 
1.8.3.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
