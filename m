From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 1 Nov 2016 10:27:28 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/2] SAFE_MACROS: Add SAFE_EXECLP()
Message-ID: <20161101092728.GA18406@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_macros.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 3cf154e..d1519f9 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -427,4 +427,10 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
 #define SAFE_SIGNAL(signum, handler) \
 	safe_signal(__FILE__, __LINE__, (signum), (handler))
 
+#define SAFE_EXECLP(file, arg, ...) do {                   \
+	execlp((file), (arg), ##__VA_ARGS__);              \
+	tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,       \
+	         "execlp(%s, %s, ...) failed", file, arg); \
+	} while (0)
+
 #endif /* SAFE_MACROS_H__ */
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
