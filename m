From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 30 Nov 2016 20:12:33 +0800
Subject: [LTP] [PATCH 3/5] SAFE_MACROS: Add SAFE_SYSTEM()
In-Reply-To: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1480507955-12652-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/tst_safe_macros.h |  4 ++++
 lib/safe_macros.c         | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 9fa0e17..2566079 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -476,4 +476,8 @@ int safe_setpriority(const char *file, const int lineno, int which, id_t who,
 #define SAFE_SETPRIORITY(which, who, prio) \
 	safe_setpriority(__FILE__, __LINE__, (which), (who), (prio))
 
+int safe_system(const char *file, const int lineno, const char *cmd);
+#define SAFE_SYSTEM(cmd) \
+	safe_system(__FILE__, __LINE__, (cmd))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index a109270..1c89b8c 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -793,3 +793,17 @@ int safe_setpriority(const char *file, const int lineno, int which, id_t who,
 
 	return rval;
 }
+
+int safe_system(const char *file, const int lineno, const char *cmd)
+{
+	int rval;
+
+	rval = system(cmd);
+	if (rval == -1 || !WIFEXITED(rval) || WEXITSTATUS(rval)) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d system(%s) failed",
+			 file, lineno, cmd);
+	}
+
+	return rval;
+}
-- 
1.8.4.2



