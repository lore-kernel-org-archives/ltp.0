From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  6 May 2021 13:51:08 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls: modify_ldt02: Fix failure
Message-ID: <20210506115108.16751-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test was wrong to begin with, if we want to get SEGFAULT from the
waitpid() we cannot setup a handler that catches it and exits with 0.

Fixes: f5e8e6b11ce8 ("syscalls/modify_ldt: Replace TINFO with TPASS or TFAIL")
Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/modify_ldt/modify_ldt02.c     | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c b/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
index e34d3d54d..f911aa5fd 100644
--- a/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
+++ b/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
@@ -120,6 +120,7 @@ int main(int ac, char **av)
 
 		tst_old_flush();
 		if ((pid = FORK_OR_VFORK()) == 0) {
+			signal(SIGSEGV, SIG_DFL);
 			val = read_segment(0);
 			exit(1);
 		}
@@ -168,24 +169,10 @@ int read_segment(unsigned int index)
 	return res;
 }
 
-void sigsegv_handler(int sig)
-{
-	tst_resm(TINFO, "received signal: %d", sig);
-	exit(0);
-}
-
 void setup(void)
 {
-	struct sigaction act;
-
-	memset(&act, 0, sizeof(act));
-	sigemptyset(&act.sa_mask);
-
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	act.sa_handler = sigsegv_handler;
-	(void)sigaction(SIGSEGV, &act, NULL);
-
 	TEST_PAUSE;
 }
 
-- 
2.26.3

