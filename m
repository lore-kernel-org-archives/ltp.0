Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VWN3Y-0006NY-9y
	for ltp-list@lists.sourceforge.net; Wed, 16 Oct 2013 09:06:16 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VWN3W-0003vv-Ho
	for ltp-list@lists.sourceforge.net; Wed, 16 Oct 2013 09:06:16 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9G9687j032726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Oct 2013 09:06:08 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9G967jg005231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Oct 2013 09:06:07 GMT
Received: from abhmt107.oracle.com (abhmt107.oracle.com [141.146.116.59])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9G966lh007658
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Oct 2013 09:06:06 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 16 Oct 2013 13:05:58 +0400
Message-Id: <1381914358-29029-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1381914358-29029-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1381914358-29029-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] msgctl11: changed logic
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

As /proc/sys/kernel/msgmni value scales with an amount of host memory,
on systems with several tens gigabytes of ram this testcase fails
with "Not enough free pids" error.

As I understood the initial testcase aim is to use all available memory
queues.

Given that I changed the logic of the testcase. Now:
 * It allocates all available message queues on the host.
 * It forks a number of children and pass to each child a bunch
   of these queues. As a result each queue is assigned to a child.
 * Each child sequentially does testing for every passed queue.

And also:
 * added a handler for SIGINT signal. Now if the testcases is interrupted
   with SIGINT or SIGTERM signal It returns TFAIL.
 * changed tst_* with printf() + exit() in children
 * performed a minor cleanup.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c |  521 +++++++++++------------
 1 files changed, 249 insertions(+), 272 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
index 82ad2d3..9cb1a53 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2002
+ *   Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -19,17 +20,19 @@
 
 /* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
 /* 11/11/2002   Port to LTP     dbarrera@us.ibm.com */
+/* 10/16/2013   Changed the algorithm stanislav.kholmanskikh@oracle.com */
 
 /*
  * NAME
  *	msgctl11
  *
  * CALLS
- *	msgget(2) msgctl(2) msgop(2)
+ *	msgget(2) msgctl(2)
  *
  * ALGORITHM
- *	Get and manipulate a message queue.
- *	Same as msgctl09 but gets the actual msgmni value under procfs.
+ *	Allocate the maximum number of message queues (based on
+ *	msgmni value under procfs).
+ *	Fork children which utilise all these queues.
  *
  * RESTRICTIONS
  *
@@ -58,15 +61,14 @@
 #else
 #define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
 #endif
-#define MAXNKIDS	10
 #define FAIL		1
 #define PASS		0
 
-int dotest(key_t, int);
-int doreader(long, int, int);
-int dowriter(long, int, int);
-int fill_buffer(char *, char, int);
-int verify(char *, char, int, int);
+static int dotest(int child_process);
+static int doreader(key_t key, int tid, int type, int child);
+static int dowriter(key_t key, int tid, int type, int child);
+static int fill_buffer(char *, char, int);
+static int verify(char *, char, int, int);
 void setup();
 void cleanup();
 
@@ -79,11 +81,11 @@ int TST_TOTAL = 1;		/* Total number of test cases. */
 
 int exp_enos[] = { 0 };		/* List must end with 0 */
 
-int maxnkids = MAXNKIDS;	/* Used if pid_max is exceeded */
+static key_t keyarray[MAXNPROCS];
+static int idarray[MAXNPROCS];
+static int idxarray[MAXNPROCS]; /* Holds child positions in keyarray, idarray */
 
