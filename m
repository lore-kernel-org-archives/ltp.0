From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  7 May 2020 15:24:30 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscall/prctl06: Fix proc NoNewPrivs
 detection
Message-ID: <20200507132430.22677-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The prctl() syscall check does return in case of success hence the check
for NoNewPrivs was never executed. Move the proc check before the sycall
check to fix that.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/prctl/prctl06.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl06.c b/testcases/kernel/syscalls/prctl/prctl06.c
index 3ebf1ab60..d6517e6b1 100644
--- a/testcases/kernel/syscalls/prctl/prctl06.c
+++ b/testcases/kernel/syscalls/prctl/prctl06.c
@@ -87,6 +87,12 @@ static void setup(void)
 	SAFE_CHOWN(BIN_PATH, 0, 0);
 	SAFE_CHMOD(BIN_PATH, SUID_MODE);
 
+	if (FILE_LINES_SCANF(PROC_STATUS, "NoNewPrivs:%d", &field)) {
+		tst_res(TCONF, "%s doesn't support NoNewPrivs field", PROC_STATUS);
+		proc_flag = 0;
+		proc_sup = "No";
+	}
+
 	TEST(prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
 	if (TST_RET == 0) {
 		tst_res(TINFO, "kernel supports PR_GET/SET_NO_NEW_PRIVS");
@@ -99,13 +105,6 @@ static void setup(void)
 
 	tst_brk(TBROK | TTERRNO,
 		"current environment doesn't permit PR_GET/SET_NO_NEW_PRIVS");
-
-	TEST(FILE_LINES_SCANF(PROC_STATUS, "NoNewPrivs:%d", &field));
-	if (TST_RET == 1) {
-		tst_res(TCONF, "%s doesn't support NoNewPrivs field", PROC_STATUS);
-		proc_flag = 0;
-		proc_sup = "No";
-	}
 }
 
 static const char *const resfile[] = {
-- 
2.26.2

