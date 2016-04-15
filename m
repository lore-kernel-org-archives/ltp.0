From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Fri, 15 Apr 2016 16:08:59 +0800
Subject: [LTP] [PATCH] waitpid/waitpid11: break test if fork() failed
Message-ID: <20160415080859.GA26131@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Please review this patch. Thanks.


Or the kill() will kill a lot of processes when -1 passed to it as pid.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitpid/waitpid11.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid11.c b/testcases/kernel/syscalls/waitpid/waitpid11.c
index 4b662d5..af5b962 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid11.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid11.c
@@ -64,13 +64,14 @@ static void do_exit_uclinux(void);
 #endif
 
 static int fail;
+static int fork_kid_pid[MAXKIDS]; 
 
 int main(int ac, char **av)
 {
 	int kid_count, ret_val, status;
 	int i, j, k, found;
 	int group1, group2;
-	int fork_kid_pid[MAXKIDS], wait_kid_pid[MAXKIDS];
+	int wait_kid_pid[MAXKIDS];
 	int pid;
 
 	tst_parse_opts(ac, av, NULL, NULL);
@@ -130,8 +131,8 @@ int main(int ac, char **av)
 		}
 
 		if (ret_val < 0)
-			tst_resm(TFAIL, "Fork kid %d failed. errno = "
-				 "%d", kid_count, errno);
+			tst_brkm(TBROK|TERRNO, cleanup, "Fork kid %d failed",
+				 kid_count);
 
 		/* parent */
 		fork_kid_pid[kid_count] = ret_val;
@@ -259,6 +260,9 @@ int main(int ac, char **av)
 			fail = 1;
 		}
 	}
+
+	memset(fork_kid_pid, 0, sizeof(fork_kid_pid));
+
 	if (kid_count != (MAXKIDS / 2)) {
 		tst_resm(TFAIL, "Wrong number of children waited on "
 			 "for pid = 0");
@@ -271,6 +275,7 @@ int main(int ac, char **av)
 	else
 		tst_resm(TPASS, "Test PASSED");
 
+	cleanup();
 	tst_exit();
 }
 
@@ -287,6 +292,11 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	int i;
+
+	for (i = 0; i < MAXKIDS; i++)
+		if (fork_kid_pid[i] > 0)
+			kill(fork_kid_pid[i], 9);
 }
 
 static void inthandlr(void)
-- 
1.9.3

