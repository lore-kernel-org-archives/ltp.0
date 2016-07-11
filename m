From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Jul 2016 16:29:46 +0200
Subject: [LTP] [PATCH] safe_macros: match oldlib SAFE_CLOSE with docs
Message-ID: <c173ae5fd35390cdf47c0fed09577c0c0edab814.1468247097.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Docs say that SAFE_CLOSE() sets the passed file descriptor to -1
after it's successfully closed, but oldlib SAFE_CLOSE doesn't
do that.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/old/safe_macros.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
index 6691a15885ab..8ed2eb493960 100644
--- a/include/old/safe_macros.h
+++ b/include/old/safe_macros.h
@@ -26,8 +26,11 @@
 #define SAFE_CHDIR(cleanup_fn, path)	\
 	safe_chdir(__FILE__, __LINE__, (cleanup_fn), (path))
 
-#define SAFE_CLOSE(cleanup_fn, fildes)	\
-	safe_close(__FILE__, __LINE__, (cleanup_fn), (fildes))
+#define SAFE_CLOSE(cleanup_fn, fd) ({ \
+		int ret = safe_close(__FILE__, __LINE__, (cleanup_fn), (fd)); \
+		fd = -1; \
+		ret; \
+	})
 
 #define SAFE_CREAT(cleanup_fn, pathname, mode)	\
 	safe_creat(__FILE__, __LINE__, cleanup_fn, (pathname), (mode))
-- 
1.8.3.1

