From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Mar 2020 16:37:55 +0100
Subject: [LTP] [PATCH v2 3/9] safe_macros: Add SAFE_SETNS()
In-Reply-To: <20200318153801.3529-1-chrubis@suse.cz>
References: <20200318153801.3529-1-chrubis@suse.cz>
Message-ID: <20200318153801.3529-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cyril Hrubis <metan@ucw.cz>

Signed-off-by: Cyril Hrubis <metan@ucw.cz>
---
 include/tst_safe_macros.h |  4 ++++
 lib/tst_safe_macros.c     | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 80c4d9cb9..291f2a722 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -547,4 +547,8 @@ int safe_personality(const char *filename, unsigned int lineno,
 void safe_unshare(const char *file, const int lineno, int flags);
 #define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
 
+
+void safe_setns(const char *file, const int lineno, int fd, int nstype);
+#define SAFE_SETNS(fd, nstype) safe_setns(__FILE__, __LINE__, (fd), (nstype));
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index f5413a18e..353ef5b1d 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -6,6 +6,7 @@
 #define _GNU_SOURCE
 #include <unistd.h>
 #include <errno.h>
+#include "lapi/setns.h"
 #include <sched.h>
 #include "config.h"
 #ifdef HAVE_SYS_FANOTIFY_H
@@ -202,3 +203,14 @@ void safe_unshare(const char *file, const int lineno, int flags)
 		}
 	}
 }
+
+void safe_setns(const char *file, const int lineno, int fd, int nstype)
+{
+	int ret;
+
+	ret = setns(fd, nstype);
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO, "setns(%i, %i) failed",
+		         fd, nstype);
+	}
+}
-- 
2.24.1

