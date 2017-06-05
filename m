From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon,  5 Jun 2017 10:48:11 -0700
Subject: [LTP] [PATCH 2/2] syscalls/add_key03: add test for NULL payload
	with nonzero length
In-Reply-To: <20170605174811.95267-1-ebiggers3@gmail.com>
References: <20170605174811.95267-1-ebiggers3@gmail.com>
Message-ID: <20170605174811.95267-3-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add a new test program to test that the add_key() syscall correctly
handles a NULL payload with nonzero length.  Note that may cause a NULL
pointer dereference in unpatched kernels.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/add_key/add_key03.c | 104 ++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 testcases/kernel/syscalls/add_key/add_key03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0c3c46e57..618089801 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -12,6 +12,7 @@ access04 access04
 acct01 acct01
 
 add_key01 add_key01
+add_key03 add_key03
 
 adjtimex01 adjtimex01
 adjtimex02 adjtimex02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 5b8df06f5..b5b428df5 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -7,6 +7,7 @@
 /access/access04
 /acct/acct01
 /add_key/add_key01
+/add_key/add_key03
 /adjtimex/adjtimex01
 /adjtimex/adjtimex02
 /alarm/alarm01
diff --git a/testcases/kernel/syscalls/add_key/add_key03.c b/testcases/kernel/syscalls/add_key/add_key03.c
new file mode 100644
index 000000000..21812710f
--- /dev/null
+++ b/testcases/kernel/syscalls/add_key/add_key03.c
@@ -0,0 +1,104 @@
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
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "config.h"
+#ifdef HAVE_LINUX_KEYCTL_H
+# include <linux/keyctl.h>
+#endif
+#include "tst_test.h"
+#include "linux_syscall_numbers.h"
+
+/*
+ * Test that the add_key() syscall correctly handles a NULL payload with nonzero
+ * length.  Specifically, it should fail with EFAULT rather than oopsing the
+ * kernel with a NULL pointer dereference or failing with EINVAL, as it did
+ * before (depending on the key type).  This is a regression test for "KEYS: fix
+ * dereferencing NULL payload with nonzero length".
+ *
+ * Note that none of the key types that exhibited the NULL pointer dereference
+ * are guaranteed to be built into the kernel, so we just test as many as we
+ * can, in the hope of catching one.  We also test with the "user" key type for
+ * good measure, although it was one of the types that failed with EINVAL rather
+ * than dereferencing NULL.
+ */
+
+#ifdef HAVE_LINUX_KEYCTL_H
+struct tcase {
+	const char *type;
+	size_t plen;
+} tcases[] = {
+	/*
+	 * The payload length we test for each key type needs to pass initial
+	 * validation but is otherwise arbitrary.  Note: the "rxrpc_s" key type
+	 * requires a payload of exactly 8 bytes.
+	 */
+	{ "asymmetric",		64 },
+	{ "cifs.idmap",		64 },
+	{ "cifs.spnego",	64 },
+	{ "pkcs7_test",		64 },
+	{ "rxrpc",		64 },
+	{ "rxrpc_s",		 8 },
+	{ "user",		64 },
+};
+#endif /* HAVE_LINUX_KEYCTL_H */
+
+static void verify_add_key(unsigned int i)
+{
+#ifdef HAVE_LINUX_KEYCTL_H
+	TEST(tst_syscall(__NR_add_key, tcases[i].type, "abc:def",
+			 NULL, tcases[i].plen, KEY_SPEC_PROCESS_KEYRING));
+
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL,
+			"add_key() with key type \"%s\" unexpectedly succeeded",
+			tcases[i].type);
+		return;
+	}
+
+	if (TEST_ERRNO == EFAULT) {
+		tst_res(TPASS, "received expected EFAULT with key type \"%s\"",
+			tcases[i].type);
+		return;
+	}
+
+	if (TEST_ERRNO == ENODEV) {
+		tst_res(TCONF, "kernel doesn't support key type \"%s\"",
+			tcases[i].type);
+		return;
+	}
+
+	/*
+	 * It's possible for the "asymmetric" key type to be supported, but with
+	 * no asymmetric key parsers registered.  In that case, attempting to
+	 * add a key of type asymmetric will fail with EBADMSG.
+	 */
+	if (TEST_ERRNO == EBADMSG && !strcmp(tcases[i].type, "asymmetric")) {
+		tst_res(TCONF, "no asymmetric key parsers are registered");
+		return;
+	}
+
+	tst_res(TFAIL | TTERRNO, "unexpected error with key type \"%s\"",
+		tcases[i].type);
+#else
+	tst_brk(TCONF, "linux/keyctl.h was missing upon compilation.");
+#endif /* HAVE_LINUX_KEYCTL_H */
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_add_key,
+};
-- 
2.13.0.506.g27d5fe0cd-goog

