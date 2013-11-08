Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VekzM-0007Zo-7j
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 12:16:36 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VekzI-0005MO-Px
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 12:16:36 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA8CGQhv023180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 12:16:26 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA8CGPkZ003486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 12:16:26 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA8CGP3h025744
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 12:16:25 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri,  8 Nov 2013 16:16:18 +0400
Message-Id: <1383912978-15159-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <527B7226.5090809@oracle.com>
References: <527B7226.5090809@oracle.com>
Subject: [LTP] [PATCH V2 2/2] msgctl{08, 09, 10, 11}: cleanup
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
Cc: vasily.isaenko@oracle.com

 * Moved common functions, definitions to libmsgctl.h, libmsgctl.c.
 * Changed tst_* in the children with printf + exit (or return).
 * Some cleanup.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/ipc/msgctl/Makefile    |   15 +
 testcases/kernel/syscalls/ipc/msgctl/libmsgctl.c |  148 +++++++++
 testcases/kernel/syscalls/ipc/msgctl/libmsgctl.h |   39 +++
 testcases/kernel/syscalls/ipc/msgctl/msgctl08.c  |  281 +++++-------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl09.c  |  348 ++++++----------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl10.c  |  282 +++++-------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c  |  339 +++++----------------
 7 files changed, 518 insertions(+), 934 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/msgctl/libmsgctl.c
 create mode 100644 testcases/kernel/syscalls/ipc/msgctl/libmsgctl.h

diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
index f467389..aedfda6 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
@@ -19,5 +19,20 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
+
+LIBSRCS := libmsgctl.c
+INTERNAL_LIB := libmsgctl.a
+
+LDFLAGS += -L$(abs_builddir)
+LDLIBS += -lmsgctl
+
+MAKE_TARGETS := $(patsubst %.c,%,$(wildcard msgctl??.c))
+MAKE_TARGET_OBJS := $(addsuffix .o,$(MAKE_TARGETS))
+
+$(MAKE_TARGET_OBJS): $(INTERNAL_LIB)
+
+.INTERMEDIATE: $(MAKE_TARGET_OBJS)
+
 include $(abs_srcdir)/../Makefile.inc
+include $(top_srcdir)/include/mk/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgctl/libmsgctl.c b/testcases/kernel/syscalls/ipc/msgctl/libmsgctl.c
new file mode 100644
index 0000000..fa77b56
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgctl/libmsgctl.c
@@ -0,0 +1,148 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include "libmsgctl.h"
+
+int doreader(long key, int tid, long type, int child, int nreps)
+{
+	int i, size;
+	int id;
+	struct mbuffer buffer;
+
+	id = msgget(key, 0);
+	if (id < 0) {
+		printf("msgget() error in the reader of child group %d: %s\n",
+			child, strerror(errno));
+
+		return FAIL;
+	}
+	if (id != tid) {
+		printf("Message queue mismatch in the reader of child group %d for message queue id %d\n",
+			child, id);
+
+		return FAIL;
+	}
+	for (i = 0; i < nreps; i++) {
+		memset(&buffer, 0, sizeof(buffer));
+
+		size = msgrcv(id, &buffer, 100, type, 0);
+		if (size < 0) {
+			printf("msgrcv() error in child %d, read # = %d: %s\n",
+				child, (i + 1), strerror(errno));
+
+			return FAIL;
+		}
+		if (buffer.type != type) {
+			printf("Type mismatch in child %d, read #d = %d: ",
+				child, (i + 1));
+			printf("for message got %ld, expected - %ld\n",
+				buffer.type, type);
+
+			return FAIL;
+		}
+		if (buffer.data.len + 1 != size) {
+			printf("Size mismatch in child %d, read # = %d: ",
+				child, (i + 1));
+			printf("for message got %d, expected - %d\n",
+				buffer.data.len + 1, size);
+
+			return FAIL;
+		}
+		if (verify(buffer.data.pbytes, (key % 255), size - 1, child)) {
+			printf("Verify failed in child %d read # = %d, key = %lx\n",
+				child, (i + 1), key);
+
+			return FAIL;
+		}
+		key++;
+	}
+	return PASS;
+}
+
+int dowriter(long key, int tid, long type, int child, int nreps)
+{
+	int i, size;
+	int id;
+	struct mbuffer buffer;
+
+	id = msgget(key, 0);
+	if (id < 0) {
+		printf("msgget() error in the writer of child group %d: %s\n",
+			child, strerror(errno));
+
+		return FAIL;
+	}
+	if (id != tid) {
+		printf("Message queue mismatch in the reader of child group %d for message queue id %d\n",
+			child, id);
+
+		return FAIL;
+	}
+
+	for (i = 0; i < nreps; i++) {
+		memset(&buffer, 0, sizeof(buffer));
+
+		do {
+			size = (lrand48() % 99);
+		} while (size == 0);
+		fill_buffer(buffer.data.pbytes, (key % 255), size);
+		buffer.data.len = size;
+		buffer.type = type;
+		if (msgsnd(id, &buffer, size + 1, 0) < 0) {
+			printf("msgsnd() error in child %d, write # = %d, key = %lx: %s\n",
+				child, nreps, key, strerror(errno));
+
+			return FAIL;
+		}
+		key++;
+	}
+	return PASS;
+}
+
+int fill_buffer(char *buf, char val, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		buf[i] = val;
+	return 0;
+}
+
+/* Check a buffer for correct values */
+int verify(char *buf, char val, int size, int child)
+{
+	while (size-- > 0) {
+		if (*buf++ != val) {
+			printf("Verify error in child %d, *buf = %x, val = %x, size = %d\n",
+				child, *buf, val, size);
+
+			return FAIL;
+		}
+	}
+	return PASS;
+}
+
diff --git a/testcases/kernel/syscalls/ipc/msgctl/libmsgctl.h b/testcases/kernel/syscalls/ipc/msgctl/libmsgctl.h
new file mode 100644
index 0000000..e1afeab
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgctl/libmsgctl.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __LIBMSGCTL_H__
+#define __LIBMSGCTL_H__
+
+#define FAIL	1
+#define PASS	0
+
+struct mbuffer {
+	long type;
+	struct {
+		char len;
+		char pbytes[99];
+	} data;
+};
+
+int doreader(long key, int tid, long type, int child, int nreps);
+int dowriter(long key, int tid, long type, int child, int nreps);
+int fill_buffer(char *buf, char val, int size);
+int verify(char *buf, char val, int size, int child);
+
+#endif /*__LIBMSGCTL_H__ */
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
index f733946..cf2892a 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
@@ -1,37 +1,26 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * 06/30/2001   Port to Linux   nsharoff@us.ibm.com
+ * 11/06/2002   Port to LTP     dbarrera@us.ibm.com
  */
 
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-/* 11/06/2002   Port to LTP     dbarrera@us.ibm.com */
-
 /*
- * NAME
- *	msgctl08
- *
- * CALLS
- *	msgget(2) msgctl(2)
- *
- * ALGORITHM
- *	Get and manipulate a message queue.
- *
- * RESTRICTIONS
- *
+ * Get and manipulate a message queue.
  */
 
 #define _XOPEN_SOURCE 500
