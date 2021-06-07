From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Mon,  7 Jun 2021 16:15:12 +0530
Subject: [LTP] [PATCH 4/7] semctl03: Skipped EFAULT tests for libc variant.
In-Reply-To: <20210607104515.29838-1-vinay.m.engg@gmail.com>
References: <20210607104515.29838-1-vinay.m.engg@gmail.com>
Message-ID: <20210607104515.29838-4-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tested EFAULT cases only for "__NR_semctl" syscall.

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/ipc/semctl/semctl03.c     | 39 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
index ed2a46b16..44030ae47 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
@@ -15,6 +15,7 @@
 #include "tst_test.h"
 #include "lapi/sem.h"
 #include "libnewipc.h"
+#include "lapi/syscalls.h"
 
 static int sem_id = -1;
 static int bad_id = -1;
@@ -23,6 +24,17 @@ static struct semid_ds sem_ds;
 static union semun sem_un = {.buf = &sem_ds};
 static void *semds_ptr = &sem_un;
 static void *bad_ptr;
+static union semun arg = {0};
+
+static int libc_semctl(int semid, int semnum, int cmd, ...)
+{
+	return semctl(semid, semnum, cmd, arg);
+}
+
+static int sys_semctl(int semid, int semnum, int cmd, ...)
+{
+	return tst_syscall(__NR_semctl, semid, semnum, cmd, arg);
+}
 
 static struct tcases {
 	int *sem_id;
@@ -37,17 +49,39 @@ static struct tcases {
 	{&sem_id, IPC_SET, &bad_ptr, EFAULT, "invalid union arg"}
 };
 
+static struct test_variants
+{
+	int (*semctl)(int semid, int semnum, int cmd, ...);
+	char *desc;
+} variants[] = {
+	{ .semctl = libc_semctl, .desc = "libc semctl()"},
+
+#if (__NR_sys_semctl != __LTP__NR_INVALID_SYSCALL)
+	{ .semctl = sys_semctl,  .desc = "__NR_semctl syscall"},
+#endif
+};
+
 static void verify_semctl(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
+	struct test_variants *tv = &variants[tst_variant];
+
+	if (tc->error == EFAULT
+		&& tv->semctl == libc_semctl) {
+		tst_res(TCONF, "EFAULT is skipped for libc variant");
+		return;
+	}
 
-	TST_EXP_FAIL(semctl(*(tc->sem_id), 0, tc->ipc_cmd, *(tc->buf)),
-		     tc->error, "semctl() with %s", tc->message);
+	TST_EXP_FAIL(sys_semctl(*(tc->sem_id), 0, tc->ipc_cmd, *(tc->buf)),
+		tc->error, "semctl() with %s", tc->message);
 }
 
 static void setup(void)
 {
 	static key_t semkey;
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
 	semkey = GETIPCKEY();
 
@@ -67,4 +101,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = verify_semctl,
 	.tcnt = ARRAY_SIZE(tests),
+	.test_variants = ARRAY_SIZE(variants),
 };
-- 
2.17.1

