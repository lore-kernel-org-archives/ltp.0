From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Jun 2018 09:59:15 +0200
Subject: [LTP] [PATCH 1/3] lib: Add SAFE_CHROOT(path) macro
Message-ID: <20180620075917.21056-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/safe_macros_fn.h  |  3 +++
 include/tst_safe_macros.h |  5 ++++-
 lib/safe_macros.c         | 15 +++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index 3df952811..9b11801a4 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -30,6 +30,9 @@ char* safe_basename(const char *file, const int lineno,
 int safe_chdir(const char *file, const int lineno,
                void (*cleanup_fn)(void), const char *path);
 
+int safe_chroot(const char *file, const int lineno,
+               void (*cleanup_fn)(void), const char *path);
+
 int safe_close(const char *file, const int lineno,
                void (*cleanup_fn)(void), int fildes);
 
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 75c2a0803..0cf560b98 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2010-2015 Linux Test Project
+ * Copyright (c) 2010-2018 Linux Test Project
  * Copyright (c) 2011-2015 Cyril Hrubis <chrubis@suse.cz>
  *
  * This program is free software: you can redistribute it and/or modify
@@ -37,6 +37,9 @@
 #define SAFE_BASENAME(path) \
 	safe_basename(__FILE__, __LINE__, NULL, (path))
 
+#define SAFE_CHROOT(path) \
+	safe_chroot(__FILE__, __LINE__, NULL, (path))
+
 #define SAFE_CHDIR(path) \
 	safe_chdir(__FILE__, __LINE__, NULL, (path))
 
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index abdeca013..2fc14f709 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -33,6 +33,21 @@ char *safe_basename(const char *file, const int lineno,
 	return rval;
 }
 
+int safe_chroot(const char *file, const int lineno, void (*cleanup_fn) (void),
+               const char *path)
+{
+	int rval;
+
+	rval = chroot(path);
+	if (rval == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			 "%s:%d: chroot(%s) failed",
+			 file, lineno, path);
+	}
+
+	return rval;
+}
+
 int
 safe_chdir(const char *file, const int lineno, void (*cleanup_fn) (void),
 	   const char *path)
-- 
2.17.1

