From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:03:12 +0100
Subject: [LTP] [PATCH 19/19] fix old style definition in inode01.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-20-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/fs/inode/inode01.c | 58 +++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
index 86c3b955c..a7387e868 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -98,7 +98,7 @@ int list_id;
 
 int increment_name(), get_next_name(), mode(), escrivez();
 
-int main()
+int main(void)
 {
 	char root[16];		//as pids can get much longer
 	int gen_ret_val, ch_ret_val, level;
@@ -275,7 +275,7 @@ int main()
 	tst_exit();
 }
 
-int generate(string, level)
+int generate(char *string, int level)
 
 /****************************************/
 /*					*/
@@ -288,19 +288,19 @@ int generate(string, level)
 /*   reached or an error occurs		*/
 /*					*/
 /****************************************/
-		/***************************/
-		/*                         */
-char string[];			/*  the directory path     */
-		/*  string below which a   */
-		/*  tree is generated      */
-		/*                         */
-		/***************************/
-
-		/***************************/
-		/*                         */
-int level;			/* the tree depth variable */
-		/*                         */
-		/***************************/
+/***************************/
+/*  string[]      	   */
+/*  the directory path     */
+/*  string below which a   */
+/*  tree is generated      */
+/*                         */
+/***************************/
+
+/***************************/
+/* level                   */
+/* the tree depth variable */
+/*                         */
+/***************************/
 {
 	int switch_flag;
 	int ret_val = 0;
@@ -453,7 +453,7 @@ int level;			/* the tree depth variable */
 		return 0;
 }
 
-int check()
+int check(void)
 
 /****************************************/
 /*					*/
@@ -570,7 +570,7 @@ int check()
 	}			/* while */
 }
 
-int get_next_name()
+int get_next_name(void)
 
 /****************************************/
 /*					*/
@@ -607,7 +607,7 @@ int get_next_name()
 	return 0;
 }
 
-int increment_name(position)
+int increment_name(int position)
 
 /****************************************/
 /*					*/
@@ -616,7 +616,6 @@ int increment_name(position)
 /*  next name				*/
 /*					*/
 /****************************************/
- int position;
 {
 	int next_position;
 
@@ -641,7 +640,7 @@ int increment_name(position)
 				  /*********************************/
 }
 
-int mode(path_string)
+int mode(char *path_string)
 
 /****************************************/
 /*					*/
@@ -649,7 +648,6 @@ int mode(path_string)
 /*   the file named by path_string 	*/
 /*					*/
 /****************************************/
- char path_string[];
 {
 	struct stat buf;
 	int ret_val, mod;
@@ -663,9 +661,7 @@ int mode(path_string)
 	}
 }
 
-int escrivez(string)
-
-char string[];
+int escrivez(char *string)
 {
 	char write_string[PATH_STRING_LENGTH + 1];
 	int len, ret_len;
@@ -684,7 +680,7 @@ char string[];
 	return 0;
 }
 
-int term()
+int term(void)
 {
 	int status;
 
@@ -713,7 +709,7 @@ int term()
  *
  * Do set up - here its a dummy function
  */
-void setup()
+void setup(void)
 {
 	tst_tmpdir();
 	temp = stderr;
@@ -728,7 +724,7 @@ gical unit
 fail or
  *              pass.
  */
-void blexit()
+void blexit(void)
 {
 	(local_flag == PASSED) ? tst_resm(TPASS, "Test block %d", block_number)
 	    : tst_resm(TFAIL, "Test block %d", block_number);
@@ -741,7 +737,7 @@ void blexit()
  *
  * Description: Print message on entering a new block
  */
-void blenter()
+void blenter(void)
 {
 	local_flag = PASSED;
 	return;
@@ -752,7 +748,7 @@ void blenter()
  *
  * Exit on failure
  */
-void fail_exit()
+void fail_exit(void)
 {
 	tst_brkm(TFAIL, tst_rmdir, "Test failed");
 }
@@ -763,7 +759,7 @@ void fail_exit()
  *
  * Description: Exit a test.
  */
-void anyfail()
+void anyfail(void)
 {
 	(local_flag == FAILED) ? tst_resm(TFAIL, "Test failed")
 	    : tst_resm(TPASS, "Test passed");
@@ -776,7 +772,7 @@ void anyfail()
  *
  * Calling block passed the test
  */
-void ok_exit()
+void ok_exit(void)
 {
 	local_flag = PASSED;
 	return;
-- 
2.13.6

