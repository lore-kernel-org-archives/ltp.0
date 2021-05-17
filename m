From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 17 May 2021 17:30:27 +0100
Subject: [LTP] [RFC PATCH 4/6] API: add tst_ to mount_overlay
In-Reply-To: <20210517163029.22974-1-rpalethorpe@suse.com>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
Message-ID: <20210517163029.22974-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/safe_file_ops_fn.h  | 3 +--
 include/tst_safe_file_ops.h | 4 ++--
 lib/tst_fs_setup.c          | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/safe_file_ops_fn.h b/include/safe_file_ops_fn.h
index 620e12e9a..e1ace0ae2 100644
--- a/include/safe_file_ops_fn.h
+++ b/include/safe_file_ops_fn.h
@@ -87,7 +87,6 @@ int safe_touch(const char *file, const int lineno,
 		mode_t mode, const struct timespec times[2]);
 
 /* helper functions to setup overlayfs mountpoint */
-void create_overlay_dirs(void);
-int mount_overlay(const char *file, const int lineno, int skip);
+int tst_mount_overlay(const char *file, const int lineno, int skip);
 
 #endif /* SAFE_FILE_OPS_FN */
diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 7457edd61..6b078b16c 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -52,9 +52,9 @@
 			(pathname), (mode), (times))
 
 #define SAFE_MOUNT_OVERLAY() \
-	((void) mount_overlay(__FILE__, __LINE__, 1))
+	((void) tst_mount_overlay(__FILE__, __LINE__, 1))
 
 #define TST_MOUNT_OVERLAY() \
-	(mount_overlay(__FILE__, __LINE__, 0) == 0)
+	(tst_mount_overlay(__FILE__, __LINE__, 0) == 0)
 
 #endif /* TST_SAFE_FILE_OPS */
diff --git a/lib/tst_fs_setup.c b/lib/tst_fs_setup.c
index b20fd06f2..8b0a343b7 100644
--- a/lib/tst_fs_setup.c
+++ b/lib/tst_fs_setup.c
@@ -24,7 +24,7 @@ static void create_overlay_dirs(void)
 	closedir(dir);
 }
 
-int mount_overlay(const char *file, const int lineno, int skip)
+int tst_mount_overlay(const char *file, const int lineno, int skip)
 {
 	int ret;
 
-- 
2.31.1

