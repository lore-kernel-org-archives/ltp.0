From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 14 Apr 2016 16:46:33 +0800
Subject: [LTP] [PATCH] clone/clone07: only kill child if clone() succeeded
Message-ID: <20160414084633.GA16717@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Or when -1 passed as pid to kill(), a lot of processes will be killed.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/clone/clone07.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clone/clone07.c b/testcases/kernel/syscalls/clone/clone07.c
index 8c723de..ed59670 100644
--- a/testcases/kernel/syscalls/clone/clone07.c
+++ b/testcases/kernel/syscalls/clone/clone07.c
@@ -64,6 +64,10 @@ int main(int ac, char **av)
 
 		child_pid = ltp_clone(SIGCHLD, do_child, NULL,
 				      CHILD_STACK_SIZE, child_stack);
+
+		if (child_pid < 0)
+			tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
+
 		if ((wait(&status)) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "wait failed, status: %d", status);
@@ -107,7 +111,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	kill(child_pid, SIGKILL);
+	if (child_pid > 0)
+		kill(child_pid, SIGKILL);
 }
 
 static int do_child(void)
-- 
1.9.3

