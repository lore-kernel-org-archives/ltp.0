Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Z28HA-0000qZ-Op
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 01:24:24 +0000
Received: from [119.145.14.65] (helo=szxga02-in.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z28H5-0002n4-Ad
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 01:24:24 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Tue, 9 Jun 2015 03:28:39 -0600
Message-ID: <1433842119-27558-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Add TEST_LOOPING in userns01.
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
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/containers/userns/userns01.c | 31 +++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index 6e313c0..9cada5e 100644
--- a/testcases/kernel/containers/userns/userns01.c
+++ b/testcases/kernel/containers/userns/userns01.c
@@ -71,25 +71,28 @@ static void setup(void)
 int main(int argc, char *argv[])
 {
 	int status;
+	int lc;
 
 	tst_parse_opts(argc, argv, NULL, NULL);
 	setup();
 
-	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWUSER, child_fn1, NULL));
-
-	if (TEST_RETURN == -1)
-		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
-	else if ((wait(&status)) == -1)
-		tst_brkm(TWARN | TERRNO, NULL, "wait failed");
-
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
-		tst_resm(TFAIL, "child exited abnormally");
-	else if (WIFSIGNALED(status)) {
-		tst_resm(TFAIL, "child was killed with signal = %d",
-			 WTERMSIG(status));
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWUSER,
+			child_fn1, NULL));
+
+		if (TEST_RETURN == -1)
+			tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
+		else if ((wait(&status)) == -1)
+			tst_brkm(TWARN | TERRNO, NULL, "wait failed");
+
+		if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "child exited abnormally");
+		else if (WIFSIGNALED(status)) {
+			tst_resm(TFAIL, "child was killed with signal = %d",
+				 WTERMSIG(status));
+		} else
+			tst_resm(TPASS, "uid and gid are right");
 	}
-
-	tst_resm(TPASS, "the uid and the gid are right inside the container");
 	tst_exit();
 }
 
-- 
1.9.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
