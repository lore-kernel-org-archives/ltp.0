From: ice_yangxiao@163.com <ice_yangxiao@163.com>
Date: Mon, 19 Apr 2021 10:38:44 +0800
Subject: [LTP] [PATCH 2/2] syscalls/{wait401.c,
 waitpid01.c}: Take use of TST_EXP_PID_SILENT()
In-Reply-To: <20210419023845.19140-1-ice_yangxiao@163.com>
References: <20210419023845.19140-1-ice_yangxiao@163.com>
Message-ID: <20210419023845.19140-2-ice_yangxiao@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Xiao Yang <yangx.jy@fujitsu.com>

Also correct the name(waitpid=>wait4) in the output of wait401.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 testcases/kernel/syscalls/wait4/wait401.c     | 10 +++-------
 testcases/kernel/syscalls/waitpid/waitpid01.c | 12 +++++-------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/wait4/wait401.c b/testcases/kernel/syscalls/wait4/wait401.c
index 07fb864f3..405b0e133 100644
--- a/testcases/kernel/syscalls/wait4/wait401.c
+++ b/testcases/kernel/syscalls/wait4/wait401.c
@@ -29,17 +29,13 @@ static void run(void)
 		exit(0);
 	}
 
-	TEST(wait4(pid, &status, 0, &rusage));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "wait4() failed");
-		return;
-	}
+	TST_EXP_PID_SILENT(wait4(pid, &status, 0, &rusage), "wait4()");
 
 	if (TST_RET != pid) {
-		tst_res(TFAIL, "waitpid() returned wrong pid %li, expected %i",
+		tst_res(TFAIL, "wait4() returned wrong pid %li, expected %i",
 			TST_RET, pid);
 	} else {
-		tst_res(TPASS, "waitpid() returned correct pid %i", pid);
+		tst_res(TPASS, "wait4() returned correct pid %i", pid);
 	}
 
 	if (!WIFEXITED(status)) {
diff --git a/testcases/kernel/syscalls/waitpid/waitpid01.c b/testcases/kernel/syscalls/waitpid/waitpid01.c
index 6e03acef6..0c5096f4e 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid01.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid01.c
@@ -18,7 +18,7 @@
 
 static void run(void)
 {
-	pid_t pid, rpid;
+	pid_t pid;
 	int status;
 
 	pid = SAFE_FORK();
@@ -27,13 +27,11 @@ static void run(void)
 		exit(0);
 	}
 
-	rpid = waitpid(pid, &status, 0);
-	if (rpid < 0)
-		tst_brk(TBROK | TERRNO, "waitpid() failed");
+	TST_EXP_PID_SILENT(waitpid(pid, &status, 0));
 
-	if (rpid != pid) {
-		tst_res(TFAIL, "waitpid() returned wrong pid %i, expected %i",
-		        rpid, pid);
+	if (TST_RET != pid) {
+		tst_res(TFAIL, "waitpid() returned wrong pid %li, expected %i",
+			TST_RET, pid);
 	} else {
 		tst_res(TPASS, "waitpid() returned correct pid %i", pid);
 	}
-- 
2.26.2

