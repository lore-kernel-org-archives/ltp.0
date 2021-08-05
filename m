From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Aug 2021 15:32:22 +0200
Subject: [LTP] [PATCH] [COMMITTED] lib/tst_test: Fix 'discards const' warning
Message-ID: <20210805133222.10589-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8a6a112ef..1bdea769a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -882,7 +882,7 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
 	}
 }
 
-static char *limit_tmpfs_mount_size(const char *mnt_data,
+static const char *limit_tmpfs_mount_size(const char *mnt_data,
 		char *buf, size_t buf_size, const char *fs_type)
 {
 	if (strcmp(fs_type, "tmpfs"))
@@ -908,7 +908,8 @@ static const char *get_device_name(const char *fs_type)
 
 static void prepare_device(void)
 {
-	char *mnt_data, buf[1024];
+	const char *mnt_data;
+	char buf[1024];
 
 	if (tst_test->format_device) {
 		SAFE_MKFS(tdev.dev, tdev.fs_type, tst_test->dev_fs_opts,
-- 
2.31.1

