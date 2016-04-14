From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 14 Apr 2016 16:06:55 +0800
Subject: [LTP] [PATCH] fcntl/fcntl17: break test if fork failed
Message-ID: <20160414080655.GA10922@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Or the kill() in catch_alarm() will use -1 as pid and kill a lot of
processes.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/fcntl/fcntl17.c | 42 ++++++++++++++-----------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl17.c b/testcases/kernel/syscalls/fcntl/fcntl17.c
index 5b03e39..6211ce2 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl17.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl17.c
@@ -160,6 +160,15 @@ int setup(void)
 
 void cleanup(void)
 {
+	if (child_pid1 > 0)
+		kill(child_pid1, 9);
+
+	if (child_pid2 > 0)
+		kill(child_pid2, 9);
+
+	if (child_pid3 > 0)
+		kill(child_pid3, 9);
+
 	close(file_fd);
 	tst_rmdir();
 
@@ -466,10 +475,8 @@ int main(int ac, char **av)
 #else
 			do_child1();
 #endif
-		} else if (child_pid1 < 0) {
-			perror("Fork failed: child 1");
-			cleanup();
-		}
+		} else if (child_pid1 < 0)
+			tst_brkm(TBROK|TERRNO, cleanup, "Fork failed: child 1");
 
 		/* parent */
 
@@ -487,12 +494,7 @@ int main(int ac, char **av)
 			do_child2();
 #endif
 		} else if (child_pid2 < 0) {
-			perror("Fork failed: child 2");
-			if ((kill(child_pid1, SIGKILL)) < 0) {
-				tst_resm(TFAIL, "Attempt to signal child "
-					 "1 failed");
-			}
-			cleanup();
+			tst_brkm(TBROK|TERRNO, cleanup, "Fork failed: child 2");
 		}
 
 		/* parent */
@@ -512,16 +514,7 @@ int main(int ac, char **av)
 #endif
 			do_child3();
 		} else if (child_pid3 < 0) {
-			perror("Fork failed: child 3");
-			if ((kill(child_pid1, SIGKILL)) < 0) {
-				tst_resm(TFAIL, "Attempt to signal child "
-					 "1 failed");
-			}
-			if ((kill(child_pid2, SIGKILL)) < 0) {
-				tst_resm(TFAIL, "Attempt to signal child 2 "
-					 "failed");
-			}
-			cleanup();
+			tst_brkm(TBROK|TERRNO, cleanup, "Fork failed: child 3");
 		}
 		/* parent */
 
@@ -616,6 +609,12 @@ int main(int ac, char **av)
 		do_test(&lock3, child_pid3);
 
 		stop_children();
+		waitpid(child_pid1, &child_stat, 0);
+		waitpid(child_pid2, &child_stat, 0);
+		waitpid(child_pid3, &child_stat, 0);
+		child_pid1 = 0;
+		child_pid2 = 0;
+		child_pid3 = 0;
 		if (fail) {
 			tst_resm(TINFO, "Block 1 FAILED");
 		} else {
@@ -623,9 +622,6 @@ int main(int ac, char **av)
 		}
 		tst_resm(TINFO, "Exit block 1");
 	}
-	waitpid(child_pid1, &child_stat, 0);
-	waitpid(child_pid2, &child_stat, 0);
-	waitpid(child_pid3, &child_stat, 0);
 	cleanup();
 	tst_exit();
 }
-- 
1.9.3

