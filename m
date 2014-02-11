Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WDF7K-0006Wk-2B
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 15:19:22 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WDF7H-0004iA-2f
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 15:19:22 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1BFJCxq032404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 15:19:13 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1BFJCmI000716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 15:19:12 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s1BFJBMo013641
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Feb 2014 15:19:11 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 11 Feb 2014 19:19:04 +0400
Message-Id: <1392131944-27263-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1392131944-27263-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <20140211142336.GA14876@rei.Home>
	<1392131944-27263-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 2/2] msgctl11: process message queues by portions
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

Now if the amount of free pids is not enough to use all the queues at once
we process the queues by portions (with the size based on an amount of free pids).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c |   71 ++++++++++++++++-------
 1 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
index 63ff88f..9ef18da 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
@@ -60,6 +60,7 @@ static int rkidarray[MAXNKIDS];
 static int wkidarray[MAXNKIDS];
 static int tid;
 static int nprocs, nreps, nkids, MSGMNI;
+static int maxnprocs;
 static int procstat;
 
 void setup(void);
@@ -67,6 +68,7 @@ void cleanup(void);
 
 static void term(int);
 static int dotest(key_t, int);
+static void dotest_iteration(int off);
 static void cleanup_msgqueue(int i, int tid);
 
 #ifdef UCLINUX
@@ -84,8 +86,7 @@ static void do_child_3_uclinux(void);
 
 int main(int argc, char **argv)
 {
-	int i, j, ok, pid;
-	int count, status;
+	int i, j, ok;
 
 #ifdef UCLINUX
 	char *msg;
@@ -109,7 +110,6 @@ int main(int argc, char **argv)
 	if (argc == 1) {
 		/* Set default parameters */
 		nreps = MAXNREPS;
-		nprocs = MSGMNI;
 		nkids = maxnkids;
 	} else if (argc == 4) {
 		if (atoi(argv[1]) > MAXNREPS) {
@@ -120,13 +120,12 @@ int main(int argc, char **argv)
 		} else {
 			nreps = atoi(argv[1]);
 		}
-		if (atoi(argv[2]) > MSGMNI) {
+		if (atoi(argv[2]) > maxnprocs) {
 			tst_resm(TCONF,
 				 "Requested number of processes too large, setting to Max. of %d",
-				 MSGMNI);
-			nprocs = MSGMNI;
+				 maxnprocs);
 		} else {
-			nprocs = atoi(argv[2]);
+			maxnprocs = atoi(argv[2]);
 		}
 		if (atoi(argv[3]) > maxnkids) {
 			tst_resm(TCONF,
@@ -153,7 +152,7 @@ int main(int argc, char **argv)
 	/* Set up array of unique keys for use in allocating message
 	 * queues
 	 */
-	for (i = 0; i < nprocs; i++) {
+	for (i = 0; i < MSGMNI; i++) {
 		ok = 1;
 		do {
 			/* Get random key */
@@ -172,13 +171,45 @@ int main(int argc, char **argv)
 			}
 		} while (ok == 0);
 	}
-	/* Fork a number of processes (nprocs), each of which will
+	/* Fork a number of processes, each of which will
 	 * create a message queue with several (nkids) reader/writer
 	 * pairs which will read and write a number (iterations)
 	 * of random length messages with specific values (keys).
+	 *
+	 * We do not fork more than maxnprocs at a time and
+	 * we fork until all the message queues get used.
 	 */
 
+	if (MSGMNI <= maxnprocs) {
+		nprocs = MSGMNI;
+		dotest_iteration(0);
+	} else {
+		for (i = 0; i < (MSGMNI / maxnprocs); i++) {
+			nprocs = maxnprocs;
+			dotest_iteration(i*(MSGMNI / maxnprocs));
+		}
+
+		nprocs = MSGMNI % maxnprocs;
+		dotest_iteration(i*(MSGMNI / maxnprocs));
+	}
+
+	tst_resm(TPASS, "msgctl11 ran successfully!");
+
+	cleanup();
+	tst_exit();
+}
+
+static void dotest_iteration(int off)
+{
+	key_t key;
+	int i, count, status;
+	pid_t pid;
+
+	memset(pidarray, 0, sizeof(pidarray));
+
 	for (i = 0; i < nprocs; i++) {
+		key = keyarray[off + i];
+
 		if ((pid = FORK_OR_VFORK()) < 0)
 			tst_brkm(TFAIL, cleanup,
 				 "Fork failed (may be OK if under stress)");
@@ -186,13 +217,13 @@ int main(int argc, char **argv)
 		/* Child does this */
 		if (pid == 0) {
 #ifdef UCLINUX
-			if (self_exec(argv[0], "ndd", 1, keyarray[i], i) < 0) {
+			if (self_exec(argv0, "ndd", 1, key, i) < 0) {
 				printf("\tself_exec failed\n");
 				exit(FAIL);
 			}
 #else
 			procstat = 1;
-			exit(dotest(keyarray[i], i));
+			exit(dotest(key, i));
 #endif
 		}
 		pidarray[i] = pid;
@@ -219,11 +250,6 @@ int main(int argc, char **argv)
 		tst_brkm(TFAIL, cleanup,
 			 "Wrong number of children exited, Saw %d, Expected %d",
 			 count, nprocs);
-
-	tst_resm(TPASS, "msgctl11 ran successfully!");
-
-	cleanup();
-	tst_exit();
 }
 
 #ifdef UCLINUX
@@ -447,6 +473,8 @@ void setup(void)
 		tst_brkm(TBROK, cleanup,
 			 "Max number of message queues already used, cannot create more.");
 
+	tst_resm(TINFO, "Found %d available message queues", MSGMNI);
+
 	free_pids = get_free_pids();
 	if (free_pids < 0) {
 		tst_brkm(TBROK, cleanup, "Can't obtain free_pid count");
@@ -454,11 +482,12 @@ void setup(void)
 		tst_brkm(TBROK, cleanup, "No free pids");
 	}
 
-	if ((MSGMNI * MAXNKIDS * 2) > (free_pids / 2)) {
-		maxnkids = ((free_pids / 4) / MSGMNI);
-		if (!maxnkids)
-			tst_brkm(TBROK, cleanup, "Not enough free pids");
-	}
+	/* We don't use more than a half of available pids.
+	 * For each child we fork up to 2*maxnkids grandchildren. */
+	maxnprocs = (free_pids / 2) / (1 + 2 * maxnkids);
+
+	if (!maxnprocs)
+		tst_brkm(TBROK, cleanup, "Not enough free pids");
 
 	tst_resm(TINFO, "Using upto %d pids", free_pids / 2);
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
