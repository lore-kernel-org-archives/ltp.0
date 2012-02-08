Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1Rv0az-0005gb-2D
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 06:01:33 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rv0ax-0005Ha-Nh
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 06:01:32 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q1861N88027951
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Tue, 7 Feb 2012 22:01:23 -0800 (PST)
From: Jin Li <jin.li@windriver.com>
Date: Wed, 8 Feb 2012 14:01:21 +0800
Message-ID: <1328680881-19809-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] code style clean up
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

clean up the code style in msgctl11.c and ipcmsg.h

Signed-off-by: Jin Li <jin.li@windriver.com>
---
 testcases/kernel/syscalls/ipc/lib/ipcmsg.h      |   19 ++++-
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c |  116 +++++++++++-----------
 2 files changed, 76 insertions(+), 59 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/lib/ipcmsg.h b/testcases/kernel/syscalls/ipc/lib/ipcmsg.h
index 2f862cc..8555ba2 100644
--- a/testcases/kernel/syscalls/ipc/lib/ipcmsg.h
+++ b/testcases/kernel/syscalls/ipc/lib/ipcmsg.h
@@ -37,7 +37,7 @@ void setup(void);
 
 #define MSG_RD  0400            /* read permission for the queue */
 #define MSG_WR  0200            /* write permission for the queue */
-#define MSG_RW	MSG_RD | MSG_WR
+#define MSG_RW	(MSG_RD | MSG_WR)
 
 #define MSGSIZE	1024		/* a resonable size for a message */
 #define MSGTYPE 1		/* a type ID for a message */
@@ -66,5 +66,22 @@ int getuserid(char *);
 
 int get_max_msgqueues(void);
 int get_used_msgqueues(void);
+int dotest(key_t, int);
+int doreader(long, int, int);
+int dowriter(long, int, int);
+int fill_buffer(char *, char, int);
+int verify(char *, char, int, int);
+void setup();
+void cleanup();
+void term(int);
+#ifdef UCLINUX
+
+void do_child_1_uclinux();
+void do_child_2_uclinux();
+void do_child_3_uclinux();
+
+#endif
+
+void cleanup_msgqueue(int, int);
 
 #endif /* ipcmsg.h */
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
index 57bd184..b63e8d3 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
@@ -54,22 +54,14 @@
 
 #define MAXNREPS	1000
 #ifndef CONFIG_COLDFIRE
-#define MAXNPROCS	 1000000	/* This value is set to an arbitrary high limit. */
+#define MAXNPROCS	1000000 /*set this value to an arbitrary high limit */
 #else
-#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
+#define MAXNPROCS	100000	/* Coldfire can't deal with 1000000 */
 #endif
 #define MAXNKIDS	10
 #define FAIL		1
 #define PASS		0
 
-int dotest(key_t, int);
-int doreader(long, int, int);
-int dowriter(long, int, int);
-int fill_buffer(char *, char, int);
-int verify(char *, char, int, int);
-void setup();
-void cleanup();
-
 /*
  * These globals must be defined in the test.
  * */
@@ -96,22 +88,17 @@ int wkidarray[MAXNKIDS];
 int tid;
 int nprocs, nreps, nkids, MSGMNI;
 int procstat;
-void term(int);
+
 #ifdef UCLINUX
-static char *argv0;
 
-void do_child_1_uclinux();
+static char *argv0;
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
 #endif
-void cleanup_msgqueue(int i, int tid);
 
 /*-----------------------------------------------------------------*/
 int main(argc, argv)
@@ -127,10 +114,10 @@ char *argv[];
 	argv0 = argv[0];
 
 	/* parse standard options */
