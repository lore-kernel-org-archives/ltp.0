From: the_hoang0709@yahoo.com <the_hoang0709@yahoo.com>
Date: Fri, 10 Mar 2017 07:48:06 +0700
Subject: [LTP]  [PATCH] mtest05/mmstress: Fix failure on read-only system
Message-ID: <1489106886-4037-1-git-send-email-the_hoang0709@yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Hoang Nguyen <the_hoang0709@yahoo.com>

In order not to fail the test on read-only system, we used tst_tmpdir to
create temporary folder to run the test. Then remove it with tst_rmdir
after test finished (or test failed at the middle).

Fixes #87.

Signed-off-by: Hoang Nguyen <the_hoang0709@yahoo.com>
---
 testcases/kernel/mem/mtest05/mmstress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/mtest05/mmstress.c b/testcases/kernel/mem/mtest05/mmstress.c
index 0240a83..cbbc181 100644
--- a/testcases/kernel/mem/mtest05/mmstress.c
+++ b/testcases/kernel/mem/mtest05/mmstress.c
@@ -832,6 +832,7 @@ int main(int argc,		/* number of command line parameters                     */
 	optarg = NULL;
 	opterr = 0;
 
+	tst_tmpdir();
 	if (argc < 2)
 		tst_resm(TINFO, "run %s -h for all options", argv[0]);
 
@@ -937,6 +938,7 @@ int main(int argc,		/* number of command line parameters                     */
 
 		if (global_rc != SUCCESS) {
 			tst_resm(TFAIL, "Test Failed");
+			tst_rmdir();
 			exit(global_rc);
 		}
 
@@ -947,5 +949,6 @@ int main(int argc,		/* number of command line parameters                     */
 	} else {
 		tst_resm(TPASS, "Test Passed");
 	}
+	tst_rmdir();
 	exit(global_rc);
 }
-- 
2.7.4

