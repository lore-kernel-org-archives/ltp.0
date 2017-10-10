From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 10 Oct 2017 10:51:19 -0700
Subject: [LTP] [PATCH 3/4] syscalls/keyctl07: new test for oops when reading
	negative key
In-Reply-To: <20171010175120.90586-1-ebiggers3@gmail.com>
References: <20171010175120.90586-1-ebiggers3@gmail.com>
Message-ID: <20171010175120.90586-4-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add a test for a bug which caused the kernel to dereference a bogus
pointer when using KEYCTL_READ to read from a negative key.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/.gitignore        |  1 +
 testcases/kernel/syscalls/keyctl/keyctl07.c | 89 +++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 67a7362ee..649dbfa6c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -501,6 +501,7 @@ keyctl03 keyctl03
 keyctl04 keyctl04
 keyctl05 keyctl05
 keyctl06 keyctl06
+keyctl07 keyctl07
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 1e573d9a4..53ad7ca2b 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -463,6 +463,7 @@
 /keyctl/keyctl04
 /keyctl/keyctl05
 /keyctl/keyctl06
+/keyctl/keyctl07
 /kcmp/kcmp01
 /kcmp/kcmp02
 /kcmp/kcmp03
diff --git a/testcases/kernel/syscalls/keyctl/keyctl07.c b/testcases/kernel/syscalls/keyctl/keyctl07.c
new file mode 100644
index 000000000..c41d7040f
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl07.c
@@ -0,0 +1,89 @@
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
+ * Regression test for commit 37863c43b2c6 ("KEYS: prevent KEYCTL_READ on
+ * negative key").
+ */
+
+#include <errno.h>
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+static void do_test(void)
+{
+	key_serial_t key_id;
+	char buffer[128];
+
+	/*
+	 * Create a negatively instantiated key of the "user" key type.  This
+	 * key type is chosen because it has a ->read() method (which makes the
+	 * bug reachable) and is available whenever CONFIG_KEYS is enabled.
+	 *
+	 * request_key() will result in the creation of a negative key provided
+	 * that /sbin/request-key isn't configured to positively instantiate the
+	 * key, based on the provided type, description, and callout_info.  If
+	 * /sbin/request-key doesn't exist, errno will be ENOENT; while if it
+	 * does exist and we specify some random unprefixed description, errno
+	 * should be ENOKEY (since /sbin/request-key should not be configured to
+	 * instantiate random user keys).  In either case a negative key should
+	 * be created and we can continue on with the test.  Negative keys last
+	 * for 60 seconds so there should be plenty of time for the test.
+	 */
+	TEST(request_key("user", "description", "callout_info",
+			 KEY_SPEC_PROCESS_KEYRING));
+	if (TEST_RETURN != -1)
+		tst_brk(TBROK, "request_key() unexpectedly succeeded");
+
+	if (TEST_ERRNO != ENOKEY && TEST_ERRNO != ENOENT) {
+		tst_brk(TBROK | TTERRNO,
+			"request_key() failed with unexpected error");
+	}
+
+	/* Get the ID of the negative key by reading the keyring */
+	TEST(keyctl(KEYCTL_READ, KEY_SPEC_PROCESS_KEYRING,
+		    &key_id, sizeof(key_id)));
+	if (TEST_RETURN < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_READ unexpectedly failed");
+	if (TEST_RETURN != sizeof(key_id)) {
+		tst_brk(TBROK, "KEYCTL_READ returned %ld but expected %zu",
+			TEST_RETURN, sizeof(key_id));
+	}
+
+	/*
+	 * Now try to read the negative key.  Unpatched kernels will oops trying
+	 * to read from memory address 0x00000000ffffff92.
+	 */
+	tst_res(TINFO, "trying to read from the negative key...");
+	TEST(keyctl(KEYCTL_READ, key_id, buffer, sizeof(buffer)));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL,
+			"KEYCTL_READ on negative key unexpectedly succeeded");
+		return;
+	}
+	if (TEST_ERRNO != ENOKEY) {
+		tst_res(TFAIL | TTERRNO,
+			"KEYCTL_READ on negative key failed with unexpected error");
+		return;
+	}
+	tst_res(TPASS, "KEYCTL_READ on negative key expectedly failed with ENOKEY");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.14.2.920.gcf0c67979c-goog

