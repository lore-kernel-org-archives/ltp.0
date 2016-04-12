From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Tue, 12 Apr 2016 11:07:34 +0800
Subject: [LTP] [PATCH] ptrace/ptrace05: preventing kill other processes if
 fork failed
Message-ID: <20160412030734.GA11627@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If fork failed, we should try next signum. Or the kill(-1, 9) on line
196 will kill a lot of processes.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/ptrace/ptrace05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index d610cc0..e717319 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -99,7 +99,7 @@ int main(int argc, char **argv)
 		switch (child = fork()) {
 		case -1:
 			tst_resm(TBROK | TERRNO, "Failed to fork properly.");
-			break;
+			continue;
 		case 0:
 
 			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != -1) {
-- 
1.9.3

