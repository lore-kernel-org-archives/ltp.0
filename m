From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 9 Mar 2017 11:51:32 +0800
Subject: [LTP] [PATCH] syscalls/keyctl03: Add new regression test
Message-ID: <1489031492-22340-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixed by:
commit f05819df10d7b09f6d1eb6f8534a8f68e5a4fe61
Author: David Howells <dhowells@redhat.com>
Date:   Thu Oct 15 17:21:37 2015 +0100

    KEYS: Fix crash when attempt to garbage collect
          an uninstantiated keyring

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/.gitignore        |  1 +
 testcases/kernel/syscalls/keyctl/Makefile   |  1 +
 testcases/kernel/syscalls/keyctl/keyctl03.c | 65 +++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 931a354..031f50a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -488,6 +488,7 @@ io_submit01 io_submit01
 
 keyctl01 keyctl01
 keyctl02 keyctl02
+keyctl03 keyctl03
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 9a4727c..a614e5d 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -453,6 +453,7 @@
 /ipc/shmget/shmget05
 /keyctl/keyctl01
 /keyctl/keyctl02
+/keyctl/keyctl03
 /kcmp/kcmp01
 /kcmp/kcmp02
 /kcmp/kcmp03
diff --git a/testcases/kernel/syscalls/keyctl/Makefile b/testcases/kernel/syscalls/keyctl/Makefile
index 5d2c48d..bb3d3a4 100644
--- a/testcases/kernel/syscalls/keyctl/Makefile
+++ b/testcases/kernel/syscalls/keyctl/Makefile
@@ -19,6 +19,7 @@
 top_srcdir		?= ../../../..
 
 keyctl02: LDLIBS	+=-lpthread $(KEYUTILS_LIBS)
+keyctl03: LDLIBS	+=$(KEYUTILS_LIBS)
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/keyctl/keyctl03.c b/testcases/kernel/syscalls/keyctl/keyctl03.c
new file mode 100644
index 0000000..83d5dcb
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl03.c
@@ -0,0 +1,65 @@
+/*
+ * Copyright (c) 2017 Fujitsu Ltd.
+ *  Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
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
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * This regression test can crash the buggy kernel,
+ * and the bug was fixed in:
+ *
+ *  commit f05819df10d7b09f6d1eb6f8534a8f68e5a4fe61
+ *  Author: David Howells <dhowells@redhat.com>
+ *  Date:   Thu Oct 15 17:21:37 2015 +0100
+ *
+ *  KEYS: Fix crash when attempt to garbage collect
+ *        an uninstantiated keyring
+ */
+
+#include "config.h"
+#include <errno.h>
+#include <sys/types.h>
+#ifdef HAVE_KEYUTILS_H
+# include <keyutils.h>
+#endif
+#include "tst_test.h"
+
+#ifdef HAVE_KEYUTILS_H
+
+static void do_test(void)
+{
+	key_serial_t key;
+
+	key = add_key("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
+	if (key == -1)
+		tst_brk(TBROK, "Failed to add key");
+
+	request_key("keyring", "foo", "bar", KEY_SPEC_THREAD_KEYRING);
+
+	TEST(keyctl(KEYCTL_UNLINK, key, KEY_SPEC_SESSION_KEYRING));
+	if (TEST_RETURN)
+		tst_res(TFAIL | TTERRNO, "keyctl unlink failed");
+	else
+		tst_res(TPASS, "Bug not reproduced");
+}
+
+static struct tst_test test = {
+	.tid = "keyctl03",
+	.test_all = do_test,
+};
+
+#else
+	TST_TEST_TCONF("keyutils.h does not exist");
+#endif /* HAVE_KEYUTILS_H */
-- 
1.8.4.2



