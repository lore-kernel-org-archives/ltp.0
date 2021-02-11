From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 11 Feb 2021 11:03:14 +0000
Subject: [LTP] [PATCH 2/5] API: Add SAFE_DUP2
In-Reply-To: <20210211110317.31942-1-rpalethorpe@suse.com>
References: <20210211110317.31942-1-rpalethorpe@suse.com>
Message-ID: <20210211110317.31942-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_safe_macros.h |  5 +++++
 lib/tst_safe_macros.c     | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index ee3df4142..2a2b0088a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -50,6 +50,11 @@ int safe_dup(const char *file, const int lineno, int oldfd);
 #define SAFE_DUP(oldfd) \
 	safe_dup(__FILE__, __LINE__, (oldfd))
 
+int safe_dup2(const char *file, const int lineno, int oldfd, int newfd);
+
+#define SAFE_DUP2(oldfd, newfd)			\
+	safe_dup2(__FILE__, __LINE__, (oldfd), (newfd))
+
 #define SAFE_GETCWD(buf, size) \
 	safe_getcwd(__FILE__, __LINE__, NULL, (buf), (size))
 
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index aa03a6d5c..182b690bb 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -415,6 +415,24 @@ int safe_dup(const char *file, const int lineno, int oldfd)
 	return rval;
 }
 
+int safe_dup2(const char *file, const int lineno, int oldfd, int newfd)
+{
+	int rval;
+
+	rval = dup2(oldfd, newfd);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "dup2(%i, %i) failed", oldfd, newfd);
+	} else if (rval != newfd) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "Invalid dup2(%i, %i) return value %d",
+			 oldfd, newfd, rval);
+	}
+
+	return rval;
+}
+
 sighandler_t safe_signal(const char *file, const int lineno,
 	int signum, sighandler_t handler)
 {
-- 
2.30.0

