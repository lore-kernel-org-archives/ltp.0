Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X1W8j-0001jT-NV
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 07:36:37 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X1W8h-0007cX-Hu
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 07:36:37 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5U7aQ3n031680
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 15:36:26 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 30 Jun 2014 15:33:23 +0800
Message-ID: <1404113603-19192-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] syscalls: fix testcases which take TCONF as TFAIL
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
work in child process, if child process returns TCONF, parent process will
get a non-zero return value, which will print TFAIL directly, so fix this.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/setfsuid/setfsuid04.c | 23 ++++++++++++++++-----
 testcases/kernel/syscalls/setreuid/setreuid04.c | 27 ++++++++++++++++++-------
 testcases/kernel/syscalls/setreuid/setreuid05.c | 24 ++++++++++++++++------
 testcases/kernel/syscalls/setreuid/setreuid07.c | 21 ++++++++++++++++---
 4 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
index 6818987..c774582 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
@@ -58,7 +58,7 @@ int main(int ac, char **av)
 {
 	pid_t pid;
 	const char *msg;
-	int status;
+	int status, ret;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
@@ -74,10 +74,23 @@ int main(int ac, char **av)
 
 	if (waitpid(pid, &status, 0) == -1)
 		tst_resm(TBROK | TERRNO, "waitpid failed");
-	if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
-		tst_resm(TFAIL, "child process terminated abnormally");
-	else
-		tst_resm(TPASS, "Test passed");
+
+	if (WIFEXITED(status)) {
+		ret = WEXITSTATUS(status);
+		if (ret == TCONF) {
+			tst_brkm(TCONF, cleanup, "child process return "
+				 "TCONF");
+		} else if (ret == TPASS) {
+			tst_resm(TPASS, "test succeeded within"
+				 "child process");
+		} else {
+			tst_resm(TFAIL, "test failed within"
+				 "child process");
+		}
+	} else {
+		tst_brkm(TBROK, cleanup, "child process terminated "
+				 "abnormally. status: %d", status);
+	}
 
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/syscalls/setreuid/setreuid04.c b/testcases/kernel/syscalls/setreuid/setreuid04.c
index f1d2ab0..82f4511 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid04.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid04.c
@@ -67,7 +67,7 @@ static void uid_verify(struct passwd *, struct passwd *, char *);
 
 int main(int ac, char **av)
 {
-	int lc;
+	int lc, ret;
 	const char *msg;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
@@ -110,14 +110,27 @@ int main(int ac, char **av)
 					   test_data[i].test_msg);
 			}
 			exit(flag);
-		} else {	/* parent */
-			waitpid(pid, &status, 0);
-			if (WEXITSTATUS(status) != 0) {
-				tst_resm(TFAIL, "test failed within "
-					 "child process.");
-			}
+		}
+
+		waitpid(pid, &status, 0);
+		if (WIFEXITED(status)) {
+			ret = WEXITSTATUS(status);
+			if (ret == TCONF) {
+				tst_brkm(TCONF, cleanup, "child process return "
+					 "TCONF");
+			} else if (ret == TPASS) {
+				tst_resm(TPASS, "test succeeded within"
+					 "child process");
+			} else {
+				tst_resm(TFAIL, "test failed within"
+					 "child process");
+				}
+		} else {
+			tst_brkm(TBROK, cleanup, "child process terminated "
+				 "abnormally. status: %d", status);
 		}
 	}
+
 	cleanup();
 	tst_exit();
 }
diff --git a/testcases/kernel/syscalls/setreuid/setreuid05.c b/testcases/kernel/syscalls/setreuid/setreuid05.c
index 42fcbb9..e9f13dd 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid05.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid05.c
@@ -88,7 +88,7 @@ static void uid_verify(struct passwd *, struct passwd *, char *);
 
 int main(int argc, char **argv)
 {
-	int lc;
+	int lc, ret;
 	const char *msg;
 
 	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
@@ -153,12 +153,24 @@ int main(int argc, char **argv)
 					   test_data[i].test_msg);
 			}
 			exit(flag);
-		} else {	/* parent */
-			waitpid(pid, &status, 0);
-			if (WEXITSTATUS(status) != 0) {
-				tst_resm(TFAIL, "test failed within "
-					 "child process.");
+		}
+
+		waitpid(pid, &status, 0);
+		if (WIFEXITED(status)) {
+			ret = WEXITSTATUS(status);
+			if (ret == TCONF) {
+				tst_brkm(TCONF, cleanup, "child process return"
+					 " TCONF");
+			} else if (ret == TPASS) {
+				tst_resm(TPASS, "test succeeded within"
+					 "child process");
+			} else {
+				tst_resm(TFAIL, "test failed within"
+					 "child process");
 			}
+		} else {
+			tst_brkm(TBROK, cleanup, "child process terminated "
+				 "abnormally. status: %d", status);
 		}
 	}
 	cleanup();
diff --git a/testcases/kernel/syscalls/setreuid/setreuid07.c b/testcases/kernel/syscalls/setreuid/setreuid07.c
index b6714f9..fc595a6 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid07.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid07.c
@@ -55,7 +55,7 @@ int main(int ac, char **av)
 {
 	pid_t pid;
 	const char *msg;
-	int status;
+	int status, ret;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
@@ -71,8 +71,23 @@ int main(int ac, char **av)
 
 	if (waitpid(pid, &status, 0) == -1)
 		tst_resm(TBROK | TERRNO, "waitpid failed");
-	if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
-		tst_resm(TFAIL, "child process terminated abnormally");
+
+	if (WIFEXITED(status)) {
+		ret = WEXITSTATUS(status);
+		if (ret == TCONF) {
+			tst_brkm(TCONF, cleanup, "child process return"
+				 " TCONF");
+		} else if (ret == TPASS) {
+			tst_resm(TPASS, "test succeeded within"
+				 "child process");
+		} else {
+			tst_resm(TFAIL, "test failed within"
+				 "child process");
+		}
+	} else {
+		tst_brkm(TBROK, cleanup, "child process terminated "
+			 "abnormally. status: %d", status);
+	}
 
 	cleanup();
 	tst_exit();
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