-key_t keyarray[MAXNPROCS];
-
-struct {
+static struct {
 	long type;
 	struct {
 		char len;
@@ -91,13 +93,16 @@ struct {
 	} data;
 } buffer;
 
-int pidarray[MAXNPROCS];
-int rkidarray[MAXNKIDS];
-int wkidarray[MAXNKIDS];
-int tid;
-int nprocs, nreps, nkids, MSGMNI;
-int procstat;
-void term(int);
+static pid_t pidarray[MAXNPROCS];
+static pid_t rkidpid, wkidpid;
+static int nqueues_per_proc[MAXNPROCS];
+
+static int nprocs, nreps, MSGMNI;
+static int procstat;
+static void term(int);
+
+static int force_exit; /* whether the program is forced to exit */
+
 #ifdef UCLINUX
 static char *argv0;
 
@@ -112,15 +117,16 @@ static int child_process_uclinux;
 void do_child_3_uclinux();
 static int rkid_uclinux;
 #endif
-void cleanup_msgqueue(int i, int tid);
 
 /*-----------------------------------------------------------------*/
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char **argv)
 {
-	register int i, j, ok, pid;
+	register int i, j, ok;
+	pid_t pid;
 	int count, status;
+	int idx;
+
+	force_exit = 0;
 
 #ifdef UCLINUX
 	char *msg;
@@ -144,53 +150,38 @@ char *argv[];
 	if (argc == 1) {
 		/* Set default parameters */
 		nreps = MAXNREPS;
-		nprocs = MSGMNI;
-		nkids = maxnkids;
-	} else if (argc == 4) {
+	} else if (argc == 2) {
 		if (atoi(argv[1]) > MAXNREPS) {
 			tst_resm(TCONF,
-				 "Requested number of iterations too large, setting to Max. of %d",
-				 MAXNREPS);
+				"Requested number of iterations too large, setting to Max. of %d",
+				MAXNREPS);
 			nreps = MAXNREPS;
 		} else {
 			nreps = atoi(argv[1]);
 		}
-		if (atoi(argv[2]) > MSGMNI) {
-			tst_resm(TCONF,
-				 "Requested number of processes too large, setting to Max. of %d",
-				 MSGMNI);
-			nprocs = MSGMNI;
-		} else {
-			nprocs = atoi(argv[2]);
-		}
-		if (atoi(argv[3]) > maxnkids) {
-			tst_resm(TCONF,
-				 "Requested number of read/write pairs too large; setting to Max. of %d",
-				 maxnkids);
-			nkids = maxnkids;
-		} else {
-			nkids = atoi(argv[3]);
-		}
 	} else {
-		tst_resm(TCONF,
-			 " Usage: %s [ number of iterations  number of processes number of read/write pairs ]",
-			 argv[0]);
+		tst_resm(TCONF, "Usage: %s [ number of iterations ]",
+			argv[0]);
 		tst_exit();
 	}
 
+
 	procstat = 0;
 	srand48((unsigned)getpid() + (unsigned)(getppid() << 16));
-	tid = -1;
 
-	/* Setup signal handleing routine */
+	/* Setup signal handling routine */
 	if (sigset(SIGTERM, term) == SIG_ERR) {
 		tst_resm(TFAIL, "Sigset SIGTERM failed");
 		tst_exit();
 	}
+	if (sigset(SIGINT, term) == SIG_ERR) {
+		tst_resm(TFAIL, "Sigset SIGINT failed");
+		tst_exit();
+	}
 	/* Set up array of unique keys for use in allocating message
 	 * queues
 	 */
-	for (i = 0; i < nprocs; i++) {
+	for (i = 0; i < MSGMNI; i++) {
 		ok = 1;
 		do {
 			/* Get random key */
@@ -209,30 +200,57 @@ char *argv[];
 			}
 		} while (ok == 0);
 	}
+
+	/* And allocate the message queues */
+	sighold(SIGTERM);
+	sighold(SIGINT);
+
+	for (i = 0; i < MSGMNI; i++) {
+		idarray[i] = msgget(keyarray[i], IPC_CREAT | S_IRUSR | S_IWUSR);
+
+		if (idarray[i] < 0)
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				"msgget() allocation error");
+	}
+
+	tst_resm(TINFO, "%d message queues allocated", MSGMNI);
+
+	sigrelse(SIGINT);
+	sigrelse(SIGTERM);
+
 /*-----------------------------------------------------------------*/
 	/* Fork a number of processes (nprocs), each of which will
-	 * create a message queue with several (nkids) reader/writer
-	 * pairs which will read and write a number (iterations)
-	 * of random length messages with specific values (keys).
+	 * be passed a number of "open" message queues. For each queue
+	 * it will sequentially fork a reader/writer pair which will
+	 * read and write a number (iterations) of random length messages
+	 * with specific values (keys).
 	 */
