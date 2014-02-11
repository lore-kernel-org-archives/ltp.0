Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WDF7L-00061x-1d
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 15:19:23 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WDF7F-0001Tz-DB
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 15:19:23 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1BFJBfG032339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 15:19:11 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1BFJAeQ024211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 15:19:11 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1BFJA2d000619
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 15:19:10 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 11 Feb 2014 19:19:03 +0400
Message-Id: <1392131944-27263-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140211142336.GA14876@rei.Home>
References: <20140211142336.GA14876@rei.Home>
Subject: [LTP] [PATCH V2 1/2] msgctl11: cleanup and fflush removed
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

Performed some cleanup and removed fflush() from the
testcase.

fflush() before FORK_OR_VFORK() is not needed because of
commit 3f0510cb2d18720e294e89fbdb4ce38e0ede47d6

fflush() before exit() is redundant.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c |   83 ++++++++--------------
 1 files changed, 30 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
index 57f4ae0..63ff88f 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
@@ -77,9 +77,9 @@ static int pid_uclinux;
 static int child_process_uclinux;
 static int rkid_uclinux;
 
-static void do_child_1_uclinux();
-static void do_child_2_uclinux();
-static void do_child_3_uclinux();
+static void do_child_1_uclinux(void);
+static void do_child_2_uclinux(void);
+static void do_child_3_uclinux(void);
 #endif
 
 int main(int argc, char **argv)
@@ -137,21 +137,19 @@ int main(int argc, char **argv)
 			nkids = atoi(argv[3]);
 		}
 	} else {
-		tst_resm(TCONF,
+		tst_brkm(TCONF, cleanup,
 			 " Usage: %s [ number of iterations  number of processes number of read/write pairs ]",
 			 argv[0]);
-		tst_exit();
 	}
 
 	procstat = 0;
 	srand48((unsigned)getpid() + (unsigned)(getppid() << 16));
 	tid = -1;
 
-	/* Setup signal handleing routine */
-	if (sigset(SIGTERM, term) == SIG_ERR) {
-		tst_resm(TFAIL, "Sigset SIGTERM failed");
-		tst_exit();
-	}
+	/* Setup signal handling routine */
+	if (sigset(SIGTERM, term) == SIG_ERR)
+		tst_brkm(TFAIL, cleanup, "Sigset SIGTERM failed");
+
 	/* Set up array of unique keys for use in allocating message
 	 * queues
 	 */
@@ -181,18 +179,16 @@ int main(int argc, char **argv)
 	 */
 
 	for (i = 0; i < nprocs; i++) {
-		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_resm(TFAIL,
-				 "\tFork failed (may be OK if under stress)");
-			tst_exit();
-		}
+		if ((pid = FORK_OR_VFORK()) < 0)
+			tst_brkm(TFAIL, cleanup,
+				 "Fork failed (may be OK if under stress)");
+
 		/* Child does this */
 		if (pid == 0) {
 #ifdef UCLINUX
 			if (self_exec(argv[0], "ndd", 1, keyarray[i], i) < 0) {
-				tst_resm(TFAIL, "\tself_exec failed");
-				tst_exit();
+				printf("\tself_exec failed\n");
+				exit(FAIL);
 			}
 #else
 			procstat = 1;
@@ -205,11 +201,9 @@ int main(int argc, char **argv)
 	count = 0;
 	while (1) {
 		if ((wait(&status)) > 0) {
-			if (status >> 8 != PASS) {
-				tst_resm(TFAIL, "Child exit status = %d",
-					 status >> 8);
-				tst_exit();
-			}
+			if (status >> 8 != PASS)
+				tst_brkm(TFAIL, cleanup,
+					"Child exit status = %d", status >> 8);
 			count++;
 		} else {
 			if (errno != EINTR) {
@@ -221,19 +215,15 @@ int main(int argc, char **argv)
 		}
 	}
 	/* Make sure proper number of children exited */
-	if (count != nprocs) {
-		tst_resm(TFAIL,
+	if (count != nprocs)
+		tst_brkm(TFAIL, cleanup,
 			 "Wrong number of children exited, Saw %d, Expected %d",
 			 count, nprocs);
-		tst_exit();
-	}
 
 	tst_resm(TPASS, "msgctl11 ran successfully!");
 
 	cleanup();
-
-	return (0);
-
+	tst_exit();
 }
 
 #ifdef UCLINUX
@@ -276,8 +266,8 @@ static void cleanup_msgqueue(int i, int tid)
 	}
 
 	if (msgctl(tid, IPC_RMID, 0) < 0) {
-		tst_resm(TFAIL | TERRNO, "Msgctl error in cleanup");
-		tst_exit();
+		printf("Msgctl error in cleanup_msgqueue %d\n", errno);
+		exit(FAIL);
 	}
 }
 
@@ -298,7 +288,6 @@ static int dotest(key_t key, int child_process)
 	exit_status = PASS;
 
 	for (i = 0; i < nkids; i++) {
-		fflush(stdout);
 		if ((pid = FORK_OR_VFORK()) < 0) {
 			printf("Fork failure in the first child of child group %d\n",
 				child_process);
@@ -321,7 +310,6 @@ static int dotest(key_t key, int child_process)
 #endif
 		}
 		rkidarray[i] = pid;
-		fflush(stdout);
 		if ((pid = FORK_OR_VFORK()) < 0) {
 			printf("Fork failure in the second child of child group %d\n",
 				child_process);
@@ -420,7 +408,6 @@ static void term(int sig)
 	}
 
 	if (procstat == 2) {
-		fflush(stdout);
 		exit(PASS);
 	}
 
@@ -453,32 +440,24 @@ void setup(void)
 
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
-	}
-
-	else if (!free_pids) {
-		tst_resm(TBROK, "No free pids");
-		tst_exit();
+		tst_brkm(TBROK, cleanup, "Can't obtain free_pid count");
+	} else if (!free_pids) {
+		tst_brkm(TBROK, cleanup, "No free pids");
 	}
 
 	if ((MSGMNI * MAXNKIDS * 2) > (free_pids / 2)) {
 		maxnkids = ((free_pids / 4) / MSGMNI);
-		if (!maxnkids) {
-			tst_resm(TBROK, "Not enough free pids");
-			tst_exit();
-		}
+		if (!maxnkids)
+			tst_brkm(TBROK, cleanup, "Not enough free pids");
 	}
 
 	tst_resm(TINFO, "Using upto %d pids", free_pids / 2);
@@ -496,7 +475,6 @@ void cleanup(void)
 #ifdef DEBUG
 	tst_resm(TINFO, "Removing the message queue");
 #endif
-	fflush(stdout);
 	(void)msgctl(tid, IPC_RMID, NULL);
 	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
 		(void)msgctl(tid, IPC_RMID, NULL);
@@ -504,6 +482,5 @@ void cleanup(void)
 
 	}
 
-	fflush(stdout);
 	tst_rmdir();
 }
-- 
1.7.1


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
