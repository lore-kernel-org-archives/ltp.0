From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jun 2018 16:16:46 +0200
Subject: [LTP] [PATCH v3 1/3] lib: Add SAFE_CHROOT(path) macro
Message-ID: <20180621141648.11430-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_safe_macros.h |  6 +++++-
 lib/tst_safe_macros.c     | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 75c2a0803..1ad9c71b2 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2010-2015 Linux Test Project
+ * Copyright (c) 2010-2018 Linux Test Project
  * Copyright (c) 2011-2015 Cyril Hrubis <chrubis@suse.cz>
  *
  * This program is free software: you can redistribute it and/or modify
@@ -48,6 +48,10 @@
 #define SAFE_CREAT(pathname, mode) \
 	safe_creat(__FILE__, __LINE__, NULL, (pathname), (mode))
 
+#define SAFE_CHROOT(path) \
+	safe_chroot(__FILE__, __LINE__, (path))
+int safe_chroot(const char *file, const int lineno, const char *path);
+
 #define SAFE_DIRNAME(path) \
 	safe_dirname(__FILE__, __LINE__, NULL, (path))
 
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index e152bff7f..17384f32c 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -152,3 +152,16 @@ struct group *safe_getgrnam(const char *file, const int lineno,
 
 	return rval;
 }
+
+int safe_chroot(const char *file, const int lineno, const char *path)
+{
+	int rval;
+
+	rval = chroot(path);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "chroot(%s) failed", path);
+	}
+
+	return rval;
+}
-- 
2.17.1

