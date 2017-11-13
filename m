From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 13 Nov 2017 14:01:51 -0800
Subject: [LTP] [PATCH v2] syscalls/add_key04: new test for associative array
	bug
Message-ID: <20171113220151.87599-1-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add a test for a bug in the kernel's generic associative array
implementation which allowed users to cause a kernel oops (NULL pointer
dereference) by adding keys to a keyring in a certain pattern.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Changed since v1: fixed a typo

 runtest/cve                                   |  1 +
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/.gitignore          |  1 +
 testcases/kernel/syscalls/add_key/add_key04.c | 90 +++++++++++++++++++++++++++
 4 files changed, 93 insertions(+)
 create mode 100644 testcases/kernel/syscalls/add_key/add_key04.c

diff --git a/runtest/cve b/runtest/cve
index 1b0d13374..2873df906 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -20,6 +20,7 @@ cve-2017-6951 cve-2017-6951
 cve-2017-7308 setsockopt02
 cve-2017-7472 keyctl04
 cve-2017-12192 keyctl07
+cve-2017-12193 add_key04
 cve-2017-15274 add_key02
 cve-2017-15299 request_key03 -b cve-2017-15299
 cve-2017-15537 ptrace07
diff --git a/runtest/syscalls b/runtest/syscalls
index fc381eb16..14089ac2c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -14,6 +14,7 @@ acct01 acct01
 add_key01 add_key01
 add_key02 add_key02
 add_key03 add_key03
+add_key04 add_key04
 
 adjtimex01 adjtimex01
 adjtimex02 adjtimex02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0b3935880..12a136edb 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -9,6 +9,7 @@
 /add_key/add_key01
 /add_key/add_key02
 /add_key/add_key03
+/add_key/add_key04
 /adjtimex/adjtimex01
 /adjtimex/adjtimex02
 /alarm/alarm01
diff --git a/testcases/kernel/syscalls/add_key/add_key04.c b/testcases/kernel/syscalls/add_key/add_key04.c
new file mode 100644
index 000000000..debf34942
--- /dev/null
+++ b/testcases/kernel/syscalls/add_key/add_key04.c
@@ -0,0 +1,90 @@
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
+ * Regression test for commit ea6789980fda ("assoc_array: Fix a buggy
+ * node-splitting case"), or CVE-2017-12193.
+ *
+ * Reproducing this bug requires adding keys to a keyring in a certain way that
+ * triggers a corner case in the kernel's "associative array" implementation,
+ * which is the data structure used to hold keys in a keyring, indexed by type
+ * and description.
+ *
+ * Specifically, the root node of a keyring's associative array must be
+ * completely filled with keys that all cluster together within the same slot.
+ * Then a key must be added which goes in a different slot.  On broken kernels,
+ * this caused a NULL pointer dereference in assoc_array_apply_edit().
+ *
+ * This can be done by carefully crafting key descriptions.  However, an easier
+ * way is to just add 16 keyrings and then a non-keyring, since keyrings all go
+ * into their own top-level slot.  This test takes the easier approach.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+#define ASSOC_ARRAY_FAN_OUT 16
+
+static void do_test(void)
+{
+	int status;
+
+	TEST(keyctl(KEYCTL_JOIN_SESSION_KEYRING, NULL));
+	if (TEST_RETURN < 0)
+		tst_brk(TBROK | TTERRNO, "failed to join new session keyring");
+
+	if (SAFE_FORK() == 0) {
+		char description[32];
+		const char payload[] = "payload";
+		int i;
+
+		for (i = 0; i < ASSOC_ARRAY_FAN_OUT; i++) {
+			sprintf(description, "keyring%d", i);
+			TEST(add_key("keyring", description, NULL, 0,
+				     KEY_SPEC_SESSION_KEYRING));
+			if (TEST_RETURN < 0) {
+				tst_brk(TBROK | TTERRNO,
+					"unable to create keyring %d", i);
+			}
+		}
+
+		TEST(add_key("user", "userkey", payload, sizeof(payload),
+			     KEY_SPEC_SESSION_KEYRING));
+		if (TEST_RETURN < 0)
+			tst_brk(TBROK | TTERRNO, "unable to create user key");
+
+		exit(0);
+	}
+
+	SAFE_WAIT(&status);
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
+		tst_res(TPASS, "didn't crash while filling keyring");
+	else if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
+		tst_res(TFAIL, "kernel oops while filling keyring");
+	else
+		tst_brk(TBROK, "Child %s", tst_strstatus(status));
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.forks_child = 1,
+};
-- 
2.15.0.448.gf294e3d99a-goog