@@ -51,17 +40,10 @@
 #include "test.h"
 #include "usctest.h"
 #include "ipcmsg.h"
+#include "libmsgctl.h"
 
-void setup();
-void cleanup();
-/*
- *  *  *  * These globals must be defined in the test.
- *   *   *   */
-
-char *TCID = "msgctl08";	/* Test program identifier.    */
-int TST_TOTAL = 1;		/* Total number of test cases. */
-
-int exp_enos[] = { 0 };		/* List must end with 0 */
+char *TCID = "msgctl08";
+int TST_TOTAL = 1;
 
 #ifndef CONFIG_COLDFIRE
 #define MAXNPROCS	1000000	/* This value is set to an arbitrary high limit. */
@@ -69,48 +51,34 @@ int exp_enos[] = { 0 };		/* List must end with 0 */
 #define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
 #endif
 #define MAXNREPS	100000
-#define FAIL		1
-#define PASS		0
-
-key_t keyarray[MAXNPROCS];
-
-struct {
-	long type;
-	struct {
-		char len;
-		char pbytes[99];
-	} data;
-} buffer;
-
-int pidarray[MAXNPROCS];
-int tid;
-int MSGMNI, nprocs, nreps;
-int procstat;
-int dotest(key_t key, int child_process);
-int doreader(int id, long key, int child);
-int dowriter(int id, long key, int child);
-int fill_buffer(register char *buf, char val, register int size);
-int verify(register char *buf, char val, register int size, int child);
-void sig_handler();		/* signal catching function */
-int mykid;
+
+static key_t keyarray[MAXNPROCS];
+static int pidarray[MAXNPROCS];
+static int tid;
+static int MSGMNI, nprocs, nreps;
+static int procstat;
+static int mykid;
+
+void setup(void);
+void cleanup(void);
+
+static int dotest(key_t key, int child_process);
+static void sig_handler();		/* signal catching function */
+
 #ifdef UCLINUX
 static char *argv0;
-
-void do_child_1_uclinux();
 static key_t key_uclinux;
 static int i_uclinux;
-
-void do_child_2_uclinux();
 static int id_uclinux;
 static int child_process_uclinux;
+
+static void do_child_1_uclinux(void);
+static void do_child_2_uclinux(void);
 #endif
 
-/*-----------------------------------------------------------------*/
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char **argv)
 {
-	register int i, j, ok, pid;
+	int i, j, ok, pid;
 	int count, status;
 	struct sigaction act;
 
@@ -162,7 +130,7 @@ char *argv[];
 	srand(getpid());
 	tid = -1;
 
-	/* Setup signal handleing routine */
+	/* Setup signal handling routine */
 	memset(&act, 0, sizeof(act));
 	act.sa_handler = sig_handler;
 	sigemptyset(&act.sa_mask);
@@ -255,190 +223,94 @@ char *argv[];
 
 }
 
-/*--------------------------------------------------------------------*/
-
 #ifdef UCLINUX
-void do_child_1_uclinux()
+static void do_child_1_uclinux(void)
 {
 	procstat = 1;
 	exit(dotest(key_uclinux, i_uclinux));
 }
 
-void do_child_2_uclinux()
+static void do_child_2_uclinux(void)
 {
-	exit(doreader(id_uclinux, key_uclinux % 255, child_process_uclinux));
+	exit(doreader(key_uclinux, id_uclinux, 1,
+			child_process_uclinux, nreps));
 }
 #endif
 
-int dotest(key, child_process)
-key_t key;
-int child_process;
+static int dotest(key_t key, int child_process)
 {
 	int id, pid;
+	int ret, status;
 
 	sighold(SIGTERM);
 	TEST(msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR));
 	if (TEST_RETURN < 0) {
-		tst_resm(TFAIL | TTERRNO, "Msgget error in child %d",
-			 child_process);
-		tst_exit();
+		printf("msgget() error in child %d: %s\n",
+			child_process, strerror(TEST_ERRNO));
+
+		return FAIL;
 	}
 	tid = id = TEST_RETURN;
 	sigrelse(SIGTERM);
 
 	fflush(stdout);
 	if ((pid = FORK_OR_VFORK()) < 0) {
-		tst_resm(TWARN, "\tFork failed (may be OK if under stress)");
+		printf("\tFork failed (may be OK if under stress)\n");
 		TEST(msgctl(tid, IPC_RMID, 0));
 		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL | TTERRNO, "Msgctl error in cleanup");
+			printf("mscgtl() error in cleanup: %s\n",
+				strerror(TEST_ERRNO));
 		}
-		tst_exit();
+		return FAIL;
 	}
 	/* Child does this */
 	if (pid == 0) {
 #ifdef UCLINUX
 		if (self_exec(argv0, "nddd", 2, id, key, child_process) < 0) {
-			tst_resm(TWARN, "self_exec failed");
+			printf("self_exec failed\n");
 			TEST(msgctl(tid, IPC_RMID, 0));
 			if (TEST_RETURN < 0) {
-				tst_resm(TFAIL | TTERRNO,
-					 "Msgctl error in cleanup");
+				printf("msgctl() error in cleanup: %s\n",
+					strerror(errno));
 			}
-			tst_exit();
+			return FAIL;
 		}
 #else
-		exit(doreader(id, key % 255, child_process));
+		exit(doreader(key, id, 1, child_process, nreps));
 #endif
 	}
 	/* Parent does this */
 	mykid = pid;
 	procstat = 2;
-	dowriter(id, key % 255, child_process);
-	wait(0);
-	TEST(msgctl(id, IPC_RMID, 0));
-	if (TEST_RETURN < 0) {
-		tst_resm(TFAIL, "msgctl errno %d", TEST_ERRNO);
-		tst_exit();
-	}
-	exit(PASS);
-}
-
-int doreader(id, key, child)
-int id, child;
-long key;
-{
-	int i, size;
-
-	for (i = 0; i < nreps; i++) {
-		if ((size = msgrcv(id, &buffer, 100, 0, 0)) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "Msgrcv error in child %d, read # = %d",
-				 (i + 1), child);
-			tst_exit();
-		}
-		if (buffer.data.len + 1 != size) {
-			tst_resm(TFAIL,
-				 "Size mismatch in child %d, read # = %d",
-				 child, (i + 1));
-			tst_resm(TFAIL,
-				 "for message size got  %d expected  %d",
-				 size, buffer.data.len);
-			tst_exit();
-		}
-		if (verify(buffer.data.pbytes, key, size - 1, child)) {
-			tst_resm(TFAIL, "in child %d read # = %d,key =  %lx",
-				 child, (i + 1), key);
-			tst_exit();
-		}
-		key++;
-	}
-	return (0);
-}
-
-int dowriter(id, key, child)
-int id, child;
-long key;
-{
-	int i, size;
-
-	for (i = 0; i < nreps; i++) {
-		do {
-			size = (rand() % 99);
-		} while (size == 0);
-		fill_buffer(buffer.data.pbytes, key, size);
-		buffer.data.len = size;
-		buffer.type = 1;
-		TEST(msgsnd(id, &buffer, size + 1, 0));
-		if (TEST_RETURN < 0) {
-			tst_brkm(TBROK | TTERRNO, cleanup,
-				 "Msgsnd error in child %d, key =   %lx",
-				 child, key);
-		}
-		key++;
-	}
-	return (0);
-}
+	ret = dowriter(key, id, 1, child_process, nreps);
+	wait(&status);
 