-	if ((msg =
-	     parse_opts(argc, argv, NULL, NULL)) != NULL) {
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	maybe_run_child(&do_child_1_uclinux, "ndd", 1, &key_uclinux,
 			&i_uclinux);
@@ -150,7 +137,8 @@ char *argv[];
 	} else if (argc == 4) {
 		if (atoi(argv[1]) > MAXNREPS) {
 			tst_resm(TCONF,
-				 "Requested number of iterations too large, setting to Max. of %d",
+				"Requested number of iterations too large, "
+				"setting to Max. of %d",
 				 MAXNREPS);
 			nreps = MAXNREPS;
 		} else {
@@ -158,7 +146,8 @@ char *argv[];
 		}
 		if (atoi(argv[2]) > MSGMNI) {
 			tst_resm(TCONF,
-				 "Requested number of processes too large, setting to Max. of %d",
+				 "Requested number of processes too large, "
+				 "setting to Max. of %d",
 				 MSGMNI);
 			nprocs = MSGMNI;
 		} else {
@@ -166,7 +155,8 @@ char *argv[];
 		}
 		if (atoi(argv[3]) > maxnkids) {
 			tst_resm(TCONF,
-				 "Requested number of read/write pairs too large; setting to Max. of %d",
+				 "Requested number of read/write pairs too "
+				 "large; setting to Max. of %d",
 				 maxnkids);
 			nkids = maxnkids;
 		} else {
@@ -174,7 +164,8 @@ char *argv[];
 		}
 	} else {
 		tst_resm(TCONF,
-			 " Usage: %s [ number of iterations  number of processes number of read/write pairs ]",
+			 " Usage: %s [ number of iterations  number of "
+			 "processes number of read/write pairs ]",
 			 argv[0]);
 		tst_exit();
 	}
@@ -219,7 +210,8 @@ char *argv[];
 
 	for (i = 0; i < nprocs; i++) {
 		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		pid = FORK_OR_VFORK();
+		if (pid  < 0) {
 			tst_resm(TFAIL,
 				 "\tFork failed (may be OK if under stress)");
 			tst_exit();
@@ -249,9 +241,8 @@ char *argv[];
 			}
 			count++;
 		} else {
-			if (errno != EINTR) {
+			if (errno != EINTR)
 				break;
-			}
 #ifdef DEBUG
 			tst_resm(TINFO, "Signal detected during wait");
 #endif
@@ -269,7 +260,7 @@ char *argv[];
 
 	cleanup();
 
-	return (0);
+	return 0;
 
 }
 
@@ -326,7 +317,8 @@ int child_process;
 	int i, count, status, exit_status;
 
 	sighold(SIGTERM);
