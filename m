From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Tue, 12 Apr 2016 11:03:10 +0800
Subject: [LTP] [PATCH] waitpid/waitpid02: check if fork failed
Message-ID: <20160412030310.GA10416@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Break the test if fork failed. Or this test case will kill a lot of
processes on the system.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitpid/waitpid02.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid02.c b/testcases/kernel/syscalls/waitpid/waitpid02.c
index e5d7957..73cdb83 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid02.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid02.c
@@ -96,6 +96,10 @@ int main(int argc, char **argv)
 			do_child();
 #endif
 		} else {
+			if (pid < 0) {
+				tst_brkm(TBROK|TERRNO, cleanup, "fork failed");
+			}
+
 			kill(pid, sig);
 			errno = 0;
 			while (((npid = waitpid(pid, &status, 0)) != -1) ||
-- 
1.9.3