-int fill_buffer(buf, val, size)
-register char *buf;
-char val;
-register int size;
-{
-	register int i;
-
-	for (i = 0; i < size; i++) {
-		buf[i] = val;
-	}
+	if (ret != PASS)
+		exit(FAIL);
 
-	return (0);
-}
+	if ((!WIFEXITED(status) || (WEXITSTATUS(status) != PASS)))
+		exit(FAIL);
 
-/*
- * verify()
- *	Check a buffer for correct values.
- */
+	TEST(msgctl(id, IPC_RMID, 0));
+	if (TEST_RETURN < 0) {
+		printf("msgctl() errno %d: %s\n",
+			TEST_ERRNO, strerror(TEST_ERRNO));
 
-int verify(buf, val, size, child)
-register char *buf;
-char val;
-register int size;
-int child;
-{
-	while (size-- > 0) {
-		if (*buf++ != val) {
-			tst_resm(TWARN,
-				 "Verify error in child %d, *buf = %x, val = %x, size = %d",
-				 child, *buf, val, size);
-			return (FAIL);
-		}
+		return FAIL;
 	}
-	return (PASS);
+	return PASS;
 }
 
-/*
- *  * void
- *  * sig_handler() - signal catching function for 'SIGUSR1' signal.
- *  *
- *  *   This is a null function and used only to catch the above signal
- *  *   generated in parent process.
- *  */
-void sig_handler()
+static void sig_handler(void)
 {
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- *****************************************************************/
-void setup()
+void setup(void)
 {
 	int nr_msgqs;
 
 	tst_tmpdir();
 
-	/* You will want to enable some signal handling so you can capture
-	 * unexpected signals like SIGSEGV.
-	 */
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
@@ -466,11 +338,7 @@ void setup()
 	MSGMNI = min(nr_msgqs, NR_MSGQUEUES);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- ****************************************************************/
-void cleanup()
+void cleanup(void)
 {
 	int status;
 	/*
@@ -488,10 +356,7 @@ void cleanup()
 	}
 
 	fflush(stdout);
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
+
 	TEST_CLEANUP;
 	tst_rmdir();
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
index bec852a..c019226 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
@@ -1,37 +1,26 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * 06/30/2001   Port to Linux   nsharoff@us.ibm.com
+ * 11/11/2002   Port to LTP     dbarrera@us.ibm.com
  */
 
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-/* 11/11/2002   Port to LTP     dbarrera@us.ibm.com */
-
 /*
- * NAME
- *	msgctl09
- *
- * CALLS
- *	msgget(2) msgctl(2) msgop(2)
- *
- * ALGORITHM
- *	Get and manipulate a message queue.
- *
- * RESTRICTIONS
- *
+ * Get and manipulate a message queue.
  */
 
 #define _XOPEN_SOURCE 500
@@ -49,6 +38,10 @@
 #include "test.h"
 #include "usctest.h"
 #include "ipcmsg.h"
+#include "libmsgctl.h"
+
+char *TCID = "msgctl09";
+int TST_TOTAL = 1;
 
 #define MAXNREPS	1000
 #ifndef CONFIG_COLDFIRE
@@ -57,65 +50,39 @@
 #define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
 #endif
 #define MAXNKIDS	10
-#define FAIL		1
-#define PASS		0
 
-int dotest(key_t, int);
-int doreader(long, int, int);
-int dowriter(long, int, int);
-int fill_buffer(char *, char, int);
-int verify(char *, char, int, int);
-void setup();
-void cleanup();
+static key_t keyarray[MAXNPROCS];
+static int pidarray[MAXNPROCS];
+static int rkidarray[MAXNKIDS];
+static int wkidarray[MAXNKIDS];
+static int tid;
+static int nprocs, nreps, nkids, MSGMNI;
+static int procstat;
+
+void setup(void);
+void cleanup(void);
+
+static void term(int);
+static int dotest(key_t, int);
+static void cleanup_msgqueue(int i, int tid);
 
-/*
- * These globals must be defined in the test.
- * */
-
-char *TCID = "msgctl09";	/* Test program identifier.    */
-int TST_TOTAL = 1;		/* Total number of test cases. */
-
-int exp_enos[] = { 0 };		/* List must end with 0 */
-
-key_t keyarray[MAXNPROCS];
-
-struct {
-	long type;
-	struct {
-		char len;
-		char pbytes[99];
-	} data;
-} buffer;
-
-int pidarray[MAXNPROCS];
-int rkidarray[MAXNKIDS];
-int wkidarray[MAXNKIDS];
-int tid;
-int nprocs, nreps, nkids, MSGMNI;
-int procstat;
-void term(int);
 #ifdef UCLINUX
 static char *argv0;
-
-void do_child_1_uclinux();
 static key_t key_uclinux;
 static int i_uclinux;
-
-void do_child_2_uclinux();
 static int pid_uclinux;
 static int child_process_uclinux;
-
-void do_child_3_uclinux();
 static int rkid_uclinux;
+
+
+static void do_child_1_uclinux(void);
+static void do_child_2_uclinux(void);
+static void do_child_3_uclinux(void);
 #endif
-void cleanup_msgqueue(int i, int tid);
 
-/*-----------------------------------------------------------------*/
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char **argv)
 {
-	register int i, j, ok, pid;
+	int i, j, ok, pid;
 	int count, status;
 
 #ifdef UCLINUX
@@ -205,7 +172,6 @@ char *argv[];
 			}
 		} while (ok == 0);
 	}
-/*-----------------------------------------------------------------*/
 	/* Fork a number of processes (nprocs), each of which will
 	 * create a message queue with several (nkids) reader/writer
 	 * pairs which will read and write a number (iterations)
@@ -268,29 +234,29 @@ char *argv[];
 
 }
 
-/*--------------------------------------------------------------------*/
-
 #ifdef UCLINUX
-void do_child_1_uclinux()
+static void do_child_1_uclinux(void)
 {
 	procstat = 1;
 	exit(dotest(key_uclinux, i_uclinux));
 }
 
-void do_child_2_uclinux()
+static void do_child_2_uclinux(void)
 {
 	procstat = 2;
-	exit(doreader(key_uclinux, pid_uclinux, child_process_uclinux));
+	exit(doreader(key_uclinux, tid, pid_uclinux,
+			child_process_uclinux, nreps));
 }
 
-void do_child_3_uclinux()
+static void do_child_3_uclinux(void)
 {
 	procstat = 2;
-	exit(dowriter(key_uclinux, rkid_uclinux, child_process_uclinux));
+	exit(dowriter(key_uclinux, tid, rkid_uclinux,
+			child_process_uclinux, nreps));
 }
 #endif
 
-void cleanup_msgqueue(int i, int tid)
+static void cleanup_msgqueue(int i, int tid)
 {
 	/*
 	 * Decrease the value of i by 1 because it
@@ -313,18 +279,16 @@ void cleanup_msgqueue(int i, int tid)
 	}
 }
 
-int dotest(key, child_process)
-key_t key;
-int child_process;
+static int dotest(key_t key, int child_process)
 {
 	int id, pid;
 	int i, count, status, exit_status;
 
 	sighold(SIGTERM);
 	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
-		tst_resm(TFAIL | TERRNO, "Msgget error in child %d",
-			 child_process);
-		tst_exit();
+		printf("msgget() error in child %d: %s\n",
+			child_process, strerror(errno));
+		return FAIL;
 	}
 	tid = id;
 	sigrelse(SIGTERM);
@@ -334,58 +298,58 @@ int child_process;
 	for (i = 0; i < nkids; i++) {
 		fflush(stdout);
 		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_resm(TWARN,
-				 "Fork failure in first child of child group %d",
-				 child_process);
+			printf("Fork failure in the first child of child group %d\n",
+				child_process);
 			cleanup_msgqueue(i, tid);
-			tst_exit();
+			return FAIL;
 		}
 		/* First child does this */
 		if (pid == 0) {
 #ifdef UCLINUX
 			if (self_exec(argv0, "nddd", 2, key, getpid(),
 				      child_process) < 0) {
-				tst_resm(TWARN, "self_exec failed");
+				printf("self_exec failed\n");
 				cleanup_msgqueue(i, tid);
-				tst_exit();
+				return FAIL;
 			}
 #else
 			procstat = 2;
-			exit(doreader(key, getpid(), child_process));
+			exit(doreader(key, tid, getpid(),
+					child_process, nreps));
 #endif
 		}
 		rkidarray[i] = pid;
 		fflush(stdout);
 		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_resm(TWARN,
-				 "Fork failure in first child of child group %d",
-				 child_process);
+			printf("Fork failure in the second child of child group %d\n",
+				child_process);
 			/*
 			 * Kill the reader child process
 			 */
 			(void)kill(rkidarray[i], SIGKILL);
 
 			cleanup_msgqueue(i, tid);
-			tst_exit();
+			return FAIL;
 		}
 		/* Second child does this */
 		if (pid == 0) {
 #ifdef UCLINUX
 			if (self_exec(argv0, "nddd", 3, key, rkidarray[i],
 				      child_process) < 0) {
-				tst_resm(TWARN, "\tFork failure in first child "
-					 "of child group %d \n", child_process);
+				printf("\tFork failure in the first child of child group %d\n",
+					child_process);
 				/*
 				 * Kill the reader child process
 				 */
 				(void)kill(rkidarray[i], SIGKILL);
 
 				cleanup_msgqueue(i, tid);
-				tst_exit();
+				return FAIL;
 			}
 #else
 			procstat = 2;
-			exit(dowriter(key, rkidarray[i], child_process));
+			exit(dowriter(key, tid, rkidarray[i],
+					child_process, nreps));
 #endif
 		}
 		wkidarray[i] = pid;
@@ -395,18 +359,17 @@ int child_process;
 	while (1) {
 		if ((wait(&status)) > 0) {
 			if (status >> 8 != PASS) {
-				tst_resm(TFAIL,
-					 "Child exit status = %d from child group %d",
-					 status >> 8, child_process);
+				printf("Child exit status = %d from child group %d\n",
+					status >> 8, child_process);
 				for (i = 0; i < nkids; i++) {
 					kill(rkidarray[i], SIGTERM);
 					kill(wkidarray[i], SIGTERM);
 				}
 				if (msgctl(tid, IPC_RMID, 0) < 0) {
-					tst_resm(TFAIL | TERRNO,
-						 "Msgctl error");
+					printf("msgctl() error: %s\n",
+						strerror(errno));
 				}
-				tst_exit();
+				return FAIL;
 			}
 			count++;
 		} else {
@@ -417,146 +380,23 @@ int child_process;
 	}
 	/* Make sure proper number of children exited */
 	if (count != (nkids * 2)) {
-		tst_resm(TFAIL,
-			 "Wrong number of children exited in child group %d, Saw %d Expected %d",
-			 child_process, count, (nkids * 2));
+		printf("Wrong number of children exited in child group %d, saw %d, expected %d\n",
+			child_process, count, (nkids * 2));
 		if (msgctl(tid, IPC_RMID, 0) < 0) {
-			tst_resm(TFAIL | TERRNO, "Msgctl error");
+			printf("msgctl() error: %s\n", strerror(errno));
 		}
-		tst_exit();
+		return FAIL;
 	}
 	if (msgctl(id, IPC_RMID, 0) < 0) {
-		tst_resm(TFAIL | TERRNO, "Msgctl failure in child group %d",
-			 child_process);
-		tst_exit();
-	}
-	exit(exit_status);
-}
-
-int doreader(key, type, child)
-int type, child;
-long key;
-{
-	int i, size;
-	int id;
-
-	if ((id = msgget(key, 0)) < 0) {
-		tst_resm(TFAIL | TERRNO,
-			 "Msgget error in reader of child group %d", child);
-		tst_exit();
-	}
-	if (id != tid) {
-		tst_resm(TFAIL,
-			 "Message queue mismatch in reader of child group %d for message queue id %d",
-			 child, id);
-		tst_exit();
-	}
-	for (i = 0; i < nreps; i++) {
-		if ((size = msgrcv(id, &buffer, 100, type, 0)) < 0) {
-			tst_resm(TFAIL | TERRNO,
-				 "Msgrcv error in child %d, read # = %d",
-				 (i + 1), child);
-			tst_exit();
-		}
-		if (buffer.type != type) {
-			tst_resm(TFAIL,
-				 "Size mismatch in child %d, read # = %d",
-				 child, (i + 1));
-			tst_resm(TFAIL,
-				 "\tfor message size got  %d expected  %d",
-				 size, buffer.data.len);
-			tst_exit();
-		}
-		if (buffer.data.len + 1 != size) {
-			tst_resm(TFAIL,
-				 "Size mismatch in child %d, read # = %d, size = %d, expected = %d",
-				 child, (i + 1), buffer.data.len, size);
-			tst_exit();
-		}
-		if (verify(buffer.data.pbytes, (key % 255), size - 1, child)) {
-			tst_resm(TFAIL, "in child %d read # = %d,key =  %lx",
-				 child, (i + 1), key);
-			tst_exit();
-		}
-		key++;
-	}
-	exit(PASS);
-}
-
-int dowriter(key, type, child)
-int type, child;
-long key;
-{
-	int i, size;
-	int id;
-
-	if ((id = msgget(key, 0)) < 0) {
-		tst_resm(TFAIL | TERRNO,
-			 "Msgget error in writer of child group %d", child);
-		tst_exit();
-	}
-	if (id != tid) {
-		tst_resm(TFAIL,
-			 "Message queue mismatch in writer of child group %d",
-			 child);
-		tst_resm(TFAIL, "\tfor message queue id %d expected  %d", id,
-			 tid);
-		tst_exit();
-	}
-
-	for (i = 0; i < nreps; i++) {
-		do {
-			size = (lrand48() % 99);
-		} while (size == 0);
-		fill_buffer(buffer.data.pbytes, (key % 255), size);
-		buffer.data.len = size;
-		buffer.type = type;
-		if (msgsnd(id, &buffer, size + 1, 0) < 0) {
-			tst_resm(TFAIL | TERRNO,
-				 "Msgsnd error in child %d, key =   %lx",
-				 child, key);
-			tst_exit();
-		}
-		key++;
+		printf("msgctl() failure in child group %d: %s\n",
+			child_process, strerror(errno));
+		return FAIL;
 	}
-	exit(PASS);
-}
-
-int fill_buffer(buf, val, size)
-register char *buf;
-char val;
-register int size;
-{
-	register int i;
-
-	for (i = 0; i < size; i++)
-		buf[i] = val;
-	return 0;
-}
-
-/*
- * verify()
- *	Check a buffer for correct values.
- */
-
-int verify(buf, val, size, child)
-register char *buf;
-char val;
-register int size;
-int child;
-{
-	while (size-- > 0)
-		if (*buf++ != val) {
-			tst_resm(TWARN,
-				 "Verify error in child %d, *buf = %x, val = %x, size = %d",
-				 child, *buf, val, size);
-			return (FAIL);
-		}
-	return (PASS);
+	return exit_status;
 }
 
 /* ARGSUSED */
-void term(int sig)
+static void term(int sig)
 {
 	int i;
 
@@ -567,9 +407,8 @@ void term(int sig)
 		for (i = 0; i < nprocs; i++) {
 			if (pidarray[i] > 0) {
 				if (kill(pidarray[i], SIGTERM) < 0) {
-					tst_resm(TBROK,
-						 "Kill failed to kill child %d",
-						 i);
+					printf("Kill failed to kill child %d",
+						i);
 					exit(FAIL);
 				}
 			}
@@ -593,17 +432,12 @@ void term(int sig)
 	}
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- *****************************************************************/
-void setup()
+void setup(void)
 {
 	int nr_msgqs;
 
 	tst_tmpdir();
-	/* You will want to enable some signal handling so you can capture
-	 * unexpected signals like SIGSEGV.
-	 */
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
@@ -631,17 +465,10 @@ void setup()
 	MSGMNI = min(nr_msgqs, NR_MSGQUEUES);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- * completion or premature exit.
- ****************************************************************/
-void cleanup()
+void cleanup(void)
 {
 	int status;
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
+
 	TEST_CLEANUP;
 
 	/*
@@ -660,5 +487,4 @@ void cleanup()
 
 	fflush(stdout);
 	tst_rmdir();
-
 }
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
index 895a319..e08b9b0 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
@@ -1,38 +1,27 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * 06/30/2001   Port to Linux   nsharoff@us.ibm.com
+ * 11/06/2002   Port to LTP     dbarrera@us.ibm.com
  */
 
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-/* 11/06/2002   Port to LTP     dbarrera@us.ibm.com */
-
 /*
- * NAME
- *	msgctl10
- *
- * CALLS
- *	msgget(2) msgctl(2)
- *
- * ALGORITHM
- *	Get and manipulate a message queue.
- *	Same as msgctl08 but gets the actual msgmni value under procfs.
- *
- * RESTRICTIONS
- *
+ * Get and manipulate a message queue.
+ * Same as msgctl08 but gets the actual msgmni value under procfs.
  */
 
 #define _XOPEN_SOURCE 500
@@ -52,62 +41,41 @@
 #include "test.h"
 #include "usctest.h"
 #include "ipcmsg.h"
+#include "libmsgctl.h"
 
-void setup();
-void cleanup();
-/*
- *  *  *  * These globals must be defined in the test.
- *   *   *   */
-
-char *TCID = "msgctl10";	/* Test program identifier.    */
-int TST_TOTAL = 1;		/* Total number of test cases. */
-
-int exp_enos[] = { 0 };		/* List must end with 0 */
+char *TCID = "msgctl10";
+int TST_TOTAL = 1;
 
 #define MAXNPROCS	10000	/*These should be sufficient */
 #define MAXNREPS	10000	/*Else they srewup the system un-necessarily */
-#define FAIL		1
-#define PASS		0
-
-key_t keyarray[MAXNPROCS];
-
-struct {
-	long type;
-	struct {
-		char len;
-		char pbytes[99];
-	} data;
-} buffer;
-
-int pidarray[MAXNPROCS];
-int tid;
-int MSGMNI, nprocs, nreps;
-int procstat;
-int dotest(key_t key, int child_process);
-int doreader(int id, long key, int child);
-int dowriter(int id, long key, int child);
-int fill_buffer(register char *buf, char val, register int size);
-int verify(register char *buf, char val, register int size, int child);
-void sig_handler();		/* signal catching function */
-int mykid;
+
+static key_t keyarray[MAXNPROCS];
+static int pidarray[MAXNPROCS];
+static int tid;
+static int MSGMNI, nprocs, nreps;
+static int procstat;
+static int mykid;
+
+void setup(void);
+void cleanup(void);
+
+static int dotest(key_t key, int child_process);
+static void sig_handler(int signo);		/* signal catching function */
+
 #ifdef UCLINUX
 static char *argv0;
-
-void do_child_1_uclinux();
 static key_t key_uclinux;
 static int i_uclinux;
-
-void do_child_2_uclinux();
 static int id_uclinux;
 static int child_process_uclinux;
+
+static void do_child_1_uclinux(void);
+static void do_child_2_uclinux(void);
 #endif
 
-/*-----------------------------------------------------------------*/
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char **argv)
 {
-	register int i, j, ok, pid;
+	int i, j, ok, pid;
 	int count, status;
 	struct sigaction act;
 
@@ -159,7 +127,7 @@ char *argv[];
 	srand(getpid());
 	tid = -1;
 
-	/* Setup signal handleing routine */
+	/* Setup signal handling routine */
 	memset(&act, 0, sizeof(act));
 	act.sa_handler = sig_handler;
 	sigemptyset(&act.sa_mask);
@@ -249,188 +217,92 @@ char *argv[];
 
 }
 
-/*--------------------------------------------------------------------*/
-
 #ifdef UCLINUX
-void do_child_1_uclinux()
+static void do_child_1_uclinux(void)
 {
 	procstat = 1;
 	exit(dotest(key_uclinux, i_uclinux));
 }
 
-void do_child_2_uclinux()
+static void do_child_2_uclinux(void)
 {
-	exit(doreader(id_uclinux, key_uclinux % 255, child_process_uclinux));
+	exit(doreader(key_uclinux, id_uclinux, 1,
+			child_process_uclinux, nreps));
 }
 #endif
 
-int dotest(key, child_process)
-key_t key;
-int child_process;
+static int dotest(key_t key, int child_process)
 {
 	int id, pid;
+	int ret, status;
 
 	sighold(SIGTERM);
 	TEST(msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR));
 	if (TEST_RETURN < 0) {
-		tst_resm(TFAIL | TTERRNO, "Msgget error in child %d",
-			 child_process);
-		tst_exit();
+		printf("msgget() error in child %d: %s\n",
+			child_process, strerror(TEST_ERRNO));
+		return FAIL;
 	}
 	tid = id = TEST_RETURN;
 	sigrelse(SIGTERM);
 
 	fflush(stdout);
 	if ((pid = FORK_OR_VFORK()) < 0) {
-		tst_resm(TWARN, "\tFork failed (may be OK if under stress)");
+		printf("Fork failed (may be OK if under stress)\n");
 		TEST(msgctl(tid, IPC_RMID, 0));
 		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL | TTERRNO, "Msgctl error in cleanup");
+			printf("msgctl() error in cleanup: %s\n",
+				strerror(TEST_ERRNO));
 		}
-		tst_exit();
+		return FAIL;
 	}
 	/* Child does this */
 	if (pid == 0) {
 #ifdef UCLINUX
 		if (self_exec(argv0, "nddd", 2, id, key, child_process) < 0) {
-			tst_resm(TWARN, "self_exec failed");
+			printf("self_exec failed\n");
 			TEST(msgctl(tid, IPC_RMID, 0));
 			if (TEST_RETURN < 0) {
-				tst_resm(TFAIL | TTERRNO,
-					 "Msgctl error in cleanup");
+				printf("msgctl() error in cleanup: %s\n",
+					strerror(TEST_ERRNO));
 			}
-			tst_exit();
+			return FAIL;
 		}
 #else
-		exit(doreader(id, key % 255, child_process));
+		exit(doreader(key, id, 1, child_process, nreps));
 #endif
 	}
 	/* Parent does this */
 	mykid = pid;
 	procstat = 2;
-	dowriter(id, key % 255, child_process);
-	wait(0);
-	TEST(msgctl(id, IPC_RMID, 0));
-	if (TEST_RETURN < 0) {
-		tst_resm(TFAIL | TTERRNO, "msgctl failed");
-		tst_exit();
-	}
-	exit(PASS);
-}
+	ret = dowriter(key, id, 1, child_process, nreps);
+	wait(&status);
 
