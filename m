From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 17 Dec 2020 12:57:51 +0530
Subject: [LTP] [PATCH V2 1/3] tst_module: Add separate declarations of
 helpers for new tests framework
Message-ID: <b48115a8d6dc3036f08e0166332035fab078b34a.1608189944.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The tests using the new test framework must not use the headers from the
old one, fix that by declaring the helpers in tst_module.h. To achieve
that rename the original routines in tst_module.c with an underscore and
use static inline wrappers to call them.

Also update the delete_module tests to use the new header.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- New patch.

 include/old/old_module.h                      | 27 ++++++++++++---
 include/tst_module.h                          | 33 +++++++++++++++++++
 lib/tst_module.c                              |  8 ++---
 .../syscalls/delete_module/delete_module01.c  |  6 ++--
 .../syscalls/delete_module/delete_module03.c  | 12 +++----
 5 files changed, 68 insertions(+), 18 deletions(-)
 create mode 100644 include/tst_module.h

diff --git a/include/old/old_module.h b/include/old/old_module.h
index c50efec76244..1af7d1f68027 100644
--- a/include/old/old_module.h
+++ b/include/old/old_module.h
@@ -34,6 +34,14 @@
 #ifndef TST_MODULE
 #define TST_MODULE
 
+void tst_module_exist_(void (cleanup_fn)(void), const char *mod_name,
+					 char **mod_path);
+
+void tst_module_load_(void (cleanup_fn)(void), const char *mod_name,
+					char *const argv[]);
+
+void tst_module_unload_(void (cleanup_fn)(void), const char *mod_name);
+
 /*
  * Check module existence.
  *
@@ -44,8 +52,11 @@
  *
  * In case of failure, test'll call cleanup_fn and exit with TCONF return value.
  */
-void tst_module_exist(void (cleanup_fn)(void), const char *mod_name,
-	char **mod_path);
+static inline void tst_module_exist(void (cleanup_fn)(void),
+				    const char *mod_name, char **mod_path)
+{
+	tst_module_exist_(cleanup_fn, mod_name, mod_path);
+}
 
 /*
  * Load a module using insmod program.
@@ -58,8 +69,11 @@ void tst_module_exist(void (cleanup_fn)(void), const char *mod_name,
  * In case of insmod failure, test will call cleanup_fn and exit with TBROK
  * return value.
  */
-void tst_module_load(void (cleanup_fn)(void),
-	const char *mod_name, char *const argv[]);
+static inline void tst_module_load(void (cleanup_fn)(void),
+				   const char *mod_name, char *const argv[])
+{
+	tst_module_load_(cleanup_fn, mod_name, argv);
+}
 
 /*
  * Unload a module using rmmod program. In case of failure, test will call
@@ -67,6 +81,9 @@ void tst_module_load(void (cleanup_fn)(void),
  *
  * @mod_name: can be module name or module's file name.
  */
-void tst_module_unload(void (cleanup_fn)(void), const char *mod_name);
+static inline void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
+{
+	tst_module_unload_(cleanup_fn, mod_name);
+}
 
 #endif /* TST_MODULE */
diff --git a/include/tst_module.h b/include/tst_module.h
new file mode 100644
index 000000000000..637e85c0bf2f
--- /dev/null
+++ b/include/tst_module.h
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Alexey Kodanev <alexey.kodanev@oracle.com>
+ */
+
+#ifndef TST_MODULE_H
+#define TST_MODULE_H
+
+void tst_module_exist_(void (cleanup_fn)(void), const char *mod_name,
+					 char **mod_path);
+
+static inline void tst_module_exist(const char *mod_name, char **mod_path)
+{
+	tst_module_exist_(NULL, mod_name, mod_path);
+}
+
+void tst_module_load_(void (cleanup_fn)(void), const char *mod_name,
+					char *const argv[]);
+
+static inline void tst_module_load(const char *mod_name, char *const argv[])
+{
+	tst_module_load_(NULL, mod_name, argv);
+}
+
+void tst_module_unload_(void (cleanup_fn)(void), const char *mod_name);
+
+static inline void tst_module_unload(const char *mod_name)
+{
+	tst_module_unload_(NULL, mod_name);
+}
+
+#endif /* TST_MODULE_H */
diff --git a/lib/tst_module.c b/lib/tst_module.c
index eda61872fe01..9bd443623616 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -28,7 +28,7 @@
 #include "ltp_priv.h"
 #include "old_module.h"
 
