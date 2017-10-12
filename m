From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 12 Oct 2017 13:42:25 -0700
Subject: [LTP] [PATCH v2 2/4] syscalls/keyctl06: new test for keyring_read()
	buffer overrun
In-Reply-To: <20171012204227.116510-1-ebiggers3@gmail.com>
References: <20171012204227.116510-1-ebiggers3@gmail.com>
Message-ID: <20171012204227.116510-3-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add a test for a bug which caused the kernel to write past the end of
the provided buffer when using KEYCTL_READ to read from a keyring.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/.gitignore        |  1 +
 testcases/kernel/syscalls/keyctl/keyctl06.c | 68 +++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b1e988dce..fc6800abf 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -502,6 +502,7 @@ keyctl02 keyctl02
 keyctl03 keyctl03
 keyctl04 keyctl04
 keyctl05 keyctl05
+keyctl06 keyctl06
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 4dc2f8bfa..a803986ef 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -463,6 +463,7 @@
 /keyctl/keyctl03
 /keyctl/keyctl04
 /keyctl/keyctl05
+/keyctl/keyctl06
 /kcmp/kcmp01
 /kcmp/kcmp02
 /kcmp/kcmp03
diff --git a/testcases/kernel/syscalls/keyctl/keyctl06.c b/testcases/kernel/syscalls/keyctl/keyctl06.c
new file mode 100644
index 000000000..88734313d
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl06.c
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
+ * Regression test for commit e645016abc80 ("KEYS: fix writing past end of
+ * user-supplied buffer in keyring_read()").
+ */
+
+#include <errno.h>
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+static key_serial_t add_test_key(const char *description)
+{
+	TEST(add_key("user", description, "payload", 7,
+		     KEY_SPEC_PROCESS_KEYRING));
+	if (TEST_RETURN < 0)
+		tst_brk(TBROK | TTERRNO, "Failed to add test key");
+	return TEST_RETURN;
+}
+
+static void do_test(void)
+{
+	key_serial_t key_ids[2];
+	key_serial_t key_id_1 = add_test_key("key1");
+	key_serial_t key_id_2 = add_test_key("key2");
+
+	memset(key_ids, 0, sizeof(key_ids));
+	TEST(keyctl(KEYCTL_READ, KEY_SPEC_PROCESS_KEYRING,
+		    (char *)key_ids, sizeof(key_serial_t)));
+	if (TEST_RETURN < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed");
+
+	if (key_ids[1] != 0)
+		tst_brk(TFAIL, "KEYCTL_READ overran the buffer");
+
+	if (key_ids[0] == 0)
+		tst_brk(TBROK, "KEYCTL_READ didn't read anything");
+
+	if (key_ids[0] != key_id_1 && key_ids[0] != key_id_2)
+		tst_brk(TBROK, "KEYCTL_READ didn't return correct key ID");
+
+	if (TEST_RETURN != sizeof(key_serial_t)) {
+		tst_brk(TBROK, "KEYCTL_READ returned %ld but expected %zu",
+			TEST_RETURN, sizeof(key_serial_t));
+	}
+
+	tst_res(TPASS, "KEYCTL_READ didn't overrun the buffer");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.15.0.rc0.271.g36b669edcc-goog

