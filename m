From: yang xu <xuyang.jy@cn.fujitsu.com>
Date: Thu, 19 Apr 2018 18:55:57 +0800
Subject: [LTP] [PATCH] syscalls/mkdir03: Use tst_get_bad_addr()
In-Reply-To: <20180419100714.GA27089@rei>
References: <20180419100714.GA27089@rei>
Message-ID: <1524135357-24852-1-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Remove useless struct member

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mkdir/mkdir03.c | 32 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index 5d7f1e1..9441afe 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -46,20 +46,18 @@ static char long_dir[PATH_MAX + 2] = {[0 ... PATH_MAX + 1] = 'a'};
 static char loop_dir[PATH_MAX] = ".";
 
 struct tcase;
-static void prot_none_pathname(struct tcase *tc);
 
 static struct tcase {
 	char *pathname;
 	int exp_errno;
-	void (*setupfunc)(struct tcase *tc);
 } TC[] = {
-	{NULL, EFAULT, prot_none_pathname},
-	{long_dir, ENAMETOOLONG, NULL},
-	{TST_EEXIST, EEXIST, NULL},
-	{TST_ENOENT, ENOENT, NULL},
-	{TST_ENOTDIR_DIR, ENOTDIR, NULL},
-	{loop_dir, ELOOP, NULL},
-	{TST_EROFS, EROFS, NULL},
+	{NULL, EFAULT},
+	{long_dir, ENAMETOOLONG},
+	{TST_EEXIST, EEXIST},
+	{TST_ENOENT, ENOENT},
+	{TST_ENOTDIR_DIR, ENOTDIR},
+	{loop_dir, ELOOP},
+	{TST_EROFS, EROFS},
 };
 
 static void verify_mkdir(unsigned int n)
@@ -82,12 +80,6 @@ static void verify_mkdir(unsigned int n)
 	}
 }
 
-static void prot_none_pathname(struct tcase *tc)
-{
-	tc->pathname = SAFE_MMAP(0, 1, PROT_NONE,
-		MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-}
-
 static void setup(void)
 {
 	unsigned int i;
@@ -95,15 +87,15 @@ static void setup(void)
 	SAFE_TOUCH(TST_EEXIST, MODE, NULL);
 	SAFE_TOUCH(TST_ENOTDIR_FILE, MODE, NULL);
 
+	for (i = 0; i < ARRAY_SIZE(TC); i++) {
+		if (TC[i].exp_errno == EFAULT)
+			TC[i].pathname = tst_get_bad_addr(NULL);
+	}
+
 	SAFE_MKDIR("test_eloop", DIR_MODE);
 	SAFE_SYMLINK("../test_eloop", "test_eloop/test_eloop");
 	for (i = 0; i < 43; i++)
 		strcat(loop_dir, "/test_eloop");
-
-	for (i = 0; i < ARRAY_SIZE(TC); i++) {
-		if (TC[i].setupfunc)
-			TC[i].setupfunc(&TC[i]);
-	}
 }
 
 static struct tst_test test = {
-- 
1.8.3.1



