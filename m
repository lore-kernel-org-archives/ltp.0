Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1T4luP-0002Up-Du
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 04:54:13 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T4luO-0001OS-IJ
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 04:54:13 +0000
Received: by mail-pb0-f47.google.com with SMTP id wy7so2433895pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 23 Aug 2012 21:54:12 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Fri, 24 Aug 2012 12:53:34 +0800
Message-Id: <d5b65002d30380ae636535f5b7bb0a2cb7816685.1345783919.git.caspar@casparzhang.com>
In-Reply-To: <cover.1345783919.git.caspar@casparzhang.com>
References: <cover.1345783919.git.caspar@casparzhang.com>
In-Reply-To: <cover.1345783919.git.caspar@casparzhang.com>
References: <cover.1345783919.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.12"
Subject: [LTP] [PATCH v2 3/4] syscall/process_vm_writev02: new testcase
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
--------------1.7.12
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This testcase is one of the simple CMA syscalls (process_vm_readv,
process_vm_writev) tests originally written by Chris Yeoh
<yeohc@au1.ibm.com>. I made some modifications to make it match the code
style in LTP.

Test Assertion and Strategy:

    Fork two children, the first one allocates a chunk of memory and the
    other one call process_vm_writev to write known data into the first
    child. Then first child verifies that the data is as expected.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/cma/process_vm_writev02.c      | 212 +++++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_writev02.c


--------------1.7.12
Content-Type: text/x-patch;
	name="0003-syscall-process_vm_writev02-new-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0003-syscall-process_vm_writev02-new-testcase.patch"

diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
new file mode 100644
index 0000000..76dc094
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -0,0 +1,212 @@
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
+char *TCID = "process_vm_writev02";
+int TST_TOTAL = 1;
+
+#define PADDING_SIZE 10
+#define DEFAULT_CHAR 53
+
+static int sflag;
+static char *sz_opt;
+static option_t options[] = {
+	{ "s:", &sflag, &sz_opt },
+	{ NULL, NULL,   NULL }
+};
+
+static long bufsz;
+static int pipe_fd[2];
+static pid_t pids[2];
+static int semid;
+
+static void child_init_and_verify(void);
+static void child_write(void);
+static void setup(void);
+static void cleanup(void);
+static void help(void);
+
+int main(int argc, char **argv)
+{
+	int lc, status;
+	char *msg;
+
+	msg = parse_opts(argc, argv, options, &help);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		if (pipe(pipe_fd) < 0)
+			tst_brkm(TBROK|TERRNO, cleanup, "pipe");
+
+		/* the start of child_init_and_verify and child_write is
+		 * already synchronized via pipe */
+		pids[0] = fork();
+		switch (pids[0]) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork #0");
+		case 0:
+			child_init_and_verify();
+			exit(0);
+		default:
+			break;
+		}
+
+		pids[1] = fork();
+		switch (pids[1]) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork #1");
+		case 0:
+			child_write();
+			exit(0);
+		}
+
+		/* wait until child_write writes into
+		 * child_init_and_verify's VM */
+		if (waitpid(pids[1], &status, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "child 1 returns %d", status);
+
+		/* signal child_init_and_verify to verify its VM now */
+		safe_semop(semid, 0, 1);
+
+		if (waitpid(pids[0], &status, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "child 0 returns %d", status);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void child_init_and_verify(void)
+{
+	unsigned char *foo;
+	char buf[bufsz];
+	long i, nr_err;
+
+	foo = SAFE_MALLOC(tst_exit, bufsz);
+	for (i = 0; i < bufsz; i++)
+		foo[i] = DEFAULT_CHAR;
+	tst_resm(TINFO, "child 0: memory allocated.");
+
+	/* passing addr of string "foo" via pipe */
+	SAFE_CLOSE(tst_exit, pipe_fd[0]);
+	snprintf(buf, bufsz, "%p", foo);
+	SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf));
+	SAFE_CLOSE(tst_exit, pipe_fd[1]);
+
+	/* wait until child_write() is done writing to our VM */
+	safe_semop(semid, 0, -1);
+
+	nr_err = 0;
+	for (i = 0; i < bufsz; i++) {
+		if (foo[i] != i % 256) {
+#if DEBUG
+			tst_resm(TFAIL, "child 0: expected %i, got %i for "
+					"byte seq %ld",
+					i % 256, foo[i], i);
+#endif
+			nr_err++;
+		}
+	}
+	if (nr_err)
+		tst_brkm(TFAIL, tst_exit, "child 0: got %ld incorrect bytes.",
+			    nr_err);
+	else
+		tst_resm(TPASS, "child 0: all bytes are expected.");
+}
+
+static void child_write(void)
+{
+	unsigned char *lp, *rp;
+	char buf[bufsz];
+	struct iovec local, remote;
+	long i;
+
+	/* get addr from pipe */
+	SAFE_CLOSE(tst_exit, pipe_fd[1]);
+	SAFE_READ(tst_exit, 0, pipe_fd[0], buf, bufsz);
+	SAFE_CLOSE(tst_exit, pipe_fd[0]);
+	if (sscanf(buf, "%p", &rp) != 1)
+		tst_brkm(TBROK|TERRNO, tst_exit, "sscanf");
+
+	lp = SAFE_MALLOC(tst_exit, bufsz + PADDING_SIZE * 2);
+
+	for (i = 0; i < bufsz + PADDING_SIZE * 2; i++)
+		lp[i] = DEFAULT_CHAR;
+	for (i = 0; i < bufsz; i++)
+		lp[i+PADDING_SIZE] = i % 256;
+
+	local.iov_base  = lp + PADDING_SIZE;
+	local.iov_len   = bufsz;
+	remote.iov_base = rp;
+	remote.iov_len  = bufsz;
+
+	tst_resm(TINFO, "child 2: write to the same memory location.");
+	TEST(test_process_vm_writev(pids[0], &local, 1, &remote, 1, 0));
+	if (TEST_RETURN != bufsz)
+		tst_brkm(TFAIL|TERRNO, tst_exit, "process_vm_readv");
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+
+	bufsz = sflag ? SAFE_STRTOL(NULL, sz_opt, 1, LONG_MAX-PADDING_SIZE*2)
+		    : 100000;
+
+#if !defined(__NR_process_vm_readv)
+	tst_brkm(TCONF, NULL, "process_vm_writev does not exist "
+		    "on your system");
+#endif
+	semid = init_sem(1);
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	clean_sem(semid);
+	TEST_CLEANUP;
+}
+
+static void help(void)
+{
+	printf("    -s NUM  Set the size of total buffer size.\n");
+}

--------------1.7.12
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
--------------1.7.12
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.12--



