Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XBjUP-0001AM-Mm
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 11:53:13 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XBjUO-0001Hq-0l
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 11:53:13 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6SBr9eV016791
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Jul 2014 19:53:09 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 28 Jul 2014 19:51:41 +0800
Message-ID: <1406548301-21888-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1406548301-21888-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <20140722143000.GA22955@rei>
	<1406548301-21888-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 3/3] syscalls: fix testcases which take TCONF as
	TFAIL
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

This issue was introduced by commit: 6f6878f4e1406d79cae53564777c5e1245d2a124
In this commit, we took TCONF as a special state, to let user know the real
LTP test coverage.

But setreuid04.c, setreuid05.c, setreuid07.c and setfsuid04.c do real test
work in child process, if 16-bit version of setreuid or setfsuid is not supported
on some platforms, child process will return a TCONF(see syscalls/utils/compat_16.h),
then parent process will get a non-zero return value and take it as TFAIL directly, fix this.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/setfsuid/setfsuid04.c | 28 ++++++++++---------------
 testcases/kernel/syscalls/setreuid/setreuid04.c | 17 +++------------
 testcases/kernel/syscalls/setreuid/setreuid05.c | 16 +++-----------
 testcases/kernel/syscalls/setreuid/setreuid07.c | 26 ++++++++++-------------
 4 files changed, 28 insertions(+), 59 deletions(-)

diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
index 6818987..f2dc351 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
@@ -58,7 +58,6 @@ int main(int ac, char **av)
 {
 	pid_t pid;
 	const char *msg;
-	int status;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
@@ -72,12 +71,7 @@ int main(int ac, char **av)
 	if (pid == 0)
 		do_master_child();
 
-	if (waitpid(pid, &status, 0) == -1)
-		tst_resm(TBROK | TERRNO, "waitpid failed");
-	if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
-		tst_resm(TFAIL, "child process terminated abnormally");
-	else
-		tst_resm(TPASS, "Test passed");
+	tst_record_childstatus(cleanup, pid);
 
 	cleanup();
 	tst_exit();
@@ -90,7 +84,7 @@ static void do_master_child(void)
 
 	if (SETFSUID(NULL, ltpuser->pw_uid) == -1) {
 		perror("setfsuid failed");
-		exit(1);
+		exit(TFAIL);
 	}
 
 	/* Test 1: Check the process with new uid cannot open the file
@@ -101,14 +95,14 @@ static void do_master_child(void)
 	if (TEST_RETURN != -1) {
 		close(TEST_RETURN);
 		printf("open succeeded unexpectedly\n");
-		exit(1);
+		exit(TFAIL);
 	}
 
 	if (TEST_ERRNO == EACCES) {
 		printf("open failed with EACCESS as expected\n");
 	} else {
 		printf("open returned unexpected errno - %d\n", TEST_ERRNO);
-		exit(1);
+		exit(TFAIL);
 	}
 
 	/* Test 2: Check a son process cannot open the file
@@ -117,7 +111,7 @@ static void do_master_child(void)
 	pid = FORK_OR_VFORK();
 	if (pid < 0) {
 		perror("Fork failed");
-		exit(1);
+		exit(TFAIL);
 	}
 
 	if (pid == 0) {
@@ -127,7 +121,7 @@ static void do_master_child(void)
 		if (TEST_RETURN != -1) {
 			close(TEST_RETURN);
 			printf("open succeeded unexpectedly\n");
-			exit(1);
+			exit(TFAIL);
 		}
 
 		if (TEST_ERRNO == EACCES) {
@@ -135,13 +129,13 @@ static void do_master_child(void)
 		} else {
 			printf("open returned unexpected errno - %d\n",
 			       TEST_ERRNO);
-			exit(1);
+			exit(TFAIL);
 		}
 	} else {
 		/* Wait for son completion */
 		if (waitpid(pid, &status, 0) == -1) {
 			perror("waitpid failed");
-			exit(1);
+			exit(TFAIL);
 		}
 
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
@@ -154,19 +148,19 @@ static void do_master_child(void)
 	tst_count++;
 	if (SETFSUID(NULL, 0) == -1) {
 		perror("setfsuid failed");
-		exit(1);
+		exit(TFAIL);
 	}
 
 	TEST(open(testfile, O_RDWR));
 
 	if (TEST_RETURN == -1) {
 		perror("open failed unexpectedly");
-		exit(1);
+		exit(TFAIL);
 	} else {
 		printf("open call succeeded\n");
 		close(TEST_RETURN);
 	}
-	exit(0);
+	exit(TPASS);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/setreuid/setreuid04.c b/testcases/kernel/syscalls/setreuid/setreuid04.c
index f1d2ab0..6c782f3 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid04.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid04.c
@@ -36,9 +36,6 @@ TCID_DEFINE(setreuid04);
 
 static uid_t neg_one = -1;
 
-/* flag to tell parent if child passed or failed. */
-static int flag;
-
 static struct passwd nobody, root;
 
 /*
@@ -75,10 +72,8 @@ int main(int ac, char **av)
 
 	setup();
 
-	flag = 0;
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int i, pid, status;
+		int i, pid;
 
 		tst_count = 0;
 
@@ -102,20 +97,15 @@ int main(int ac, char **av)
 						 "did not return as expected.",
 						 *test_data[i].real_uid,
 						 *test_data[i].eff_uid);
-					flag = -1;
 				}
 
 				uid_verify(test_data[i].exp_real_usr,
 					   test_data[i].exp_eff_usr,
 					   test_data[i].test_msg);
 			}
-			exit(flag);
+			tst_exit();
 		} else {	/* parent */
-			waitpid(pid, &status, 0);
-			if (WEXITSTATUS(status) != 0) {
-				tst_resm(TFAIL, "test failed within "
-					 "child process.");
-			}
+			tst_record_childstatus(cleanup, pid);
 		}
 	}
 	cleanup();
