Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1Xm3m1-0001Tr-Ld
	for ltp-list@lists.sourceforge.net; Wed, 05 Nov 2014 16:49:33 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xm3lv-0001H9-ES
	for ltp-list@lists.sourceforge.net; Wed, 05 Nov 2014 16:49:33 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sA5GnKOd017555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Nov 2014 11:49:20 -0500
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id sA5GnJoH028321
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Nov 2014 11:49:20 -0500
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Wed,  5 Nov 2014 17:49:10 +0100
Message-Id: <1415206150-12848-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1414681678-28439-1-git-send-email-mmarhefk@redhat.com>
References: <1414681678-28439-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH v2] containers: added mountns/mountns05.c
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

Tests a slave-shared mount: slave-shared mount makes
a mountpoint both, shared and slave at the same time.

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                              |   1 +
 testcases/kernel/containers/.gitignore          |   1 +
 testcases/kernel/containers/mountns/mountns05.c | 448 ++++++++++++++++++++++++
 3 files changed, 450 insertions(+)
 create mode 100644 testcases/kernel/containers/mountns/mountns05.c

diff --git a/runtest/containers b/runtest/containers
index 6535628..54b9fd2 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -67,3 +67,4 @@ mountns01 mountns01
 mountns02 mountns02
 mountns03 mountns03
 mountns04 mountns04
+mountns05 mountns05
diff --git a/testcases/kernel/containers/.gitignore b/testcases/kernel/containers/.gitignore
index 4a98373..386e211 100644
--- a/testcases/kernel/containers/.gitignore
+++ b/testcases/kernel/containers/.gitignore
@@ -3,3 +3,4 @@ mountns/mountns01
 mountns/mountns02
 mountns/mountns03
 mountns/mountns04
