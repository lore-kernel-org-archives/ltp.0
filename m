From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Apr 2020 13:35:00 +0200
Subject: [LTP] [PATCH 1/2] fanotify: Move safe_fanotify_init() + safe macro
 into fanotify.h
Message-ID: <20200428113501.24711-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fanotify code is used only in testcases/kernel/syscalls/fanotify/, which
justify breaking rule of having safe function and macro outside of
library. This will be further cleaned in next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

patchset is based on Amir's patchset [1], which I'd prefer to have
merged before.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=171631&state=*

 include/tst_safe_macros.h                     |  5 ----
 lib/tst_safe_macros.c                         | 24 -----------------
 testcases/kernel/syscalls/fanotify/fanotify.h | 27 ++++++++++++++++++-
 3 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index c39d8768b..edaeef461 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -520,11 +520,6 @@ int safe_mincore(const char *file, const int lineno, void *start,
 #define SAFE_MINCORE(start, length, vec) \
 	safe_mincore(__FILE__, __LINE__, (start), (length), (vec))
 
-int safe_fanotify_init(const char *file, const int lineno,
-	unsigned int flags, unsigned int event_f_flags);
-#define SAFE_FANOTIFY_INIT(fan, mode)  \
-	safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
-
 int safe_personality(const char *filename, unsigned int lineno,
 		    unsigned long persona);
 #define SAFE_PERSONALITY(persona) safe_personality(__FILE__, __LINE__, persona)
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index dbdfcc5be..9a9c73d06 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -45,29 +45,6 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid)
 	return pgid;
 }
 
-int safe_fanotify_init(const char *file, const int lineno,
-	unsigned int flags, unsigned int event_f_flags)
-{
-	int rval;
-
-#ifdef HAVE_SYS_FANOTIFY_H
-	rval = fanotify_init(flags, event_f_flags);
-
-	if (rval == -1) {
-		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"fanotify is not configured in this kernel.");
-		}
-		tst_brk(TBROK | TERRNO,
-			"%s:%d: fanotify_init() failed", file, lineno);
-	}
-#else
-	tst_brk(TCONF, "Header <sys/fanotify.h> is not present");
-#endif /* HAVE_SYS_FANOTIFY_H */
-
-	return rval;
-}
-
 int safe_personality(const char *filename, unsigned int lineno,
 		    unsigned long persona)
 {
@@ -96,7 +73,6 @@ int safe_setregid(const char *file, const int lineno,
 	return rval;
 }
 
-
 int safe_setreuid(const char *file, const int lineno,
 		  uid_t ruid, uid_t euid)
 {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index a05f4a372..f74171c15 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2012 Linux Test Project.  All Rights Reserved.
+ * Copyright (c) 2012-2020 Linux Test Project.  All Rights Reserved.
  * Author: Jan Kara, November 2013
  */
 
@@ -38,6 +38,31 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 
 #endif /* HAVE_SYS_FANOTIFY_H */
 
+int safe_fanotify_init(const char *file, const int lineno,
+	unsigned int flags, unsigned int event_f_flags)
+{
+	int rval;
+
+#ifdef HAVE_SYS_FANOTIFY_H
+	rval = fanotify_init(flags, event_f_flags);
+
+	if (rval == -1) {
+		if (errno == ENOSYS) {
+			tst_brk(TCONF,
+				"fanotify is not configured in this kernel.");
+		}
+		tst_brk(TBROK | TERRNO,
+			"%s:%d: fanotify_init() failed", file, lineno);
+	}
+#else
+	tst_brk(TCONF, "Header <sys/fanotify.h> is not present");
+#endif /* HAVE_SYS_FANOTIFY_H */
+
+	return rval;
+}
+#define SAFE_FANOTIFY_INIT(fan, mode)  \
+	safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
+
 #ifndef FAN_REPORT_TID
 #define FAN_REPORT_TID		0x00000100
 #endif
-- 
2.26.2

