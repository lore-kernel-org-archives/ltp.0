From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 30 Oct 2017 11:50:36 -0700
Subject: [LTP] [PATCH] syscalls/request_key03: new test for key
	instantiation races
Message-ID: <20171030185036.126451-1-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add a test for two related bugs in the keyrings subsystem which each
allowed unprivileged local users to cause a kernel oops (at best) by
attempting to "add" a key concurrently with "requesting" it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/lapi/keyctl.h                              |   4 +
 runtest/cve                                        |   2 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/request_key/request_key03.c    | 174 +++++++++++++++++++++
 5 files changed, 182 insertions(+)
 create mode 100644 testcases/kernel/syscalls/request_key/request_key03.c

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 8e6beac0e..dddd4a0ca 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -119,6 +119,10 @@ static inline long keyctl(int cmd, ...)
 # define KEYCTL_SETPERM 5
 #endif
 
+#ifndef KEYCTL_CLEAR
+# define KEYCTL_CLEAR 7
+#endif
+
 #ifndef KEYCTL_UNLINK
 # define KEYCTL_UNLINK 9
 #endif
diff --git a/runtest/cve b/runtest/cve
index 1719997cc..41a84a5d1 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -19,5 +19,7 @@ cve-2017-6951 cve-2017-6951
 cve-2017-7472 keyctl04
 cve-2017-12192 keyctl07
 cve-2017-15274 add_key02
+cve-2017-15299 request_key03
 cve-2017-15537 ptrace07
+cve-2017-15951 request_key03
 cve-2017-1000364 stack_clash
diff --git a/runtest/syscalls b/runtest/syscalls
index 323947556..f94b9c0a2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -930,6 +930,7 @@ renameat202 renameat202 -i 10
 
 request_key01 request_key01
 request_key02 request_key02
+request_key03 request_key03
 cve-2017-6951 cve-2017-6951
 
 rmdir01 rmdir01
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index a988e6b6e..cfde1cca5 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -771,6 +771,7 @@
 /renameat2/renameat202
 /request_key/request_key01
 /request_key/request_key02
+/request_key/request_key03
 /rmdir/rmdir01
 /rmdir/rmdir02
 /rmdir/rmdir03
