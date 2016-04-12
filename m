From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Tue, 12 Apr 2016 21:22:56 +0800
Subject: [LTP] [PATCH] waitpid/waitpid03: break test if fork failed
Message-ID: <20160412132256.GA7441@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If continue after the fork failure, a lot of processes may be killed by
the kill() on line 125.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitpid/waitpid03.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid03.c b/testcases/kernel/syscalls/waitpid/waitpid03.c
index 2599a92..648870c 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid03.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid03.c
@@ -106,7 +106,8 @@ int main(int argc, char **argv)
 				if (DEBUG)
 					tst_resm(TINFO, "child # %d", ikids);
 			} else if (pid[ikids] == -1) {
-				tst_resm(TFAIL, "cannot open fork #%d", ikids);
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "cannot open fork #%d", ikids);
 			} else {
 #ifdef UCLINUX
 				if (self_exec(argv[0], "d", ikids) < 0) {
-- 
1.9.3

