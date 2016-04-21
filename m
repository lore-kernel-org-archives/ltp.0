From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 21 Apr 2016 10:03:27 +0800
Subject: [LTP] [PATCH] waitpid/waitpid11: correct error message
Message-ID: <20160421020327.GA2818@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According to code, the message should be "did not find a fork_kid_pid
for the wait_kid_pid of %d".

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitpid/waitpid11.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid11.c b/testcases/kernel/syscalls/waitpid/waitpid11.c
index 72ee3f6..135ec56 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid11.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid11.c
@@ -189,8 +189,8 @@ int main(int ac, char **av)
 			}
 		}
 		if (!found) {
-			tst_resm(TFAIL, "Did not find a wait_kid_pid "
-				 "for the fork_kid_pid of %d", wait_kid_pid[i]);
+			tst_resm(TFAIL, "Did not find a fork_kid_pid "
+				 "for the wait_kid_pid of %d", wait_kid_pid[i]);
 			for (k = 0; k < MAXKIDS; k++) {
 				tst_resm(TFAIL, "fork_kid_pid[%d] = "
 					 "%d", k, fork_kid_pid[k]);
@@ -248,8 +248,8 @@ int main(int ac, char **av)
 			}
 		}
 		if (!found) {
-			tst_resm(TFAIL, "Did not find a wait_kid_pid "
-				 "for the fork_kid_pid of %d", fork_kid_pid[j]);
+			tst_resm(TFAIL, "Did not find a fork_kid_pid "
+				 "for the wait_kid_pid of %d", wait_kid_pid[i]);
 			for (k = 0; k < MAXKIDS; k++)
 				tst_resm(TFAIL, "fork_kid_pid[%d] = "
 					 "%d", k, fork_kid_pid[k]);
-- 
1.9.3

