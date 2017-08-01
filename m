From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  1 Aug 2017 15:26:59 +0200
Subject: [LTP] [PATCH v3 1/3] lib: Add personality fallback and SAFE macro
Message-ID: <20170801132701.16317-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add the macro SAFE_PERSONALITY as well as fallback logic for if
<sys/personality.h> is missing or incomplete.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V3 - Use the renamed lapi/syscalls.h header

 configure.ac               |  3 +++
 include/lapi/personality.h | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 include/tst_personality.h  | 28 ++++++++++++++++++++++++
 lib/tst_personality.c      | 33 +++++++++++++++++++++++++++++
 m4/ltp-personality.m4      | 24 +++++++++++++++++++++
 5 files changed, 141 insertions(+)
 create mode 100644 include/lapi/personality.h
 create mode 100644 include/tst_personality.h
 create mode 100644 lib/tst_personality.c
 create mode 100644 m4/ltp-personality.m4

diff --git a/configure.ac b/configure.ac
index 223241c78..c0e39ad64 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,10 +37,12 @@ AC_CHECK_HEADERS([ \
     mm.h \
     pthread.h \
     sys/xattr.h \
+    sys/personality.h \
     linux/genetlink.h \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
+    linux/personality.h \
     sys/epoll.h \
     sys/inotify.h \
     sys/fanotify.h \
@@ -193,5 +195,6 @@ LTP_CHECK_SYNC_ADD_AND_FETCH
 LTP_CHECK_BUILTIN_CLEAR_CACHE
 LTP_CHECK_MMSGHDR
 LTP_CHECK_UNAME_DOMAINNAME
+LTP_CHECK_PERSONALITY
 
 AC_OUTPUT
diff --git a/include/lapi/personality.h b/include/lapi/personality.h
new file mode 100644
index 000000000..11d2fc08b
--- /dev/null
+++ b/include/lapi/personality.h
@@ -0,0 +1,53 @@
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
+#include "config.h"
+
+#if defined(HAVE_SYS_PERSONALITY_H)
+#include <sys/personality.h>
+#elif defined(HAVE_LINUX_PERSONALITY_H)
+#include <linux/personality.h>
+#endif
+
+#ifndef HAVE_SYS_PERSONALITY_H
+#include "lapi/syscalls.h"
+
+static int personality(unsigned long persona)
+{
+	return tst_syscall(__NR_personality, persona);
+}
+#endif
+
+#if !(HAVE_DECL_UNAME26 == 1 || defined(UNAME26))
+#define UNAME26 0x0020000
+#endif
+
+#if !(HAVE_DECL_READ_IMPLIES_EXEC == 1 || defined(READ_IMPLIES_EXEC))
+#define READ_IMPLIES_EXEC 0x0400000
+#endif
+
+#if !(HAVE_DECL_PER_LINUX == 1 || defined(PER_LINUX))
+#define PER_LINUX 0
+#endif
+
+#endif	/* PERSONALITY_H */
diff --git a/include/tst_personality.h b/include/tst_personality.h
new file mode 100644
index 000000000..ff61f4607
--- /dev/null
+++ b/include/tst_personality.h
@@ -0,0 +1,28 @@
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
+
+#ifndef TST_PERSONALITY__
+#define TST_PERSONALITY__
+
+#include "lapi/personality.h"
+
+int tst_personality(const char *filename, unsigned int lineno,
+		    unsigned long persona);
+
+#define SAFE_PERSONALITY(persona) tst_personality(__FILE__, __LINE__, persona)
+
+#endif
diff --git a/lib/tst_personality.c b/lib/tst_personality.c
new file mode 100644
index 000000000..3f64331db
--- /dev/null
+++ b/lib/tst_personality.c
@@ -0,0 +1,33 @@
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
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_personality.h"
+
+int tst_personality(const char *filename, unsigned int lineno,
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
diff --git a/m4/ltp-personality.m4 b/m4/ltp-personality.m4
new file mode 100644
index 000000000..78a3bc231
--- /dev/null
+++ b/m4/ltp-personality.m4
@@ -0,0 +1,24 @@
+dnl Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+AC_DEFUN([LTP_CHECK_PERSONALITY],[
+AC_CHECK_DECLS([UNAME26,READ_IMPLIES_EXEC,PER_LINUX],,,[
+#if defined(HAVE_SYS_PERSONALITY_H)
+#include <sys/personality.h>
+#elif defined(HAVE_LINUX_PERSONALITY_H)
+#include <linux/personality.h>
+#endif
+])
+])
-- 
2.13.3