diff --git a/testcases/kernel/syscalls/request_key/request_key03.c b/testcases/kernel/syscalls/request_key/request_key03.c
new file mode 100644
index 000000000..6ea763a3d
--- /dev/null
+++ b/testcases/kernel/syscalls/request_key/request_key03.c
@@ -0,0 +1,174 @@
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
+ * Regression test for two related bugs:
+ *
+ * (1) CVE-2017-15299, fixed by commit 60ff5b2f547a ("KEYS: don't let add_key()
+ *     update an uninstantiated key")
+ * (2) CVE-2017-15951, fixed by commit 363b02dab09b ("KEYS: Fix race between
+ *     updating and finding a negative key")
+ *
+ * We test for the bugs together because the reproduction steps are essentially
+ * the same: repeatedly try to add/update a key with add_key() while requesting
+ * it with request_key() in another task.  This reproduces both bugs:
+ *
+ * For CVE-2017-15299, add_key() has to run while the key being created by
+ * request_key() is still in the "uninstantiated" state.  For the "encrypted" or
+ * "trusted" key types (not guaranteed to be available) this caused a NULL
+ * pointer dereference in encrypted_update() or in trusted_update(),
+ * respectively.  For the "user" key type, this caused the WARN_ON() in
+ * construct_key() to be hit.
+ *
+ * For CVE-2017-15951, request_key() has to run while the key is "negatively
+ * instantiated" (from a prior request_key()) and is being concurrently changed
+ * to "positively instantiated" via add_key() updating it.  This race, which is
+ * a bit more difficult to reproduce, caused the task executing request_key() to
+ * dereference an invalid pointer in __key_link_begin().
+ */
+
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+static void test_with_key_type(const char *type, const char *payload,
+			       int effort)
+{
+	int i;
+	int status;
+	pid_t add_key_pid;
+	pid_t request_key_pid;
+
+	TEST(keyctl(KEYCTL_JOIN_SESSION_KEYRING, NULL));
+	if (TEST_RETURN < 0)
+		tst_brk(TBROK | TTERRNO, "failed to join new session keyring");
+
+	TEST(add_key(type, "desc", payload, strlen(payload),
+		     KEY_SPEC_SESSION_KEYRING));
+	if (TEST_RETURN < 0 && TEST_ERRNO != EINVAL) {
+		if (TEST_ERRNO == ENODEV) {
+			tst_res(TCONF, "kernel doesn't support key type '%s'",
+				type);
+			return;
+		}
+		tst_brk(TBROK | TTERRNO,
+			"unexpected error checking whether key type '%s' is supported",
+			type);
+	}
+
+	/*
+	 * Fork a subprocess which repeatedly tries to "add" a key of the given
+	 * type.  This actually will try to update the key if it already exists.
+	 * Depending on the state of the key, add_key() should either succeed or
+	 * fail with one of several errors:
+	 *
+	 * (1) key didn't exist@all: either add_key() should succeed (if the
+	 *     payload is valid), or it should fail with EINVAL (if the payload
+	 *     is invalid; this is needed for the "encrypted" and "trusted" key
+	 *     types because they have a quirk where the payload syntax differs
+	 *     for creating new keys vs. updating existing keys)
+	 *
+	 * (2) key was negative: add_key() should succeed
+	 *
+	 * (3) key was uninstantiated: add_key() should wait for the key to be
+	 *     negated, then fail with ENOKEY
+	 */
+	add_key_pid = SAFE_FORK();
+	if (add_key_pid == 0) {
+		for (i = 0; i < 100 * effort; i++) {
+			usleep(rand() % 1024);
+			TEST(add_key(type, "desc", payload, strlen(payload),
+				     KEY_SPEC_SESSION_KEYRING));
+			if (TEST_RETURN < 0 &&
+			    TEST_ERRNO != EINVAL && TEST_ERRNO != ENOKEY) {
+				tst_brk(TBROK | TTERRNO,
+					"unexpected error adding key of type '%s'",
+					type);
+			}
+			TEST(keyctl(KEYCTL_CLEAR, KEY_SPEC_SESSION_KEYRING));
+			if (TEST_RETURN < 0) {
+				tst_brk(TBROK | TTERRNO,
+					"unable to clear keyring");
+			}
+		}
+		exit(0);
+	}
+
+	request_key_pid = SAFE_FORK();
+	if (request_key_pid == 0) {
+		for (i = 0; i < 5000 * effort; i++) {
+			TEST(request_key(type, "desc", "callout_info",
+					 KEY_SPEC_SESSION_KEYRING));
+			if (TEST_RETURN < 0 &&
+			    TEST_ERRNO != ENOKEY && TEST_ERRNO != ENOENT) {
+				tst_brk(TBROK | TTERRNO,
+					"unexpected error requesting key of type '%s'",
+					type);
+			}
+		}
+		exit(0);
+	}
+
+	SAFE_WAITPID(add_key_pid, &status, 0);
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+		tst_res(TPASS, "didn't crash while updating key of type '%s'",
+			type);
+	} else if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
+		/* Probably CVE-2017-15299 */
+		tst_res(TFAIL, "kernel oops while updating key of type '%s'",
+			type);
+	} else {
+		tst_brk(TBROK, "add_key child %s", tst_strstatus(status));
+	}
+
+	SAFE_WAITPID(request_key_pid, &status, 0);
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+		tst_res(TPASS, "didn't crash while requesting key of type '%s'",
+			type);
+	} else if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
+		/* Probably CVE-2017-15951 */
+		tst_res(TFAIL, "kernel oops while requesting key of type '%s'",
+			type);
+	} else {
+		tst_brk(TBROK, "request_key child %s", tst_strstatus(status));
+	}
+}
+
+static void do_test(void)
+{
+	/*
+	 * Briefly test the "encrypted" and/or "trusted" key types when
+	 * availaible, mainly to reproduce CVE-2017-15299.
+	 */
+	test_with_key_type("encrypted", "update user:foo 32", 2);
+	test_with_key_type("trusted", "update", 2);
+
+	/*
+	 * Test the "user" key type for longer, mainly in order to reproduce
+	 * CVE-2017-15951.  However, without the fix for CVE-2017-15299 as well,
+	 * WARNs may show up in the kernel log.
+	 */
+	test_with_key_type("user", "payload", 15);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.forks_child = 1,
+};
-- 
2.15.0.rc2.357.g7e34df9404-goog