-	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
+	id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR);
+	if (id < 0) {
 		tst_resm(TFAIL|TERRNO, "Msgget error in child %d",
 			 child_process);
 		tst_exit();
@@ -338,9 +330,10 @@ int child_process;
 
 	for (i = 0; i < nkids; i++) {
 		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		pid = FORK_OR_VFORK();
+		if (pid < 0) {
 			tst_resm(TWARN,
-				 "Fork failure in first child of child group %d",
+				"Fork failure in first child of child group %d",
 				 child_process);
 			cleanup_msgqueue(i, tid);
 			tst_exit();
@@ -361,9 +354,10 @@ int child_process;
 		}
 		rkidarray[i] = pid;
 		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		pid = FORK_OR_VFORK();
+		if (pid < 0) {
 			tst_resm(TWARN,
-				 "Fork failure in first child of child group %d",
+				"Fork failure in first child of child group %d",
 				 child_process);
 			/*
 			 * Kill the reader child process
@@ -379,7 +373,7 @@ int child_process;
 			if (self_exec(argv0, "nddd", 3, key, rkidarray[i],
 				      child_process) < 0) {
 				tst_resm(TWARN, "\tFork failure in first child "
-					 "of child group %d \n", child_process);
+					 "of child group %d\n", child_process);
 				/*
 				 * Kill the reader child process
 				 */
@@ -401,7 +395,8 @@ int child_process;
 		if ((wait(&status)) > 0) {
 			if (status >> 8 != PASS) {
 				tst_resm(TFAIL,
-					 "Child exit status = %d from child group %d",
+					"Child exit status = %d from child "
+					"group %d",
 					 status >> 8, child_process);
 				for (i = 0; i < nkids; i++) {
 					kill(rkidarray[i], SIGTERM);
@@ -415,19 +410,18 @@ int child_process;
 			}
 			count++;
 		} else {
-			if (errno != EINTR) {
+			if (errno != EINTR)
 				break;
-			}
 		}
 	}
 	/* Make sure proper number of children exited */
 	if (count != (nkids * 2)) {
 		tst_resm(TFAIL,
-			 "Wrong number of children exited in child group %d, Saw %d Expected %d",
+			 "Wrong number of children exited in child group %d, "
+			 "Saw %d Expected %d",
 			 child_process, count, (nkids * 2));
-		if (msgctl(tid, IPC_RMID, 0) < 0) {
+		if (msgctl(tid, IPC_RMID, 0) < 0)
 			tst_resm(TFAIL|TERRNO, "Msgctl error");
-		}
 		tst_exit();
 	}
 	if (msgctl(id, IPC_RMID, 0) < 0) {
@@ -445,7 +439,8 @@ long key;
 	int i, size;
 	int id;
 
-	if ((id = msgget(key, 0)) < 0) {
+	id = msgget(key, 0);
+	if (id < 0) {
 		tst_resm(TFAIL|TERRNO,
 			 "Msgget error in reader of child group %d",
 			 child);
@@ -453,12 +448,14 @@ long key;
 	}
 	if (id != tid) {
 		tst_resm(TFAIL,
-			 "Message queue mismatch in reader of child group %d for message queue id %d",
+			 "Message queue mismatch in reader of child group %d "
+			 "for message queue id %d",
 			 child, id);
 		tst_exit();
 	}
 	for (i = 0; i < nreps; i++) {
-		if ((size = msgrcv(id, &buffer, 100, type, 0)) < 0) {
+		size = msgrcv(id, &buffer, 100, type, 0);
+		if (size < 0) {
 			tst_resm(TFAIL|TERRNO,
 				 "Msgrcv error in child %d, read # = %d",
 				 (i + 1), child);
@@ -475,7 +472,8 @@ long key;
 		}
 		if (buffer.data.len + 1 != size) {
 			tst_resm(TFAIL,
-				 "Size mismatch in child %d, read # = %d, size = %d, expected = %d",
+				 "Size mismatch in child %d, read # = %d, "
+				 "size = %d, expected = %d",
 				 child, (i + 1), buffer.data.len, size);
 			tst_exit();
 		}
@@ -496,7 +494,8 @@ long key;
 	int i, size;
 	int id;
 
-	if ((id = msgget(key, 0)) < 0) {
+	id = msgget(key, 0);
+	if (id < 0) {
 		tst_resm(TFAIL|TERRNO,
 			 "Msgget error in writer of child group %d",
 			 child);
@@ -555,11 +554,12 @@ int child;
 	while (size-- > 0)
 		if (*buf++ != val) {
 			tst_resm(TWARN,
-				 "Verify error in child %d, *buf = %x, val = %x, size = %d",
+				 "Verify error in child %d, *buf = %x, "
+				 "val = %x, size = %d",
 				 child, *buf, val, size);
-			return (FAIL);
+			return FAIL;
 		}
-	return (PASS);
+	return PASS;
 }
 
 /* ARGSUSED */
@@ -589,9 +589,8 @@ void term(int sig)
 		exit(PASS);
 	}
 
-	if (tid == -1) {
+	if (tid == -1)
 		exit(FAIL);
-	}
 	for (i = 0; i < nkids; i++) {
 		if (rkidarray[i] > 0)
 			kill(rkidarray[i], SIGTERM);
@@ -613,9 +612,9 @@ void setup()
 	 */
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
-	 * fork the test with the -c option.  You want to make sure you do this
-	 * before you create your temporary directory.
+	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code
+	 * to fork the test with the -c option.  You want to make sure you do
+	 * this before you create your temporary directory.
 	 */
 	TEST_PAUSE;
 
@@ -626,7 +625,8 @@ void setup()
 	MSGMNI = nr_msgqs - get_used_msgqueues();
 	if (MSGMNI <= 0) {
 		tst_resm(TBROK,
-			 "Max number of message queues already used, cannot create more.");
+			 "Max number of message queues already used, "
+			 "cannot create more.");
 		cleanup();
 	}
 
@@ -673,13 +673,13 @@ void cleanup()
 #endif
 	fflush(stdout);
 	(void)msgctl(tid, IPC_RMID, NULL);
-	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
+	status = msgctl(tid, IPC_STAT, NULL);
+	if (status != -1) {
 		(void)msgctl(tid, IPC_RMID, NULL);
 		tst_resm(TFAIL, "msgctl(tid, IPC_RMID) failed");
-
 	}
 
 	fflush(stdout);
 	tst_rmdir();
 
-}
\ No newline at end of file
+}
-- 
1.6.3.1


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
