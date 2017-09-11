From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 11 Sep 2017 13:50:52 +0200
Subject: [LTP] [PATCH v5 1/3] lib: Add personality fallback and SAFE macro
Message-ID: <20170911115054.19982-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add the macro SAFE_PERSONALITY as well as fallback logic for if
<sys/personality.h> is missing UNAME26.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/personality.h | 30 ++++++++++++++++++++++++++++++
 include/tst_safe_macros.h  |  5 +++++
 lib/tst_safe_macros.c      | 14 ++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 include/lapi/personality.h

diff --git a/include/lapi/personality.h b/include/lapi/personality.h
new file mode 100644
index 000000000..5b5543805
--- /dev/null
+++ b/include/lapi/personality.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
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
+/* In the Linux kernel and glibc enums are (mostly) used for the constants,
+ * but in musl macros are used.
+ */
+
+#ifndef PERSONALITY_H
+#define PERSONALITY_H
+
+#include <sys/personality.h>
+
+#ifndef UNAME26
+# define UNAME26 0x0020000
+#endif
+
+#endif	/* PERSONALITY_H */
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index f23f765c2..1e034b8e2 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -443,4 +443,9 @@ int safe_fanotify_init(const char *file, const int lineno,
 #define SAFE_FANOTIFY_INIT(fan, mode)  \
 	safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
 
+int safe_personality(const char *filename, unsigned int lineno,
+		    unsigned long persona);
+#define SAFE_PERSONALITY(persona) safe_personality(__FILE__, __LINE__, persona)
+
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index d4d81c6cd..b65a22b71 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -25,6 +25,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_safe_macros.h"
+#include "lapi/personality.h"
 
 int safe_setpgid(const char *file, const int lineno, pid_t pid, pid_t pgid)
 {
@@ -75,3 +76,16 @@ int safe_fanotify_init(const char *file, const int lineno,
 
 	return rval;
 }
+
+int safe_personality(const char *filename, unsigned int lineno,
+		    unsigned long persona)
+{
+	int prev_persona = personality(persona);
+
+	if (prev_persona < 0) {
+		tst_brk_(filename, lineno, TBROK | TERRNO,
+			 "persona(%ld) failed", persona);
+	}
+
+	return prev_persona;
+}
-- 
2.14.1

