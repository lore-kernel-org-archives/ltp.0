From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Wed, 13 Apr 2016 15:11:11 +0800
Subject: [LTP] [PATCH] waitpid/waitpid10: break test if fork failed
Message-ID: <20160413071111.GA26897@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Or a lot of processes will be killed when -1 passed as pid to kill()

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitpid/waitpid10.c | 59 +++++++++++++++++++--------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid10.c b/testcases/kernel/syscalls/waitpid/waitpid10.c
index 6378ab9..9ae251a 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid10.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid10.c
@@ -81,8 +81,10 @@ static void do_compute(void);
 static void do_fork(void);
 static void do_sleep(void);
 static void do_mkdir(void);
+static void kill_children();
 
 static int fail;
+static int fork_kid_pid[MAXKIDS] = { 0 };
 
 #ifdef UCLINUX
 static char *argv0;
@@ -92,7 +94,7 @@ int main(int ac, char **av)
 {
 	int kid_count, ret_val, status, nkids;
 	int i, j, k, found;
-	int fork_kid_pid[MAXKIDS], wait_kid_pid[MAXKIDS];
+	int wait_kid_pid[MAXKIDS];
 	int runtime;		/* time(sec) to run this process */
 
 	int lc;
@@ -178,7 +180,8 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 0 failed. errno = "
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "Fork kid 0 failed. errno = "
 					 "%d", errno);
 
 			}
@@ -196,8 +199,10 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 1 failed. errno = "
-					 "%d", errno);
+				tst_resm(TBROK|TERRNO, "Fork kid 1 failed");
+				kill_children();
+				cleanup();
+				tst_exit();
 
 			}
 
@@ -214,8 +219,10 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 2 failed. errno = "
-					 "%d", errno);
+				tst_resm(TBROK|TERRNO, "Fork kid 2 failed");
+				kill_children();
+				cleanup();
+				tst_exit();
 
 			}
 
@@ -232,8 +239,10 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 3 failed. errno = "
-					 "%d", errno);
+				tst_resm(TBROK|TERRNO, "Fork kid 3 failed");
+				kill_children();
+				cleanup();
+				tst_exit();
 
 			}
 
@@ -250,8 +259,10 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 4 failed. errno = "
-					 "%d", errno);
+				tst_resm(TBROK|TERRNO, "Fork kid 4 failed");
+				kill_children();
+				cleanup();
+				tst_exit();
 
 			}
 
@@ -268,8 +279,10 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 5 failed. errno = "
-					 "%d", errno);
+				tst_resm(TBROK|TERRNO, "Fork kid 5 failed");
+				kill_children();
+				cleanup();
+				tst_exit();
 
 			}
 
@@ -286,8 +299,10 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 6 failed. errno = "
-					 "%d", errno);
+				tst_resm(TBROK|TERRNO, "Fork kid 6 failed");
+				kill_children();
+				cleanup();
+				tst_exit();
 
 			}
 
@@ -304,8 +319,10 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 7 failed. errno = "
-					 "%d", errno);
+				tst_resm(TBROK|TERRNO, "Fork kid 7 failed");
+				kill_children();
+				cleanup();
+				tst_exit();
 
 			}
 
@@ -516,3 +533,13 @@ static void do_mkdir(void)
 
 	exit(4);
 }
+
+static void kill_children(void)
+{
+	int i;
+
+	for (i = 0; i < MAXKIDS; i++) {
+		if (fork_kid_pid[i] > 0)
+			kill(fork_kid_pid[i], 9);
+	}
+}
-- 
1.9.3

