From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Wed,  2 Nov 2016 11:59:47 +0100
Subject: [LTP]  [PATCH v3 1/5] safe_macros: add safe_setxattr(),
In-Reply-To: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1478084391-30192-2-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Added SAFE_SETXATTR(), SAFE_LSETXATTR() and SAFE_FSETXATTR()
macros to simplify error checking in test preparation. Instead
of calling the system function, checking for their return value
and aborting the test if the operation has failed, just use
corresponding safe macro.

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 include/tst_safe_macros.h | 12 +++++++++
 lib/safe_macros.c         | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d1519f9..936f4dc 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -433,4 +433,16 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
 	         "execlp(%s, %s, ...) failed", file, arg); \
 	} while (0)
 
+#define SAFE_SETXATTR(path, name, value, size, flags) \
+	safe_setxattr(__FILE__, __LINE__, NULL, (path), (name), (value), (size), \
+				(flags))
+
+#define SAFE_LSETXATTR(path, name, value, size, flags) \
+	safe_lsetxattr(__FILE__, __LINE__, NULL, (path), (name), (value), (size), \
+				(flags))
+
+#define SAFE_FSETXATTR(fd, name, value, size, flags) \
+	safe_fsetxattr(__FILE__, __LINE__, NULL, (fd), (name), (value), (size), \
+				(flags))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 5a05c84..e1d01b9 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -794,3 +794,69 @@ struct dirent *safe_readdir(const char *file, const int lineno, void (cleanup_fn
 	errno = err;
 	return rval;
 }
+
+int safe_setxattr(const char *file, const int lineno, void (cleanup_fn)(void),
+				const char *path, const char *name, const void *value,
+				size_t size, int flags)
+{
+	int rval;
+
+	rval = setxattr(path, name, value, size, flags);
+
+	if (rval) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, cleanup_fn,
+				 "%s:%d: no xattr support in fs or mounted "
+				 "without user_xattr option", file, lineno);
+		}
+
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "%s:%d: setxattr() failed",
+			     file, lineno);
+	}
+
+	return rval;
+}
+
+int safe_lsetxattr(const char *file, const int lineno, void (cleanup_fn)(void),
+				const char *path, const char *name, const void *value,
+				size_t size, int flags)
+{
+	int rval;
+
+	rval = lsetxattr(path, name, value, size, flags);
+
+	if (rval) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, cleanup_fn,
+				 "%s:%d: no xattr support in fs or mounted "
+				 "without user_xattr option", file, lineno);
+		}
+
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "%s:%d: lsetxattr() failed",
+			     file, lineno);
+	}
+
+	return rval;
+}
+
+int safe_fsetxattr(const char *file, const int lineno, void (cleanup_fn)(void),
+				int fd, const char *name, const void *value, size_t size,
+				int flags)
+{
+	int rval;
+
+	rval = fsetxattr(fd, name, value, size, flags);
+
+	if (rval) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, cleanup_fn,
+				 "%s:%d: no xattr support in fs or mounted "
+				 "without user_xattr option", file, lineno);
+		}
+
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "%s:%d: fsetxattr() failed",
+			     file, lineno);
+	}
+
+	return rval;
+}
-- 
1.9.1

