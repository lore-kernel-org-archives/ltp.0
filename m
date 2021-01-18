From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Jan 2021 17:13:08 +0100
Subject: [LTP] [PATCH v2 1/2] lib: Fix kernel module detection on BusyBox
Message-ID: <20210118161308.30771-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

BusyBox modprobe implementation does not support -n switch.

It does support -D, which could be used, *but* unless is busybox binary
configured with CONFIG_MODPROBE_SMALL=y (IMHO the default).

We could use modinfo and grep output for 'filename:', but we agreed on
ML that having our own implementation will be the best as it also
does not require modinfo as external dependency.

Implementation searches for for module presence in /lib/modules/$(uname
-r)/modules.{dep,builtin}. On Android expect files in /system/lib/modules
directory.

On Android still assume all drivers are available as config files might
not be available).

This fixes many tests on BusyBox, e.g. *all* network tests (tests using
tst_net.sh) after 305a78e4c ("tst_net.sh: Require veth for netns").

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Check also modules.builtin (built-in dependency).

Kind regards,
Petr

 lib/tst_kernel.c | 81 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 9 deletions(-)

diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 57fa4b2be..ab324a643 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -17,8 +18,11 @@
 
 #include <sys/personality.h>
 #include <sys/utsname.h>
+#include <limits.h>
+
 #include "test.h"
 #include "tst_kernel.h"
+#include "old_safe_stdio.h"
 
 static int get_kernel_bits_from_uname(struct utsname *buf)
 {
@@ -81,20 +85,79 @@ int tst_kernel_bits(void)
 	return kernel_bits;
 }
 
-int tst_check_driver(const char *name)
+#ifndef __ANDROID__
+# define MODULES_DIR "/lib/modules"
+#else
+# define MODULES_DIR "/system/lib/modules"
+#endif
+
+
+int tst_search_driver(const char *driver, const char *file)
 {
+	struct stat st;
+	char *path = NULL;
+	char buf[PATH_MAX], module[PATH_MAX], search[PATH_MAX] = "/";
+	FILE *f;
+
 #ifndef __ANDROID__
-	const char * const argv[] = { "modprobe", "-n", name, NULL };
-	int res = tst_cmd_(NULL, argv, "/dev/null", "/dev/null",
-			       TST_CMD_PASS_RETVAL);
+	struct utsname uts;
 
-	/* 255 - it looks like modprobe not available */
-	return (res == 255) ? 0 : res;
+	if (uname(&uts)) {
+		tst_brkm(TBROK | TERRNO, NULL, "uname() failed");
+		return -1;
+	}
+	SAFE_ASPRINTF(NULL, &path, "%s/%s/%s", MODULES_DIR, uts.release, file);
 #else
-	/* Android modprobe may not have '-n', or properly installed
-	 * module.*.bin files to determine built-in drivers. Assume
-	 * all drivers are available.
+	SAFE_ASPRINTF(NULL, &path, "%s/%s", MODULES_DIR, file);
+#endif
+
+	if (stat(path, &st) || !(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))) {
+#ifndef __ANDROID__
+		tst_resm(TWARN, "expected file %s does not exist or not a file", path);
+#endif
+		return -1;
+	}
+
+	if (access(path, R_OK)) {
+#ifndef __ANDROID__
+		tst_resm(TWARN, "file %s cannot be read", path);
+#endif
+		return -1;
+	}
+
+	strcat(search, driver);
+	strcat(search, ".ko");
+
+	f = SAFE_FOPEN(NULL, path, "r");
+
+	while (fgets(buf, sizeof(buf), f)) {
+		if (sscanf(buf, "%s", module) != 1)
+			continue;
+
+		if (strstr(module, search) != NULL) {
+			SAFE_FCLOSE(NULL, f);
+			return 0;
+		}
+	}
+
+	SAFE_FCLOSE(NULL, f);
+
+	return -1;
+}
+
+int tst_check_driver(const char *driver)
+{
+#ifdef __ANDROID__
+	/*
+	 * Android may not have properly installed modules.* files to determine
+	 * built-in drivers. Assume all drivers are available.
 	 */
 	return 0;
 #endif
+
+	if (!tst_search_driver(driver, "modules.dep") ||
+		!tst_search_driver(driver, "modules.builtin"))
+		return 0;
+
+	return 1;
 }
-- 
2.29.2

