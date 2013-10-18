Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VX67B-0003V4-Jr
	for ltp-list@lists.sourceforge.net; Fri, 18 Oct 2013 09:13:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VX678-0004zX-TT
	for ltp-list@lists.sourceforge.net; Fri, 18 Oct 2013 09:13:01 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9I9CqO5009009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Oct 2013 09:12:53 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9I9CpDs027825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Oct 2013 09:12:52 GMT
Received: from abhmt117.oracle.com (abhmt117.oracle.com [141.146.116.69])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9I9Cp7I017859
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Oct 2013 09:12:51 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 18 Oct 2013 13:12:45 +0400
Message-Id: <1382087565-2370-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <525F76B7.4050705@oracle.com>
References: <525F76B7.4050705@oracle.com>
Subject: [LTP] [PATCH] msgctl{08, 09, 10, 11}: cleanup
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
* Changed tst_* in children with printf + exit (or return).
* Some cleanup.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/ipc/msgctl/Makefile    |    9 +
 testcases/kernel/syscalls/ipc/msgctl/libmsgctl.c |  148 +++++++++++++
 testcases/kernel/syscalls/ipc/msgctl/libmsgctl.h |   39 ++++
 testcases/kernel/syscalls/ipc/msgctl/msgctl08.c  |  201 ++++--------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl09.c  |  252 ++++-----------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl10.c  |  196 ++++--------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c  |  245 ++++-----------------
 7 files changed, 369 insertions(+), 721 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/msgctl/libmsgctl.c
 create mode 100644 testcases/kernel/syscalls/ipc/msgctl/libmsgctl.h

diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
index f467389..ae61b51 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
@@ -18,6 +18,15 @@
 
 top_srcdir              ?= ../../../../..
 
