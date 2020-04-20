From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 20 Apr 2020 17:51:18 +0800
Subject: [LTP] [PATCH] syscalls/prctl: Use TST_ASSERT_STR/INT
Message-ID: <1587376278-14538-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/prctl/prctl05.c | 17 ++---------------
 testcases/kernel/syscalls/prctl/prctl08.c | 16 +---------------
 2 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl05.c b/testcases/kernel/syscalls/prctl/prctl05.c
index 1f979007f..ae390fdfc 100644
--- a/testcases/kernel/syscalls/prctl/prctl05.c
+++ b/testcases/kernel/syscalls/prctl/prctl05.c
@@ -28,18 +28,6 @@ static struct tcase {
 	{"prctl05_test_xxxxx", "prctl05_test_xx"}
 };
 
-static void check_proc_comm(char *path, char *name)
-{
-	char comm_buf[20];
-
-	SAFE_FILE_SCANF(path, "%s", comm_buf);
-	if (strcmp(name, comm_buf))
-		tst_res(TFAIL,
-			"%s has %s, expected %s", path, comm_buf, name);
-	else
-		tst_res(TPASS, "%s sets to %s", path, comm_buf);
-}
-
 static void verify_prctl(unsigned int n)
 {
 	char buf[20];
@@ -71,9 +59,8 @@ static void verify_prctl(unsigned int n)
 	tid = tst_syscall(__NR_gettid);
 
 	sprintf(comm_path, "/proc/self/task/%d/comm", tid);
-	check_proc_comm(comm_path, tc->expname);
-
-	check_proc_comm("/proc/self/comm", tc->expname);
+	TST_ASSERT_STR(comm_path, tc->expname);
+	TST_ASSERT_STR("/proc/self/comm", tc->expname);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/prctl/prctl08.c b/testcases/kernel/syscalls/prctl/prctl08.c
index fd8ccb6ad..9a1b34c17 100644
--- a/testcases/kernel/syscalls/prctl/prctl08.c
+++ b/testcases/kernel/syscalls/prctl/prctl08.c
@@ -53,19 +53,6 @@ static void check_reset_timerslack(char *message)
 	check_get_timerslack(message, origin_value);
 }
 
-static void check_proc_timerslack(char *message, unsigned long value)
-{
-	unsigned long proc_value;
-
-	SAFE_FILE_SCANF(PROC_TIMERSLACK_PATH, "%lu", &proc_value);
-	if (proc_value == value)
-		tst_res(TPASS, "%s %s  got %lu expectedly",
-				message, PROC_TIMERSLACK_PATH, proc_value);
-	else
-		tst_res(TFAIL, "%s %s expected %lu got %lu",
-				message, PROC_TIMERSLACK_PATH, value, proc_value);
-}
-
 static void check_get_timerslack(char *message, unsigned long value)
 {
 	TEST(prctl(PR_GET_TIMERSLACK));
@@ -77,8 +64,7 @@ static void check_get_timerslack(char *message, unsigned long value)
 				message, value, TST_RET);
 
 	if (proc_flag)
-		check_proc_timerslack(message, value);
-
+		TST_ASSERT_INT(PROC_TIMERSLACK_PATH, value);
 }
 
 static void check_inherit_timerslack(char *message, unsigned long value)
-- 
2.23.0



