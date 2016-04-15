From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Fri, 15 Apr 2016 16:09:42 +0800
Subject: [LTP] [PATCH] mtest01/mtest01: break test if fork failed
Message-ID: <20160415080942.GA26368@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Please review this patch. Thanks.


Or a lot of processes will be killed when -1 being passed as pid to
kill().

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/mem/mtest01/mtest01.c | 35 +++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index 5fe4adc..61e3db9 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -52,6 +52,7 @@ char *TCID = "mtest01";
 int TST_TOTAL = 1;
 static sig_atomic_t pid_count;
 static sig_atomic_t sigchld_count;
+static pid_t *pid_list;
 
 static void handler(int signo)
 {
@@ -60,6 +61,18 @@ static void handler(int signo)
 	pid_count++;
 }
 
+static void cleanup(void)
+{
+	int i = 0;
+
+	while (pid_list[i] > 0) {
+		kill(pid_list[i], 9);
+		i++;
+	}
+
+	free(pid_list);
+}
+
 int main(int argc, char *argv[])
 {
 	int c;
@@ -73,7 +86,7 @@ int main(int argc, char *argv[])
 	int chunksize = 1024 * 1024;	/* one meg at a time by default */
 	struct sysinfo sstats;
 	int i, pid_cntr;
-	pid_t pid, *pid_list;
+	pid_t pid;
 	struct sigaction act;
 
 	act.sa_handler = handler;
@@ -177,15 +190,20 @@ int main(int argc, char *argv[])
 	i = 0;
 	pid_cntr = 0;
 	pid = fork();
-	if (pid != 0)
+	if (pid < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
+	if (pid != 0) {
 		pid_cntr++;
-	pid_list[i] = pid;
+		pid_list[i] = pid;
+	}
 
 #if defined (_s390_)		/* s390's 31bit addressing requires smaller chunks */
 	while (pid != 0 && maxbytes > FIVE_HUNDRED_MB) {
 		i++;
 		maxbytes -= FIVE_HUNDRED_MB;
 		pid = fork();
+		if (pid < 0)
+			tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
 		if (pid != 0) {
 			pid_cntr++;
 			pid_list[i] = pid;
@@ -201,6 +219,8 @@ int main(int argc, char *argv[])
 		i++;
 		maxbytes -= ONE_GB;
 		pid = fork();
+		if (pid < 0)
+		    tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
 		if (pid != 0) {
 			pid_cntr++;
 			pid_list[i] = pid;
@@ -216,6 +236,8 @@ int main(int argc, char *argv[])
 		i++;
 		maxbytes -= THREE_GB;
 		pid = fork();
+		if (pid < 0)
+			tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
 		if (pid != 0) {
 			pid_cntr++;
 			pid_list[i] = pid;
@@ -257,7 +279,6 @@ int main(int argc, char *argv[])
 		while (1)
 			sleep(1);
 	} else {
-		i = 0;
 		sysinfo(&sstats);
 
 		if (dowrite) {
@@ -295,11 +316,7 @@ int main(int argc, char *argv[])
 				 original_maxbytes / 1024);
 		}
 
-		while (pid_list[i] != 0) {
-			kill(pid_list[i], SIGKILL);
-			i++;
-		}
 	}
-	free(pid_list);
+	cleanup();
 	tst_exit();
 }
-- 
1.9.3

