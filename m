From: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  9 Nov 2020 17:46:04 +0100
Subject: [LTP] [PATCH v3 1/2] Add tst_secureboot_enabled() helper function
Message-ID: <20201109164605.25965-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also check for SecureBoot status in tst_lockdown_enabled() if the lockdown
sysfile is not available/readable

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- check whether machine is in EFI mode first

Changes since v2:
- move tst_secureboot_enabled() code to a separate header file
- move EFIVAR_CFLAGS and EFIVAR_LIBS out of global CFLAGS and LDLIBS

 configure.ac             |  1 +
 include/mk/config.mk.in  |  2 ++
 include/tst_lockdown.h   |  4 +++
 include/tst_secureboot.h | 53 ++++++++++++++++++++++++++++++++++++++++
 m4/ltp-libefivar.m4      |  9 +++++++
 5 files changed, 69 insertions(+)
 create mode 100644 include/tst_secureboot.h
 create mode 100644 m4/ltp-libefivar.m4

diff --git a/configure.ac b/configure.ac
index 03e4e09c9..d9ca5ad38 100644
--- a/configure.ac
+++ b/configure.ac
@@ -296,6 +296,7 @@ LTP_CHECK_CAPABILITY_SUPPORT
 LTP_CHECK_CC_WARN_OLDSTYLE
 LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 LTP_CHECK_CRYPTO
+LTP_CHECK_EFIVAR
 LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_KERNEL_DEVEL
 LTP_CHECK_KEYUTILS_SUPPORT
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 427608a17..45105cdab 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -45,6 +45,8 @@ KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
 HAVE_FTS_H		:= @HAVE_FTS_H@
 LIBMNL_LIBS		:= @LIBMNL_LIBS@
 LIBMNL_CFLAGS		:= @LIBMNL_CFLAGS@
+EFIVAR_CFLAGS		:= @EFIVAR_CFLAGS@
+EFIVAR_LIBS		:= @EFIVAR_LIBS@
 
 prefix			:= @prefix@
 
diff --git a/include/tst_lockdown.h b/include/tst_lockdown.h
index 78eaeccea..1c60151a9 100644
--- a/include/tst_lockdown.h
+++ b/include/tst_lockdown.h
@@ -5,6 +5,10 @@
 
 #define PATH_LOCKDOWN	"/sys/kernel/security/lockdown"
 
+/*
+ * Note: Also check tst_secureboot_enabled(). It may indicate integrity
+ * lockdown even if tst_lockdown_enabled() returns 0.
+ */
 int tst_lockdown_enabled(void);
 
 #endif /* TST_LOCKDOWN_H */
diff --git a/include/tst_secureboot.h b/include/tst_secureboot.h
new file mode 100644
index 000000000..70980a76a
--- /dev/null
+++ b/include/tst_secureboot.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef TST_SECUREBOOT_H
+#define TST_SECUREBOOT_H
+
+#include "config.h"
+#include <stdlib.h>
+
+#ifdef HAVE_EFIVAR
+#include <efivar.h>
+#endif /* HAVE_EFIVAR */
+
+static inline int tst_secureboot_enabled(void)
+{
+#ifdef HAVE_EFIVAR
+	int ret, status = 0;
+	uint8_t *data = NULL;
+	size_t size = 0;
+	uint32_t attrs = 0;
+
+	if (!efi_variables_supported()) {
+		tst_res(TINFO, "SecureBoot: off (non-EFI system)");
+		return 0;
+	}
+
+	efi_error_clear();
+	ret = efi_get_variable(EFI_GLOBAL_GUID, "SecureBoot", &data, &size,
+		&attrs);
+
+	if (ret) {
+		char *fn, *func, *msg;
+		int ln, err, i = 0;
+
+		while (efi_error_get(i++, &fn, &func, &ln, &msg, &err) > 0)
+			tst_res(TINFO, "Efivar error: %s", msg);
+
+		efi_error_clear();
+	} else if (data) {
+		status = *data;
+		tst_res(TINFO, "SecureBoot: %s", status ? "on" : "off");
+	}
+
+	if (data)
+		free(data);
+
+	return status;
+#else /* HAVE_EFIVAR */
+	tst_res(TINFO, "%s(): LTP was built without efivar support", __func__);
+	return -1;
+#endif /* HAVE_EFIVAR */
+}
+
+#endif /* TST_SECUREBOOT_H */
diff --git a/m4/ltp-libefivar.m4 b/m4/ltp-libefivar.m4
new file mode 100644
index 000000000..0a2750701
--- /dev/null
+++ b/m4/ltp-libefivar.m4
@@ -0,0 +1,9 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
+
+AC_DEFUN([LTP_CHECK_EFIVAR], [
+	dnl efivar library and headers
+	PKG_CHECK_MODULES([EFIVAR], [efivar], [
+		AC_DEFINE([HAVE_EFIVAR], [1], [Define to 1 if you have libefivar library and headers])
+	], [have_efivar=no])
+])
-- 
2.28.0

