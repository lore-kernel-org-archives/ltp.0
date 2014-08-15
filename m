Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XIF98-0003hW-6f
	for ltp-list@lists.sourceforge.net; Fri, 15 Aug 2014 10:54:10 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XIF97-0005U1-2n
	for ltp-list@lists.sourceforge.net; Fri, 15 Aug 2014 10:54:10 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7FAs24p016943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Aug 2014 06:54:02 -0400
Received: from cc-vtoe5.lab.eng.brq.redhat.com
	(cc-vtoe5.lab.eng.brq.redhat.com [10.34.74.39])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s7FArMYa012634
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Aug 2014 06:54:02 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Fri, 15 Aug 2014 12:52:45 +0200
Message-Id: <1408099965-15748-3-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1408099965-15748-1-git-send-email-mmarhefk@redhat.com>
References: <1408099965-15748-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 3/3] containers: added mountns/mountns02.c
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

* Tests a private mount: private mount does not forward or receive
  propagation.

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                              |   1 +
 testcases/kernel/containers/mountns/mountns02.c | 151 ++++++++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100644 testcases/kernel/containers/mountns/mountns02.c

diff --git a/runtest/containers b/runtest/containers
index bf50ae4..ab16bc0 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -15,5 +15,6 @@ pidns30 pidns30
 pidns31 pidns31
 
 mountns01 mountns01
+mountns02 mountns02
 
 Containers	container_test.sh
diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
new file mode 100644
index 0000000..8bd0100
--- /dev/null
+++ b/testcases/kernel/containers/mountns/mountns02.c
@@ -0,0 +1,151 @@
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
+ * File: mountns02.c
+ *
+ * Tests a private mount: private mount does not forward or receive
+ * propagation.
+ * Description:
+ * 1. Creates directories "A", "B" and files "A/A", "B/B"
+ * 2. Unshares mount namespace and makes it private (so mounts/umounts
+ *    have no effect on a real system)
+ * 3. Bind mounts directory "A" to "A" and "B" to "B"
+ * 4. Makes both directories ("A" and "B") shared
+ * 5. Clones a new child process with CLONE_NEWNS flag - the new child
+ *    then mounts directory "A" as private and bind mounts directory
+ *    "B" to "A"
+ * 6. Parent then checks if directory "A" doesn't contain the file "B"
+ *    (changes in child should not be visible in parent as mount in child
+ *    was private):
+ *    - if it doesn't, test passes
+ *    - if it does, test fails
+ ***********************************************************************/
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <sys/mount.h>
+#include <stdio.h>
+#include <errno.h>
+#include "test.h"
+#include "usctest.h"
+#include "libclone.h"
+#include "safe_macros.h"
+#include "safe_file_ops.h"
+#include "mountns_helper.h"
+
+
+#define DIRA "A"
+#define DIRB "B"
+char *TCID	= "mountns02";
+int TST_TOTAL	= 1;
+
+
+static void cleanup(void)
+{
+	umount(DIRA);
+	umount(DIRA);
+	umount(DIRB);
+	tst_rmdir();
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_newns();	/* from mountns_helper.h */
+	tst_tmpdir();
+	SAFE_MKDIR(cleanup, DIRA, 0777);
+	SAFE_MKDIR(cleanup, DIRB, 0777);
+	SAFE_TOUCH(cleanup, DIRA"/A", 0, NULL);
+	SAFE_TOUCH(cleanup, DIRB"/B", 0, NULL);
+}
+
+int child_func(void *arg)
+{
+	/* makes DIRA private */
+	if (mount("none", DIRA, "none", MS_PRIVATE, NULL) == -1) {
+		perror("mount");
+		return 1;
+	}
+
+	/* bind mounts DIRB to DIRA making contents of DIRB visible
+	 * in DIRA (should apply only for child as DIRA is private) */
+        if (mount(DIRB, DIRA, "none", MS_BIND, NULL) == -1) {
+		perror("mount");
+		return 1;
+	}
+
+	return 0;
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
+	/* bind mounts DIRB to itself */
+	SAFE_MOUNT(cleanup, DIRB, DIRB, "none", MS_BIND, NULL);
+
+	/* makes mount DIRA shared */
+	SAFE_MOUNT(cleanup, "none", DIRA, "none", MS_SHARED, NULL);
+	/* makes mount DIRB shared */
+	SAFE_MOUNT(cleanup, "none", DIRB, "none", MS_SHARED, NULL);
+
+
+	if (do_clone_tests(CLONE_NEWNS, child_func, NULL, NULL, NULL) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+
+	SAFE_WAIT(cleanup, &status);
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+		tst_brkm(TBROK, cleanup, "mount (in child) failed");
+
+	if (WIFSIGNALED(status)) {
+		tst_resm(TFAIL, "child was killed with signal %s",
+			 tst_strsig(WTERMSIG(status)));
+		return;
+	}
+
+	/* as child made private mount from DIRA, parent should not
+	 * see file "B" in DIRA; following checks if DIRA doesn't contain
+	 * file "B" */
+	if (access(DIRA"/B", F_OK) == -1)
+		tst_resm(TPASS, "private mount passed");
+	else
+		tst_resm(TFAIL, "private mount failed");
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
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
