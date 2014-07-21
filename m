Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1X9FNt-0007JA-5D
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 15:20:13 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X9FNn-0003Ca-85
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 15:20:13 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6LFK0IL009252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Jul 2014 11:20:00 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Mon, 21 Jul 2014 17:19:38 +0200
Message-Id: <1405955978-28590-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1347769361.12788938.1405948971664.JavaMail.zimbra@redhat.com>
References: <1347769361.12788938.1405948971664.JavaMail.zimbra@redhat.com>
Subject: [LTP] [PATCH v2] containers: added pidns/pidns03.c
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

* Clones a new child process with CLONE_NEWPID flag - the new child
* process mounts procfs to a "proc2" directory and checks if it belongs
* to a new pid namespace by:
* 1. reading value of a symbolic link "proc2/self"
* 2. comparing read value (PID) with "1"

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/kernel/containers/pidns/pidns03.c | 120 ++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 testcases/kernel/containers/pidns/pidns03.c

diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
new file mode 100644
index 0000000..ad2a683
--- /dev/null
+++ b/testcases/kernel/containers/pidns/pidns03.c
@@ -0,0 +1,120 @@
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
+ * process mounts procfs to a "proc2" directory and checks if it belongs
+ * to a new pid namespace by:
+ * 1. reading value of a symbolic link "proc2/self"
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
+#define PROCDIR "proc2"
+char *TCID	= "pidns03";
+int TST_TOTAL	= 1;
+
+
+static void cleanup(void)
+{
+	umount(PROCDIR);
+	rmdir(PROCDIR);
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
+int childFunc(void *arg)
+{
+	char buf[10];
+	int result = 1;
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
+
+	/* child should have PID 1 in a new pid namespace - if true
+	 * procfs belongs to the new pid namespace */
+	if (!strcmp(buf, "1"))
+		result = 0;
+	else
+		fprintf(stderr, "%s contains: %s\n", PROCDIR"/self", buf);
+
+	return result;
+}
+
+static void test(void)
+{
+	int status;
+	int ret;
+
+	ret = do_clone_tests(CLONE_NEWPID, childFunc, NULL, NULL, NULL);
+
+	if (ret == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+	else if ((wait(&status)) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "wait failed");
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+		tst_resm(TFAIL, "mounting procfs in a new namespace");
+	else if (WIFSIGNALED(status))
+		tst_resm(TFAIL, "child was killed with signal = %d",
+			 WTERMSIG(status));
+	else
+		tst_resm(TPASS, "mounting procfs in a new namespace");
+}
+
+int main(int argc, char *argv[])
+{
+	const char *msg;
+	int lc;
+
+	if ((msg = parse_opts(argc, argv, NULL, NULL)))
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
