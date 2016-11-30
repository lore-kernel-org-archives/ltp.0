From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 30 Nov 2016 20:12:35 +0800
Subject: [LTP] [PATCH 5/5] syscalls/setpriority01: Use new user id to avoid
	messing system environment
In-Reply-To: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1480507955-12652-5-git-send-email-fenggw-fnst@cn.fujitsu.com>
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
 .../kernel/syscalls/setpriority/setpriority01.c    | 68 +++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c b/testcases/kernel/syscalls/setpriority/setpriority01.c
index e5111d7..0e53784 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority01.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
@@ -23,9 +23,23 @@
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
+static char username[32];
+static uid_t uid;
+static struct __user_cap_header_struct header;
+static struct __user_cap_data_struct data;
 
 static struct tcase {
 	int which;
@@ -35,9 +49,8 @@ static struct tcase {
 	{PRIO_USER}
 };
 
-static void verify_setpriority(unsigned int n)
+static void setpriority_test(struct tcase *tc)
 {
-	struct tcase *tc = &tcases[n];
 	int new_prio, cur_prio;
 	int failflag = 0;
 
@@ -68,9 +81,60 @@ static void verify_setpriority(unsigned int n)
 	}
 }
 
+static void verify_setpriority(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	if (!SAFE_FORK()) {
+		SAFE_PRCTL(PR_SET_KEEPCAPS, 1);
+
+		SAFE_SETUID(uid);
+		SAFE_SETPGID(0, 0);
+
+		if (tst_syscall(__NR_capset, &header, &data) == -1)
+			tst_brk(TBROK | TERRNO, "capset() failed");
+
+		setpriority_test(tc);
+
+		exit(0);
+	}
+
+	tst_reap_children();
+}
+
+static void setup(void)
+{
+	char cmd[64];
+	struct passwd *ltpuser;
+
+	sprintf(username, "setpriority01.%d", getpid());
+
+	sprintf(cmd, "useradd %s", username);
+	SAFE_SYSTEM(cmd);
+
+	ltpuser = SAFE_GETPWNAM(username);
+	uid = ltpuser->pw_uid;
+
+	header.version = _LINUX_CAPABILITY_VERSION;
+	header.pid = 0;
+	if (tst_syscall(__NR_capget, &header, &data) == -1)
+		tst_brk(TBROK | TERRNO, "capget() failed");
+}
+
+static void cleanup(void)
+{
+	char cmd[64];
+
+	sprintf(cmd, "userdel -r %s", username);
+	SAFE_SYSTEM(cmd);
+}
+
 static struct tst_test test = {
 	.tid = "setpriority01",
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
 	.test = verify_setpriority,
 };
-- 
1.8.4.2



