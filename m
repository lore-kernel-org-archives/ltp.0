From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 2 Mar 2017 18:37:35 +0800
Subject: [LTP] [PATCH 2/3] safe_macros: add safe_removexattr()
In-Reply-To: <1488451056-24535-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1488451056-24535-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1488451056-24535-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_safe_macros.h |  5 +++++
 lib/safe_macros.c         | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 241b92a..7683109 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -422,4 +422,9 @@ int safe_fsetxattr(const char *file, const int lineno, int fd, const char *name,
 #define SAFE_FSETXATTR(fd, name, value, size, flags) \
 	safe_fsetxattr(__FILE__, __LINE__, (fd), (name), (value), (size), (flags))
 
+int safe_removexattr(const char *file, const int lineno, const char *path,
+		const char *name);
+#define SAFE_REMOVEXATTR(path, name) \
+	safe_removexattr(__FILE__, __LINE__, (path), (name))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 6476246..df0df7f 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -853,3 +853,24 @@ int safe_fsetxattr(const char *file, const int lineno, int fd, const char *name,
 
 	return rval;
 }
+
+int safe_removexattr(const char *file, const int lineno, const char *path,
+		const char *name)
+{
+	int rval;
+
+	rval = removexattr(path, name);
+
+	if (rval) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, NULL,
+				"%s:%d: no xattr support in fs or mounted "
+				"without user_xattr option", file, lineno);
+		}
+
+		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: removexattr() failed",
+			file, lineno);
+	}
+
+	return rval;
+}
-- 
1.8.3.1



