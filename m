From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 9 Mar 2017 18:22:43 +0800
Subject: [LTP] [PATCH] syscalls/keyctl02: Fix insufficiency of default key
	count quota
Message-ID: <1489054963-999-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adding and revoking keys rapidly in loops will take a significant
number of key count quota, because it takes time to release the
instantiated key, so temporarily raise the quota when testing.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/keyctl/keyctl02.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index 7145a5a..fc743d2 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -48,6 +48,9 @@
 #ifdef HAVE_KEYUTILS_H
 
 #define LOOPS	20000
+#define PATH_KEY_COUNT_QUOTA	"/proc/sys/kernel/keys/root_maxkeys"
+
+static int orig_maxkeys;
 
 static void *do_read(void *arg)
 {
@@ -98,8 +101,22 @@ static void do_test(void)
 	tst_res(TPASS, "Bug not reproduced");
 }
 
+static void setup(void)
+{
+	SAFE_FILE_SCANF(PATH_KEY_COUNT_QUOTA, "%d", &orig_maxkeys);
+	SAFE_FILE_PRINTF(PATH_KEY_COUNT_QUOTA, "%d", orig_maxkeys + LOOPS);
+}
+
+static void cleanup(void)
+{
+	SAFE_FILE_PRINTF(PATH_KEY_COUNT_QUOTA, "%d", orig_maxkeys);
+}
+
 static struct tst_test test = {
 	.tid = "keyctl02",
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
 	.test_all = do_test,
 };
 
-- 
1.8.4.2



