From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 17:28:16 +0100
Subject: [LTP] [COMMITTED] [PATCH] lib: tst_mkfs: Include __FILE__ and
	__LINE__ in tst_brkm messages
Message-ID: <20170213162816.9613-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I should have made the tst_mkfs() as a macro in the first place.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/old/test.h |  9 ++++++---
 include/tst_mkfs.h | 10 ++++++----
 lib/tst_mkfs.c     | 38 ++++++++++++++++----------------------
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/include/old/test.h b/include/old/test.h
index d492560..209dc5b 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -201,9 +201,12 @@ int self_exec(const char *argv0, const char *fmt, ...);
  * @fs_opts: NULL or NULL terminated array of mkfs options
  * @extra_opt: extra mkfs option which is passed after the device name
  */
-void tst_mkfs(void (cleanup_fn)(void), const char *dev,
-              const char *fs_type, const char *const fs_opts[],
-              const char *extra_opt);
+#define tst_mkfs(cleanup, dev, fs_type, fs_opts, extra_opt) \
+	tst_mkfs_(__FILE__, __LINE__, cleanup, dev, fs_type, \
+		  fs_opts, extra_opt)
+void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
+	       const char *dev, const char *fs_type,
+	       const char *const fs_opts[], const char *extra_opt);
 
 /* lib/tst_net.c
  *
diff --git a/include/tst_mkfs.h b/include/tst_mkfs.h
index 52e9974..83f5808 100644
--- a/include/tst_mkfs.h
+++ b/include/tst_mkfs.h
@@ -23,10 +23,12 @@
  * @fs_type: filesystem type
  * @fs_opts: NULL or NULL terminated array of extra mkfs options
  */
-void safe_mkfs(const int lineno, const char *fname, const char *dev,
-               const char *fs_type, const char *const fs_opts[],
-	       const char *extra_opt);
+void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
+	       const char *dev, const char *fs_type,
+	       const char *const fs_opts[], const char *extra_opt);
+
 #define SAFE_MKFS(device, fs_type, fs_opts, extra_opt) \
-	safe_mkfs(__LINE__, __FILE__, device, fs_type, fs_opts, extra_opt)
+	tst_mkfs_(__LINE__, __FILE__, NULL, device, fs_type, \
+		  fs_opts, extra_opt)
 
 #endif	/* TST_MKFS_H__ */
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 734cf9b..e582de7 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -21,20 +21,24 @@
 
 #define OPTS_MAX 32
 
-void tst_mkfs(void (cleanup_fn)(void), const char *dev,
-              const char *fs_type, const char *const fs_opts[],
-              const char *extra_opt)
+void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
+	       const char *dev, const char *fs_type,
+	       const char *const fs_opts[], const char *extra_opt)
 {
 	int i, pos = 1, ret;
 	char mkfs[64];
 	const char *argv[OPTS_MAX] = {mkfs};
 	char fs_opts_str[1024] = "";
 
-	if (!dev)
-		tst_brkm(TBROK, cleanup_fn, "No device specified");
+	if (!dev) {
+		tst_brkm(TBROK, cleanup_fn,
+			 "%s:%d: No device specified", file, lineno);
+	}
 
-	if (!fs_type)
-		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
+	if (!fs_type) {
+		tst_brkm(TBROK, cleanup_fn,
+			 "%s:%d: No fs_type specified", file, lineno);
+	}
 
 	snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);
 
@@ -44,7 +48,8 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 
 			if (pos + 2 > OPTS_MAX) {
 				tst_brkm(TBROK, cleanup_fn,
-				         "Too much mkfs options");
+				         "%s:%d: Too much mkfs options",
+					 file, lineno);
 			}
 
 			if (i)
@@ -60,7 +65,7 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 
 		if (pos + 1 > OPTS_MAX) {
 			tst_brkm(TBROK, cleanup_fn,
-			         "Too much mkfs options");
+			         "%s:%d: Too much mkfs options", file, lineno);
 		}
 	}
 
@@ -75,10 +80,10 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 	break;
 	case 255:
 		tst_brkm(TCONF, cleanup_fn,
-			 "%s not found in $PATH", mkfs);
+			 "%s:%d: %s not found in $PATH", mkfs, file, lineno);
 	default:
 		tst_brkm(TBROK, cleanup_fn,
-			 "%s failed with %i", mkfs, ret);
+			 "%s:%d: %s failed with %i", mkfs, ret, file, lineno);
 	}
 }
 
@@ -93,14 +98,3 @@ const char *tst_dev_fs_type(void)
 
 	return DEFAULT_FS_TYPE;
 }
-
-void safe_mkfs(const int lineno, const char *fname, const char *dev,
-               const char *fs_type, const char *const fs_opts[],
-               const char *extra_opt)
-{
-	/* ignore for now, will fix once all tst_mkfs() users are converted */
-	(void)lineno;
-	(void)fname;
-
-	tst_mkfs(NULL, dev, fs_type, fs_opts, extra_opt);
-}
-- 
2.10.2

