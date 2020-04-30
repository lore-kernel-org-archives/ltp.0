From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 30 Apr 2020 17:58:22 +0800
Subject: [LTP] [PATCH v2 1/3] lib/tst_assert: print correct file and lineno
 when parsing failed
In-Reply-To: <20200429120609.GA668@yuki.lan>
References: <20200429120609.GA668@yuki.lan>
Message-ID: <1588240704-14747-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use safe_file_scanf instead of SAFE_FILE_SCANF, so we can pass correct
file and lineno. ie prctl05.c

Before this patch, fail as below:
safe_file_ops.c:142: BROK: Failed to open FILE '/proc/self/comm1' for reading at tst_assert.c:29: ENOENT (2)

After this patch, fail as below:
safe_file_ops.c:142: BROK: Failed to open FILE '/proc/self/comm1' for reading at prctl05.c:63: ENOENT (2)

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 lib/tst_assert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_assert.c b/lib/tst_assert.c
index 8ef3cd72e..f05aea222 100644
--- a/lib/tst_assert.c
+++ b/lib/tst_assert.c
@@ -12,7 +12,7 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
 {
 	int sys_val;
 
-	SAFE_FILE_SCANF(path, "%d", &sys_val);
+	safe_file_scanf(file, lineno, NULL, path, "%d", &sys_val);
 
 	if (val == sys_val) {
 		tst_res_(file, lineno, TPASS, "%s = %d", path, val);
@@ -26,7 +26,7 @@ void tst_assert_str(const char *file, const int lineno, const char *path, const
 {
 	char sys_val[1024];
 
-	SAFE_FILE_SCANF(path, "%1024s", sys_val);
+	safe_file_scanf(file, lineno, NULL, path, "%1024s", sys_val);
 	if (!strcmp(val, sys_val)) {
 		tst_res_(file, lineno, TPASS, "%s = '%s'", path, val);
 		return;
-- 
2.23.0



