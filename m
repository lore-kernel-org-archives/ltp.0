From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 28 Jan 2016 15:28:50 +0300
Subject: [LTP] [PATCH v2 4/6] lib/safe_macros: add readlink()
In-Reply-To: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
References: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1453984132-6240-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/safe_macros.h |    6 ++++++
 lib/safe_macros.c     |   17 +++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index e4041d4..8545c97 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -164,6 +164,12 @@ int	safe_linkat(const char *file, const int lineno,
 	safe_linkat(__FILE__, __LINE__, cleanup_fn, (olddirfd), (oldpath), \
 		    (newdirfd), (newpath), (flags))
 
+ssize_t	safe_readlink(const char *file, const int lineno,
+		      void (cleanup_fn)(void), const char *path,
+		      char *buf, size_t bufsize);
+#define SAFE_READLINK(cleanup_fn, path, buf, bufsize) \
+	safe_readlink(__FILE__, __LINE__, cleanup_fn, (path), (buf), (bufsize))
+
 int	safe_symlink(const char *file, const int lineno,
                      void (cleanup_fn)(void), const char *oldpath,
                      const char *newpath);
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 9fa6ac4..5a05c84 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -409,6 +409,23 @@ int safe_linkat(const char *file, const int lineno,
 	return rval;
 }
 
+ssize_t safe_readlink(const char *file, const int lineno,
+		  void (cleanup_fn)(void), const char *path,
+		  char *buf, size_t bufsize)
+{
+	ssize_t rval;
+
+	rval = readlink(path, buf, bufsize);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: readlink(%s,%p,%zu) failed",
+			 file, lineno, path, buf, bufsize);
+	}
+
+	return rval;
+}
+
 int safe_symlink(const char *file, const int lineno,
                  void (cleanup_fn)(void), const char *oldpath,
                  const char *newpath)
-- 
1.7.1

