From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 15 Jul 2016 17:39:42 +0300
Subject: [LTP] [PATCH 1/8] tst_safe_macros: SAFE_GETPGID
In-Reply-To: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1468593589-30545-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/tst_safe_macros.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 540fcb2..3cf154e 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -135,6 +135,22 @@ static inline int safe_setpgid(const char *file, const int lineno,
 #define SAFE_SETPGID(pid, pgid) \
 	safe_setpgid(__FILE__, __LINE__, (pid), (pgid));
 
+static inline pid_t safe_getpgid(const char *file, const int lineno,
+				 pid_t pid)
+{
+	pid_t pgid;
+
+	pgid = getpgid(pid);
+	if (pgid == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "getpgid(%i) failed", pid);
+	}
+
+	return pgid;
+}
+#define SAFE_GETPGID(pid) \
+	safe_getpgid(__FILE__, __LINE__, (pid))
+
 #define SAFE_UNLINK(pathname) \
 	safe_unlink(__FILE__, __LINE__, NULL, (pathname))
 
-- 
1.7.1

