From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 16 Oct 2017 12:47:57 -0700
Subject: [LTP] [PATCH v3] syscalls/keyctl07: new test for oops when reading
	negative key
Message-ID: <20171016194757.47486-1-ebiggers3@gmail.com>
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
 runtest/cve                                 |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/.gitignore        |   1 +
 testcases/kernel/syscalls/keyctl/keyctl07.c | 109 ++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl07.c

diff --git a/runtest/cve b/runtest/cve
index d182e592a..b8e038112 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -17,5 +17,6 @@ cve-2017-2671 cve-2017-2671
 cve-2017-5669 cve-2017-5669
 cve-2017-6951 cve-2017-6951
 cve-2017-7472 keyctl04
+cve-2017-12192 keyctl07
 cve-2017-15274 add_key02
 cve-2017-1000364 stack_clash
diff --git a/runtest/syscalls b/runtest/syscalls
index 49ae48621..e345325a2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -504,6 +504,7 @@ keyctl03 keyctl03
 keyctl04 keyctl04
 keyctl05 keyctl05
 keyctl06 keyctl06
+keyctl07 keyctl07
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 76bae9e4a..2a770a998 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -465,6 +465,7 @@
 /keyctl/keyctl04
 /keyctl/keyctl05
 /keyctl/keyctl06
+/keyctl/keyctl07
 /kcmp/kcmp01
 /kcmp/kcmp02
 /kcmp/kcmp03
diff --git a/testcases/kernel/syscalls/keyctl/keyctl07.c b/testcases/kernel/syscalls/keyctl/keyctl07.c
new file mode 100644
index 000000000..eb8a72dbe
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl07.c
@@ -0,0 +1,109 @@
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
+ * negative key").  This is CVE-2017-12192.
+ */
+
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+static void try_to_read_negative_key(void)
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
+		tst_brk(TFAIL,
+			"KEYCTL_READ on negative key unexpectedly succeeded");
+	}
+	if (TEST_ERRNO != ENOKEY) {
+		tst_brk(TFAIL | TTERRNO,
+			"KEYCTL_READ on negative key failed with unexpected error");
+	}
+	tst_res(TPASS,
+		"KEYCTL_READ on negative key expectedly failed with ENOKEY");
+}
+
+static void do_test(void)
+{
+	int status;
+
+	if (SAFE_FORK() == 0) {
+		try_to_read_negative_key();
+		return;
+	}
+	SAFE_WAIT(&status);
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
+		tst_brk(TFAIL,
+			"KEYCTL_READ on negative key caused kernel oops");
+	}
+	if (!WIFEXITED(status))
+		tst_brk(TBROK, "child exited abnormally");
+	exit(WEXITSTATUS(status));
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.forks_child = 1,
+};
-- 
2.15.0.rc0.271.g36b669edcc-goog

