Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VbRks-00071B-1Y
	for ltp-list@lists.sourceforge.net; Wed, 30 Oct 2013 09:07:58 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VbRkr-0000dB-5D
	for ltp-list@lists.sourceforge.net; Wed, 30 Oct 2013 09:07:58 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9U97p68024293
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Oct 2013 09:07:51 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9U97niw027155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Oct 2013 09:07:49 GMT
Received: from abhmt105.oracle.com (abhmt105.oracle.com [141.146.116.57])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9U97n5L020866
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Oct 2013 09:07:49 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 30 Oct 2013 13:07:38 +0400
Message-Id: <1383124058-13133-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <955388781.15408075.1383042634142.JavaMail.root@redhat.com>
References: <955388781.15408075.1383042634142.JavaMail.root@redhat.com>
Subject: [LTP] [PATCH V2 2/2] setpgid03: use SIGUSR1 instead of sleep
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

I came accross the following rare issue:

setpgid03    1  TPASS  :  setpgid SUCCESS to set errno to EPERM
setpgid03    2  TFAIL  :  setpgid FAILED, expect EACCES got 1

I suppose It may happen if the test host is under stress.

To prevent this It would be better to use SIGUSR1 for parent-child
synchronisations.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/setpgid/setpgid03.c |  123 +++++++++++++++++++++++--
 1 files changed, 115 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 2c47bc4..34975b7 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -34,15 +35,20 @@
 char *TCID = "setpgid03";
 int TST_TOTAL = 1;
 
+static pid_t pid = -1;
+
 static void do_child(void);
+static void sigusr_handler(int signum);
+static void term_handler(int signum);
 static void setup(void);
 static void cleanup(void);
 
 int main(int ac, char **av)
 {
-	int pid;
 	int rval;
 	int status;
+	sigset_t sig_set;
+	struct sigaction sa;
 
 	int lc;
 	char *msg;
@@ -56,12 +62,42 @@ int main(int ac, char **av)
 
 	setup();
 
+	/* We need to block these signals before fork()
+	 * because our children may terminate either
+	 * normally (parent receives both SIGUSR1 and SIGCHLD) or
+	 * abnormally (parent receives SIGCHLD only)
+	 */
+	sigemptyset(&sig_set);
+	sigaddset(&sig_set, SIGUSR1);
+	sigaddset(&sig_set, SIGCHLD);
+
+	/* Since we use SIGUSR1 as a control signal It should not
+	 * be an "unexpected" one
+	 */
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = sigusr_handler;
+	if (sigaction(SIGUSR1, &sa, NULL) < 0)
+		tst_brkm(TFAIL | TERRNO, cleanup, "sigaction(SIGUSR1) failed");
+
+	/* But for SIGINT, SIGTERM we should kill our children */
+	sa.sa_handler = term_handler;
+	if (sigaction(SIGTERM, &sa, NULL) < 0)
+		tst_brkm(TFAIL | TERRNO, cleanup, "sigaction(SIGTERM) failed");
+	if (sigaction(SIGINT, &sa, NULL) < 0)
+		tst_brkm(TFAIL | TERRNO, cleanup, "sigaction(SIGINT) failed");
+
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
 
 //test1:
 		/* sid of the calling process is not same */
+
+		if (sigprocmask(SIG_BLOCK, &sig_set, NULL) < 0)
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				"sigprocmask(SIG_BLOCK) in test 1 failed");
+
+
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork() failed");
 		}
@@ -76,7 +112,14 @@ int main(int ac, char **av)
 #endif
 		}
 
-		sleep(1);
+		if (sigwaitinfo(&sig_set, NULL) < 0)
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				"sigwaitinfo() failed");
+
+		if (sigprocmask(SIG_UNBLOCK, &sig_set, NULL) < 0)
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				"sigprocmask(SIG_UNBLOCK) in test 2 failed");
+
 		rval = setpgid(pid, getppid());
 		if (errno == EPERM) {
 			tst_resm(TPASS,
@@ -86,11 +129,14 @@ int main(int ac, char **av)
 				"setpgid FAILED, expect %d, return %d",
 				EPERM, errno);
 		}
-		sleep(1);
+
+		kill(pid, SIGUSR1);
 
 		if (wait(&status) < 0)
 			tst_resm(TFAIL | TERRNO, "wait() for child 1 failed");
 
+		pid = -1;
+
 		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
 			tst_resm(TFAIL, "child 1 failed with status %d",
 				WEXITSTATUS(status));
@@ -100,18 +146,47 @@ int main(int ac, char **av)
 		 * Value of pid matches the pid of the child process and
 		 * the child process has exec successfully. Error
 		 */
+
+		if (sigprocmask(SIG_BLOCK, &sig_set, NULL) < 0)
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				"sigprocmask(SIG_BLOCK) in test 2 failed");
+
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_resm(TFAIL, "Fork failed");
 
 		}
 		if (pid == 0) {
-			if (execlp("sleep", "sleep", "3", NULL) < 0) {
-				perror("exec failed");
+			char buf[10];
+			int ret;
+
+			ret = snprintf(buf, 10, "%d", getppid());
+			if ((ret >= 10) || (ret <= 0)) {
+				printf("snprintf() failed\n");
+
+				exit(126);
 			}
+
+			const char *args[4 + 1];
+			args[0] = "kill";
+			args[1] = "-s";
+			args[2] = "SIGUSR1";
+			args[3] = buf;
+			args[4] = NULL;
+
+			if (execvp(args[0], (char *const *)args) < 0)
+				perror("execvp() failed\n");
+
 			exit(127);
 		}
 
-		sleep(1);
+		if (sigwaitinfo(&sig_set, NULL) < 0)
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				"sigwaitinfo() failed");
+
+		if (sigprocmask(SIG_UNBLOCK, &sig_set, NULL) < 0)
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				"sigprocmask(SIG_UNBLOCK) in test 2 failed");
+
 		rval = setpgid(pid, getppid());
 		if (errno == EACCES) {
 			tst_resm(TPASS,
@@ -124,6 +199,8 @@ int main(int ac, char **av)
 		if (wait(&status) < 0)
 			tst_resm(TFAIL | TERRNO, "wait() for child 2 failed");
 
+		pid = -1;
+
 		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
 			tst_resm(TFAIL, "child 2 failed with status %d",
 				WEXITSTATUS(status));
@@ -136,18 +213,48 @@ int main(int ac, char **av)
 static void do_child(void)
 {
 	int exno = 0;
+	sigset_t set;
 
 	if (setsid() < 0) {
 		printf("setsid() failed, errno: %d\n", errno);
 		exno = 1;
 	}
-	sleep(2);
+
+	kill(getppid(), SIGUSR1);
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_UNBLOCK, &set, NULL) < 0) {
+		printf("sigprocmask() in child failed: %d\n", errno);
+
+		exit(1);
+	}
+
+	pause();
+
 	exit(exno);
 }
 
-static void setup(void)
+static void sigusr_handler(int signum)
 {
+}
+
+static void term_handler(int signum)
+{
+	if (pid == 0) {
+		printf("Child received signal %d\n", signum);
 
+		exit(1);
+	} else {
+		if (pid > 0)
+			kill(pid, signum);
+
+		tst_brkm(TFAIL, cleanup, "Signal %d received. Exiting", signum);
+	}
+}
+
+static void setup(void)
+{
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	umask(0);
-- 
1.7.1


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
