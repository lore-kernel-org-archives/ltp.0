From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 30 Nov 2016 20:12:34 +0800
Subject: [LTP] [PATCH 4/5] SAFE_MACROS: Add SAFE_PRCTL()
In-Reply-To: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1480507955-12652-4-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/tst_safe_macros.h |  4 ++++
 lib/safe_macros.c         | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 2566079..bd60b40 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -480,4 +480,8 @@ int safe_system(const char *file, const int lineno, const char *cmd);
 #define SAFE_SYSTEM(cmd) \
 	safe_system(__FILE__, __LINE__, (cmd))
 
+int safe_prctl(const char *file, const int lineno, int opt, ...);
+#define SAFE_PRCTL(opt, ...) \
+	safe_prctl(__FILE__, __LINE__, (opt), ##__VA_ARGS__)
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 1c89b8c..c8c5383 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -807,3 +807,23 @@ int safe_system(const char *file, const int lineno, const char *cmd)
 
 	return rval;
 }
+
+int safe_prctl(const char *file, const int lineno, int opt, ...)
+{
+	va_list ap;
+	int rval;
+	unsigned long arg;
+
+	va_start(ap, opt);
+	arg = va_arg(ap, unsigned long);
+	va_end(ap);
+
+	rval = prctl(opt, arg);
+	if (rval < 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d prctl(%i, %lu) failed",
+			 file, lineno, opt, arg);
+	}
+
+	return rval;
+}
-- 
1.8.4.2



