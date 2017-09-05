From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  5 Sep 2017 18:09:14 +0200
Subject: [LTP] [RFC] [PATCH 11/15] syscalls/setxattr01: Run test for all
	filesystems
In-Reply-To: <20170905160918.6477-1-chrubis@suse.cz>
References: <20170905160918.6477-1-chrubis@suse.cz>
Message-ID: <20170905160918.6477-11-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/setxattr/setxattr01.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index 86df7ba73..4db56123a 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -66,7 +66,8 @@
 #define XATTR_TEST_KEY "user.testkey"
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
-#define FNAME "setxattr01testfile"
+#define MNTPOINT "mntpoint"
+#define FNAME MNTPOINT"/setxattr01testfile"
 
 static char long_key[XATTR_NAME_LEN];
 static char *long_value;
@@ -165,8 +166,6 @@ static void verify_setxattr(unsigned int i)
 
 static void setup(void)
 {
-	SAFE_TOUCH(FNAME, 0644, NULL);
-
 	snprintf(long_key, 6, "%s", "user.");
 	memset(long_key + 5, 'k', XATTR_NAME_LEN - 5);
 	long_key[XATTR_NAME_LEN - 1] = '\0';
@@ -174,12 +173,17 @@ static void setup(void)
 	long_value = SAFE_MALLOC(XATTR_SIZE_MAX + 2);
 	memset(long_value, 'v', XATTR_SIZE_MAX + 2);
 	long_value[XATTR_SIZE_MAX + 1] = '\0';
+
+	SAFE_TOUCH(FNAME, 0644, NULL);
 }
 
 static struct tst_test test = {
 	.setup = setup,
 	.test = verify_setxattr,
 	.tcnt = ARRAY_SIZE(tc),
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 };
-- 
2.13.0

