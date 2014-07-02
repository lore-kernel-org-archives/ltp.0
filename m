Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X2H4x-0000ls-QV
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 09:43:51 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X2H4v-00085L-D6
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 09:43:51 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s629hf78012554
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jul 2014 17:43:41 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 2 Jul 2014 17:40:10 +0800
Message-ID: <1404294010-18698-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1404294010-18698-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1404294010-18698-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 3/3] syscalls: fix testcases which take TCONF as
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
 testcases/kernel/syscalls/setfsuid/setfsuid04.c | 30 +++++++++++++------------
 testcases/kernel/syscalls/setreuid/setreuid04.c | 25 ++++++++++-----------
 testcases/kernel/syscalls/setreuid/setreuid05.c | 25 ++++++++++-----------
 testcases/kernel/syscalls/setreuid/setreuid07.c | 28 +++++++++++++----------
 4 files changed, 56 insertions(+), 52 deletions(-)

diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
index 6818987..518fa0b 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
@@ -74,10 +74,12 @@ int main(int ac, char **av)
 
 	if (waitpid(pid, &status, 0) == -1)
 		tst_resm(TBROK | TERRNO, "waitpid failed");
-	if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
-		tst_resm(TFAIL, "child process terminated abnormally");
-	else
-		tst_resm(TPASS, "Test passed");
+
+	if (tst_record_childstatus(status, NULL) !=
+	    CHILD_EXIT_NORMALLY) {
+		tst_brkm(TBROK, cleanup, "child process have abnormal"
+			 "status: %d", status);
+	}
 
 	cleanup();
 	tst_exit();
@@ -90,7 +92,7 @@ static void do_master_child(void)
 
 	if (SETFSUID(NULL, ltpuser->pw_uid) == -1) {
 		perror("setfsuid failed");
-		exit(1);
+		exit(TFAIL);
 	}
 
 	/* Test 1: Check the process with new uid cannot open the file
@@ -101,14 +103,14 @@ static void do_master_child(void)
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
@@ -117,7 +119,7 @@ static void do_master_child(void)
 	pid = FORK_OR_VFORK();
 	if (pid < 0) {
 		perror("Fork failed");
-		exit(1);
+		exit(TFAIL);
 	}
 
 	if (pid == 0) {
@@ -127,7 +129,7 @@ static void do_master_child(void)
 		if (TEST_RETURN != -1) {
 			close(TEST_RETURN);
 			printf("open succeeded unexpectedly\n");
-			exit(1);
+			exit(TFAIL);
 		}
 
 		if (TEST_ERRNO == EACCES) {
@@ -135,13 +137,13 @@ static void do_master_child(void)
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
@@ -154,19 +156,19 @@ static void do_master_child(void)
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
index f1d2ab0..502533d 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid04.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid04.c
@@ -36,8 +36,6 @@ TCID_DEFINE(setreuid04);
 
 static uid_t neg_one = -1;
 
-/* flag to tell parent if child passed or failed. */
-static int flag;
 
 static struct passwd nobody, root;
 
@@ -75,8 +73,6 @@ int main(int ac, char **av)
 
 	setup();
 
-	flag = 0;
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i, pid, status;
 
@@ -86,6 +82,8 @@ int main(int ac, char **av)
 			tst_brkm(TBROK, cleanup, "fork failed");
 		} else if (pid == 0) {	/* child */
 
+			tst_reset_exitval();
+
 			for (i = 0; i < TST_TOTAL; i++) {
 
 				/* Set the real or effective user id */
@@ -102,22 +100,24 @@ int main(int ac, char **av)
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
-		} else {	/* parent */
-			waitpid(pid, &status, 0);
-			if (WEXITSTATUS(status) != 0) {
-				tst_resm(TFAIL, "test failed within "
-					 "child process.");
-			}
+
+			tst_exit();
+		}
+
+		waitpid(pid, &status, 0);
+		if (tst_record_childstatus(status, NULL) !=
+		    CHILD_EXIT_NORMALLY) {
+			tst_brkm(TBROK, cleanup, "child process have abnormal"
+				 "status: %d", status);
 		}
 	}
