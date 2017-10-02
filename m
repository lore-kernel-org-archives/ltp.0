From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon,  2 Oct 2017 16:19:37 +0200
Subject: [LTP] [PATCH] Add test for cve-2016-9604 on
	keyctl_join_session_keyring(".name")
Message-ID: <20171002141937.17321-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check key names starting with "." are disallowed.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/keyctl.h         |  5 +++++
 runtest/cve                   |  1 +
 runtest/syscalls              |  1 +
 testcases/cve/.gitignore      |  1 +
 testcases/cve/Makefile        |  2 ++
 testcases/cve/cve-2016-9604.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 54 insertions(+)
 create mode 100644 testcases/cve/cve-2016-9604.c

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 3e7ce4708..2fc588a4a 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -63,6 +63,11 @@ static inline long keyctl(int cmd, ...)
 
 	return tst_syscall(__NR_keyctl, cmd, arg2, arg3, arg4, arg5);
 }
+
+static inline key_serial_t keyctl_join_session_keyring(const char *name) {
+	return keyctl(KEYCTL_JOIN_SESSION_KEYRING, name);
+}
+
 #endif /* HAVE_KEYUTILS_H */
 
 #ifndef KEYCTL_GET_KEYRING_ID
diff --git a/runtest/cve b/runtest/cve
index 8c140b5cb..806adccfb 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -11,6 +11,7 @@ cve-2016-4997 cve-2016-4997
 cve-2016-5195 dirtyc0w
 cve-2016-7042 cve-2016-7042
 cve-2016-7117 cve-2016-7117
+cve-2016-9604 cve-2016-9604
 cve-2016-10044 cve-2016-10044
 cve-2017-2618 cve-2017-2618
 cve-2017-2671 cve-2017-2671
diff --git a/runtest/syscalls b/runtest/syscalls
index 2362a231d..1952c6fd8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -500,6 +500,7 @@ keyctl02 keyctl02
 keyctl03 keyctl03
 keyctl04 keyctl04
 keyctl05 keyctl05
+cve-2016-9604 cve-2016-9604
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index f76c39826..ecd1d745c 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -3,6 +3,7 @@ cve-2014-0196
 cve-2016-4997
 cve-2016-7042
 cve-2016-7117
+cve-2016-9604
 cve-2016-10044
 cve-2017-2618
 cve-2017-2671
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 0905fd95c..88c2b15c4 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -30,4 +30,6 @@ cve-2014-0196:  LDLIBS += -lrt -lutil
 cve-2017-2671:	CFLAGS += -pthread
 cve-2017-2671:	LDLIBS += -lrt
 
+cve-2016-9604: 	LDLIBS += $(KEYUTILS_LIBS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/cve/cve-2016-9604.c b/testcases/cve/cve-2016-9604.c
new file mode 100644
index 000000000..fca5c34de
--- /dev/null
+++ b/testcases/cve/cve-2016-9604.c
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
2.14.1

