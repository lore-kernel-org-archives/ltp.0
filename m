From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Wed,  9 Jun 2021 23:05:58 +0530
Subject: [LTP] [PATCH v2 07/10] msgctl04: Skipped EFAULT tests for libc
 variant.
In-Reply-To: <20210609173601.29352-1-vinay.m.engg@gmail.com>
References: <YL/Wf51Y6V5lRnkM@pevik>
 <20210609173601.29352-1-vinay.m.engg@gmail.com>
Message-ID: <20210609173601.29352-7-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tested EFAULT cases only for "__NR_msgctl" syscall.

Tests for bad addresses in LTP cases trigger segment
fault in libc on a 32bit system.

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/ipc/msgctl/msgctl04.c     | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
index 900b22244..3d0c7f896 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
@@ -15,6 +15,7 @@
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
+#include "lapi/syscalls.h"
 
 static int msg_id1 = -1;
 static int msg_id2 = -1;
@@ -23,6 +24,16 @@ static int bad_q = -1;
 
 struct msqid_ds q_buf;
 
+static int libc_msgctl(int msqid, int cmd, void *buf)
+{
+	return msgctl(msqid, cmd, buf);
+}
+
+static int sys_msgctl(int msqid, int cmd, void *buf)
+{
+	return tst_syscall(__NR_msgctl, msqid, cmd, buf);
+}
+
 struct tcase {
 	int *msg_id;
 	int cmd;
@@ -45,9 +56,29 @@ struct tcase {
 	{&msg_id3, IPC_RMID, NULL, EPERM},
 };
 
+static struct test_variants
+{
+	int (*msgctl)(int msqid, int cmd, void *buf);
+	char *desc;
+} variants[] = {
+	{ .msgctl = libc_msgctl, .desc = "libc msgctl()"},
+
+#if (__NR_msgctl != __LTP__NR_INVALID_SYSCALL)
+	{ .msgctl = sys_msgctl,  .desc = "__NR_msgctl syscall"},
+#endif
+};
+
 static void verify_msgctl(unsigned int i)
 {
-	TEST(msgctl(*(tc[i].msg_id), tc[i].cmd, tc[i].buf));
+	struct test_variants *tv = &variants[tst_variant];
+
+	if (tc[i].error == EFAULT &&
+		tv->msgctl == libc_msgctl) {
+		tst_res(TCONF, "EFAULT is skipped for libc variant");
+		return;
+	}
+
+	TEST(tv->msgctl(*(tc[i].msg_id), tc[i].cmd, tc[i].buf));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "msgctl() returned %li", TST_RET);
@@ -66,6 +97,8 @@ static void verify_msgctl(unsigned int i)
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+
 	key_t msgkey1, msgkey2;
 	struct passwd *ltpuser;
 
@@ -79,6 +112,8 @@ static void setup(void)
 
 	msg_id1 = SAFE_MSGGET(msgkey1, IPC_CREAT | IPC_EXCL);
 	msg_id2 = SAFE_MSGGET(msgkey2, IPC_CREAT | IPC_EXCL | MSG_RD | MSG_WR);
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
 }
 
 static void cleanup(void)
@@ -100,6 +135,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = verify_msgctl,
 	.tcnt = ARRAY_SIZE(tc),
+	.test_variants = ARRAY_SIZE(variants),
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 };
-- 
2.17.1

