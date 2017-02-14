From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 10:28:54 +0100
Subject: [LTP] [COMMITTED] [PATCH 3/3] lib: tst_mkfs: Fix typos
In-Reply-To: <20170214092854.26536-1-chrubis@suse.cz>
References: <20170214092854.26536-1-chrubis@suse.cz>
Message-ID: <20170214092854.26536-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix typos caused by:

commit b0a30feb08732bcaacd77a5457947af1d4f14fb4
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Mon Feb 13 17:15:38 2017 +0100

lib: tst_mkfs: Include __FILE__ and __LINE__ in tst_brkm messages

Again sorry everyone.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_mkfs.h | 2 +-
 lib/tst_mkfs.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tst_mkfs.h b/include/tst_mkfs.h
index 83f5808..d3aea9e 100644
--- a/include/tst_mkfs.h
+++ b/include/tst_mkfs.h
@@ -28,7 +28,7 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	       const char *const fs_opts[], const char *extra_opt);
 
 #define SAFE_MKFS(device, fs_type, fs_opts, extra_opt) \
-	tst_mkfs_(__LINE__, __FILE__, NULL, device, fs_type, \
+	tst_mkfs_(__FILE__, __LINE__, NULL, device, fs_type, \
 		  fs_opts, extra_opt)
 
 #endif	/* TST_MKFS_H__ */
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index e582de7..7810654 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -80,7 +80,7 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	break;
 	case 255:
 		tst_brkm(TCONF, cleanup_fn,
-			 "%s:%d: %s not found in $PATH", mkfs, file, lineno);
+			 "%s:%d: %s not found in $PATH", file, lineno, mkfs);
 	default:
 		tst_brkm(TBROK, cleanup_fn,
 			 "%s:%d: %s failed with %i", mkfs, ret, file, lineno);
-- 
2.10.2