-
+	idx = 0;
 	for (i = 0; i < nprocs; i++) {
+		if (force_exit)
+			break;
+
+		idxarray[i] = idx;
+		idx += nqueues_per_proc[i];
+
 		fflush(stdout);
 		if ((pid = FORK_OR_VFORK()) < 0) {
 			tst_resm(TFAIL,
 				 "\tFork failed (may be OK if under stress)");
-			tst_exit();
+			break;
 		}
 		/* Child does this */
 		if (pid == 0) {
 #ifdef UCLINUX
-			if (self_exec(argv[0], "ndd", 1, keyarray[i], i) < 0) {
-				tst_resm(TFAIL, "\tself_exec failed");
-				tst_exit();
+			if (self_exec(argv[0], "ndd", 1, i) < 0) {
+				printf("self_exec failed: %s\n",
+					strerror(errno));
+
+				exit(FAIL);
 			}
 #else
 			procstat = 1;
-			exit(dotest(keyarray[i], i));
+			exit(dotest(i));
 #endif
 		}
 		pidarray[i] = pid;
@@ -244,7 +262,7 @@ char *argv[];
 			if (status >> 8 != PASS) {
 				tst_resm(TFAIL, "Child exit status = %d",
 					 status >> 8);
-				tst_exit();
+/*				tst_exit(); */
 			}
 			count++;
 		} else {
@@ -257,17 +275,21 @@ char *argv[];
 		}
 	}
 	/* Make sure proper number of children exited */
-	if (count != nprocs) {
+	if (count != nprocs)
 		tst_resm(TFAIL,
 			 "Wrong number of children exited, Saw %d, Expected %d",
 			 count, nprocs);
-		tst_exit();
-	}
 
-	tst_resm(TPASS, "msgctl11 ran successfully!");
+	if (force_exit)
+		tst_resm(TFAIL,
+			"msgctl11 failed (SIGTERM or SIGINT was received)");
+	else
+		tst_resm(TPASS, "msgctl11 ran successfully!");
 
 	cleanup();
 
+	tst_exit();
+
 	return (0);
 
 }
@@ -294,239 +316,194 @@ void do_child_3_uclinux()
 }
 #endif
 
-void cleanup_msgqueue(int i, int tid)
+static int dotest(int child_process)
 {
-	/*
-	 * Decrease the value of i by 1 because it
-	 * is getting incremented even if the fork
-	 * is failing.
-	 */
-
-	i--;
-	/*
-	 * Kill all children & free message queue.
-	 */
-	for (; i >= 0; i--) {
-		(void)kill(rkidarray[i], SIGKILL);
-		(void)kill(wkidarray[i], SIGKILL);
-	}
-
-	if (msgctl(tid, IPC_RMID, 0) < 0) {
-		tst_resm(TFAIL | TERRNO, "Msgctl error in cleanup");
-		tst_exit();
-	}
-}
-
-int dotest(key, child_process)
-key_t key;
-int child_process;
-{
-	int id, pid;
-	int i, count, status, exit_status;
+	pid_t pid;
+	int id;
+	int i, count, status;
+	int nqueues;
+	key_t key;
 
-	sighold(SIGTERM);
-	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
-		tst_resm(TFAIL | TERRNO, "Msgget error in child %d",
-			 child_process);
-		tst_exit();
-	}
-	tid = id;
-	sigrelse(SIGTERM);
+	nqueues = nqueues_per_proc[child_process];
 
