From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  1 Sep 2017 11:08:30 +0200
Subject: [LTP] [PATCH] [COMMITTED] mm/mmstress: Fix warnings.
Message-ID: <20170901090830.21376-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/mtest05/mmstress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/mtest05/mmstress.c b/testcases/kernel/mem/mtest05/mmstress.c
index e91736cf7..4d8efdb6b 100644
--- a/testcases/kernel/mem/mtest05/mmstress.c
+++ b/testcases/kernel/mem/mtest05/mmstress.c
@@ -631,7 +631,8 @@ static void run_test(unsigned int i)
 int main(int argc, char **argv)
 {
 	static char *version_info = "mmstress V1.00 04/17/2001";
-	int ch, i;
+	int ch;
+	unsigned int i;
 	int test_num = 0;
 	int test_time = 0;
 	int run_once = TRUE;
@@ -708,7 +709,7 @@ int main(int argc, char **argv)
 			for (i = 0; i < ARRAY_SIZE(test_ptr); i++)
 				run_test(i);
 		} else {
-			if (test_num > ARRAY_SIZE(test_ptr)) {
+			if (test_num > (int)ARRAY_SIZE(test_ptr)) {
 				tst_brkm(TBROK, NULL, "Invalid test number %i",
 					 test_num);
 			}
-- 
2.13.0

