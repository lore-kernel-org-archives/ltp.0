From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:56 +0200
Subject: [LTP] [COMMITTED] [PATCH 09/13] Make use of SAFE_WAIT()
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-9-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/clone/clone01.c           | 6 ++----
 testcases/kernel/syscalls/exit_group/exit_group01.c | 5 ++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/clone/clone01.c b/testcases/kernel/syscalls/clone/clone01.c
index 855c1085d..e490b4e77 100644
--- a/testcases/kernel/syscalls/clone/clone01.c
+++ b/testcases/kernel/syscalls/clone/clone01.c
@@ -30,6 +30,7 @@
 #include <sched.h>
 #include <sys/wait.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "clone_platform.h"
 
 static void setup(void);
@@ -58,10 +59,7 @@ int main(int ac, char **av)
 	if (TEST_RETURN == -1)
 		tst_resm(TFAIL | TTERRNO, "clone failed");
 
-	child_pid = wait(&status);
-	if (child_pid == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "wait failed, status: %d",
-			 status);
+	child_pid = SAFE_WAIT(cleanup, &status);
 
 	if (TEST_RETURN == child_pid)
 		tst_resm(TPASS, "clone returned %ld", TEST_RETURN);
diff --git a/testcases/kernel/syscalls/exit_group/exit_group01.c b/testcases/kernel/syscalls/exit_group/exit_group01.c
index 3726b0652..d7bcbe9d6 100644
--- a/testcases/kernel/syscalls/exit_group/exit_group01.c
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -25,6 +25,7 @@
 #include <sys/wait.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "lapi/syscalls.h"
 
 char *TCID = "exit_group01";
@@ -43,9 +44,7 @@ static void verify_exit_group(void)
 	if (cpid == 0) {
 		TEST(ltp_syscall(__NR_exit_group, 4));
 	} else {
-		w = wait(&status);
-		if (w == -1)
-			tst_brkm(TBROK | TERRNO, NULL, "wait() failed");
+		w = SAFE_WAIT(NULL, &status);
 
 		if (WIFEXITED(status) && (WEXITSTATUS(status) == 4)) {
 			tst_resm(TPASS, "exit_group() succeeded");
-- 
2.13.5

