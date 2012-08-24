Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1T4luM-000235-LG
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 04:54:10 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T4luL-0001Om-Mw
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 04:54:10 +0000
Received: by pbcwy7 with SMTP id wy7so2433964pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 23 Aug 2012 21:54:03 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Fri, 24 Aug 2012 12:53:32 +0800
Message-Id: <8e25aa7a310f2bb74e56938796cfc8bfcfbd0e94.1345783919.git.caspar@casparzhang.com>
In-Reply-To: <cover.1345783919.git.caspar@casparzhang.com>
References: <cover.1345783919.git.caspar@casparzhang.com>
In-Reply-To: <cover.1345783919.git.caspar@casparzhang.com>
References: <cover.1345783919.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.12"
Subject: [LTP] [PATCH v2 1/4] syscall/process_vm_readv02: new testcase
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

    Fork two children, one child allocates memory and initializes it;
    then the other one calls process_vm_readv and reads from the same
    memory location, it then verifies if process_vm_readv returns
    correct data.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/cma/process_vm.h         |  47 ++++++
 testcases/kernel/syscalls/cma/process_vm_readv02.c | 172 +++++++++++++++++++++
 2 files changed, 219 insertions(+)
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_readv02.c


--------------1.7.12
Content-Type: text/x-patch;
	name="0001-syscall-process_vm_readv02-new-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscall-process_vm_readv02-new-testcase.patch"

diff --git a/testcases/kernel/syscalls/cma/process_vm.h b/testcases/kernel/syscalls/cma/process_vm.h
index 04176c9..5241fa1 100644
--- a/testcases/kernel/syscalls/cma/process_vm.h
+++ b/testcases/kernel/syscalls/cma/process_vm.h
@@ -25,10 +25,19 @@
 #ifndef _PROCESS_VM_H_
 #define _PROCESS_VM_H_
 
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/sem.h>
 #include <sys/syscall.h>
 #include <sys/uio.h>
 #include <unistd.h>
 
+union semun {
+	int val;
+	struct semid_ds *buf;
+	unsigned short int *array;
+};
+
 static inline ssize_t test_process_vm_readv(pid_t pid,
 		const struct iovec *lvec, unsigned long liovcnt,
 		const struct iovec *rvec, unsigned long riovcnt,
@@ -55,4 +64,42 @@ static inline ssize_t test_process_vm_writev(pid_t pid,
 #endif
 }
 
+void safe_semop(int id, unsigned short num, short op)
+{
+	int ret;
+	struct sembuf sem_op;
+	sem_op.sem_num = num,
+	sem_op.sem_op = op,
+	sem_op.sem_flg = 0;
+
+	do {
+		ret = semop(id, &sem_op, 1);
+	} while (ret == -1 && errno == EINTR);
+	if (ret == -1)
+		tst_brkm(TBROK|TERRNO, NULL, "semop(%d, (%d, %d)) failed",
+			id, num, op);
+}
+
+int init_sem(int num)
+{
+	int id, i;
+	union semun u;
+	if ((id = semget(IPC_PRIVATE, num, IPC_CREAT|S_IRWXU)) == -1)
+		tst_brkm(TBROK|TERRNO, NULL, "Couldn't allocate semaphore");
+
+	for (i = 0; i < num; i++) {
+		u.val = 0;
+		if (semctl(id, 0, SETVAL, u) == -1)
+			tst_brkm(TBROK|TERRNO, NULL,
+				"Couldn't initialize sem %d value", i);
+	}
+	return id;
+}
+
+void clean_sem(int id)
+{
+	if (semctl(id, 0, IPC_RMID) == -1)
+		tst_brkm(TBROK|TERRNO, NULL, "Couldn't remove sem");
+}
+
 #endif /* _PROCESS_VM_H_ */
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
new file mode 100644
index 0000000..7fac132
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -0,0 +1,172 @@
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
+static int semid;
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
+		/* the start of child_alloc and child_invoke is already
+		 * synchronized via pipe */
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
+			tst_brkm(TBROK|TERRNO, cleanup, "fork #1");
+		case 0:
+			child_invoke();
+			exit(0);
+		}
+
+		/* wait until child_invoke reads from child_alloc's VM */
+		if (waitpid(pids[1], &status, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "child 1 returns %d", status);
+
+		/* child_alloc is free to exit now */
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
+	/* wait until child_invoke is done reading from our VM */
+	safe_semop(semid, 0, -1);
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
+		tst_brkm(TFAIL|TERRNO, tst_exit, "process_vm_readv");
+	if (strncmp(lp, tst_string, len) != 0)
+		tst_brkm(TFAIL, tst_exit, "child 1: expected string: %s, "
+			    "received string: %256s", tst_string, lp);
+	else
+		tst_resm(TPASS, "expected string received.");
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+
+#if !defined(__NR_process_vm_readv)
+	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
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



