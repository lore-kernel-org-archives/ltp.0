Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VgssH-0002eC-GL
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 09:06:05 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VgssG-0006bH-9V
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 09:06:05 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rAE95t7I032576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Nov 2013 04:05:56 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id rAE95rcw002918
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Nov 2013 04:05:54 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Nov 2013 10:05:51 +0100
Message-Id: <1a7334c8ecd0ea0adb174c7c55667844d971a3f2.1384419525.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] add test for tst_checkpoint_signal_child timing out
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

This is simple test for patch which adds timeout to
tst_checkpoint_signal_child().

The test is expected to end with:
  Failed to open fifo 'tst_checkpoint_fifo' at
  tst_checkpoint_child_exits2.c:56: errno=ETIMEDOUT(110): Connection timed out

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .gitignore                              |    1 +
 lib/tests/tst_checkpoint_child_exits2.c |   62 +++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 lib/tests/tst_checkpoint_child_exits2.c

diff --git a/.gitignore b/.gitignore
index 140f5f4..dfee1ad 100644
--- a/.gitignore
+++ b/.gitignore
@@ -55,6 +55,7 @@ logfile.*
 /lib/tests/tst_tmpdir_test
 /lib/tests/tst_checkpoint_child
 /lib/tests/tst_checkpoint_child_exits
+/lib/tests/tst_checkpoint_child_exits2
 /lib/tests/tst_checkpoint_parent
 /lib/tests/tst_checkpoint_parent_exits
 /lib/tests/tst_process_state
diff --git a/lib/tests/tst_checkpoint_child_exits2.c b/lib/tests/tst_checkpoint_child_exits2.c
new file mode 100644
index 0000000..fb79145
--- /dev/null
+++ b/lib/tests/tst_checkpoint_child_exits2.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2013 Linux Test Project
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <sys/wait.h>
+
+#include "test.h"
+
+char *TCID = "tst_checkpoint_child_exits2";
+int TST_TOTAL = 1;
+
+static void cleanup(void)
+{
+	tst_rmdir();
+}
+
+int main(void)
+{
+	int pid;
+	struct tst_checkpoint checkpoint;
+
+	tst_tmpdir();
+
+	pid = fork();
+
+	switch (pid) {
+	case -1:
+		tst_brkm(TBROK | TERRNO, NULL, "Fork failed");
+		break;
+	case 0:
+		fprintf(stderr, "Child: exiting prior checkpoint init\n");
+		exit(0);
+		break;
+	default:
+		wait(NULL);
+		TST_CHECKPOINT_INIT(&checkpoint);
+		TST_CHECKPOINT_SIGNAL_CHILD(cleanup, &checkpoint);
+		fprintf(stderr, "Parent: checkpoint reached\n");
+		break;
+	}
+
+	return 0;
+}
-- 
1.7.1


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
