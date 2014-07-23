Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1X9srJ-0006bW-C6
	for ltp-list@lists.sourceforge.net; Wed, 23 Jul 2014 09:29:13 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X9srH-0007bQ-Vh
	for ltp-list@lists.sourceforge.net; Wed, 23 Jul 2014 09:29:13 +0000
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Wed, 23 Jul 2014 11:28:49 +0200
Message-Id: <1406107729-29729-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <20140722165406.GA10128@rei>
References: <20140722165406.GA10128@rei>
Subject: [LTP] [PATCH v3] containers: added pidns/pidns03.c
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
Cc: metan@suse.de

* Clones a new child process with CLONE_NEWPID flag - the new child
* process mounts procfs to a "proc" directory and checks if it belongs
* to a new pid namespace by:
* 1. reading value of a symbolic link "proc/self"
* 2. comparing read value (PID) with "1"

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/kernel/containers/pidns/pidns03.c | 121 ++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 testcases/kernel/containers/pidns/pidns03.c

diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
new file mode 100644
index 0000000..ac0dcbf
--- /dev/null
+++ b/testcases/kernel/containers/pidns/pidns03.c
@@ -0,0 +1,121 @@
+/* Copyright (c) 2014 Red Hat, Inc. All rights reserved.
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
+ * File: pidns03.c
+ *
+ * Description:
+ * Clones a new child process with CLONE_NEWPID flag - the new child
+ * process mounts procfs to a "proc" directory and checks if it belongs
+ * to a new pid namespace by:
+ * 1. reading value of a symbolic link "proc/self"
+ * 2. comparing read value (PID) with "1"
+ */
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include "usctest.h"
+#include "test.h"
+#include "safe_macros.h"
+#include "libclone.h"
+
+
+#define PROCDIR "proc"
+char *TCID	= "pidns03";
+int TST_TOTAL	= 1;
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
+	tst_tmpdir();
+	SAFE_MKDIR(cleanup, PROCDIR, 0555);
+}
+
+int child_func(void *arg)
+{
+	char buf[10];
+
+	if (mount("none", PROCDIR, "proc", MS_RDONLY, NULL) == -1) {
+		perror("mount");
+		return 1;
+	}
+
+	if (readlink(PROCDIR"/self", buf, sizeof(buf)) == -1) {
+		perror("readlink");
+		return 1;
+	}
+
+	umount(PROCDIR);
+
+	/* child should have PID 1 in a new pid namespace - if true
+	 * procfs belongs to the new pid namespace */
+	if (strcmp(buf, "1")) {
+		fprintf(stderr, "%s contains: %s\n", PROCDIR"/self", buf);
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
+	if (do_clone_tests(CLONE_NEWPID, child_func, NULL, NULL, NULL) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+
+	SAFE_WAIT(cleanup, &status);
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+		tst_resm(TPASS, "mounting procfs in a new namespace");
+		return;
+	}
+
+	if (WIFSIGNALED(status)) {
+		tst_resm(TFAIL, "child was killed with signal %s",
+			 tst_strsig(WTERMSIG(status)));
+		return;
+	}
+
+	tst_resm(TFAIL, "mounting procfs in a new namespace");
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
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