+FILTER_OUT_MAKE_TARGETS	:= libmsgctl
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+SRCS			?= $(wildcard $(abs_srcdir)/*.c)
+OBJS			:= $(notdir $(patsubst %.c,%.o,$(SRCS)))
+.INTERMEDIATE: $(OBJS)
+
+$(MAKE_TARGETS): %: %.o libmsgctl.o
+libmsgctl.o: libmsgctl.h
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
index f733946..8d7e431 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
@@ -51,6 +51,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "ipcmsg.h"
+#include "libmsgctl.h"
 
 void setup();
 void cleanup();
@@ -61,38 +62,22 @@ void cleanup();
 char *TCID = "msgctl08";	/* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test cases. */
 
-int exp_enos[] = { 0 };		/* List must end with 0 */
-
 #ifndef CONFIG_COLDFIRE
 #define MAXNPROCS	1000000	/* This value is set to an arbitrary high limit. */
 #else
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
+
+static key_t keyarray[MAXNPROCS];
+
+static int pidarray[MAXNPROCS];
+static int tid;
+static int MSGMNI, nprocs, nreps;
+static int procstat;
 int dotest(key_t key, int child_process);
-int doreader(int id, long key, int child);
-int dowriter(int id, long key, int child);
-int fill_buffer(register char *buf, char val, register int size);
-int verify(register char *buf, char val, register int size, int child);
 void sig_handler();		/* signal catching function */
-int mykid;
+static int mykid;
 #ifdef UCLINUX
 static char *argv0;
 
@@ -106,11 +91,9 @@ static int child_process_uclinux;
 #endif
 
 /*-----------------------------------------------------------------*/
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char **argv)
 {
-	register int i, j, ok, pid;
+	int i, j, ok, pid;
 	int count, status;
 	struct sigaction act;
 
@@ -162,7 +145,7 @@ char *argv[];
 	srand(getpid());
 	tid = -1;
 
-	/* Setup signal handleing routine */
+	/* Setup signal handling routine */
 	memset(&act, 0, sizeof(act));
 	act.sa_handler = sig_handler;
 	sigemptyset(&act.sa_mask);
@@ -266,179 +249,84 @@ void do_child_1_uclinux()
 
 void do_child_2_uclinux()
 {
-	exit(doreader(id_uclinux, key_uclinux % 255, child_process_uclinux));
+	exit(doreader(key_uclinux, id_uclinux, 1, child_process_uclinux, nreps));
 }
 #endif
 
-int dotest(key, child_process)
-key_t key;
-int child_process;
+int dotest(key_t key, int child_process)
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
+	ret = dowriter(key, id, 1, child_process, nreps);
+	wait(&status);
 
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
+	if (ret != PASS)
+		exit(FAIL);
 
-int dowriter(id, key, child)
-int id, child;
-long key;
-{
-	int i, size;
+	if ((!WIFEXITED(status) || (WEXITSTATUS(status) != PASS)))
+		exit(FAIL);
 
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
-
-	return (0);
-}
-
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
 void sig_handler()
 {
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- *****************************************************************/
 void setup()
 {
 	int nr_msgqs;
 
 	tst_tmpdir();
 
-	/* You will want to enable some signal handling so you can capture
-	 * unexpected signals like SIGSEGV.
-	 */
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
@@ -466,10 +354,6 @@ void setup()
 	MSGMNI = min(nr_msgqs, NR_MSGQUEUES);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- ****************************************************************/
 void cleanup()
 {
 	int status;
@@ -488,10 +372,7 @@ void cleanup()
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
index bec852a..a2a1256 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
@@ -49,6 +49,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "ipcmsg.h"
+#include "libmsgctl.h"
 
 #define MAXNREPS	1000
 #ifndef CONFIG_COLDFIRE
@@ -57,14 +58,8 @@
 #define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
 #endif
 #define MAXNKIDS	10
-#define FAIL		1
-#define PASS		0
 
 int dotest(key_t, int);
-int doreader(long, int, int);
-int dowriter(long, int, int);
-int fill_buffer(char *, char, int);
-int verify(char *, char, int, int);
 void setup();
 void cleanup();
 
@@ -75,24 +70,14 @@ void cleanup();
 char *TCID = "msgctl09";	/* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test cases. */
 
-int exp_enos[] = { 0 };		/* List must end with 0 */
+static key_t keyarray[MAXNPROCS];
 
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
+static int pidarray[MAXNPROCS];
+static int rkidarray[MAXNKIDS];
+static int wkidarray[MAXNKIDS];
+static int tid;
+static int nprocs, nreps, nkids, MSGMNI;
+static int procstat;
 void term(int);
 #ifdef UCLINUX
 static char *argv0;
@@ -111,11 +96,9 @@ static int rkid_uclinux;
 void cleanup_msgqueue(int i, int tid);
 
 /*-----------------------------------------------------------------*/
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char **argv)
 {
-	register int i, j, ok, pid;
+	int i, j, ok, pid;
 	int count, status;
 
 #ifdef UCLINUX
@@ -280,13 +263,15 @@ void do_child_1_uclinux()
 void do_child_2_uclinux()
 {
 	procstat = 2;
-	exit(doreader(key_uclinux, pid_uclinux, child_process_uclinux));
+	exit(doreader(key_uclinux, tid, pid_uclinux,
+			child_process_uclinux, nreps));
 }
 
 void do_child_3_uclinux()
 {
 	procstat = 2;
-	exit(dowriter(key_uclinux, rkid_uclinux, child_process_uclinux));
+	exit(dowriter(key_uclinux, tid, rkid_uclinux,
+			child_process_uclinux, nreps));
 }
 #endif
 
@@ -313,18 +298,16 @@ void cleanup_msgqueue(int i, int tid)
 	}
 }
 
-int dotest(key, child_process)
-key_t key;
-int child_process;
+int dotest(key_t key, int child_process)
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
@@ -334,58 +317,56 @@ int child_process;
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
+			exit(doreader(key, tid, getpid(), child_process, nreps));
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
+			exit(dowriter(key, tid, rkidarray[i], child_process, nreps));
 #endif
 		}
 		wkidarray[i] = pid;
@@ -395,18 +376,17 @@ int child_process;
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
@@ -417,142 +397,19 @@ int child_process;
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
@@ -567,9 +424,8 @@ void term(int sig)
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
@@ -593,17 +449,12 @@ void term(int sig)
 	}
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- *****************************************************************/
 void setup()
 {
 	int nr_msgqs;
 
 	tst_tmpdir();
-	/* You will want to enable some signal handling so you can capture
-	 * unexpected signals like SIGSEGV.
-	 */
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
@@ -631,17 +482,10 @@ void setup()
 	MSGMNI = min(nr_msgqs, NR_MSGQUEUES);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- * completion or premature exit.
- ****************************************************************/
 void cleanup()
 {
 	int status;
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
+
 	TEST_CLEANUP;
 
 	/*
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
index 895a319..20d209e 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
@@ -52,6 +52,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "ipcmsg.h"
+#include "libmsgctl.h"
 
 void setup();
 void cleanup();
@@ -62,34 +63,18 @@ void cleanup();
 char *TCID = "msgctl10";	/* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test cases. */
 
-int exp_enos[] = { 0 };		/* List must end with 0 */
-
 #define MAXNPROCS	10000	/*These should be sufficient */
 #define MAXNREPS	10000	/*Else they srewup the system un-necessarily */
-#define FAIL		1
-#define PASS		0
 
 key_t keyarray[MAXNPROCS];
 
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
+static int pidarray[MAXNPROCS];
+static int tid;
+static int MSGMNI, nprocs, nreps;
+static int procstat;
+static int dotest(key_t key, int child_process);
 void sig_handler();		/* signal catching function */
-int mykid;
+static int mykid;
 #ifdef UCLINUX
 static char *argv0;
 
@@ -103,11 +88,9 @@ static int child_process_uclinux;
 #endif
 
 /*-----------------------------------------------------------------*/
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char **argv)
 {
-	register int i, j, ok, pid;
+	int i, j, ok, pid;
 	int count, status;
 	struct sigaction act;
 
@@ -159,7 +142,7 @@ char *argv[];
 	srand(getpid());
 	tid = -1;
 
-	/* Setup signal handleing routine */
+	/* Setup signal handling routine */
 	memset(&act, 0, sizeof(act));
 	act.sa_handler = sig_handler;
 	sigemptyset(&act.sa_mask);
@@ -260,177 +243,82 @@ void do_child_1_uclinux()
 
 void do_child_2_uclinux()
 {
-	exit(doreader(id_uclinux, key_uclinux % 255, child_process_uclinux));
+	exit(doreader(key_uclinux, id_uclinux, 1, child_process_uclinux, nreps));
 }
 #endif
 
-int dotest(key, child_process)
-key_t key;
-int child_process;
+int dotest(key_t key, int child_process)
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
-
-int doreader(int id, long key, int child)
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
+	ret = dowriter(key, id, 1, child_process, nreps);
+	wait(&status);
 
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
+	if (ret != PASS)
+		exit(FAIL);
 
-int fill_buffer(buf, val, size)
-register char *buf;
-char val;
-register int size;
-{
-	register int i;
+	if ((!WIFEXITED(status) || (WEXITSTATUS(status) != PASS)))
+		exit(FAIL);
 
-	for (i = 0; i < size; i++) {
-		buf[i] = val;
-	}
-
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
 void sig_handler()
 {
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- *****************************************************************/
 void setup()
 {
 	int nr_msgqs;
 
 	tst_tmpdir();
 
-	/* You will want to enable some signal handling so you can capture
-	 * unexpected signals like SIGSEGV.
-	 */
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
@@ -453,10 +341,6 @@ void setup()
 	}
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- ****************************************************************/
 void cleanup()
 {
 	int status;
@@ -475,11 +359,7 @@ void cleanup()
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
index 82ad2d3..9746e0d 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
@@ -50,6 +50,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "ipcmsg.h"
+#include "libmsgctl.h"
 #include "system_specific_process_info.h"
 
 #define MAXNREPS	1000
@@ -59,14 +60,8 @@
 #define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
 #endif
 #define MAXNKIDS	10
-#define FAIL		1
-#define PASS		0
 
 int dotest(key_t, int);
-int doreader(long, int, int);
-int dowriter(long, int, int);
-int fill_buffer(char *, char, int);
-int verify(char *, char, int, int);
 void setup();
 void cleanup();
 
@@ -77,26 +72,16 @@ void cleanup();
 char *TCID = "msgctl11";	/* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test cases. */
 
-int exp_enos[] = { 0 };		/* List must end with 0 */
+static int maxnkids = MAXNKIDS;	/* Used if pid_max is exceeded */
 
-int maxnkids = MAXNKIDS;	/* Used if pid_max is exceeded */
+static key_t keyarray[MAXNPROCS];
 
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
+static int pidarray[MAXNPROCS];
+static int rkidarray[MAXNKIDS];
+static int wkidarray[MAXNKIDS];
+static int tid;
+static int nprocs, nreps, nkids, MSGMNI;
+static int procstat;
 void term(int);
 #ifdef UCLINUX
 static char *argv0;
@@ -115,11 +100,9 @@ static int rkid_uclinux;
 void cleanup_msgqueue(int i, int tid);
 
 /*-----------------------------------------------------------------*/
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char **argv)
 {
-	register int i, j, ok, pid;
+	int i, j, ok, pid;
 	int count, status;
 
 #ifdef UCLINUX
@@ -284,13 +267,15 @@ void do_child_1_uclinux()
 void do_child_2_uclinux()
 {
 	procstat = 2;
-	exit(doreader(key_uclinux, pid_uclinux, child_process_uclinux));
+	exit(doreader(key_uclinux, tid, pid_uclinux,
+			child_process_uclinux, nreps));
 }
 
 void do_child_3_uclinux()
 {
 	procstat = 2;
-	exit(dowriter(key_uclinux, rkid_uclinux, child_process_uclinux));
+	exit(dowriter(key_uclinux, tid, rkid_uclinux,
+			child_process_uclinux, nreps));
 }
 #endif
 
@@ -317,18 +302,16 @@ void cleanup_msgqueue(int i, int tid)
 	}
 }
 
-int dotest(key, child_process)
-key_t key;
-int child_process;
+int dotest(key_t key, int child_process)
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
@@ -338,58 +321,56 @@ int child_process;
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
+			exit(doreader(key, tid, getpid(), child_process, nreps));
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
+			exit(dowriter(key, tid, rkidarray[i], child_process, nreps));
 #endif
 		}
 		wkidarray[i] = pid;
@@ -399,18 +380,17 @@ int child_process;
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
@@ -421,142 +401,19 @@ int child_process;
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
@@ -597,9 +454,6 @@ void term(int sig)
 	}
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- *****************************************************************/
 void setup()
 {
 	int nr_msgqs, free_pids;
@@ -649,17 +503,10 @@ void setup()
 	tst_resm(TINFO, "Using upto %d pids", free_pids / 2);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- * completion or premature exit.
- ****************************************************************/
 void cleanup()
 {
 	int status;
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
+
 	TEST_CLEANUP;
 
 	/*
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
