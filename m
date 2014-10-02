Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XZfW8-0006W8-Eu
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 12:29:56 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XZfW7-0004Ip-6P
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 12:29:56 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s92CTm48018388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 08:29:49 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s92CTlRv024438
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 08:29:47 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Thu,  2 Oct 2014 14:29:35 +0200
Message-Id: <1412252975-22104-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1409047170-18251-2-git-send-email-mmarhefk@redhat.com>
References: <1409047170-18251-2-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH 2/2 v3] containers: added mountns/mountns04.c
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

* Tests an unbindable mount: unbindable mount is an unbindable
  private mount

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                              |   1 +
 testcases/kernel/containers/.gitignore          |   1 +
 testcases/kernel/containers/mountns/mountns04.c | 103 ++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 testcases/kernel/containers/mountns/mountns04.c

diff --git a/runtest/containers b/runtest/containers
index 3653c9c..8e8e067 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -59,3 +59,4 @@ utstest_clone_5 utstest clone 5
 mountns01 mountns01
 mountns02 mountns02
 mountns03 mountns03
+mountns04 mountns04
diff --git a/testcases/kernel/containers/.gitignore b/testcases/kernel/containers/.gitignore
index 5b96cb9..4a98373 100644
--- a/testcases/kernel/containers/.gitignore
+++ b/testcases/kernel/containers/.gitignore
@@ -2,3 +2,4 @@
 mountns/mountns01
 mountns/mountns02
 mountns/mountns03
+mountns/mountns04
diff --git a/testcases/kernel/containers/mountns/mountns04.c b/testcases/kernel/containers/mountns/mountns04.c
new file mode 100644
index 0000000..fe80e95
--- /dev/null
+++ b/testcases/kernel/containers/mountns/mountns04.c
@@ -0,0 +1,103 @@
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
+ * File: mountns04.c
+ *
+ * Tests an unbindable mount: unbindable mount is an unbindable
+ * private mount.
+ * Description:
+ * 1. Creates directories "A", "B" and files "A/A", "B/B"
+ * 2. Unshares mount namespace and makes it private (so mounts/umounts
+ *    have no effect on a real system)
+ * 3. Bind mounts directory "A" to "A" and "B" to "B"
+ * 4. Makes directory "B" shared and directory "A" unbindable
+ * 5. Tries to bind mount unbindable "A" to "B":
+ *    - if it fails, test passes
+ *    - if it passes, test fails
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
+char *TCID	= "mountns04";
+int TST_TOTAL	= 1;
+
+
+#if defined(MS_SHARED) && defined(MS_PRIVATE) \
+    && defined(MS_REC) && defined(MS_UNBINDABLE)
+
+static void test(void)
+{
+	/* unshares the mount ns */
+	if (unshare(CLONE_NEWNS) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
+	/* makes sure mounts/umounts have no effect on a real system */
+	SAFE_MOUNT(cleanup, "none", "/", "none", MS_REC|MS_PRIVATE, NULL);
+
+	/* bind mounts DIRA to itself */
+	SAFE_MOUNT(cleanup, DIRA, DIRA, "none", MS_BIND, NULL);
+	/* bind mounts DIRB to itself */
+	SAFE_MOUNT(cleanup, DIRB, DIRB, "none", MS_BIND, NULL);
+
+	/* makes mount DIRA unbindable */
+	SAFE_MOUNT(cleanup, "none", DIRA, "none", MS_UNBINDABLE, NULL);
+	/* makes mount DIRB shared */
+	SAFE_MOUNT(cleanup, "none", DIRB, "none", MS_SHARED, NULL);
+
+	/* tries to bind mount unbindable DIRA to DIRB which should fail */
+	if (mount(DIRA, DIRB, "none", MS_BIND, NULL) == -1) {
+		tst_resm(TPASS, "unbindable mount passed");
+	} else {
+		SAFE_UMOUNT(cleanup, DIRB);
+		tst_resm(TFAIL, "unbindable mount faled");
+	}
+
+	SAFE_UMOUNT(cleanup, DIRA);
+	SAFE_UMOUNT(cleanup, DIRB);
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
