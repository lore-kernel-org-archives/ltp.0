From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Mon, 11 Apr 2016 22:27:36 +0800
Subject: [LTP] [PATCH] fcntl/fcntl14: break remaining tests if cannot fork
Message-ID: <20160411142736.GA406@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It has been observed that if the test continued after the failure of
fork, a lot of other processes on the same machine will be killed by
the signal handler catch_alarm().

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/fcntl/fcntl14.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index a6c8215..68e110e 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -755,6 +755,7 @@ void dochild(void)
 		switch (pid) {
 		case -1:
 			tst_resm(TFAIL, "Fork failed");
+			fail = 1;
 			break;
 		case 0:	/* child */
 #ifdef UCLINUX
@@ -872,8 +873,7 @@ void run_test(int file_flag, int file_mode, int seek, int start, int end)
 #endif
 		}
 		if (child < 0) {
-			tst_resm(TFAIL, "Fork failed");
-			cleanup();
+			tst_brkm(TBROK|TERRNO, cleanup, "Fork failed");
 		}
 		/* parent process */
 		if ((thiscase->c_flag) == WILLBLOCK) {
@@ -1145,8 +1145,7 @@ int main(int ac, char **av)
 #endif
 		}
 		if (child < 0) {
-			tst_resm(TFAIL, "Fork failed");
-			cleanup();
+			tst_brkm(TBROK|TERRNO, cleanup, "Fork failed");
 		}
 
 		/* parent process */
-- 
1.9.3

