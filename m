Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UpdSU-0007EK-Qv
	for ltp-list@lists.sourceforge.net; Thu, 20 Jun 2013 11:55:22 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UpdSQ-00062n-Jp
	for ltp-list@lists.sourceforge.net; Thu, 20 Jun 2013 11:55:22 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r5KBms61013543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Jun 2013 11:48:55 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5KBtAOf029085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Jun 2013 11:55:11 GMT
Received: from abhmt108.oracle.com (abhmt108.oracle.com [141.146.116.60])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5KBtAgr014193
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Jun 2013 11:55:10 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 20 Jun 2013 15:54:37 +0400
Message-Id: <1371729277-12450-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] tst_module: create new library functions for kernel
	modules
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

There are new functions: tst_module_exists(), tst_module_load() and
tst_module_unload(). These functions help to load and unload kernel
modules in the tests.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/tst_module.h |   72 +++++++++++++++++++++++++++++++++
 lib/tst_module.c     |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 include/tst_module.h
 create mode 100644 lib/tst_module.c

diff --git a/include/tst_module.h b/include/tst_module.h
new file mode 100644
index 0000000..0eb7dd5
--- /dev/null
+++ b/include/tst_module.h
@@ -0,0 +1,72 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author:
+ * Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ * These functions help to load and unload kernel modules in the tests.
+ *
+ * tst_module_load and tst_module_unload functions already include
+ * tst_module_exists function, which is checking the following possible
+ * module's locations:
+ *
+ * 1. Current working directory
+ *
+ * 2. LTP installation path (using env LTPROOT, which is usally /opt/ltp)
+ *
+ * 3. If tmp directory created, it'll look at the test start working directory
+ *
+ */
+
+#ifndef TST_MODULE
+#define TST_MODULE
+
+/*
+ * Check module existence.
+ *
+ * @res_path: if this pointer isn't NULL, found module's path will be written
+ * to it.
+ *
+ * In case of failure, test'll call cleanup_fn and exit with TCONF return value.
+ */
+void tst_module_exist(void (*cleanup_fn)(void), const char *mod_name,
+	char *res_path, size_t max_path);
+
+/*
+ * Load a module using insmod program.
+ *
+ * @mod_opt: pointer to a character string containing additional module's
+ * params. This character string can contain a format that follows the same
+ * specifications as format in printf. If this pointer is NULL, it will be
+ * ignored.
+ *
+ * This function may expect additional arguments to replace a format specifier
+ * in the mod_opt string.
+ *
+ * In case of insmod failure, test will call cleanup_fn and exit with TBROK
+ * return value.
+ */
+void tst_module_load(void (*cleanup_fn)(void),
+	const char *mod_name, char *mod_opt, ...);
+
+/*
+ * Unload a module using rmmod program. In case of failure, test will call
+ * cleanup_fn and exit with TBROK return value.
+ */
+void tst_module_unload(void (*cleanup_fn)(void), const char *mod_name);
+
+#endif /* TST_MODULE */
diff --git a/lib/tst_module.c b/lib/tst_module.c
new file mode 100644
index 0000000..0c6062f
--- /dev/null
+++ b/lib/tst_module.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ */
+
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "tst_module.h"
+
+/* declared in tst_tmpdir.c */
+const char *tst_get_startwd(void);
+
+void tst_module_exists(void (*cleanup_fn)(void),
+	const char *mod_name, char *res_path, size_t max_path)
+{
+	/* check current working directory */
+	if (access(mod_name, F_OK) == 0) {
+		if (res_path != NULL)
+			snprintf(res_path, max_path, "%s", mod_name);
+		return;
+	}
+
+	int err = -1;
+	char buf[PATH_MAX];
+	/* check LTP installation path */
+	const char *ltproot = getenv("LTPROOT");
+	if (ltproot != NULL) {
+		snprintf(buf, PATH_MAX, "%s/testcases/bin/%s",
+			ltproot, mod_name);
+		err = access(buf, F_OK);
+	}
+	/* check start working directory */
+	if (err == -1 && tst_tmpdir_created()) {
+		snprintf(buf, PATH_MAX, "%s/%s", tst_get_startwd(),
+			mod_name);
+		err = access(buf, F_OK);
+	}
+
+	if (err == 0) {
+		if (res_path != NULL)
+			snprintf(res_path, max_path, "%s", buf);
+	} else {
+		tst_brkm(TCONF, cleanup_fn, "Failed to find module '%s'",
+			mod_name);
+	}
+}
+
+void tst_module_load(void (*cleanup_fn)(void),
+	const char *mod_name, char *mod_opt, ...)
+{
+	char mod_path[PATH_MAX];
+
+	tst_module_exists(cleanup_fn, mod_name, mod_path, PATH_MAX);
+
+	char params[PATH_MAX];
+	params[0] = '\0';
+
+	if (mod_opt != NULL) {
+		va_list ap;
+		va_start(ap, mod_opt);
+		vsnprintf(params, PATH_MAX, mod_opt, ap);
+		va_end(ap);
+	}
+
+	char cmd[strlen(mod_path) + strlen(params) + 9];
+	snprintf(cmd, sizeof(cmd), "insmod %s %s", mod_path, params);
+
+	if (system(cmd) != 0) {
+		tst_brkm(TBROK, cleanup_fn, "Failed to load module '%s'",
+			mod_name);
+	}
+}
+
+void tst_module_unload(void (*cleanup_fn)(void), const char *mod_name)
+{
+	char mod_path[PATH_MAX];
+
+	tst_module_exists(cleanup_fn, mod_name, mod_path, PATH_MAX);
+
+	char cmd[strlen(mod_path) + 7];
+	snprintf(cmd, sizeof(cmd), "rmmod %s", mod_path);
+	if (system(cmd) != 0) {
+		tst_brkm(TBROK, cleanup_fn, "Failed to unload module '%s'",
+			mod_name);
+	}
+}
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
