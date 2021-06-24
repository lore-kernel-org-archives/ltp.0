From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 24 Jun 2021 13:33:45 +0800
Subject: [LTP] [PATCH v3 1/3] lib: Add SAFE_SETGROUPS() and SAFE_GETGROUPS()
 function to LTP library
In-Reply-To: <YNM4rlDJLzb4xk6v@yuki>
References: <YNM4rlDJLzb4xk6v@yuki>
Message-ID: <1624512827-3256-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_safe_macros.h | 10 ++++++++++
 lib/tst_safe_macros.c     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d68f26021..6fd618597 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -136,6 +136,16 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
 #define SAFE_GETPGID(pid) \
 	safe_getpgid(__FILE__, __LINE__, (pid))
 
+int safe_setgroups(const char *file, const int lineno, size_t size, const gid_t *list);
+
+#define SAFE_SETGROUPS(size, list) \
+	safe_setgroups(__FILE__, __LINE__, (size), (list))
+
+int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
+
+#define SAFE_GETGROUPS(size, list) \
+	safe_getgroups(__FILE__, __LINE__, (size), (list))
+
 #define SAFE_UNLINK(pathname) \
 	safe_unlink(__FILE__, __LINE__, NULL, (pathname))
 
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index fd5f1704b..fcff6d161 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -54,6 +54,42 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid)
 	return pgid;
 }
 
+int safe_setgroups(const char *file, const int lineno, size_t size, const gid_t *list)
+{
+	int rval;
+
+	rval = setgroups(size, list);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"setgroups(%zu, %p) failed", size, list);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid setgroups(%zu, %p) return value %d", size,
+			list, rval);
+	}
+
+	return rval;
+}
+
+int safe_getgroups(const char *file, const int lineno, int size, gid_t list[])
+{
+	int rval;
+
+	rval = getgroups(size, list);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"getgroups(%i, %p)", size, list);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid getgroups(%i, %p) return value %d", size,
+			list, rval);
+	}
+
+	return rval;
+}
+
 int safe_personality(const char *filename, unsigned int lineno,
 		    unsigned long persona)
 {
-- 
2.23.0

