Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1T4lzK-0002cD-BQ
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 04:59:18 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T4lzJ-0008Ln-97
	for ltp-list@lists.sourceforge.net; Fri, 24 Aug 2012 04:59:18 +0000
Received: by pbcwy7 with SMTP id wy7so2439244pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 23 Aug 2012 21:59:11 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Fri, 24 Aug 2012 12:53:33 +0800
Message-Id: <966cbc0ceb15e3e069034060d589a32188f4adac.1345783919.git.caspar@casparzhang.com>
In-Reply-To: <cover.1345783919.git.caspar@casparzhang.com>
References: <cover.1345783919.git.caspar@casparzhang.com>
In-Reply-To: <cover.1345783919.git.caspar@casparzhang.com>
References: <cover.1345783919.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.12"
Subject: [LTP] [PATCH v2 2/4] syscall/process_vm_readv03: new testcase
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

    Fork two children, one child mallocs randomly sized trunks of memory
    and initializes them; the other child calls process_vm_readv with
    the remote iovecs initialized to the original process memory
    locations and the local iovecs initialized to randomly sized and
    allocated local memory locations. The second child then verifies
    that the data copied is correct.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/cma/process_vm_readv03.c | 281 +++++++++++++++++++++
 1 file changed, 281 insertions(+)
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_readv03.c


--------------1.7.12
Content-Type: text/x-patch;
	name="0002-syscall-process_vm_readv03-new-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-syscall-process_vm_readv03-new-testcase.patch"

diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
new file mode 100644
index 0000000..25c0c07
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -0,0 +1,281 @@
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
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "process_vm.h"
+
+char *TCID = "process_vm_readv03";
+int TST_TOTAL = 1;
+
+#define NUM_LOCAL_VECS 4
+
+static int nflag, sflag;
+static char *nr_opt, *sz_opt;
+static option_t options[] = {
+	{ "n:", &nflag, &nr_opt },
+	{ "s:", &sflag, &sz_opt },
+	{ NULL, NULL,   NULL }
+};
+
+static int nr_iovecs;
+static long bufsz;
+static int pipe_fd[2];
+static pid_t pids[2];
+static int semid;
+
+static void gen_random_arr(int *arr, int arr_sz);
+static void child_alloc(int *bufsz_arr);
+static void child_invoke(int *bufsz_arr);
+static long *fetch_remote_addrs(void);
+static void setup(void);
+static void cleanup(void);
+static void help(void);
+
+int main(int argc, char **argv)
+{
+	int lc, status;
+	char *msg;
+	int *bufsz_arr;
+
+	msg = parse_opts(argc, argv, options, &help);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s"
+				"use -help", msg);
+
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+
+		if (pipe(pipe_fd) < 0)
+			tst_brkm(TBROK|TERRNO, cleanup, "pipe");
+
+		bufsz_arr = SAFE_MALLOC(cleanup, nr_iovecs * sizeof(int));
+		gen_random_arr(bufsz_arr, nr_iovecs);
+
+		/* the start of child_alloc and child_invoke is already
+		 * synchronized via pipe */
+		pids[0] = fork();
+		switch (pids[0]) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork #0");
+		case 0:
+			child_alloc(bufsz_arr);
+			exit(0);
+		}
+
+		pids[1] = fork();
+		switch (pids[1]) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork #1");
+		case 0:
+			child_invoke(bufsz_arr);
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
+
+		free(bufsz_arr);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void gen_random_arr(int *arr, int arr_sz)
+{
+	long bufsz_left, bufsz_single;
+	int i;
+
+	bufsz_left = bufsz;
+	for (i = 0; i < arr_sz - 1; i++) {
+		bufsz_single = rand() % (bufsz_left / 2) + 1;
+		arr[i] = bufsz_single;
+		bufsz_left -= bufsz_single;
+	}
+	arr[arr_sz-1] = bufsz_left;
+}
+
+static void child_alloc(int *bufsz_arr)
+{
+	char **foo;
+	int i, j;
+	char buf[BUFSIZ];
+	long count;
+
+	foo = SAFE_MALLOC(tst_exit, nr_iovecs * sizeof(char *));
+
+	count = 0;
+	for (i = 0; i < nr_iovecs; i++) {
+		foo[i] = SAFE_MALLOC(tst_exit, bufsz_arr[i]);
+		for (j = 0; j < bufsz_arr[i]; j++) {
+			foo[i][j] = count % 256;
+			count++;
+		}
+	}
+	tst_resm(TINFO, "child 0: %d iovecs allocated and initialized.",
+		    nr_iovecs);
+
+	/* passing addr via pipe */
+	SAFE_CLOSE(tst_exit, pipe_fd[0]);
+	snprintf(buf, BUFSIZ, "%p", (void *)foo);
+	SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf));
+	SAFE_CLOSE(tst_exit, pipe_fd[1]);
+
+	/* wait until child_invoke is done reading from our VM */
+	safe_semop(semid, 0, -1);
+}
+
+static long *fetch_remote_addrs(void)
+{
+	long *foo, *bar;
+	char buf[BUFSIZ];
+	long len;
+	struct iovec local, remote;
+
+	/* get addr from pipe */
+	SAFE_CLOSE(tst_exit, pipe_fd[1]);
+	SAFE_READ(tst_exit, 0, pipe_fd[0], buf, BUFSIZ);
+	SAFE_CLOSE(tst_exit, pipe_fd[0]);
+	if (sscanf(buf, "%p", &foo) != 1)
+		tst_brkm(TBROK|TERRNO, tst_exit, "sscanf");
+
+	len = nr_iovecs * sizeof(long);
+	bar = SAFE_MALLOC(tst_exit, len);
+	local.iov_base  = bar;
+	local.iov_len   = len;
+	remote.iov_base = foo;
+	remote.iov_len  = len;
+
+	TEST(test_process_vm_readv(pids[0], &local, 1, &remote, 1, 0));
+	if (TEST_RETURN != len)
+		tst_brkm(TFAIL|TERRNO, tst_exit, "process_vm_readv");
+
+	return local.iov_base;
+}
+
+static void child_invoke(int *bufsz_arr)
+{
+	int i, j, count, nr_error;
+	unsigned char expect, actual;
+	long *addrs;
+	struct iovec local[NUM_LOCAL_VECS], *remote;
+	int rcv_arr[NUM_LOCAL_VECS];
+
+	addrs = fetch_remote_addrs();
+
+	remote = SAFE_MALLOC(tst_exit, nr_iovecs * sizeof(struct iovec));
+	for (i = 0; i < nr_iovecs; i++) {
+		remote[i].iov_base = (void *)addrs[i];
+		remote[i].iov_len  = bufsz_arr[i];
+	}
+	tst_resm(TINFO, "child 1: %d remote iovecs received.", nr_iovecs);
+
+	gen_random_arr(rcv_arr, NUM_LOCAL_VECS);
+	for (i = 0; i < NUM_LOCAL_VECS; i++) {
+		local[i].iov_base = SAFE_MALLOC(tst_exit, rcv_arr[i]);
+		local[i].iov_len  = rcv_arr[i];
+	}
+	tst_resm(TINFO, "child 1: %d local iovecs initialized.",
+		    NUM_LOCAL_VECS);
+
+	TEST(test_process_vm_readv(pids[0], local, NUM_LOCAL_VECS,
+		    remote, nr_iovecs, 0));
+	if (TEST_RETURN != bufsz)
+		tst_brkm(TBROK|TERRNO, tst_exit, "process_vm_readv");
+
+	/* verify every byte */
+	count = 0;
+	nr_error = 0;
+	for (i = 0; i < NUM_LOCAL_VECS; i++) {
+		for (j = 0; j < local[i].iov_len; j++) {
+			expect = count % 256;
+			actual = ((unsigned char *)local[i].iov_base)[j];
+			if (expect != actual) {
+#if DEBUG
+				tst_resm(TFAIL, "child 1: expected %i, got %i "
+						"for byte seq %d",
+						expect, actual, count);
+#endif
+				nr_error++;
+			}
+			count++;
+		}
+	}
+	if (nr_error)
+		tst_brkm(TFAIL, tst_exit, "child 1: %d incorrect bytes "
+				"received.", nr_error);
+	else
+		tst_resm(TPASS, "child 1: all bytes are correctly received.");
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+
+	nr_iovecs = nflag ? SAFE_STRTOL(NULL, nr_opt, 1, IOV_MAX) : 10;
+	bufsz = sflag ? SAFE_STRTOL(NULL, sz_opt, NUM_LOCAL_VECS, LONG_MAX)
+		    : 100000;
+
+#if !defined(__NR_process_vm_readv)
+	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
+		    "on your system");
+#endif
+	semid = init_sem(1);
+	srand(time(NULL));
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
+	printf("    -n NUM  Set the number of iovecs to be allocated.\n");
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



