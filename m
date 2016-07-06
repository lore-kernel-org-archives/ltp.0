From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 6 Jul 2016 11:50:06 +0800
Subject: [LTP] [PATCH] tst_safe_macros: add SAFE_DUP
Message-ID: <1467777006-469-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_safe_macros.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index a213312..540fcb2 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -50,6 +50,22 @@
 #define SAFE_DIRNAME(path) \
 	safe_dirname(__FILE__, __LINE__, NULL, (path))
 
+static inline int safe_dup(const char *file, const int lineno,
+			   int oldfd)
+{
+	int rval;
+
+	rval = dup(oldfd);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "dup(%i) failed", oldfd);
+	}
+
+	return rval;
+}
+#define SAFE_DUP(oldfd) \
+	safe_dup(__FILE__, __LINE__, (oldfd))
+
 #define	SAFE_GETCWD(buf, size) \
 	safe_getcwd(__FILE__, __LINE__, NULL, (buf), (size))
 
-- 
1.8.3.1



