From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Tue, 8 Dec 2020 05:07:45 -0500
Subject: [LTP] [PATCH 1/3] syscalls/ipc: shmctl04: Test SHM_STAT_ANY with
 nobody user
Message-ID: <1607422067-15500-1-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use the nobody user to test the SHM_STAT_ANY is not checked for read access.

Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c | 26 +++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index bf3c854..9ba40f9 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -19,6 +19,7 @@
 
 #define _GNU_SOURCE
 #include <stdio.h>
+#include <pwd.h>
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
@@ -27,6 +28,16 @@
 #define SHM_SIZE 2048
 
 static int shm_id = -1;
+static struct passwd *ltpuser;
+static uid_t nobody_uid, root_uid;
+
+static struct tcases {
+	uid_t *uid;
+	char *desc;
+} tests[] = {
+	{&nobody_uid, "with nobody user"},
+	{&root_uid, "with root user"}
+};
 
 static void parse_proc_sysvipc(struct shm_info *info)
 {
@@ -96,12 +107,17 @@ static void parse_proc_sysvipc(struct shm_info *info)
 	fclose(f);
 }
 
-static void verify_shminfo(void)
+static void verify_shminfo(unsigned int n)
 {
+	struct tcases *tc = &tests[n];
 	struct shm_info info;
 	struct shmid_ds ds;
 	int i, shmid, cnt = 0;
 
+	tst_res(TINFO, "Test SHM_STAT_ANY %s", tc->desc);
+
+	SAFE_SETEUID(*tc->uid);
+
 	TEST(shmctl(0, SHM_INFO, (struct shmid_ds *)&info));
 
 	if (TST_RET == -1) {
@@ -136,6 +152,10 @@ static void verify_shminfo(void)
 
 static void setup(void)
 {
+	ltpuser = SAFE_GETPWNAM("nobody");
+	nobody_uid = ltpuser->pw_uid;
+	root_uid = 0;
+
 	shm_id = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
 }
 
@@ -148,5 +168,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_all = verify_shminfo,
+	.test = verify_shminfo,
+	.tcnt = ARRAY_SIZE(tests),
+	.needs_root = 1,
 };
-- 
1.8.3.1



