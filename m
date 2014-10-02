Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XZfVK-00023B-Il
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 12:29:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XZfVJ-0002F3-Ac
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 12:29:06 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s92CSwTW028687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 08:28:58 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s92CSvmm027841
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 08:28:58 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Thu,  2 Oct 2014 14:28:47 +0200
Message-Id: <1412252927-22058-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1409047170-18251-1-git-send-email-mmarhefk@redhat.com>
References: <1409047170-18251-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 1/2 v3] containers: added mountns/mountns03.c
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

* Tests a slave mount: slave mount is like a shared mount except that
  mount and umount events only propagate towards it

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                              |   1 +
 testcases/kernel/containers/.gitignore          |   1 +
 testcases/kernel/containers/mountns/mountns03.c | 179 ++++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 testcases/kernel/containers/mountns/mountns03.c

diff --git a/runtest/containers b/runtest/containers
index 56977c0..3653c9c 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -58,3 +58,4 @@ utstest_clone_5 utstest clone 5
 
 mountns01 mountns01
 mountns02 mountns02
+mountns03 mountns03
diff --git a/testcases/kernel/containers/.gitignore b/testcases/kernel/containers/.gitignore
index f175296..5b96cb9 100644
--- a/testcases/kernel/containers/.gitignore
+++ b/testcases/kernel/containers/.gitignore
@@ -1,3 +1,4 @@
 /check_for_unshare
 mountns/mountns01
 mountns/mountns02
+mountns/mountns03
diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
new file mode 100644
index 0000000..eb64581
--- /dev/null
+++ b/testcases/kernel/containers/mountns/mountns03.c
@@ -0,0 +1,179 @@
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
+ * File: mountns03.c
+ *
+ * Tests a slave mount: slave mount is like a shared mount except that
+ * mount and umount events only propagate towards it.
+ *
+ * Description:
+ * 1. Creates directories "A", "B" and files "A/A", "B/B"
+ * 2. Unshares mount namespace and makes it private (so mounts/umounts
+ *    have no effect on a real system)
+ * 3. Bind mounts directory "A" to itself
+ * 4. Makes directory "A" shared
+ * 5. Clones a new child process with CLONE_NEWNS flag and makes "A"
+ *    a slave mount
+ * 6. There are two testcases (where X is parent namespace and Y child
+ *    namespace):
+ *    1)
+ *	X: bind mounts "B" to "A"
+ *	Y: must see the file "A/B"
+ *	X: umounts "A"
+ *    2)
+ *	Y: bind mounts "B" to "A"
+ *	X: must see only the "A/A" and must not see "A/B" (as slave
+ *	   mount does not forward propagation)
+ *	Y: umounts "A"
+ ***********************************************************************/
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <sys/mount.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include "test.h"
+#include "usctest.h"
+#include "libclone.h"
+#include "safe_macros.h"
+#include "safe_file_ops.h"
+#include "mountns_helper.h"
+
+
+char *TCID	= "mountns03";
+int TST_TOTAL	= 2;
+
+
+#if defined(MS_SHARED) && defined(MS_PRIVATE) \
+    && defined(MS_REC) && defined(MS_SLAVE)
+
+int child_func(void *arg)
+{
+	int ret = 0;
+
+	/* makes mount DIRA a slave of DIRA (all slave mounts have
+	 * a master mount which is a shared mount) */
+	if (mount("none", DIRA, "none", MS_SLAVE, NULL) == -1) {
+		perror("mount");
+		return 1;
+	}
+
+	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint1);
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint2);
+
+	/* checks that shared mounts propagates to slave mount */
+	if (access(DIRA"/B", F_OK) == -1)
+		ret = 2;
+
+	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint1);
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint2);
+
+	/* bind mounts DIRB to DIRA making contents of DIRB visible
+	 * in DIRA */
+	if (mount(DIRB, DIRA, "none", MS_BIND, NULL) == -1) {
+		perror("mount");
+		return 1;
+	}
+
+	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint1);
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint2);
+
+	umount(DIRA);
+	return ret;
+}
+
+static void test(void)
+{
+	int status;
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
+	if (do_clone_tests(CLONE_NEWNS, child_func, NULL, NULL, NULL) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+
+	/* waits for child to make a slave mount */
+	TST_CHECKPOINT_PARENT_WAIT(cleanup, &checkpoint1);
+
+	/* bind mounts DIRB to DIRA making contents of DIRB visible
+	 * in DIRA */
+	SAFE_MOUNT(cleanup, DIRB, DIRA, "none", MS_BIND, NULL);
+
+	TST_CHECKPOINT_SIGNAL_CHILD(cleanup, &checkpoint2);
+	TST_CHECKPOINT_PARENT_WAIT(cleanup, &checkpoint1);
+
+	SAFE_UMOUNT(cleanup, DIRA);
+
+	TST_CHECKPOINT_SIGNAL_CHILD(cleanup, &checkpoint2);
+	TST_CHECKPOINT_PARENT_WAIT(cleanup, &checkpoint1);
+
+	/* checks that slave mount doesn't propagate to shared mount */
+	if ((access(DIRA"/A", F_OK) == 0) && (access(DIRA"/B", F_OK) == -1))
+		tst_resm(TPASS, "propagation from slave mount passed");
+	else
+		tst_resm(TFAIL, "propagation form slave mount failed");
+
+	TST_CHECKPOINT_SIGNAL_CHILD(cleanup, &checkpoint2);
+
+
+	SAFE_WAIT(cleanup, &status);
+	if (WIFEXITED(status)) {
+		if (WEXITSTATUS(status) == 0)
+			tst_resm(TPASS, "propagation to slave mount passed");
+		else
+			tst_resm(TFAIL, "propagation to slave mount failed");
+	}
+	if (WIFSIGNALED(status)) {
+		tst_resm(TBROK, "child was killed with signal %s",
+			 tst_strsig(WTERMSIG(status)));
+		return;
+	}
+
+	SAFE_UMOUNT(cleanup, DIRA);
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
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
