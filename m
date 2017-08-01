From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 31 Jul 2017 17:46:26 -0700
Subject: [LTP] [PATCH v2] syscalls/keyctl04: new test for thread keyring
	memory leak
Message-ID: <20170801004626.108851-1-ebiggers3@gmail.com>
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
 runtest/cve                                 |  1 +
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/.gitignore        |  1 +
 testcases/kernel/syscalls/keyctl/keyctl04.c | 68 +++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl04.c

diff --git a/runtest/cve b/runtest/cve
index 6e3e52d3a..e97f823c8 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -7,4 +7,5 @@ cve-2016-7117 cve-2016-7117
 cve-2017-2671 cve-2017-2671
 cve-2017-5669 cve-2017-5669
 cve-2017-6951 cve-2017-6951
+cve-2017-7472 keyctl04
 cve-2017-1000364 stack_clash
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
index 000000000..942cf2d5b
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl04.c
@@ -0,0 +1,68 @@
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
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+typedef int32_t key_serial_t;
+
+#define KEYCTL_GET_KEYRING_ID		0
+#define KEYCTL_SET_REQKEY_KEYRING	14
+
+#define KEY_SPEC_THREAD_KEYRING		-1
+
+#define KEY_REQKEY_DEFL_THREAD_KEYRING	1
+
+static void do_test(void)
+{
+	key_serial_t tid_keyring;
+
+	TEST(tst_syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
+			 KEY_SPEC_THREAD_KEYRING, 1));
+	if (TEST_RETURN < 0)
+		tst_brk(TBROK | TTERRNO, "failed to create thread keyring");
+	tid_keyring = TEST_RETURN;
+
+	TEST(tst_syscall(__NR_keyctl, KEYCTL_SET_REQKEY_KEYRING,
+			 KEY_REQKEY_DEFL_THREAD_KEYRING));
+	if (TEST_RETURN < 0)
+		tst_brk(TBROK | TTERRNO, "failed to set reqkey keyring");
+
+	TEST(tst_syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
+			 KEY_SPEC_THREAD_KEYRING, 0));
+	if (TEST_RETURN < 0)
+		tst_brk(TBROK | TTERRNO, "failed to get thread keyring ID");
+	if (TEST_RETURN == tid_keyring)
+		tst_res(TPASS, "thread keyring was not leaked");
+	else
+		tst_res(TFAIL, "thread keyring was leaked!");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.14.0.rc0.400.g1c36432dff-goog

