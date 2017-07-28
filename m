From: Eric Biggers <ebiggers3@gmail.com>
Date: Fri, 28 Jul 2017 14:13:13 -0700
Subject: [LTP] [PATCH] syscalls/keyctl04: new test for thread keyring memory
	leak
Message-ID: <20170728211313.89836-1-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add a test for a kernel bug that allowed unprivileged programs to
exhaust kernel memory by leaking thread keyrings (CVE-2017-7472).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/.gitignore        |  1 +
 testcases/kernel/syscalls/keyctl/keyctl04.c | 72 +++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8e1f58731..5c7fd8e94 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -494,6 +494,7 @@ io_submit01 io_submit01
 keyctl01 keyctl01
 keyctl02 keyctl02
 keyctl03 keyctl03
+keyctl04 keyctl04
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 6e0af314c..e311ba3f8 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -457,6 +457,7 @@
 /keyctl/keyctl01
 /keyctl/keyctl02
 /keyctl/keyctl03
+/keyctl/keyctl04
 /kcmp/kcmp01
 /kcmp/kcmp02
 /kcmp/kcmp03
diff --git a/testcases/kernel/syscalls/keyctl/keyctl04.c b/testcases/kernel/syscalls/keyctl/keyctl04.c
new file mode 100644
index 000000000..c4a493b45
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl04.c
@@ -0,0 +1,72 @@
+/*
+ * Copyright (c) 2017 Google, Inc.
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
+ * Regression test for commit c9f838d104fe ("KEYS: fix
+ * keyctl_set_reqkey_keyring() to not leak thread keyrings"), a.k.a.
+ * CVE-2017-7472.  This bug could be used to exhaust kernel memory, though it
+ * would take a while to do that and it would grind the test suite to a halt.
+ * Instead we do a quick check for whether the existing thread keyring is
+ * replaced when the default request-key destination is set to the thread
+ * keyring.  It shouldn't be, but before the fix it was (and the old thread
+ * keyring was leaked).
+ */
+
+#include "config.h"
+#ifdef HAVE_LINUX_KEYCTL_H
+# include <linux/keyctl.h>
+#endif
+#include "tst_test.h"
+#include "linux_syscall_numbers.h"
+
+#ifdef HAVE_LINUX_KEYCTL_H
+
+static void do_test(void)
+{
+	int tid_keyring;
+
+	/* Create a thread keyring and remember its ID */
+	TEST(tst_syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
+			 KEY_SPEC_THREAD_KEYRING, 1));
+	if (TEST_RETURN < 0)
+		tst_brk(TFAIL | TTERRNO, "failed to create thread keyring");
+	tid_keyring = TEST_RETURN;
+
+	/* Set the default request-key destination to the thread keyring */
+	TEST(tst_syscall(__NR_keyctl, KEYCTL_SET_REQKEY_KEYRING,
+			 KEY_REQKEY_DEFL_THREAD_KEYRING));
+	if (TEST_RETURN < 0)
+		tst_brk(TFAIL | TTERRNO, "failed to set reqkey keyring");
+
+	/* Get the thread keyring ID again; it shouldn't have changed */
+	TEST(tst_syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
+			 KEY_SPEC_THREAD_KEYRING, 0));
+	if (TEST_RETURN < 0)
+		tst_brk(TFAIL | TTERRNO, "failed to get thread keyring ID");
+	if (TEST_RETURN != tid_keyring)
+		tst_brk(TFAIL, "thread keyring was leaked!");
+
+	tst_res(TPASS, "thread keyring was not leaked");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
+
+#else
+	TST_TEST_TCONF("linux/keyctl.h was missing upon compilation.");
+#endif /* HAVE_LINUX_KEYCTL_H */
-- 
2.14.0.rc0.400.g1c36432dff-goog

