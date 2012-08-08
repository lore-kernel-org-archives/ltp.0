Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sz2Y0-0001yf-79
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:27:24 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sz2Xu-0003QZ-NU
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:27:24 +0000
Received: by pbcwy7 with SMTP id wy7so1085364pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 02:27:12 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Wed,  8 Aug 2012 17:26:54 +0800
Message-Id: <9fe539868cd8580388b98397a87e25ff1cac34bc.1344418001.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH 1/4] syscall/process_vm_readv02: new testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This testcase is one of the simple CMA syscalls (process_vm_readv,
process_vm_writev) tests originally written by Chris Yeoh
<yeohc@au1.ibm.com>. I made some modifications to make it match the code
style in LTP.

Test Assertion and Strategy:

    Fork two children, one child allocates memory and initializes it;
    then the other one calls process_vm_readv and reads from the same
    memory location, it then verifies if process_vm_readv returns
    correct data.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/syscalls/cma/process_vm_readv02.c |  162 ++++++++++++++++++++
 1 files changed, 162 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_readv02.c


--------------1.7.8.6
Content-Type: text/x-patch;
	name="0001-syscall-process_vm_readv02-new-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscall-process_vm_readv02-new-testcase.patch"

diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
new file mode 100644
index 0000000..db48312
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -0,0 +1,162 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2012
+ * Copyright (c) Linux Test Project, 2012
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "process_vm.h"
+
+char *TCID = "process_vm_readv02";
+int TST_TOTAL = 1;
+
+static char *tst_string = "THIS IS A TEST";
+static int len;
+static int pipe_fd[2];
+static pid_t pids[2];
+
+static void child_alloc(void);
+static void child_invoke(void);
+static void setup(void);
+static void cleanup(void);
+
+int main(int argc, char **argv)
+{
+	int lc, status;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		len = strlen(tst_string);
+
+		if (pipe(pipe_fd) < 0)
+			tst_brkm(TBROK|TERRNO, cleanup, "pipe");
+
+		pids[0] = fork();
+		switch (pids[0]) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork #0");
+		case 0:
+			child_alloc();
+			exit(0);
+		}
+
+		pids[1] = fork();
+		switch (pids[1]) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork #0");
+		case 0:
+			child_invoke();
+			exit(0);
+		default:
+			if (waitpid(pids[1], &status, 0) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+				tst_resm(TFAIL, "child 1 returns %d", status);
+		}
+		if (kill(pids[0], SIGCONT) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "kill");
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void child_alloc(void)
+{
+	char *foo;
+	char buf[BUFSIZ];
+
+	foo = SAFE_MALLOC(tst_exit, len + 1);
+	strncpy(foo, tst_string, len);
+	foo[len] = '\0';
+	tst_resm(TINFO, "child 0: memory allocated and initialized.");
+
+	/* passing addr of string "foo" via pipe */
+	SAFE_CLOSE(tst_exit, pipe_fd[0]);
+	snprintf(buf, BUFSIZ, "%p", foo);
+	SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf));
+	SAFE_CLOSE(tst_exit, pipe_fd[1]);
+
+	if (raise(SIGSTOP) < 0)
+		tst_brkm(TBROK|TERRNO, tst_exit, "raise");
+}
+
+static void child_invoke(void)
+{
+	char *lp, *rp;
+	char buf[BUFSIZ];
+	struct iovec local, remote;
+
+	/* get addr from pipe */
+	SAFE_CLOSE(tst_exit, pipe_fd[1]);
+	SAFE_READ(tst_exit, 0, pipe_fd[0], buf, BUFSIZ);
+	SAFE_CLOSE(tst_exit, pipe_fd[0]);
+	if (sscanf(buf, "%p", &rp) != 1)
+		tst_brkm(TBROK|TERRNO, tst_exit, "sscanf");
+
+	lp = SAFE_MALLOC(tst_exit, len + 1);
+	local.iov_base  = lp;
+	local.iov_len   = len;
+	remote.iov_base = rp;
+	remote.iov_len  = len;
+
+	tst_resm(TINFO, "child 1: reading string from same memory location.");
+	TEST(test_process_vm_readv(pids[0], &local, 1, &remote, 1, 0));
+	if (TEST_RETURN != len)
+		tst_brkm(TBROK|TERRNO, tst_exit, "process_vm_readv");
+	if (strcmp(lp, tst_string) != 0)
+		tst_brkm(TFAIL, tst_exit, "child 1: expected string: %s, "
+			    "received string: %s", tst_string, lp);
+	else
+		tst_resm(TPASS, "expected string received.");
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+
+#if !defined(__NR_process_vm_readv)
+	tst_brkm(TCONF, NULL, "process_vm_writev does not exist "
+		    "on your system");
+#endif
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}

--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



