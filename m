From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 15 Jun 2017 17:57:34 +0800
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Add SAFE_SETSID()
Message-ID: <1497520655-12426-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/tst_safe_macros.h |  3 +++
 lib/safe_macros.c         | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index a25a4f0..09745c1 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -430,4 +430,7 @@ int safe_removexattr(const char *file, const int lineno, const char *path,
 int safe_fsync(const char *file, const int lineno, int fd);
 #define SAFE_FSYNC(fd) safe_fsync(__FILE__, __LINE__, (fd))
 
+int safe_setsid(const char *file, const int lineno);
+#define SAFE_SETSID() safe_setsid(__FILE__, __LINE__)
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index a6b4ff7..3ef9266 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -895,3 +895,16 @@ int safe_fsync(const char *file, const int lineno, int fd)
 
 	return rval;
 }
+
+pid_t safe_setsid(const char *file, const int lineno)
+{
+	pid_t rval;
+
+	rval = setsid();
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: setsid() failed", file, lineno);
+	}
+
+	return rval;
+}
-- 
1.8.4.2