@@ -153,6 +143,5 @@ static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
 			 when, getuid(), geteuid());
 		tst_resm(TINFO, "Expected: real uid = %d; effective uid = %d",
 			 ru->pw_uid, eu->pw_uid);
-		flag = -1;
 	}
 }
diff --git a/testcases/kernel/syscalls/setreuid/setreuid05.c b/testcases/kernel/syscalls/setreuid/setreuid05.c
index 42fcbb9..14b0ade 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid05.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid05.c
@@ -34,9 +34,6 @@
 
 TCID_DEFINE(setreuid05);
 
-/* flag to tell parent if child passed or failed. */
-int flag = 0;
-
 static int fail = -1;
 static int pass;
 static uid_t neg_one = -1;
@@ -99,7 +96,7 @@ int main(int argc, char **argv)
 	pass = 0;
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int i, pid, status;
+		int i, pid;
 
 		tst_count = 0;
 
@@ -122,7 +119,6 @@ int main(int argc, char **argv)
 								 [i].real_uid,
 								 *test_data
 								 [i].eff_uid);
-							flag = -1;
 							continue;
 						}
 						tst_resm(TPASS,
@@ -142,7 +138,6 @@ int main(int argc, char **argv)
 						 "did not return as expected.",
 						 *test_data[i].real_uid,
 						 *test_data[i].eff_uid);
-					flag = -1;
 				}
 
 				if (TEST_RETURN == -1) {
@@ -152,13 +147,9 @@ int main(int argc, char **argv)
 					   test_data[i].exp_eff_usr,
 					   test_data[i].test_msg);
 			}
-			exit(flag);
+			tst_exit();
 		} else {	/* parent */
-			waitpid(pid, &status, 0);
-			if (WEXITSTATUS(status) != 0) {
-				tst_resm(TFAIL, "test failed within "
-					 "child process.");
-			}
+			tst_record_childstatus(cleanup, pid);
 		}
 	}
 	cleanup();
@@ -207,6 +198,5 @@ static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
 			 when, getuid(), geteuid());
 		tst_resm(TINFO, "Expected: real uid = %d; effective uid = %d",
 			 ru->pw_uid, eu->pw_uid);
-		flag = -1;
 	}
 }
diff --git a/testcases/kernel/syscalls/setreuid/setreuid07.c b/testcases/kernel/syscalls/setreuid/setreuid07.c
index b6714f9..753ee16 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid07.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid07.c
@@ -55,7 +55,6 @@ int main(int ac, char **av)
 {
 	pid_t pid;
 	const char *msg;
-	int status;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
@@ -69,10 +68,7 @@ int main(int ac, char **av)
 	if (pid == 0)
 		do_master_child();
 
-	if (waitpid(pid, &status, 0) == -1)
-		tst_resm(TBROK | TERRNO, "waitpid failed");
-	if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
-		tst_resm(TFAIL, "child process terminated abnormally");
+	tst_record_childstatus(cleanup, pid);
 
 	cleanup();
 	tst_exit();
@@ -91,7 +87,7 @@ static void do_master_child(void)
 
 		if (SETREUID(NULL, 0, ltpuser->pw_uid) == -1) {
 			perror("setreuid failed");
-			exit(1);
+			exit(TFAIL);
 		}
 
 		/* Test 1: Check the process with new uid cannot open the file
@@ -102,14 +98,14 @@ static void do_master_child(void)
 		if (TEST_RETURN != -1) {
 			printf("open succeeded unexpectedly\n");
 			close(tst_fd);
-			exit(1);
+			exit(TFAIL);
 		}
 
 		if (TEST_ERRNO == EACCES) {
 			printf("open failed with EACCES as expected\n");
 		} else {
 			perror("open failed unexpectedly");
-			exit(1);
+			exit(TFAIL);
 		}
 
 		/* Test 2: Check a son process cannot open the file
@@ -128,23 +124,23 @@ static void do_master_child(void)
 			if (TEST_RETURN != -1) {
 				printf("call succeeded unexpectedly\n");
 				close(tst_fd2);
-				exit(1);
+				exit(TFAIL);
 			}
 
 			TEST_ERROR_LOG(TEST_ERRNO);
 
 			if (TEST_ERRNO == EACCES) {
 				printf("open failed with EACCES as expected\n");
-				exit(0);
+				exit(TPASS);
 			} else {
 				printf("open failed unexpectedly\n");
-				exit(1);
+				exit(TFAIL);
 			}
 		} else {
 			/* Wait for son completion */
 			if (waitpid(pid, &status, 0) == -1) {
 				perror("waitpid failed");
-				exit(1);
+				exit(TFAIL);
 			}
 			if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
 				exit(WEXITSTATUS(status));
@@ -156,20 +152,20 @@ static void do_master_child(void)
 		tst_count++;
 		if (SETREUID(NULL, 0, 0) == -1) {
 			perror("setreuid failed");
-			exit(1);
+			exit(TFAIL);
 		}
 
 		TEST(tst_fd = open(testfile, O_RDWR));
 
 		if (TEST_RETURN == -1) {
 			perror("open failed unexpectedly");
-			exit(1);
+			exit(TFAIL);
 		} else {
 			printf("open call succeeded\n");
 			close(tst_fd);
 		}
 	}
-	exit(0);
+	exit(TPASS);
 }
 
 static void setup(void)
-- 
1.8.2.1


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