+
 	cleanup();
 	tst_exit();
 }
@@ -153,6 +153,5 @@ static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
 			 when, getuid(), geteuid());
 		tst_resm(TINFO, "Expected: real uid = %d; effective uid = %d",
 			 ru->pw_uid, eu->pw_uid);
-		flag = -1;
 	}
 }
diff --git a/testcases/kernel/syscalls/setreuid/setreuid05.c b/testcases/kernel/syscalls/setreuid/setreuid05.c
index 42fcbb9..78f082a 100644
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
@@ -106,6 +103,9 @@ int main(int argc, char **argv)
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork failed");
 		} else if (pid == 0) {	/* child */
+
+			tst_reset_exitval();
+
 			for (i = 0; i < TST_TOTAL; i++) {
 				/* Set the real or effective user id */
 				TEST(SETREUID(cleanup, *test_data[i].real_uid,
@@ -122,7 +122,6 @@ int main(int argc, char **argv)
 								 [i].real_uid,
 								 *test_data
 								 [i].eff_uid);
-							flag = -1;
 							continue;
 						}
 						tst_resm(TPASS,
@@ -142,7 +141,6 @@ int main(int argc, char **argv)
 						 "did not return as expected.",
 						 *test_data[i].real_uid,
 						 *test_data[i].eff_uid);
-					flag = -1;
 				}
 
 				if (TEST_RETURN == -1) {
@@ -152,13 +150,15 @@ int main(int argc, char **argv)
 					   test_data[i].exp_eff_usr,
 					   test_data[i].test_msg);
 			}
-			exit(flag);
-		} else {	/* parent */
-			waitpid(pid, &status, 0);
-			if (WEXITSTATUS(status) != 0) {
-				tst_resm(TFAIL, "test failed within "
-					 "child process.");
-			}
+
+			tst_exit();
+		}
+
+		waitpid(pid, &status, 0);
+		if (tst_record_childstatus(status, NULL) !=
+		    CHILD_EXIT_NORMALLY) {
+			tst_brkm(TBROK, cleanup, "child process have abnormal"
+				 "status: %d", status);
 		}
 	}
 	cleanup();
@@ -207,6 +207,5 @@ static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
 			 when, getuid(), geteuid());
 		tst_resm(TINFO, "Expected: real uid = %d; effective uid = %d",
 			 ru->pw_uid, eu->pw_uid);
-		flag = -1;
 	}
 }
diff --git a/testcases/kernel/syscalls/setreuid/setreuid07.c b/testcases/kernel/syscalls/setreuid/setreuid07.c
index b6714f9..6b4f16f 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid07.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid07.c
@@ -71,8 +71,12 @@ int main(int ac, char **av)
 
 	if (waitpid(pid, &status, 0) == -1)
 		tst_resm(TBROK | TERRNO, "waitpid failed");
-	if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
-		tst_resm(TFAIL, "child process terminated abnormally");
+
+	if (tst_record_childstatus(status, NULL) !=
+	    CHILD_EXIT_NORMALLY) {
+		tst_brkm(TBROK, cleanup, "child process have abnormal"
+			 "status: %d", status);
+	}
 
 	cleanup();
 	tst_exit();
@@ -91,7 +95,7 @@ static void do_master_child(void)
 
 		if (SETREUID(NULL, 0, ltpuser->pw_uid) == -1) {
 			perror("setreuid failed");
-			exit(1);
+			exit(TFAIL);
 		}
 
 		/* Test 1: Check the process with new uid cannot open the file
@@ -102,14 +106,14 @@ static void do_master_child(void)
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
@@ -128,23 +132,23 @@ static void do_master_child(void)
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
@@ -156,20 +160,20 @@ static void do_master_child(void)
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
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
