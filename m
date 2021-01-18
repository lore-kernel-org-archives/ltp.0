From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Jan 2021 13:34:32 +0100
Subject: [LTP] [RFC PATCH 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <20210118123433.17071-1-pvorel@suse.cz>
References: <20210118123433.17071-1-pvorel@suse.cz>
Message-ID: <20210118123433.17071-2-pvorel@suse.cz>
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
-r)/modules.dep, for Android in /system/lib/modules/modules.dep.

Android is always a bit tricky, thus does not fail when depmod.dep (it
might not be available or or modules directory not readable for non-root
user) or module itself not found.

This fixes many tests on BusyBox, e.g. *all* network tests (tests using
tst_net.sh) after 305a78e4c ("tst_net.sh: Require veth for netns").

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_kernel.c | 63 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 57fa4b2be..ef01cda3d 100644
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
@@ -81,15 +85,64 @@ int tst_kernel_bits(void)
 	return kernel_bits;
 }
 
+#ifndef __ANDROID__
+# define MODULES_DIR "/lib/modules"
+#else
+# define MODULES_DIR "/system/lib/modules"
+#endif
+
 int tst_check_driver(const char *name)
 {
+	struct stat st;
+	char *depmod_path = NULL;
+	char buf[PATH_MAX], module[PATH_MAX], search[PATH_MAX] = "/";
+	FILE *f;
+
+#ifndef __ANDROID__
+	struct utsname uts;
+
+	if (uname(&uts)) {
+		tst_brkm(TBROK | TERRNO, NULL, "uname()");
+		return -1;
+	}
+	SAFE_ASPRINTF(NULL, &depmod_path, "%s/%s/modules.dep", MODULES_DIR, uts.release);
+#else
+	SAFE_ASPRINTF(NULL, &depmod_path, "%s/modules.dep", MODULES_DIR);
+#endif
+
+	if (stat(depmod_path, &st) || !(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))) {
 #ifndef __ANDROID__
-	const char * const argv[] = { "modprobe", "-n", name, NULL };
-	int res = tst_cmd_(NULL, argv, "/dev/null", "/dev/null",
-			       TST_CMD_PASS_RETVAL);
+		tst_resm(TWARN, "expected depmod file %s does not exist or not a file", depmod_path);
+#endif
+		return 0;
+	}
+
+	if (access(depmod_path, R_OK)) {
+#ifndef __ANDROID__
+		tst_resm(TWARN, "depmod file %s cannot be read", depmod_path);
+#endif
+		return 0;
+	}
+
+	strcat(search, name);
+	strcat(search, ".ko");
 
-	/* 255 - it looks like modprobe not available */
-	return (res == 255) ? 0 : res;
+	f = SAFE_FOPEN(NULL, depmod_path, "r");
+
+	while (fgets(buf, sizeof(buf), f)) {
+		if (sscanf(buf, "%s:", module) != 1)
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
+#ifndef __ANDROID__
+	return 1;
 #else
 	/* Android modprobe may not have '-n', or properly installed
 	 * module.*.bin files to determine built-in drivers. Assume
-- 
2.29.2

