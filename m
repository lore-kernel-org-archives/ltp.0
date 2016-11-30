From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 30 Nov 2016 20:12:32 +0800
Subject: [LTP] [PATCH 2/5] SAFE_MACROS: Add SAFE_SETPRIORITY()
In-Reply-To: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1480507955-12652-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
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
index ffb5446..9fa0e17 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -471,4 +471,9 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who);
 #define SAFE_GETPRIORITY(which, who) \
 	safe_getpriority(__FILE__, __LINE__, (which), (who))
 
+int safe_setpriority(const char *file, const int lineno, int which, id_t who,
+	int prio);
+#define SAFE_SETPRIORITY(which, who, prio) \
+	safe_setpriority(__FILE__, __LINE__, (which), (who), (prio))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 2db362f..a109270 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -778,3 +778,18 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who)
 	errno = err;
 	return rval;
 }
+
+int safe_setpriority(const char *file, const int lineno, int which, id_t who,
+	int prio)
+{
+	int rval;
+
+	rval = setpriority(which, who, prio);
+	if (rval) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d setpriority(%i, %i, %i) failed",
+			 file, lineno, which, who, prio);
+	}
+
+	return rval;
+}
-- 
1.8.4.2



