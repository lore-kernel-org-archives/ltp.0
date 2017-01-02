From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  2 Jan 2017 16:41:01 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/3] safe_macros: Move safe_get/setpgid()
	to C source
Message-ID: <1483371662-30039-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes numerous "implicit function declaration" warnings (for all sources
that include the header) on slightly older distributions since
get/setpgid() required either _XOPEN_SOURCE or _GNU_SOURCE on older
glibc.

Note that defining _GNU_SOURCE in the tst_safe_macros.h is not a
solution since it has to be defined before any libc headers are
included.

So this commit adds tst_safe_macros.c that defines _GNU_SOURCE and puts
these two functions there.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_macros.h | 26 ++-----------------------
 lib/tst_safe_macros.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 24 deletions(-)
 create mode 100644 lib/tst_safe_macros.c

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d352d5a3..df858be 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -138,35 +138,13 @@ static inline ssize_t safe_pread(const char *file, const int lineno,
 #define SAFE_GETRESGID(rgid, egid, sgid) \
 	safe_getresgid(__FILE__, __LINE__, NULL, (rgid), (egid), (sgid))
 
-static inline int safe_setpgid(const char *file, const int lineno,
-                               pid_t pid, pid_t pgid)
-{
-	int rval;
-
-	rval = setpgid(pid, pgid);
-	if (rval) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-		         "setpgid(%i, %i) failed", pid, pgid);
-	}
+int safe_setpgid(const char *file, const int lineno, pid_t pid, pid_t pgid);
 
-	return rval;
-}
 #define SAFE_SETPGID(pid, pgid) \
 	safe_setpgid(__FILE__, __LINE__, (pid), (pgid));
 
-static inline pid_t safe_getpgid(const char *file, const int lineno,
-				 pid_t pid)
-{
-	pid_t pgid;
-
-	pgid = getpgid(pid);
-	if (pgid == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "getpgid(%i) failed", pid);
-	}
+pid_t safe_getpgid(const char *file, const int lineno, pid_t pid);
 
-	return pgid;
-}
 #define SAFE_GETPGID(pid) \
 	safe_getpgid(__FILE__, __LINE__, (pid))
 
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
new file mode 100644
index 0000000..e7f5095
--- /dev/null
+++ b/lib/tst_safe_macros.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+int safe_setpgid(const char *file, const int lineno, pid_t pid, pid_t pgid)
+{
+	int rval;
+
+	rval = setpgid(pid, pgid);
+	if (rval) {
+		tst_brk(TBROK | TERRNO,
+		        "%s:%d: setpgid(%i, %i) failed",
+			file, lineno, pid, pgid);
+	}
+
+	return rval;
+}
+
+pid_t safe_getpgid(const char *file, const int lineno, pid_t pid)
+{
+	pid_t pgid;
+
+	pgid = getpgid(pid);
+	if (pgid == -1) {
+		tst_brk(TBROK | TERRNO,
+			"%s:%d: getpgid(%i) failed", file, lineno, pid);
+	}
+
+	return pgid;
+}
-- 
2.7.3

