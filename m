From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 29 Mar 2017 15:12:29 +0800
Subject: [LTP] [PATCH v2] syscalls/keyctl02: Fix insufficiency of default
	key count quota
In-Reply-To: <1489054963-999-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1489054963-999-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1490771549-29656-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adding and revoking keys rapidly in loops will take a significant
number of key count quota, because it takes time to free the
instantiated keys, so temporarily raise the quota when testing.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/keyctl/keyctl02.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index 11d3af9..1fdea79 100644
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
@@ -98,9 +101,22 @@ static void do_test(void)
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
 	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
 	.test_all = do_test,
 };
 
-- 
1.8.4.2



