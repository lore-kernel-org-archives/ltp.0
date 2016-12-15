From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 15 Dec 2016 18:49:55 +0800
Subject: [LTP] [PATCH v2 2/4] SAFE_MACROS: Add SAFE_SETPRIORITY()
In-Reply-To: <1481798997-2320-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <20161215104356.GB29787@rei.suse.cz>
 <1481798997-2320-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1481798997-2320-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/tst_safe_macros.h |  5 +++++
 lib/safe_macros.c         | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 32b2556..59973b6 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -471,6 +471,11 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who);
 #define SAFE_GETPRIORITY(which, who) \
 	safe_getpriority(__FILE__, __LINE__, (which), (who))
 
+int safe_setpriority(const char *file, const int lineno, int which, id_t who,
+		     int prio);
+#define SAFE_SETPRIORITY(which, who, prio) \
+	safe_setpriority(__FILE__, __LINE__, (which), (who), (prio))
+
 int safe_setxattr(const char *file, const int lineno, const char *path,
             const char *name, const void *value, size_t size, int flags);
 #define SAFE_SETXATTR(path, name, value, size, flags) \
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index d5c8753..65fe27c 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -780,6 +780,21 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who)
 	return rval;
 }
 
+int safe_setpriority(const char *file, const int lineno, int which, id_t who,
+		     int prio)
+{
+	int rval;
+
+	rval = setpriority(which, who, prio);
+	if (rval) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			"%s:%d setpriority(%i, %i, %i) failed",
+			file, lineno, which, who, prio);
+	}
+
+	return rval;
+}
+
 int safe_setxattr(const char *file, const int lineno, const char *path,
 		  const char *name, const void *value, size_t size, int flags)
 {
-- 
1.8.4.2



