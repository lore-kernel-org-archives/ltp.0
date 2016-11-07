From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  7 Nov 2016 14:19:09 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/6] SAFE_MACROS: Add SAFE_GETPRIORITY()
Message-ID: <1478524754-15752-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_macros.h |  4 ++++
 lib/safe_macros.c         | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d1519f9..59cba1a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -433,4 +433,8 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
 	         "execlp(%s, %s, ...) failed", file, arg); \
 	} while (0)
 
+int safe_getpriority(const char *file, const int lineno, int which, id_t who);
+#define SAFE_GETPRIORITY(which, who) \
+	safe_getpriority(__FILE__, __LINE__, (which), (who))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 5a05c84..b97f43d 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -794,3 +794,19 @@ struct dirent *safe_readdir(const char *file, const int lineno, void (cleanup_fn
 	errno = err;
 	return rval;
 }
+
+int safe_getpriority(const char *file, const int lineno, int which, id_t who)
+{
+	int rval, err = errno;
+
+	errno = 0;
+	rval = getpriority(which, who);
+	if (errno) {
+		tst_brkm(TBROK | TERRNO, NULL,
+		         "%s:%d getpriority(%i, %i) failed",
+			 file, lineno, which, who);
+	}
+
+	errno = err;
+	return rval;
+}
-- 
2.7.3

