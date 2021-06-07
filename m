From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Mon,  7 Jun 2021 16:15:13 +0530
Subject: [LTP] [PATCH 5/7] shmctl02: Skipped EFAULT tests for libc variant.
In-Reply-To: <20210607104515.29838-1-vinay.m.engg@gmail.com>
References: <20210607104515.29838-1-vinay.m.engg@gmail.com>
Message-ID: <20210607104515.29838-5-vinay.m.engg@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tested EFAULT cases only for "__NR_shmctl"

Signed-off-by: Vinay Kumar <vinay.m.engg@gmail.com>
---
 .../kernel/syscalls/ipc/shmctl/shmctl02.c     | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
index 9057b7f54..b9a71722d 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
@@ -32,6 +32,7 @@
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
+#include "lapi/syscalls.h"
 
 #define SHM_SIZE 2048
 
@@ -43,6 +44,16 @@ static int shm_rem;
 
 static struct shmid_ds buf;
 
+static int libc_shmctl(int shmid, int cmd, void *buf)
+{
+	return shmctl(shmid, cmd, buf);
+}
+
+static int sys_shmctl(int shmid, int cmd, void *buf)
+{
+	return tst_syscall(__NR_shmctl, shmid, cmd, buf);
+}
+
 static struct tcase {
 	int *shm_id;
 	int cmd;
@@ -63,9 +74,29 @@ static struct tcase {
 	{&shm_id3, SHM_UNLOCK, &buf, EPERM}
 };
 
+static struct test_variants
+{
+	int (*shmctl)(int shmid, int cmd, void *buf);
+	char *desc;
+} variants[] = {
+	{ .shmctl = libc_shmctl, .desc = "libc shmctl()"},
+
+#if (__NR_shmctl != __LTP__NR_INVALID_SYSCALL)
+	{ .shmctl = sys_shmctl,  .desc = "__NR_shmctl syscall"},
+#endif
+};
+
 static void verify_shmctl(unsigned int i)
 {
-	TEST(shmctl(*(tc[i].shm_id), tc[i].cmd, tc[i].buf));
+	struct test_variants *tv = &variants[tst_variant];
+
+	if (tc[i].error == EFAULT
+		&& tv->shmctl == libc_shmctl) {
+		tst_res(TCONF, "EFAULT is skipped for libc variant");
+		return;
+	}
+
+	TEST(tv->shmctl(*(tc[i].shm_id), tc[i].cmd, tc[i].buf));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "shmctl() returned %li", TST_RET);
@@ -74,7 +105,7 @@ static void verify_shmctl(unsigned int i)
 
 	if (TST_ERR == tc[i].error) {
 		tst_res(TPASS | TTERRNO, "shmctl(%i, %i, %p)",
-		        *tc[i].shm_id, tc[i].cmd, tc[i].buf);
+				*tc[i].shm_id, tc[i].cmd, tc[i].buf);
 		return;
 	}
 
@@ -84,10 +115,14 @@ static void verify_shmctl(unsigned int i)
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+
 	key_t shmkey1, shmkey2;
 	struct passwd *ltpuser;
 	int tmp;
 
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+
 	shm_id3 = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
 
 	ltpuser = SAFE_GETPWNAM("nobody");
@@ -121,6 +156,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_shmctl,
+	.test_variants = ARRAY_SIZE(variants),
 	.tcnt = ARRAY_SIZE(tc),
 	.needs_root = 1,
 };
-- 
2.17.1

