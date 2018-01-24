From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:03:11 +0100
Subject: [LTP] [PATCH 18/19] fix old style definition in inode02.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-19-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/fs/inode/inode02.c | 67 +++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/testcases/kernel/fs/inode/inode02.c b/testcases/kernel/fs/inode/inode02.c
index 78495ec75..85598b2fc 100644
--- a/testcases/kernel/fs/inode/inode02.c
+++ b/testcases/kernel/fs/inode/inode02.c
@@ -110,9 +110,7 @@ char *TCID = "inode02";		/* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test cases. */
 /**************/
 
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char *argv[])
 {
 	int pid, tree(), p, status;
 	int count, child;
@@ -216,8 +214,7 @@ char *argv[];
 	tst_exit();
 }
 
-int bd_arg(str)
-char *str;
+int bd_arg(char *str)
 {
 	fprintf(temp,
 		"Bad argument - %s - could not parse as number.\n\tinode02 [max_depth] [max_breadth] [file_length] [#children]\n\tdefault: inode02 6 5 8 5\n",
@@ -225,7 +222,7 @@ char *str;
 	exit(1);
 }
 
-int tree()
+int tree(void)
 
 /************************************************/
 /*						*/
@@ -375,7 +372,7 @@ int tree()
 	exit(exit_val);
 }
 
-int generate(string, level)
+int generate(char *string, int level)
 
 /****************************************/
 /*					*/
@@ -388,19 +385,19 @@ int generate(string, level)
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
+/*  string:                */
+/*  the directory path     */
+/*  string below which a   */
+/*  tree is generated      */
+/*                         */
+/***************************/
+
+/***************************/
+/* level:                  */
+/* the tree depth variable */
+/*                         */
+/***************************/
 {
 	int switch_flag;
 	int ret_val = 0;
@@ -557,7 +554,7 @@ int level;			/* the tree depth variable */
 		return 0;
 }
 
-int check()
+int check(void)
 
 /****************************************/
 /*					*/
@@ -675,7 +672,7 @@ int check()
 	}			/* while */
 }
 
-int get_next_name()
+int get_next_name(void)
 
 /****************************************/
 /*					*/
@@ -712,7 +709,7 @@ int get_next_name()
 	return 0;
 }
 
-int increment_name(position)
+int increment_name(int position)
 
 /****************************************/
 /*					*/
@@ -721,7 +718,6 @@ int increment_name(position)
 /*  next name				*/
 /*					*/
 /****************************************/
- int position;
 {
 	int next_position;
 
@@ -746,7 +742,7 @@ int increment_name(position)
 				  /*********************************/
 }
 
-int mode(path_string)
+int mode(char *path_string)
 
 /****************************************/
 /*					*/
@@ -754,7 +750,6 @@ int mode(path_string)
 /*   the file named by path_string 	*/
 /*					*/
 /****************************************/
- char path_string[];
 {
 	struct stat buf;
 	int ret_val, mod;
@@ -768,9 +763,7 @@ int mode(path_string)
 	}
 }
 
-int escrivez(string)
-
-char string[];
+int escrivez(char *string)
 {
 	char write_string[PATH_STRING_LENGTH + 1];
 	int len, ret_len;
@@ -789,7 +782,7 @@ char string[];
 	return 0;
 }
 
-int term()
+int term(void)
 {
 	int status;
 
@@ -814,7 +807,7 @@ int term()
 	return 0;
 }
 
-int massmurder()
+int massmurder(void)
 {
 	int i;
 	for (i = 0; i < MAXCHILD; i++) {
@@ -831,7 +824,7 @@ int massmurder()
  *
  * Do set up - here its a dummy function
  */
-void setup()
+void setup(void)
 {
 	tst_tmpdir();
 	temp = stderr;
@@ -842,7 +835,7 @@ void setup()
  *
  * Exit on failure
  */
-void fail_exit()
+void fail_exit(void)
 {
 	tst_brkm(TFAIL, tst_rmdir, "Test failed\n");
 }
@@ -853,7 +846,7 @@ void fail_exit()
  *
  * Description: Exit a test.
  */
-void anyfail()
+void anyfail(void)
 {
 	(local_flag == FAILED) ? tst_resm(TFAIL, "Test failed")
 	    : tst_resm(TPASS, "Test passed");
@@ -866,7 +859,7 @@ void anyfail()
  *
  * Calling block passed the test
  */
-void ok_exit()
+void ok_exit(void)
 {
 	local_flag = PASSED;
 	return;
@@ -877,7 +870,7 @@ void ok_exit()
  *
  * exit on failure
  */
-void forkfail()
+void forkfail(void)
 {
 	tst_brkm(TBROK, tst_rmdir, "Reason: %s\n", strerror(errno));
 }
@@ -901,7 +894,7 @@ void terror(char *message)
  * Assume that we are always running under stress, so this function will
  * return > 0 value always.
  */
-int instress()
+int instress(void)
 {
 	tst_resm(TINFO, "System resource may be too low, fork() malloc()"
 		 " etc are likely to fail.\n");
-- 
2.13.6