-int doreader(int id, long key, int child)
-{
-	int i, size;
+	if (ret != PASS)
+		exit(FAIL);
 
-	for (i = 0; i < nreps; i++) {
-		if ((size = msgrcv(id, &buffer, 100, 0, 0)) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "Msgrcv error in child %d, read # = %d",
-				 (i + 1), child);
-			tst_exit();
-		}
-		if (buffer.data.len + 1 != size) {
-			tst_resm(TFAIL,
-				 "Size mismatch in child %d, read # = %d",
-				 child, (i + 1));
-			tst_resm(TFAIL,
-				 "for message size got  %d expected  %d",
-				 size, buffer.data.len);
-			tst_exit();
-		}
-		if (verify(buffer.data.pbytes, key, size - 1, child)) {
-			tst_resm(TFAIL, "in child %d read # = %d,key =  %lx",
-				 child, (i + 1), key);
-			tst_exit();
-		}
-		key++;
-	}
-	return (0);
-}
-
-int dowriter(id, key, child)
-int id, child;
-long key;
-{
-	int i, size;
-
-	for (i = 0; i < nreps; i++) {
-		do {
-			size = (rand() % 99);
-		} while (size == 0);
-		fill_buffer(buffer.data.pbytes, key, size);
-		buffer.data.len = size;
-		buffer.type = 1;
-		TEST(msgsnd(id, &buffer, size + 1, 0));
-		if (TEST_RETURN < 0) {
-			tst_brkm(TBROK | TTERRNO, cleanup,
-				 "Msgsnd error in child %d, key =   %lx",
-				 child, key);
-		}
-		key++;
-	}
-	return (0);
-}
-
-int fill_buffer(buf, val, size)
-register char *buf;
-char val;
-register int size;
-{
-	register int i;
-
-	for (i = 0; i < size; i++) {
-		buf[i] = val;
-	}
+	if ((!WIFEXITED(status) || (WEXITSTATUS(status) != PASS)))
+		exit(FAIL);
 
-	return (0);
-}
-
-/*
- * verify()
- *	Check a buffer for correct values.
- */
-
-int verify(buf, val, size, child)
-register char *buf;
-char val;
-register int size;
-int child;
-{
-	while (size-- > 0) {
-		if (*buf++ != val) {
-			tst_resm(TWARN,
-				 "Verify error in child %d, *buf = %x, val = %x, size = %d",
-				 child, *buf, val, size);
-			return (FAIL);
-		}
+	TEST(msgctl(id, IPC_RMID, 0));
+	if (TEST_RETURN < 0) {
+		printf("msgctl() failed: %s\n",
+			strerror(TEST_ERRNO));
+		return FAIL;
 	}
-	return (PASS);
+	return PASS;
 }
 
-/*
- *  * void
- *  * sig_handler() - signal catching function for 'SIGUSR1' signal.
- *  *
- *  *   This is a null function and used only to catch the above signal
- *  *   generated in parent process.
- *  */
-void sig_handler()
+static void sig_handler(int signo)
 {
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- *****************************************************************/
-void setup()
+void setup(void)
 {
 	int nr_msgqs;
 
 	tst_tmpdir();
 
-	/* You will want to enable some signal handling so you can capture
-	 * unexpected signals like SIGSEGV.
-	 */
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
@@ -453,11 +325,7 @@ void setup()
 	}
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- ****************************************************************/
-void cleanup()
+void cleanup(void)
 {
 	int status;
 	/*
@@ -475,11 +343,7 @@ void cleanup()
 	}
 
 	fflush(stdout);
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
+
 	TEST_CLEANUP;
 	tst_rmdir();
-
 }
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
index 82ad2d3..9b21df8 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
@@ -1,38 +1,27 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2002
  *
- *   Copyright (c) International Business Machines  Corp., 2002
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * 06/30/2001   Port to Linux   nsharoff@us.ibm.com
+ * 11/11/2002   Port to LTP     dbarrera@us.ibm.com
  */
 
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-/* 11/11/2002   Port to LTP     dbarrera@us.ibm.com */
-
 /*
- * NAME
- *	msgctl11
- *
- * CALLS
- *	msgget(2) msgctl(2) msgop(2)
- *
- * ALGORITHM
- *	Get and manipulate a message queue.
- *	Same as msgctl09 but gets the actual msgmni value under procfs.
- *
- * RESTRICTIONS
- *
+ * Get and manipulate a message queue.
+ * Same as msgctl09 but gets the actual msgmni value under procfs.
  */
 
 #define _XOPEN_SOURCE 500
@@ -50,8 +39,12 @@
 #include "test.h"
 #include "usctest.h"
 #include "ipcmsg.h"
+#include "libmsgctl.h"
 #include "system_specific_process_info.h"
 
+char *TCID = "msgctl11";
+int TST_TOTAL = 1;
+
 #define MAXNREPS	1000
 #ifndef CONFIG_COLDFIRE
 #define MAXNPROCS	 1000000	/* This value is set to an arbitrary high limit. */
@@ -59,67 +52,39 @@
 #define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
 #endif
 #define MAXNKIDS	10
-#define FAIL		1
-#define PASS		0
-
-int dotest(key_t, int);
-int doreader(long, int, int);
-int dowriter(long, int, int);
-int fill_buffer(char *, char, int);
-int verify(char *, char, int, int);
-void setup();
-void cleanup();
-
-/*
- * These globals must be defined in the test.
- * */
-
-char *TCID = "msgctl11";	/* Test program identifier.    */
-int TST_TOTAL = 1;		/* Total number of test cases. */
 
-int exp_enos[] = { 0 };		/* List must end with 0 */
+static int maxnkids = MAXNKIDS;	/* Used if pid_max is exceeded */
+static key_t keyarray[MAXNPROCS];
+static int pidarray[MAXNPROCS];
+static int rkidarray[MAXNKIDS];
+static int wkidarray[MAXNKIDS];
+static int tid;
+static int nprocs, nreps, nkids, MSGMNI;
+static int procstat;
 
-int maxnkids = MAXNKIDS;	/* Used if pid_max is exceeded */
+void setup(void);
+void cleanup(void);
 
-key_t keyarray[MAXNPROCS];
+static void term(int);
+static int dotest(key_t, int);
+static void cleanup_msgqueue(int i, int tid);
 
-struct {
-	long type;
-	struct {
-		char len;
-		char pbytes[99];
-	} data;
-} buffer;
-
-int pidarray[MAXNPROCS];
-int rkidarray[MAXNKIDS];
-int wkidarray[MAXNKIDS];
-int tid;
-int nprocs, nreps, nkids, MSGMNI;
-int procstat;
-void term(int);
 #ifdef UCLINUX
 static char *argv0;
-
-void do_child_1_uclinux();
 static key_t key_uclinux;
 static int i_uclinux;
-
-void do_child_2_uclinux();
 static int pid_uclinux;
 static int child_process_uclinux;
-
-void do_child_3_uclinux();
 static int rkid_uclinux;
+
+static void do_child_1_uclinux();
+static void do_child_2_uclinux();
+static void do_child_3_uclinux();
 #endif
-void cleanup_msgqueue(int i, int tid);
 
-/*-----------------------------------------------------------------*/
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char **argv)
 {
-	register int i, j, ok, pid;
+	int i, j, ok, pid;
 	int count, status;
 
 #ifdef UCLINUX
@@ -209,7 +174,6 @@ char *argv[];
 			}
 		} while (ok == 0);
 	}
