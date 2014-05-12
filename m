Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WjjTD-00058j-UA
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 06:12:15 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WjjTC-0001IH-RI
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 06:12:15 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4C6CA0g011945
	for <ltp-list@lists.sourceforge.net>; Mon, 12 May 2014 14:12:10 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 12 May 2014 14:09:47 +0800
Message-ID: <1399874987-24926-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1399874987-24926-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1399874987-24926-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] setpgid/setpgid01.c: add pid = 0 and pgid = 0 test
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/setpgid/setpgid01.c | 31 ++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid01.c b/testcases/kernel/syscalls/setpgid/setpgid01.c
index d35f201..ed20f63 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid01.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid01.c
@@ -36,6 +36,7 @@
  * Description:
  * Verify that:
  *   1. Basic functionality test for setpgid(2).
+ *   2. Check proper functioning of setpgid(2) with pid = 0 and pgid = 0.
  */
 
 #include <errno.h>
@@ -52,7 +53,8 @@ static void cleanup(void);
 char *TCID = "setpgid01";
 
 static void setpgid_test1(void);
-static void (*testfunc[])(void) = { setpgid_test1};
+static void setpgid_test2(void);
+static void (*testfunc[])(void) = { setpgid_test1, setpgid_test2 };
 int TST_TOTAL = ARRAY_SIZE(testfunc);
 
 int main(int ac, char **av)
@@ -128,6 +130,33 @@ static void setpgid_test1(void)
 		tst_resm(TFAIL, "test setpgid(%d, %d) fail", pid, pgid);
 }
 
+static void setpgid_test2(void)
+{
+	int ret;
+	pid_t pgid, pid;
+
+	pid = FORK_OR_VFORK();
+	if (pid == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "fork()");
+
+	if (pid != 0) {
+		ret = wait4child(pid);
+	} else {
+		pid = getpid();
+		TEST(setpgid(0, 0));
+		pgid = getpgrp();
+		if (TEST_RETURN == -1 || pid != pgid)
+			exit(1);
+		else
+			exit(0);
+	}
+
+	if (ret == 0)
+		tst_resm(TPASS, "test setpgid(0, 0) success");
+	else
+		tst_resm(TFAIL, "test setpgid(0, 0) fail");
+}
+
 static void setup(void)
 {
 	tst_sig(FORK, DEF_HANDLER, cleanup);
-- 
1.8.2.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
