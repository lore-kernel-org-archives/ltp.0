From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 27 Mar 2020 13:16:10 +0100
Subject: [LTP] [PATCH v2 1/2] Add SAFE_PTRACE() to LTP library
Message-ID: <20200327121611.1566-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The function treats any non-zero return value as error. Requests which may
return non-zero values on success are not supported and need to be handled
manually.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Split off from CVE 2018-1000199 patch
- Changed the req parameter type to int
- Moved SAFE_PTRACE() declaration from tst_safe_ptrace.h to tst_safe_macros.h

 include/tst_safe_macros.h | 10 ++++++++++
 lib/tst_safe_macros.c     | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d95d26219..c018497b9 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -534,4 +534,14 @@ int safe_personality(const char *filename, unsigned int lineno,
 void safe_unshare(const char *file, const int lineno, int flags);
 #define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
 
+/*
+ * SAFE_PTRACE() treats any non-zero return value as error. Don't use it
+ * for requests like PTRACE_PEEK* or PTRACE_SECCOMP_GET_FILTER which use
+ * the return value to pass arbitrary data.
+ */
+long tst_safe_ptrace(const char *file, const int lineno, int req, pid_t pid,
+	void *addr, void *data);
+#define SAFE_PTRACE(req, pid, addr, data) \
+	tst_safe_ptrace(__FILE__, __LINE__, req, pid, addr, data)
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index f5413a18e..68431fe24 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <sched.h>
+#include <sys/ptrace.h>
 #include "config.h"
 #ifdef HAVE_SYS_FANOTIFY_H
 # include <sys/fanotify.h>
@@ -202,3 +203,21 @@ void safe_unshare(const char *file, const int lineno, int flags)
 		}
 	}
 }
+
+long tst_safe_ptrace(const char *file, const int lineno, int req, pid_t pid,
+	void *addr, void *data)
+{
+	long ret;
+
+	errno = 0;
+	ret = ptrace(req, pid, addr, data);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO, "ptrace() failed");
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid ptrace() return value %ld", ret);
+	}
+
+	return ret;
+}
-- 
2.25.1

