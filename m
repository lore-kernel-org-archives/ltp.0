From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 28 Jan 2016 15:28:49 +0300
Subject: [LTP] [PATCH v2 3/6] lib/safe_macros: add linkat()
In-Reply-To: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
References: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1453984132-6240-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/safe_macros.h |    7 +++++++
 lib/safe_macros.c     |   18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index ab09699..e4041d4 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -157,6 +157,13 @@ int	safe_link(const char *file, const int lineno,
 #define SAFE_LINK(cleanup_fn, oldpath, newpath) \
         safe_link(__FILE__, __LINE__, cleanup_fn, (oldpath), (newpath))
 
+int	safe_linkat(const char *file, const int lineno,
+		    void (cleanup_fn)(void), int olddirfd, const char *oldpath,
+		    int newdirfd, const char *newpath, int flags);
+#define SAFE_LINKAT(cleanup_fn, olddirfd, oldpath, newdirfd, newpath, flags) \
+	safe_linkat(__FILE__, __LINE__, cleanup_fn, (olddirfd), (oldpath), \
+		    (newdirfd), (newpath), (flags))
+
 int	safe_symlink(const char *file, const int lineno,
                      void (cleanup_fn)(void), const char *oldpath,
                      const char *newpath);
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 173d72f..9fa6ac4 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -391,6 +391,24 @@ int safe_link(const char *file, const int lineno,
 	return rval;
 }
 
+int safe_linkat(const char *file, const int lineno,
+		void (cleanup_fn)(void), int olddirfd, const char *oldpath,
+		int newdirfd, const char *newpath, int flags)
+{
+	int rval;
+
+	rval = linkat(olddirfd, oldpath, newdirfd, newpath, flags);
+
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: linkat(%d,%s,%d,%s,%d) failed",
+			 file, lineno, olddirfd, oldpath, newdirfd,
+			 newpath, flags);
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

