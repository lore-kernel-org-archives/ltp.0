Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XLuwf-0003Bb-Lt
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 14:08:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XLuwd-0004I4-QR
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 14:08:29 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7PE8KFK007210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 25 Aug 2014 10:08:20 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Mon, 25 Aug 2014 16:08:08 +0200
Message-Id: <1408975688-7728-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1408099965-15748-2-git-send-email-mmarhefk@redhat.com>
References: <1408099965-15748-2-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 2/3 v2] containers: added mountns dir and
	mountns/mountns01.c
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

* tests shared mount: shared mount can be replicated to as many
  mountpoints and all the replicas continue to be exactly same.

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                                 |   2 +
 testcases/kernel/containers/.gitignore             |   1 +
 testcases/kernel/containers/mountns/Makefile       |  23 ++++
 testcases/kernel/containers/mountns/mountns01.c    | 152 +++++++++++++++++++++
 .../kernel/containers/mountns/mountns_helper.h     |  39 ++++++
 5 files changed, 217 insertions(+)
 create mode 100644 testcases/kernel/containers/mountns/Makefile
 create mode 100644 testcases/kernel/containers/mountns/mountns01.c
 create mode 100644 testcases/kernel/containers/mountns/mountns_helper.h

diff --git a/runtest/containers b/runtest/containers
index 558d7eb..f298c7e 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -55,3 +55,5 @@ utstest_clone_2 utstest clone 2
 utstest_clone_3 utstest clone 3
 utstest_clone_4 utstest clone 4
 utstest_clone_5 utstest clone 5
+
+mountns01 mountns01
diff --git a/testcases/kernel/containers/.gitignore b/testcases/kernel/containers/.gitignore
index f6f5b14..254d1b9 100644
--- a/testcases/kernel/containers/.gitignore
+++ b/testcases/kernel/containers/.gitignore
@@ -1 +1,2 @@
 /check_for_unshare
+mountns/mountns01
diff --git a/testcases/kernel/containers/mountns/Makefile b/testcases/kernel/containers/mountns/Makefile
new file mode 100644
index 0000000..f9b6b99
--- /dev/null
+++ b/testcases/kernel/containers/mountns/Makefile
@@ -0,0 +1,23 @@
+# Copyright (c) 2014 Red Hat, Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of version 2 the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+##############################################################################
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(abs_srcdir)/../Makefile.inc
+
+LDLIBS                  := -lclone -lltp
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
new file mode 100644
index 0000000..5932300
--- /dev/null
+++ b/testcases/kernel/containers/mountns/mountns01.c
@@ -0,0 +1,152 @@
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
+ * File: mountns01.c
+ *
+ * Tests a shared mount: shared mount can be replicated to as many
+ * mountpoints and all the replicas continue to be exactly same.
+ * Description:
+ * 1. Creates directories "A", "B" and files "A/A", "B/B"
+ * 2. Unshares mount namespace and makes it private (so mounts/umounts
+ *    have no effect on a real system)
+ * 3. Bind mounts directory "A" to "A" and "B" to "B"
+ * 4. Makes both directories ("A" and "B") shared
+ * 5. Clones a new child process with CLONE_NEWNS flag - the new child
+ *    then bind mounts directory "B" to "A"
+ * 6. Parent then checks if directory "A" contains the file "B"
+ *    (changes in child should be visible in parent as mounts were
+ *    shared):
+ *    - if it does, test passes
+ *    - if it doesn't, test fails
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
+char *TCID	= "mountns01";
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
+
+	/* checks if MS_SHARED/MS_PRIVATE/MS_REC mountflags are defined */
+	#if !defined(MS_SHARED) || !defined(MS_PRIVATE) || !defined(MS_SHARED)
+		tst_brkm(TCONF, NULL, "needed mountflags are not defined");
+	#endif
+
+	tst_tmpdir();
+	SAFE_MKDIR(cleanup, DIRA, 0777);
+	SAFE_MKDIR(cleanup, DIRB, 0777);
+	SAFE_TOUCH(cleanup, DIRA"/A", 0, NULL);
+	SAFE_TOUCH(cleanup, DIRB"/B", 0, NULL);
+}
+
+int child_func(void *arg)
+{
+	/* bind mounts DIRB to DIRA making contents of DIRB visible
+	 * in DIRA */
+	if (mount(DIRB, DIRA, "none", MS_BIND, NULL) == -1) {
+		perror("mount");
+		return 1;
+	}
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
+	/* as child shared mounts with parent, parent should also
+	 * see file "B" in DIRA; following checks if DIRA contains file "B" */
+	if (access(DIRA"/B", F_OK) != -1)
+		tst_resm(TPASS, "share mount passed");
+	else
+		tst_resm(TFAIL, "share mount failed");
+
+	umount(DIRA);
+	umount(DIRA);
+	umount(DIRB);
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
diff --git a/testcases/kernel/containers/mountns/mountns_helper.h b/testcases/kernel/containers/mountns/mountns_helper.h
new file mode 100644
index 0000000..e305028
--- /dev/null
+++ b/testcases/kernel/containers/mountns/mountns_helper.h
@@ -0,0 +1,39 @@
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
+ */
+
+#include "libclone.h"
+#include "test.h"
+#include "safe_macros.h"
+
+static int dummy_child(void *v)
+{
+	(void) v;
+	return 0;
+}
+
+static int check_newns(void)
+{
+	int pid, status;
+
+	if (tst_kvercmp(2, 4, 19) < 0)
+		tst_brkm(TCONF, NULL, "CLONE_NEWNS not supported");
+
+	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWNS, dummy_child, NULL);
+	if (pid == -1)
+		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWNS not supported");
+	SAFE_WAIT(NULL, &status);
+
+	return 0;
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
