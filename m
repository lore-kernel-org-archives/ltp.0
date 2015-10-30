From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 30 Oct 2015 17:34:25 -0400
Subject: [LTP] [PATCH] include/safe_macros.h: fix for SAFE_PREAD()
Message-ID: <1446240865-11586-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/safe_macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index e938f17..79edf5a 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -111,7 +111,7 @@ ssize_t	safe_read(const char *file, const int lineno,
 
 ssize_t safe_pread(const char *file, const int lineno, void (*cleanup_fn)(void),
 	    char len_strict, int fildes, void *buf, size_t nbyte, off_t offset);
-#define SAFE_PREAD(cleanup_fn, len_strict, fildes, buf, nbyte)   \
+#define SAFE_PREAD(cleanup_fn, len_strict, fildes, buf, nbyte, offset)   \
 	safe_pread(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
 	    (buf), (nbyte), (offset))
 
-- 
1.8.3.1