-void tst_module_exists(void (cleanup_fn)(void),
+void tst_module_exists_(void (cleanup_fn)(void),
 	const char *mod_name, char **mod_path)
 {
 	/* check current working directory */
@@ -77,11 +77,11 @@ void tst_module_exists(void (cleanup_fn)(void),
 		free(buf);
 }
 
-void tst_module_load(void (cleanup_fn)(void),
+void tst_module_load_(void (cleanup_fn)(void),
 	const char *mod_name, char *const argv[])
 {
 	char *mod_path = NULL;
-	tst_module_exists(cleanup_fn, mod_name, &mod_path);
+	tst_module_exists_(cleanup_fn, mod_name, &mod_path);
 
 	const int offset = 2; /* command name & module path */
 	int size = 0;
@@ -101,7 +101,7 @@ void tst_module_load(void (cleanup_fn)(void),
 	free(mod_path);
 }
 
-void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
+void tst_module_unload_(void (cleanup_fn)(void), const char *mod_name)
 {
 	int i, rc;
 
diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
index e5cb53cc9ec3..8fb559f0c703 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module01.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
@@ -14,9 +14,9 @@
  */
 
 #include <errno.h>
-#include "old_module.h"
 #include "lapi/syscalls.h"
 #include "tst_test.h"
+#include "tst_module.h"
 
 #define MODULE_NAME	"dummy_del_mod"
 #define MODULE_NAME_KO	"dummy_del_mod.ko"
@@ -26,7 +26,7 @@ static int module_loaded;
 static void do_delete_module(void)
 {
 	if (module_loaded == 0) {
-		tst_module_load(NULL, MODULE_NAME_KO, NULL);
+		tst_module_load(MODULE_NAME_KO, NULL);
 		module_loaded = 1;
 	}
 
@@ -44,7 +44,7 @@ static void do_delete_module(void)
 static void cleanup(void)
 {
 	if (module_loaded == 1)
-		tst_module_unload(NULL, MODULE_NAME_KO);
+		tst_module_unload(MODULE_NAME_KO);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/delete_module/delete_module03.c b/testcases/kernel/syscalls/delete_module/delete_module03.c
index 8bd51be07dc2..7178e8ef13b0 100644
--- a/testcases/kernel/syscalls/delete_module/delete_module03.c
+++ b/testcases/kernel/syscalls/delete_module/delete_module03.c
@@ -14,7 +14,7 @@
 
 #include <errno.h>
 #include "tst_test.h"
-#include "old_module.h"
+#include "tst_module.h"
 #include "lapi/syscalls.h"
 
 #define DUMMY_MOD		"dummy_del_mod"
@@ -43,7 +43,7 @@ static void do_delete_module(void)
 		 * insmod DUMMY_MOD_KO again in case running
 		 * with -i option
 		 */
-		tst_module_load(NULL, DUMMY_MOD_KO, NULL);
+		tst_module_load(DUMMY_MOD_KO, NULL);
 		dummy_mod_loaded = 1;
 	}
 }
@@ -51,11 +51,11 @@ static void do_delete_module(void)
 static void setup(void)
 {
 	/* Load first kernel module */
-	tst_module_load(NULL, DUMMY_MOD_KO, NULL);
+	tst_module_load(DUMMY_MOD_KO, NULL);
 	dummy_mod_loaded = 1;
 
 	/* Load dependant kernel module */
-	tst_module_load(NULL, DUMMY_MOD_DEP_KO, NULL);
+	tst_module_load(DUMMY_MOD_DEP_KO, NULL);
 	dummy_mod_dep_loaded = 1;
 }
 
@@ -63,11 +63,11 @@ static void cleanup(void)
 {
 	/* Unload dependent kernel module */
 	if (dummy_mod_dep_loaded == 1)
-		tst_module_unload(NULL, DUMMY_MOD_DEP_KO);
+		tst_module_unload(DUMMY_MOD_DEP_KO);
 
 	/* Unload first kernel module */
 	if (dummy_mod_loaded == 1)
-		tst_module_unload(NULL, DUMMY_MOD_KO);
+		tst_module_unload(DUMMY_MOD_KO);
 }
 
 static struct tst_test test = {
-- 
2.25.0.rc1.19.g042ed3e048af

