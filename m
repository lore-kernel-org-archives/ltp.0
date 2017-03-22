From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Wed, 22 Mar 2017 03:07:18 +0000 (UTC)
Subject: [LTP] [PATCH] mtest05/mmstress: Fix failure on read-only system
In-Reply-To: <1489106886-4037-1-git-send-email-the_hoang0709@yahoo.com>
References: <1489106886-4037-1-git-send-email-the_hoang0709@yahoo.com>
Message-ID: <1027308535.1052715.1490152038111@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
Could you help to check, so that we can close the Issue ?
Thanks and regards
Hoang
Sent from Yahoo Mail on Android 
 
  On Fri, Mar 10, 2017 at 7:48, the_hoang0709@yahoo.com<the_hoang0709@yahoo.com> wrote:   From: Hoang Nguyen <the_hoang0709@yahoo.com>

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
@@ -832,6 +832,7 @@ int main(int argc,        /* number of command line parameters                    */
     optarg = NULL;
     opterr = 0;
 
+    tst_tmpdir();
     if (argc < 2)
         tst_resm(TINFO, "run %s -h for all options", argv[0]);
 
@@ -937,6 +938,7 @@ int main(int argc,        /* number of command line parameters                    */
 
         if (global_rc != SUCCESS) {
             tst_resm(TFAIL, "Test Failed");
+            tst_rmdir();
             exit(global_rc);
         }
 
@@ -947,5 +949,6 @@ int main(int argc,        /* number of command line parameters                    */
     } else {
         tst_resm(TPASS, "Test Passed");
     }
+    tst_rmdir();
     exit(global_rc);
 }
-- 
2.7.4

  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170322/3dff5a53/attachment.html>
