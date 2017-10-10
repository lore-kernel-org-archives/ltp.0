From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 10 Oct 2017 10:51:20 -0700
Subject: [LTP] [PATCH 4/4] syscalls/add_key03: new test for forging user
	keyrings
In-Reply-To: <20171010175120.90586-1-ebiggers3@gmail.com>
References: <20171010175120.90586-1-ebiggers3@gmail.com>
Message-ID: <20171010175120.90586-5-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add a test for a bug which allowed a user to create the user and user
session keyrings for another user.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/add_key/add_key03.c | 122 ++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 testcases/kernel/syscalls/add_key/add_key03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 649dbfa6c..0d2254393 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -13,6 +13,7 @@ acct01 acct01
 
 add_key01 add_key01
 add_key02 add_key02
+add_key03 add_key03
 
 adjtimex01 adjtimex01
 adjtimex02 adjtimex02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 53ad7ca2b..7dea3b2c7 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -8,6 +8,7 @@
 /acct/acct01
 /add_key/add_key01
 /add_key/add_key02
+/add_key/add_key03
 /adjtimex/adjtimex01
 /adjtimex/adjtimex02
 /alarm/alarm01
diff --git a/testcases/kernel/syscalls/add_key/add_key03.c b/testcases/kernel/syscalls/add_key/add_key03.c
new file mode 100644
index 000000000..8c68f8635
--- /dev/null
+++ b/testcases/kernel/syscalls/add_key/add_key03.c
@@ -0,0 +1,122 @@
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
+ * Regression test for commit 237bbd29f7a0 ("KEYS: prevent creating a different
+ * user's keyrings").  The bug allowed any random user to create a keyring named
+ * "_uid.$UID" (or "_uid_ses.$UID"), and it would become the user keyring (or
+ * user session keyring) for user $UID, provided that it hadn't already been
+ * created.
+ *
+ * This test must be run as root so that it has permission to switch to another
+ * user ID and check whether the keyrings are wrong.  However, the underlying
+ * bug is actually reachable/exploitable by a non-root user.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+static key_serial_t create_keyring(const char *description)
+{
+	TEST(add_key("keyring", description, NULL, 0,
+		     KEY_SPEC_PROCESS_KEYRING));
+	if (TEST_RETURN < 0) {
+		tst_brk(TBROK | TTERRNO,
+			"unable to create keyring '%s'", description);
+	}
+	return TEST_RETURN;
+}
+
+static key_serial_t get_keyring_id(key_serial_t special_id)
+{
+	TEST(keyctl(KEYCTL_GET_KEYRING_ID, special_id, 1));
+	if (TEST_RETURN < 0) {
+		tst_brk(TBROK | TTERRNO,
+			"unable to get ID of keyring %d", special_id);
+	}
+	return TEST_RETURN;
+}
+
+static void unlink_keyring(key_serial_t id)
+{
+	TEST(keyctl(KEYCTL_UNLINK, id, KEY_SPEC_PROCESS_KEYRING));
+	if (TEST_RETURN < 0) {
+		tst_brk(TBROK | TTERRNO,
+			"unable to unlink the keyring we created");
+	}
+}
+
+static void do_test(void)
+{
+	int i;
+
+	/*
+	 * Try with multiple user IDs before reporting success.  By chance, some
+	 * users may already have an existing user keyring; the bug will not be
+	 * reproducible for them.
+	 */
+	for (i = 0; i < 10; i++) {
+		char description[32];
+		uid_t uid;
+		key_serial_t fake_user_keyring;
+		key_serial_t fake_user_session_keyring;
+
+		uid = rand();
+		if (uid == 0)
+			continue;
+
+		sprintf(description, "_uid.%u", uid);
+		fake_user_keyring = create_keyring(description);
+		sprintf(description, "_uid_ses.%u", uid);
+		fake_user_session_keyring = create_keyring(description);
+
+		TEST(setreuid(uid, 0));
+		if (TEST_RETURN < 0) {
+			tst_brk(TBROK | TTERRNO,
+				"unable to set real uid to %u", uid);
+		}
+
+		if (fake_user_keyring == get_keyring_id(KEY_SPEC_USER_KEYRING)) {
+			tst_brk(TFAIL,
+				"created user keyring for another user");
+		}
+
+		if (fake_user_session_keyring ==
+		    get_keyring_id(KEY_SPEC_USER_SESSION_KEYRING)) {
+			tst_brk(TFAIL,
+				"created user session keyring for another user");
+		}
+
+		TEST(setreuid(0, 0));
+		if (TEST_RETURN < 0)
+			tst_brk(TBROK | TTERRNO, "unable to reset real uid");
+		uid++;
+
+		unlink_keyring(fake_user_keyring);
+		unlink_keyring(fake_user_session_keyring);
+	}
+	tst_res(TPASS, "expectedly could not create another user's keyrings");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_root = 1,
+};
-- 
2.14.2.920.gcf0c67979c-goog

