From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 15 Dec 2016 18:49:57 +0800
Subject: [LTP] [PATCH v2 4/4] syscalls/setpriority01: Use new user id to
	avoid messing system environment
In-Reply-To: <1481798997-2320-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <20161215104356.GB29787@rei.suse.cz>
 <1481798997-2320-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1481798997-2320-4-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

setpriority(PRIO_USER, root_proc, prio) sets the priorities of
all the root processes to the specified value, though this is
kind of expected for the test, it impacts the system environment.

Create a new user and set it privileged, then test with the temp
user id to ensure the test safety.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 .../kernel/syscalls/setpriority/setpriority01.c    | 96 +++++++++++++++++++---
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c b/testcases/kernel/syscalls/setpriority/setpriority01.c
index e5111d7..83c9c1e 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority01.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
@@ -23,36 +23,50 @@
  */
 
 #include <errno.h>
+#include <pwd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/capability.h>
+#include <sys/prctl.h>
 #include <sys/resource.h>
 #include <sys/time.h>
+#include <sys/types.h>
+#include <unistd.h>
+
 #include "tst_test.h"
+#include "linux_syscall_numbers.h"
+
+static const char *username = "ltp_setpriority01";
+static int pid, uid;
+static cap_user_header_t header;
+static cap_user_data_t data;
 
 static struct tcase {
 	int which;
+	int *who;
 } tcases[] = {
-	{PRIO_PROCESS},
-	{PRIO_PGRP},
-	{PRIO_USER}
+	{PRIO_PROCESS, &pid},
+	{PRIO_PGRP, &pid},
+	{PRIO_USER, &uid}
 };
 
-static void verify_setpriority(unsigned int n)
+static void setpriority_test(struct tcase *tc)
 {
-	struct tcase *tc = &tcases[n];
 	int new_prio, cur_prio;
 	int failflag = 0;
 
 	for (new_prio = -20; new_prio < 20; new_prio++) {
-		TEST(setpriority(tc->which, 0, new_prio));
+		TEST(setpriority(tc->which, *tc->who, new_prio));
 
 		if (TEST_RETURN != 0) {
 			tst_res(TFAIL | TTERRNO,
-				"setpriority(%d, 0, %d) failed",
-				tc->which, new_prio);
+				"setpriority(%d, %d, %d) failed",
+				tc->which, *tc->who, new_prio);
 			failflag = 1;
 			continue;
 		}
 
-		cur_prio = SAFE_GETPRIORITY(tc->which, 0);
+		cur_prio = SAFE_GETPRIORITY(tc->which, *tc->who);
 
 		if (cur_prio != new_prio) {
 			tst_res(TFAIL, "current priority(%d) and "
@@ -63,14 +77,74 @@ static void verify_setpriority(unsigned int n)
 	}
 
 	if (!failflag) {
-		tst_res(TPASS, "setpriority(%d, 0, -20..19) succeeded",
-			tc->which);
+		tst_res(TPASS, "setpriority(%d, %d, -20..19) succeeded",
+			tc->which, *tc->who);
+	}
+}
+
+static void verify_setpriority(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		SAFE_PRCTL(PR_SET_KEEPCAPS, 1);
+
+		SAFE_SETUID(uid);
+		SAFE_SETPGID(0, 0);
+
+		if (tst_syscall(__NR_capset, header, data) == -1)
+			tst_brk(TBROK | TERRNO, "capset() failed");
+
+		TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+		exit(0);
 	}
+
+	TST_CHECKPOINT_WAIT(0);
+
+	setpriority_test(tc);
+
+	TST_CHECKPOINT_WAKE(0);
+
+	tst_reap_children();
+}
+
+static void setup(void)
+{
+	const char *const cmd_useradd[] = {"useradd", username, NULL};
+	struct passwd *ltpuser;
+
+	tst_run_cmd(cmd_useradd, NULL, NULL, 0);
+
+	ltpuser = SAFE_GETPWNAM(username);
+	uid = ltpuser->pw_uid;
+
+	header = SAFE_MALLOC(sizeof(cap_user_header_t));
+	data = SAFE_MALLOC(sizeof(cap_user_data_t));
+
+	header->version = _LINUX_CAPABILITY_VERSION;
+	header->pid = 0;
+
+	if (tst_syscall(__NR_capget, header, data) == -1)
+		tst_brk(TBROK | TERRNO, "capget() failed");
+}
+
+static void cleanup(void)
+{
+	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
+
+	if (tst_run_cmd(cmd_userdel, NULL, NULL, 1))
+		tst_res(TWARN | TERRNO, "'userdel -r %s' failed", username);
 }
 
 static struct tst_test test = {
 	.tid = "setpriority01",
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.setup = setup,
+	.cleanup = cleanup,
 	.test = verify_setpriority,
 };
-- 
1.8.4.2



