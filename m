From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed,  1 Nov 2017 15:59:43 +0100
Subject: [LTP] [PATCH v2] Add test keyctl08 for cve-2016-9604 on
	keyctl_join_session_keyring
Message-ID: <20171101145943.17785-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check key names starting with "." are disallowed.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/keyctl.h                       |  5 ++++
 runtest/cve                                 |  1 +
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/.gitignore        |  1 +
 testcases/kernel/syscalls/keyctl/keyctl08.c | 44 +++++++++++++++++++++++++++++
 5 files changed, 52 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl08.c

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 8e6beac0e..328e55763 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -65,6 +65,11 @@ static inline long keyctl(int cmd, ...)
 
 	return tst_syscall(__NR_keyctl, cmd, arg2, arg3, arg4, arg5);
 }
+
+static inline key_serial_t keyctl_join_session_keyring(const char *name) {
+	return keyctl(KEYCTL_JOIN_SESSION_KEYRING, name);
+}
+
 #endif /* defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS) */
 
 /* special process keyring shortcut IDs */
diff --git a/runtest/cve b/runtest/cve
index 1719997cc..bea7b3b5b 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -11,6 +11,7 @@ cve-2016-4997 cve-2016-4997
 cve-2016-5195 dirtyc0w
 cve-2016-7042 cve-2016-7042
 cve-2016-7117 cve-2016-7117
+cve-2016-9604 keyctl08
 cve-2016-10044 cve-2016-10044
 cve-2017-2618 cve-2017-2618
 cve-2017-2671 cve-2017-2671
diff --git a/runtest/syscalls b/runtest/syscalls
index 323947556..67c1ba7f0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -505,6 +505,7 @@ keyctl04 keyctl04
 keyctl05 keyctl05
 keyctl06 keyctl06
 keyctl07 keyctl07
+keyctl08 keyctl08
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index a988e6b6e..805fe119e 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -466,6 +466,7 @@
 /keyctl/keyctl05
 /keyctl/keyctl06
 /keyctl/keyctl07
+/keyctl/keyctl08
 /kcmp/kcmp01
 /kcmp/kcmp02
 /kcmp/kcmp03
diff --git a/testcases/kernel/syscalls/keyctl/keyctl08.c b/testcases/kernel/syscalls/keyctl/keyctl08.c
new file mode 100644
index 000000000..fca5c34de
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl08.c
@@ -0,0 +1,44 @@
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
+/* Check for CVE-2016-9604; that keys beginning with "." are disallowed.
+ *
+ * See commit ee8f844e3c5a73b999edf733df1c529d6503ec2f
+ */
+
+#include <errno.h>
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+void run(void)
+{
+	if (keyctl_join_session_keyring(".builtin_trusted_keys") == -1) {
+		if (errno != EPERM) {
+			tst_brk(TBROK | TERRNO,
+				"keyctl_join_sessoin_keyring(...)");
+		}
+
+		tst_res(TPASS, "Denied access to .builtin_trusted_keys");
+	} else {
+		tst_res(TFAIL, "Allowed access to .builtin_trusted_keys");
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.min_kver = "2.6.13",
+};
-- 
2.14.3