-/*-----------------------------------------------------------------*/
 	/* Fork a number of processes (nprocs), each of which will
 	 * create a message queue with several (nkids) reader/writer
 	 * pairs which will read and write a number (iterations)
@@ -272,29 +236,29 @@ char *argv[];
 
 }
 
-/*--------------------------------------------------------------------*/
-
 #ifdef UCLINUX
-void do_child_1_uclinux()
+static void do_child_1_uclinux(void)
 {
 	procstat = 1;
 	exit(dotest(key_uclinux, i_uclinux));
 }
 
-void do_child_2_uclinux()
+static void do_child_2_uclinux(void)
 {
 	procstat = 2;
-	exit(doreader(key_uclinux, pid_uclinux, child_process_uclinux));
+	exit(doreader(key_uclinux, tid, pid_uclinux,
+			child_process_uclinux, nreps));
 }
 
-void do_child_3_uclinux()
+static void do_child_3_uclinux(void)
 {
 	procstat = 2;
-	exit(dowriter(key_uclinux, rkid_uclinux, child_process_uclinux));
+	exit(dowriter(key_uclinux, tid, rkid_uclinux,
+			child_process_uclinux, nreps));
 }
 #endif
 
-void cleanup_msgqueue(int i, int tid)
+static void cleanup_msgqueue(int i, int tid)
 {
 	/*
 	 * Decrease the value of i by 1 because it
@@ -317,18 +281,16 @@ void cleanup_msgqueue(int i, int tid)
 	}
 }
 
-int dotest(key, child_process)
-key_t key;
-int child_process;
+static int dotest(key_t key, int child_process)
 {
 	int id, pid;
 	int i, count, status, exit_status;
 
 	sighold(SIGTERM);
 	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
-		tst_resm(TFAIL | TERRNO, "Msgget error in child %d",
-			 child_process);
-		tst_exit();
+		printf("msgget() error in child %d: %s\n",
+			child_process, strerror(errno));
+		return FAIL;
 	}
 	tid = id;
 	sigrelse(SIGTERM);
@@ -338,58 +300,58 @@ int child_process;
 	for (i = 0; i < nkids; i++) {
 		fflush(stdout);
 		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_resm(TWARN,
-				 "Fork failure in first child of child group %d",
-				 child_process);
+			printf("Fork failure in the first child of child group %d\n",
+				child_process);
 			cleanup_msgqueue(i, tid);
-			tst_exit();
+			return FAIL;
 		}
 		/* First child does this */
 		if (pid == 0) {
 #ifdef UCLINUX
 			if (self_exec(argv0, "nddd", 2, key, getpid(),
 				      child_process) < 0) {
-				tst_resm(TWARN, "self_exec failed");
+				printf("self_exec failed\n");
 				cleanup_msgqueue(i, tid);
-				tst_exit();
+				return FAIL;
 			}
 #else
 			procstat = 2;
-			exit(doreader(key, getpid(), child_process));
+			exit(doreader(key, tid, getpid(),
+					child_process, nreps));
 #endif
 		}
 		rkidarray[i] = pid;
 		fflush(stdout);
 		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_resm(TWARN,
-				 "Fork failure in first child of child group %d",
-				 child_process);
+			printf("Fork failure in the second child of child group %d\n",
+				child_process);
 			/*
 			 * Kill the reader child process
 			 */
 			(void)kill(rkidarray[i], SIGKILL);
 
 			cleanup_msgqueue(i, tid);
-			tst_exit();
+			return FAIL;
 		}
 		/* Second child does this */
 		if (pid == 0) {
 #ifdef UCLINUX
 			if (self_exec(argv0, "nddd", 3, key, rkidarray[i],
 				      child_process) < 0) {
-				tst_resm(TWARN, "\tFork failure in first child "
-					 "of child group %d \n", child_process);
+				printf("\tFork failure in the first child of child group %d\n",
+					child_process);
 				/*
 				 * Kill the reader child process
 				 */
 				(void)kill(rkidarray[i], SIGKILL);
 
 				cleanup_msgqueue(i, tid);
-				tst_exit();
+				return FAIL;
 			}
 #else
 			procstat = 2;
-			exit(dowriter(key, rkidarray[i], child_process));
+			exit(dowriter(key, tid, rkidarray[i],
+					child_process, nreps));
 #endif
 		}
 		wkidarray[i] = pid;