+mountns/mountns05
diff --git a/testcases/kernel/containers/mountns/mountns05.c b/testcases/kernel/containers/mountns/mountns05.c
new file mode 100644
index 0000000..a75f1bc
--- /dev/null
+++ b/testcases/kernel/containers/mountns/mountns05.c
@@ -0,0 +1,448 @@
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
+ * File: mountns05.c
+ *
+ * Tests a slave-shared mount: slave-shared mount makes a mountpoint both,
+ * shared and slave at the same time.
+ * Description (X is parent namespace, Y and Z are child namespaces):
+ * 1. Creates directories "A", "B" and files "A/A", "B/B"
+ * 2. Unshares mount namespace and makes it private (so mounts/umounts
+ *    have no effect on a real system)
+ * 3. Bind mounts directory "A" to "A"
+ * 4. Makes directory "A" shared
+ * 5. Clones a new child process with CLONE_NEWNS flag (creates namespace Y)
+ * 6. The new child (namespace Y) makes "A" a slave mount (of mount in parent
+ *    namespace X) and also makes "A" shared inside its (Y) namespace
+ * 7. The new child process (namespace Y) clones a new child with CLONE_NEWNS
+ *    flag (creates namespace Z)
+ * 6. There are three test cases:
+ *    1)
+ *	X: bind mounts "B" to "A"
+ *	Y: must see "A/B"
+ *	Z: must see "A/B"
+ *	X: umounts "A"
+ *    2)
+ *	Y: bind mounts "B" to "A"
+ *	X: must see only "A/A" - slave cannot propagate up
+ *	Z: must see "A/B"      - NS Z shares "A" with NS Y
+ *	Y: umounts "A"
+ *    3)
+ *      Z: bind mounts "B" to "A"
+ *      X: must see only "A/A" - slave cannot propagate up
+ *	Y: must see "A/B"      - NS Y shares "A" with NS Z
+ *	Z: umounts "A"
+ ***********************************************************************/
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <sys/mount.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/msg.h>
+#include "test.h"
+#include "usctest.h"
+#include "libclone.h"
+#include "safe_macros.h"
+#include "safe_file_ops.h"
+#include "mountns_helper.h"
+
+
+#define TC1_MSG "parent: shared mount propagation to slave mount shared " \
+		" between two children"
+#define TC2_MSG "child1: slave-shared mount inability to prapagate up to " \
+		"master and ability to propagate to shared mount with child2"
+#define TC3_MSG "child2: slave-shared mount inability to prapagate up to " \
+		"master and ability to propagate to shared mount with child1"
+
+#define TESTKEY 124426L
+#define TC1_OK 0x01
+#define TC2_OK 0x02
+#define TC3_OK 0x04
+#define ERRC 0x10
+
+
+char *TCID	= "mountns05";
+int TST_TOTAL	= 3;
+int id;
+
+
+#if defined(MS_SHARED) && defined(MS_PRIVATE) \
+    && defined(MS_REC) && defined(MS_SLAVE)
+
+int child_func2(void *arg)
+{
+	int result = TC3_OK;
+	char *errmsg;
+	struct msgbuf m, r;
+
+	m.mtype = 3;
+
+	id = msgget(TESTKEY, 0644);
+	if (id == -1) {
+		errmsg = "msgget";
+		goto err;
+	}
+
+	/* TC#1 */
+	if (msgrcv(id, &r, sizeof(r.mtext), 1, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+
+	if (access(DIRA"/B", F_OK) == 0)
+		result |= TC1_OK;
+
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1) {
+		errmsg = "msgsnd";
+		goto err;
+	}
+	/* END OF TC#1 */
+
+	/* sync with parent */
+	if (msgrcv(id, &r, sizeof(r.mtext), 4, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+
+	/* TC#2 */
+	if (msgrcv(id, &r, sizeof(r.mtext), 2, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+
+	if (access(DIRA"/B", F_OK) == 0)
+		result |= TC2_OK;
+
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1) {
+		errmsg = "msgsnd";
+		goto err;
+	}
+	/* END OF TC#2 */
+
+	/* sync with parent */
+	if (msgrcv(id, &r, sizeof(r.mtext), 4, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+
+	/* TC#3 */
+	/* bind mounts DIRB to DIRA */
+	if (mount(DIRB, DIRA, "none", MS_BIND, NULL) == -1) {
+		errmsg = "mount";
+		goto err;
+	}
+
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1) {
+		errmsg = "msgsnd";
+		goto err;
+	}
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1) {
+		errmsg = "msgsnd";
+		goto err;
+	}
+
+	if (msgrcv(id, &r, sizeof(r.mtext), 1, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+	if (msgrcv(id, &r, sizeof(r.mtext), 2, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+
+	umount(DIRA);
+	/* END OF TC#3 */
+
+	return result;
+
+err:
+	perror(errmsg);
+	umount(DIRA);
+	msgctl(id, IPC_RMID, NULL);
+	return ERRC;
+}
+
+int child_func1(void *arg)
+{
+	int status, result = TC2_OK;
+	char *errmsg;
+	struct msgbuf m, r;
+
+	m.mtype = 2;
+
+	id = msgget(TESTKEY, 0644);
+	if (id == -1) {
+		errmsg = "msgget";
+		goto err;
+	}
+
+	/* makes mount DIRA a slave mount (of DIRA in parent NS) */
+	if (mount("none", DIRA, "none", MS_SLAVE, NULL) == -1) {
+		errmsg = "mount";
+		goto err;
+	}
+
+	/* makes mount DIRA a shared mount inside child NS */
+	if (mount("none", DIRA, "none", MS_SHARED, NULL) == -1) {
+		errmsg = "mount";
+		goto err;
+	}
+
+	if (do_clone_tests(CLONE_NEWNS, child_func2, NULL, NULL, NULL) == -1) {
+		errmsg = "clone";
+		goto err;
+	}
+
+	/* sync with parent*/
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1) {
+		errmsg = "msgsnd";
+		goto err;
+	}
+
+	/* TC#1 */
+	if (msgrcv(id, &r, sizeof(r.mtext), 1, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+
+	if (access(DIRA"/B", F_OK) == 0)
+		result |= TC1_OK;
+
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1) {
+		errmsg = "msgsnd";
+		goto err;
+	}
+	/* END OF TC#1 */
+
+	/* sync with parent */
+	if (msgrcv(id, &r, sizeof(r.mtext), 4, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+
+	/* TC#2 */
+	/* bind mounts DIRB to DIRA */
+	if (mount(DIRB, DIRA, "none", MS_BIND, NULL) == -1) {
+		errmsg = "mount";
+		goto err;
+	}
+
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1) {
+		errmsg = "msgsnd";
+		goto err;
+	}
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1) {
+		errmsg = "msgsnd";
+		goto err;
+	}
+
+	if (msgrcv(id, &r, sizeof(r.mtext), 1, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+	if (msgrcv(id, &r, sizeof(r.mtext), 3, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+
+	umount(DIRA);
+	/* END OF TC#2 */
+
+	/* sync with parent */
+	if (msgrcv(id, &r, sizeof(r.mtext), 4, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+
+	/* TC#3 */
+	if (msgrcv(id, &r, sizeof(r.mtext), 3, 0) == -1) {
+		errmsg = "msgrcv";
+		goto err;
+	}
+
+	if (access(DIRA"/B", F_OK) == 0)
+		result |= TC3_OK;
+
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1) {
+		errmsg = "msgsnd";
+		goto err;
+	}
+	/* END OF TC#3 */
+
+	wait(&status);
+	if (WIFEXITED(status)) {
+		if (WEXITSTATUS(status) & ERRC)
+			return ERRC;
+		return (result & WEXITSTATUS(status));
+	} else {
+		return ERRC;
+	}
+
+err:
+	perror(errmsg);
+	umount(DIRA);
+	msgctl(id, IPC_RMID, NULL);
+	wait(&status);
+	return ERRC;
+}
+
+static void cleanup2(void)
+{
+	int status;
+
+	msgctl(id, IPC_RMID, NULL);
+	wait(&status);
+	umount(DIRA);
+	cleanup();
+}
+
+static void test(void)
+{
+	int status, result = TC1_OK;
+	struct msgbuf m, r, sync;
+
+	m.mtype = 1;
+	sync.mtype = 4;
+
+	/* unshares the mount ns */
+	if (unshare(CLONE_NEWNS) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
+	/* makes sure parent mounts/umounts have no effect on a real system */
+	SAFE_MOUNT(cleanup, "none", "/", "none", MS_REC|MS_PRIVATE, NULL);
+
+	/* bind mounts DIRA to itself */
+	SAFE_MOUNT(cleanup, DIRA, DIRA, "none", MS_BIND, NULL);
+
+	/* makes mount DIRA shared */
+	SAFE_MOUNT(cleanup, "none", DIRA, "none", MS_SHARED, NULL);
+
+	id = msgget(TESTKEY, IPC_CREAT | 0644);
+	if (id == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "msgget");
+
+	if (do_clone_tests(CLONE_NEWNS, child_func1, NULL, NULL, NULL) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "clone");
+
+	/* sync with child1 */
+	if (msgrcv(id, &r, sizeof(r.mtext), 2, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgrcv");
+
+	/* TC#1 */
+	/* bind mounts DIRB to DIRA */
+	SAFE_MOUNT(cleanup2, DIRB, DIRA, "none", MS_BIND, NULL);
+
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgsnd");
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgsnd");
+
+	if (msgrcv(id, &r, sizeof(r.mtext), 2, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgrcv");
+	if (msgrcv(id, &r, sizeof(r.mtext), 3, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgrcv");
+
+	SAFE_UMOUNT(cleanup2, DIRA);
+	/* END OF TC#1 */
+
+	/* sync with children */
+	if (msgsnd(id, &sync, sizeof(sync.mtext), 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgsnd");
+	if (msgsnd(id, &sync, sizeof(sync.mtext), 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgsnd");
+
+	/* TC#2 */
+	if (msgrcv(id, &r, sizeof(r.mtext), 2, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgrcv");
+
+	if ((access(DIRA"/A", F_OK) == 0) && (access(DIRA"/B", F_OK) == -1))
+		result |= TC2_OK;
+
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgsnd");
+	/* END OF TC#2 */
+
+	/* sync with children */
+	if (msgsnd(id, &sync, sizeof(sync.mtext), 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgsnd");
+	if (msgsnd(id, &sync, sizeof(sync.mtext), 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgsnd");
+
+	/* TC#3 */
+	if (msgrcv(id, &r, sizeof(r.mtext), 3, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgrcv");
+
+	if ((access(DIRA"/A", F_OK) == 0) && (access(DIRA"/B", F_OK) == -1))
+		result |= TC3_OK;
+
+	if (msgsnd(id, &m, sizeof(m.mtext), 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup2, "msgsnd");
+	/* END OF TC#3 */
+
+
+	SAFE_WAIT(cleanup2, &status);
+	if (WIFEXITED(status)) {
+		result &= WEXITSTATUS(status);
+		if (result & ERRC)
+			tst_brkm(TBROK, cleanup2, "error in child");
+	}
+	if (WIFSIGNALED(status)) {
+		tst_resm(TBROK, "child was killed with signal %s",
+			 tst_strsig(WTERMSIG(status)));
+		return;
+	}
+
+	msgctl(id, IPC_RMID, NULL);
+	SAFE_UMOUNT(cleanup, DIRA);
+
+	if ((result & TC1_OK) == TC1_OK)
+		tst_resm(TPASS, TC1_MSG);
+	else
+		tst_resm(TFAIL, TC1_MSG);
+
+	if ((result & TC2_OK) == TC2_OK)
+		tst_resm(TPASS, TC2_MSG);
+	else
+		tst_resm(TFAIL, TC2_MSG);
+
+	if ((result & TC3_OK) == TC3_OK)
+		tst_resm(TPASS, TC3_MSG);
+	else
+		tst_resm(TFAIL, TC3_MSG);
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
+
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "needed mountflags are not defined");
+}
+#endif
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
