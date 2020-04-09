From: laniel_francis@privacyrequired.com <laniel_francis@privacyrequired.com>
Date: Thu,  9 Apr 2020 23:12:55 +0200
Subject: [LTP] [PATCH v3 1/2] Add SAFE_PIPE2.
In-Reply-To: <67fdc846a8cd8616c9eb13cf89463b9d637e6849>
References: <67fdc846a8cd8616c9eb13cf89463b9d637e6849>
Message-ID: <20200409211255.1357-2-laniel_francis@privacyrequired.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Francis Laniel <laniel_francis@privacyrequired.com>

This macro is the equivalent of SAFE_PIPE for pipe2 system call.
---
 include/old/safe_macros.h |  3 +++
 include/tst_safe_macros.h |  6 ++++++
 lib/safe_macros.c         | 15 +++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
index e778d3077..a7bd43c80 100644
--- a/include/old/safe_macros.h
+++ b/include/old/safe_macros.h
@@ -66,6 +66,9 @@
 #define SAFE_PIPE(cleanup_fn, fildes)	\
 	safe_pipe(__FILE__, __LINE__, cleanup_fn, (fildes))
 
+#define SAFE_PIPE2(fildes, flags) \
+	safe_pipe2(__FILE__, __LINE__, NULL, (fildes), (flags))
+
 #define SAFE_READ(cleanup_fn, len_strict, fildes, buf, nbyte)	\
 	safe_read(__FILE__, __LINE__, cleanup_fn, (len_strict), (fildes), \
 	    (buf), (nbyte))
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d95d26219..a21d75646 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -87,6 +87,12 @@ static inline int safe_dup(const char *file, const int lineno,
 #define SAFE_PIPE(fildes) \
 	safe_pipe(__FILE__, __LINE__, NULL, (fildes))
 
+int safe_pipe2(const char *file, const int lineno, void (*cleanup_fn) (void),
+	       int fildes[2], int flags);
+
+#define SAFE_PIPE2(fildes, flags) \
+	safe_pipe2(__FILE__, __LINE__, NULL, (fildes), (flags))
+
 #define SAFE_READ(len_strict, fildes, buf, nbyte) \
 	safe_read(__FILE__, __LINE__, NULL, (len_strict), (fildes), (buf), (nbyte))
 
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index dde9b7b5e..780245821 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -248,6 +248,21 @@ int safe_pipe(const char *file, const int lineno, void (*cleanup_fn) (void),
 	return rval;
 }
 
+int safe_pipe2(const char *file, const int lineno, void (*cleanup_fn) (void),
+               int fildes[2], int flags)
+{
+	int rval;
+
+	rval = pipe2(fildes, flags);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: pipe2({%d,%d}) failed",
+			 file, lineno, fildes[0], fildes[1]);
+	}
+
+	return rval;
+}
+
 ssize_t safe_read(const char *file, const int lineno, void (*cleanup_fn) (void),
                   char len_strict, int fildes, void *buf, size_t nbyte)
 {
-- 
2.20.1