-	exit_status = PASS;
+	for (i = 0; i < nqueues; i++) {
+		key = keyarray[idxarray[child_process] + i];
+		id = idarray[idxarray[child_process] + i];
 
-	for (i = 0; i < nkids; i++) {
 		fflush(stdout);
 		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_resm(TWARN,
-				 "Fork failure in first child of child group %d",
-				 child_process);
-			cleanup_msgqueue(i, tid);
-			tst_exit();
+			printf("Fork failure for the reader child of child group %d: %s\n",
+				child_process, strerror(errno));
+
+			exit(FAIL);
 		}
+
 		/* First child does this */
 		if (pid == 0) {
 #ifdef UCLINUX
 			if (self_exec(argv0, "nddd", 2, key, getpid(),
 				      child_process) < 0) {
-				tst_resm(TWARN, "self_exec failed");
-				cleanup_msgqueue(i, tid);
-				tst_exit();
+				printf("self_exec failed in the reader child of child group %d: %s\n",
+					child_process, strerror(errno));
+
+				exit(FAIL);
 			}
 #else
 			procstat = 2;
-			exit(doreader(key, getpid(), child_process));
+			exit(doreader(key, id, getpid(), child_process));
 #endif
 		}
-		rkidarray[i] = pid;
+		rkidpid = pid;
+
 		fflush(stdout);
 		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_resm(TWARN,
-				 "Fork failure in first child of child group %d",
-				 child_process);
-			/*
-			 * Kill the reader child process
-			 */
-			(void)kill(rkidarray[i], SIGKILL);
-
-			cleanup_msgqueue(i, tid);
-			tst_exit();
+			printf("Fork failure for the writer child of child group %d: %s\n",
+				child_process, strerror(errno));
+
+			/* Kill the reader child process */
+			(void)kill(rkidpid, SIGKILL);
+
+			exit(FAIL);
 		}
 		/* Second child does this */
 		if (pid == 0) {
 #ifdef UCLINUX
-			if (self_exec(argv0, "nddd", 3, key, rkidarray[i],
+			if (self_exec(argv0, "nddd", 3, key, rkidpid,
 				      child_process) < 0) {
-				tst_resm(TWARN, "\tFork failure in first child "
-					 "of child group %d \n", child_process);
-				/*
-				 * Kill the reader child process
-				 */
-				(void)kill(rkidarray[i], SIGKILL);
-
-				cleanup_msgqueue(i, tid);
-				tst_exit();
+				printf("self_exec failed in the writer child of child group %d: %s\n",
+					child_process, strerror(errno));
+
+				/* Kill the reader child process */
+				(void)kill(rkidpid, SIGKILL);
+
+				exit(FAIL);
 			}
 #else
 			procstat = 2;
-			exit(dowriter(key, rkidarray[i], child_process));
+			exit(dowriter(key, id, rkidpid, child_process));
 #endif
 		}
-		wkidarray[i] = pid;
-	}
-	/* Parent does this */
-	count = 0;
-	while (1) {
-		if ((wait(&status)) > 0) {
-			if (status >> 8 != PASS) {
-				tst_resm(TFAIL,
-					 "Child exit status = %d from child group %d",
-					 status >> 8, child_process);
-				for (i = 0; i < nkids; i++) {
-					kill(rkidarray[i], SIGTERM);
-					kill(wkidarray[i], SIGTERM);
-				}
-				if (msgctl(tid, IPC_RMID, 0) < 0) {
-					tst_resm(TFAIL | TERRNO,
-						 "Msgctl error");
+		wkidpid = pid;
+
+		/* Parent does this */
+		count = 0;
+		while (1) {
+			if ((wait(&status)) > 0) {
+				if (status >> 8 != PASS) {
+					printf("Child exit status = %d from child group %d\n",
+						status >> 8, child_process);
+
+					kill(rkidpid, SIGTERM);
+					kill(wkidpid, SIGTERM);
+
+					exit(FAIL);
 				}
-				tst_exit();
-			}
-			count++;
-		} else {
-			if (errno != EINTR) {
-				break;
+				count++;
+			} else {
+				if (errno != EINTR)
+					break;
 			}
 		}
-	}
-	/* Make sure proper number of children exited */
-	if (count != (nkids * 2)) {
-		tst_resm(TFAIL,
-			 "Wrong number of children exited in child group %d, Saw %d Expected %d",
-			 child_process, count, (nkids * 2));
-		if (msgctl(tid, IPC_RMID, 0) < 0) {
-			tst_resm(TFAIL | TERRNO, "Msgctl error");
+
+		/* Make sure proper number of children exited */
+		if (count != 2) {
+			printf("Wrong number of children exited in child group %d, Saw %d Expected %d\n",
+				child_process, count, 2);
+
+			exit(FAIL);
 		}
-		tst_exit();
-	}
-	if (msgctl(id, IPC_RMID, 0) < 0) {
-		tst_resm(TFAIL | TERRNO, "Msgctl failure in child group %d",
-			 child_process);
-		tst_exit();
 	}
-	exit(exit_status);
+
+	exit(PASS);
 }
 
-int doreader(key, type, child)
-int type, child;
-long key;
+static int doreader(key_t key, int tid, int type, int child)
 {
 	int i, size;
 	int id;
 
 	if ((id = msgget(key, 0)) < 0) {
-		tst_resm(TFAIL | TERRNO,
-			 "Msgget error in reader of child group %d", child);
-		tst_exit();
+		printf("msgget() error in the reader of child group %d: %s\n",
+			child, strerror(errno));
+
+		exit(FAIL);
 	}
 	if (id != tid) {
-		tst_resm(TFAIL,
-			 "Message queue mismatch in reader of child group %d for message queue id %d",
-			 child, id);
-		tst_exit();
+		printf("Message queue mismatch in the reader of child group %d for message queue id %lx\n",
+			child, (long)key);
+
+		exit(FAIL);
 	}
 	for (i = 0; i < nreps; i++) {
 		if ((size = msgrcv(id, &buffer, 100, type, 0)) < 0) {
-			tst_resm(TFAIL | TERRNO,
-				 "Msgrcv error in child %d, read # = %d",
-				 (i + 1), child);
-			tst_exit();
+			printf("msgrcv() error in child %d, read # = %d: %s\n",
+				child, (i + 1), strerror(errno));
+
+			exit(FAIL);
 		}
 		if (buffer.type != type) {
-			tst_resm(TFAIL,
-				 "Size mismatch in child %d, read # = %d",
-				 child, (i + 1));
-			tst_resm(TFAIL,
-				 "\tfor message size got  %d expected  %d",
-				 size, buffer.data.len);
-			tst_exit();
+			printf("Size mismatch in child %d, read #d = %d;\n"
+				"\tfor message size got %d, expected %d\n",
+				child, (i + 1), size, buffer.data.len);
+
+			exit(FAIL);
 		}
 		if (buffer.data.len + 1 != size) {
-			tst_resm(TFAIL,
-				 "Size mismatch in child %d, read # = %d, size = %d, expected = %d",
-				 child, (i + 1), buffer.data.len, size);
-			tst_exit();
+			printf("Size mismatch in child %d, read # = %d, size = %d, expected = %d\n",
+				child, (i + 1), buffer.data.len, size);
+
+			exit(FAIL);
 		}
 		if (verify(buffer.data.pbytes, (key % 255), size - 1, child)) {
-			tst_resm(TFAIL, "in child %d read # = %d,key =  %lx",
-				 child, (i + 1), key);
-			tst_exit();
+			printf("In child %d read # = %d, key = %lx\n",
+				child, (i + 1), (long)key);
+
+			exit(FAIL);
 		}
 		key++;
 	}
 	exit(PASS);
 }
 
-int dowriter(key, type, child)
-int type, child;
-long key;
+static int dowriter(key_t key, int tid, int type, int child)
 {
 	int i, size;
 	int id;
 
 	if ((id = msgget(key, 0)) < 0) {
-		tst_resm(TFAIL | TERRNO,
-			 "Msgget error in writer of child group %d", child);
-		tst_exit();
+		printf("msgget() error in the writer of child group %d: %s\n",
+			child, strerror(errno));
+
+		exit(FAIL);
 	}
 	if (id != tid) {
-		tst_resm(TFAIL,
-			 "Message queue mismatch in writer of child group %d",
-			 child);
-		tst_resm(TFAIL, "\tfor message queue id %d expected  %d", id,
-			 tid);
-		tst_exit();
+		printf("Message queue mismatch in the writer of child group %d for message queue key %lx\n",
+			child, (long)key);
+
+		exit(FAIL);
 	}
 
 	for (i = 0; i < nreps; i++) {
 		do {
 			size = (lrand48() % 99);
 		} while (size == 0);
+
 		fill_buffer(buffer.data.pbytes, (key % 255), size);
 		buffer.data.len = size;
 		buffer.type = type;
+
 		if (msgsnd(id, &buffer, size + 1, 0) < 0) {
-			tst_resm(TFAIL | TERRNO,
-				 "Msgsnd error in child %d, key =   %lx",
-				 child, key);
-			tst_exit();
+			printf("msgsnd() error in child %d, key = %lx: %s\n",
+				child, (long)key, strerror(errno));
+
+			exit(FAIL);
 		}
 		key++;
 	}
 	exit(PASS);
 }
 
-int fill_buffer(buf, val, size)
+static int fill_buffer(buf, val, size)
 register char *buf;
 char val;
 register int size;
@@ -543,7 +520,7 @@ register int size;
  *	Check a buffer for correct values.
  */
 
-int verify(buf, val, size, child)
+static int verify(buf, val, size, child)
 register char *buf;
 char val;
 register int size;
@@ -560,40 +537,39 @@ int child;
 }
 
 /* ARGSUSED */
-void term(int sig)
+static void term(int sig)
 {
 	int i;
 
+	/* parent (main) process */
 	if (procstat == 0) {
+		/* if we are here we cannot guarantee that the testcase is ok */
+		force_exit = 1;
 #ifdef DEBUG
-		tst_resm(TINFO, "SIGTERM signal received, test killing kids");
+		tst_resm(TINFO,
+			"SIGTERM or SIGINT signal received, test killing kids");
 #endif
 		for (i = 0; i < nprocs; i++) {
-			if (pidarray[i] > 0) {
-				if (kill(pidarray[i], SIGTERM) < 0) {
-					tst_resm(TBROK,
-						 "Kill failed to kill child %d",
-						 i);
-					exit(FAIL);
-				}
-			}
+			if (pidarray[i] > 0)
+				kill(pidarray[i], SIGTERM);
 		}
 		return;
 	}
 
-	if (procstat == 2) {
-		fflush(stdout);
+	/* child */
+	if (procstat == 1) {
+		if (rkidpid > 0)
+			kill(rkidpid, SIGTERM);
+		if (wkidpid > 0)
+			kill(wkidpid, SIGTERM);
+
 		exit(PASS);
 	}
 
-	if (tid == -1) {
-		exit(FAIL);
-	}
-	for (i = 0; i < nkids; i++) {
-		if (rkidarray[i] > 0)
-			kill(rkidarray[i], SIGTERM);
-		if (wkidarray[i] > 0)
-			kill(wkidarray[i], SIGTERM);
+	/* grandchild (reader or writer) */
+	if (procstat == 2) {
+		fflush(stdout);
+		exit(PASS);
 	}
 }
 
@@ -602,6 +578,7 @@ void term(int sig)
  *****************************************************************/
 void setup()
 {
+	int i;
 	int nr_msgqs, free_pids;
 
 	tst_tmpdir();
@@ -618,35 +595,36 @@ void setup()
 
 	nr_msgqs = get_max_msgqueues();
 	if (nr_msgqs < 0)
-		cleanup();
+		tst_brkm(TBROK, cleanup, "get_max_msgqueues() failed");
 
 	MSGMNI = nr_msgqs - get_used_msgqueues();
-	if (MSGMNI <= 0) {
-		tst_resm(TBROK,
+	if (MSGMNI <= 0)
+		tst_brkm(TBROK, cleanup,
 			 "Max number of message queues already used, cannot create more.");
-		cleanup();
-	}
 
 	free_pids = get_free_pids();
 	if (free_pids < 0) {
-		tst_resm(TBROK, "Can't obtain free_pid count");
-		tst_exit();
+		tst_brkm(TBROK, cleanup, "Can't obtain free_pid count");
+	} else if (!free_pids) {
+		tst_brkm(TBROK, cleanup, "No free pids");
+	} else if ((free_pids / 2) < (1 + 2)) {
+		tst_brkm(TBROK, cleanup, "Not enough free pids");
 	}
 
-	else if (!free_pids) {
-		tst_resm(TBROK, "No free pids");
-		tst_exit();
-	}
+       /* We don't use more that free_pids / 2 pids */
+	if (MSGMNI <= 3)
+		nprocs = 1;
+	else
+		nprocs = min(MSGMNI, (free_pids / 2)) / (1 + 2);
 
-	if ((MSGMNI * MAXNKIDS * 2) > (free_pids / 2)) {
-		maxnkids = ((free_pids / 4) / MSGMNI);
-		if (!maxnkids) {
-			tst_resm(TBROK, "Not enough free pids");
-			tst_exit();
-		}
-	}
+	/* Calculating a number of queues per child process */
+	for (i = 0; i < nprocs; i++)
+		nqueues_per_proc[i] = MSGMNI / nprocs;
+
+	/* The last process handles the rest of the available queues */
+	nqueues_per_proc[nprocs - 1] += MSGMNI % nprocs;
 
-	tst_resm(TINFO, "Using upto %d pids", free_pids / 2);
+	tst_resm(TINFO, "Using %d children", nprocs);
 }
 
 /***************************************************************
@@ -655,28 +633,27 @@ void setup()
  ****************************************************************/
 void cleanup()
 {
-	int status;
+	int i;
+	struct msqid_ds buf;
+
+
 	/*
 	 * print timing stats if that option was specified.
 	 * print errno log if that option was specified.
 	 */
 	TEST_CLEANUP;
 
-	/*
-	 * Remove the message queue from the system
-	 */
-#ifdef DEBUG
-	tst_resm(TINFO, "Removing the message queue");
-#endif
-	fflush(stdout);
-	(void)msgctl(tid, IPC_RMID, NULL);
-	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
-		(void)msgctl(tid, IPC_RMID, NULL);
-		tst_resm(TFAIL, "msgctl(tid, IPC_RMID) failed");
+	/* Remove the message queues from the system */
+	for (i = 0; i < MSGMNI; i++) {
+		if (idarray[i] > 0) {
+			if ((msgctl(idarray[i], IPC_STAT, &buf) != -1) &&
+				(msgctl(idarray[i], IPC_RMID, 0) < 0)) {
 
+				tst_resm(TFAIL, "Removal of queue id %d failed",
+					idarray[i]);
+			}
+		}
 	}
 
-	fflush(stdout);
 	tst_rmdir();
-
 }
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