@@ -399,18 +361,17 @@ int child_process;
 	while (1) {
 		if ((wait(&status)) > 0) {
 			if (status >> 8 != PASS) {
-				tst_resm(TFAIL,
-					 "Child exit status = %d from child group %d",
-					 status >> 8, child_process);
+				printf("Child exit status = %d from child group %d\n",
+					status >> 8, child_process);
 				for (i = 0; i < nkids; i++) {
 					kill(rkidarray[i], SIGTERM);
 					kill(wkidarray[i], SIGTERM);
 				}
 				if (msgctl(tid, IPC_RMID, 0) < 0) {
-					tst_resm(TFAIL | TERRNO,
-						 "Msgctl error");
+					printf("msgctl() error: %s\n",
+						strerror(errno));
 				}
-				tst_exit();
+				return FAIL;
 			}
 			count++;
 		} else {
@@ -421,146 +382,23 @@ int child_process;
 	}
 	/* Make sure proper number of children exited */
 	if (count != (nkids * 2)) {
-		tst_resm(TFAIL,
-			 "Wrong number of children exited in child group %d, Saw %d Expected %d",
-			 child_process, count, (nkids * 2));
+		printf("Wrong number of children exited in child group %d, saw %d, expected %d\n",
+			child_process, count, (nkids * 2));
 		if (msgctl(tid, IPC_RMID, 0) < 0) {
-			tst_resm(TFAIL | TERRNO, "Msgctl error");
+			printf("msgctl() error: %s\n", strerror(errno));
 		}
-		tst_exit();
+		return FAIL;
 	}
 	if (msgctl(id, IPC_RMID, 0) < 0) {
-		tst_resm(TFAIL | TERRNO, "Msgctl failure in child group %d",
-			 child_process);
-		tst_exit();
+		printf("msgctl() failure in child group %d: %s\n",
+			child_process, strerror(errno));
+		return FAIL;
 	}
-	exit(exit_status);
-}
-
-int doreader(key, type, child)
-int type, child;
-long key;
-{
-	int i, size;
-	int id;
-
-	if ((id = msgget(key, 0)) < 0) {
-		tst_resm(TFAIL | TERRNO,
-			 "Msgget error in reader of child group %d", child);
-		tst_exit();
-	}
-	if (id != tid) {
-		tst_resm(TFAIL,
-			 "Message queue mismatch in reader of child group %d for message queue id %d",
-			 child, id);
-		tst_exit();
-	}
-	for (i = 0; i < nreps; i++) {
-		if ((size = msgrcv(id, &buffer, 100, type, 0)) < 0) {
-			tst_resm(TFAIL | TERRNO,
-				 "Msgrcv error in child %d, read # = %d",
-				 (i + 1), child);
-			tst_exit();
-		}
-		if (buffer.type != type) {
-			tst_resm(TFAIL,
-				 "Size mismatch in child %d, read # = %d",
-				 child, (i + 1));
-			tst_resm(TFAIL,
-				 "\tfor message size got  %d expected  %d",
-				 size, buffer.data.len);
-			tst_exit();
-		}
-		if (buffer.data.len + 1 != size) {
-			tst_resm(TFAIL,
-				 "Size mismatch in child %d, read # = %d, size = %d, expected = %d",
-				 child, (i + 1), buffer.data.len, size);
-			tst_exit();
-		}
-		if (verify(buffer.data.pbytes, (key % 255), size - 1, child)) {
-			tst_resm(TFAIL, "in child %d read # = %d,key =  %lx",
-				 child, (i + 1), key);
-			tst_exit();
-		}
-		key++;
-	}
-	exit(PASS);
-}
-
-int dowriter(key, type, child)
-int type, child;
-long key;
-{
-	int i, size;
-	int id;
-
-	if ((id = msgget(key, 0)) < 0) {
-		tst_resm(TFAIL | TERRNO,
-			 "Msgget error in writer of child group %d", child);
-		tst_exit();
-	}
-	if (id != tid) {
-		tst_resm(TFAIL,
-			 "Message queue mismatch in writer of child group %d",
-			 child);
-		tst_resm(TFAIL, "\tfor message queue id %d expected  %d", id,
-			 tid);
-		tst_exit();
-	}
-
-	for (i = 0; i < nreps; i++) {
-		do {
-			size = (lrand48() % 99);
-		} while (size == 0);
-		fill_buffer(buffer.data.pbytes, (key % 255), size);
-		buffer.data.len = size;
-		buffer.type = type;
-		if (msgsnd(id, &buffer, size + 1, 0) < 0) {
-			tst_resm(TFAIL | TERRNO,
-				 "Msgsnd error in child %d, key =   %lx",
-				 child, key);
-			tst_exit();
-		}
-		key++;
-	}
-	exit(PASS);
-}
-
-int fill_buffer(buf, val, size)
-register char *buf;
-char val;
-register int size;
-{
-	register int i;
-
-	for (i = 0; i < size; i++)
-		buf[i] = val;
-	return 0;
-}
-
-/*
- * verify()
- *	Check a buffer for correct values.
- */
-
-int verify(buf, val, size, child)
-register char *buf;
-char val;
-register int size;
-int child;
-{
-	while (size-- > 0)
-		if (*buf++ != val) {
-			tst_resm(TWARN,
-				 "Verify error in child %d, *buf = %x, val = %x, size = %d",
-				 child, *buf, val, size);
-			return (FAIL);
-		}
-	return (PASS);
+	return exit_status;
 }
 
 /* ARGSUSED */
-void term(int sig)
+static void term(int sig)
 {
 	int i;
 
@@ -597,10 +435,7 @@ void term(int sig)
 	}
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- *****************************************************************/
-void setup()
+void setup(void)
 {
 	int nr_msgqs, free_pids;
 
@@ -649,17 +484,10 @@ void setup()
 	tst_resm(TINFO, "Using upto %d pids", free_pids / 2);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- * completion or premature exit.
- ****************************************************************/
-void cleanup()
+void cleanup(void)
 {
 	int status;
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
+
 	TEST_CLEANUP;
 
 	/*
@@ -678,5 +506,4 @@ void cleanup()
 
 	fflush(stdout);
 	tst_rmdir();
-
 }
-- 
1.7.1


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
