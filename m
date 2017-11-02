From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu,  2 Nov 2017 10:15:40 -0700
Subject: [LTP] [PATCH] syscalls/keyctl06: update to test for follow-on fix
Message-ID: <20171102171540.76665-1-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

The original fix for the buffer overflow bug changed keyring_read() to
start returning a short value if the specified buffer is too small, but
the documented behavior is actually to return the size needed.  Update
the test to expect the documented behavior, as is provided by a
follow-on fix.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 testcases/kernel/syscalls/keyctl/keyctl06.c | 41 ++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl06.c b/testcases/kernel/syscalls/keyctl/keyctl06.c
index 88734313d..c62010e0b 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl06.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl06.c
@@ -16,8 +16,16 @@
  */
 
 /*
- * Regression test for commit e645016abc80 ("KEYS: fix writing past end of
- * user-supplied buffer in keyring_read()").
+ * Regression test for:
+ *
+ *	commit e645016abc80 ("KEYS: fix writing past end of user-supplied buffer
+ *	in keyring_read()").
+ *
+ * as well as its follow-on fix:
+ *
+ *	commit 3239b6f29bdf ("KEYS: return full count in keyring_read() if
+ *	buffer is too small")
+ *
  */
 
 #include <errno.h>
@@ -25,20 +33,20 @@
 #include "tst_test.h"
 #include "lapi/keyctl.h"
 
-static key_serial_t add_test_key(const char *description)
+static void add_test_key(const char *description)
 {
 	TEST(add_key("user", description, "payload", 7,
 		     KEY_SPEC_PROCESS_KEYRING));
 	if (TEST_RETURN < 0)
 		tst_brk(TBROK | TTERRNO, "Failed to add test key");
-	return TEST_RETURN;
 }
 
 static void do_test(void)
 {
 	key_serial_t key_ids[2];
-	key_serial_t key_id_1 = add_test_key("key1");
-	key_serial_t key_id_2 = add_test_key("key2");
+
+	add_test_key("key1");
+	add_test_key("key2");
 
 	memset(key_ids, 0, sizeof(key_ids));
 	TEST(keyctl(KEYCTL_READ, KEY_SPEC_PROCESS_KEYRING,
@@ -46,21 +54,22 @@ static void do_test(void)
 	if (TEST_RETURN < 0)
 		tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed");
 
+	/*
+	 * Do not check key_ids[0], as the contents of the buffer are
+	 * unspecified if it was too small.  However, key_ids[1] must not have
+	 * been written to, as it was outside the buffer.
+	 */
+
 	if (key_ids[1] != 0)
 		tst_brk(TFAIL, "KEYCTL_READ overran the buffer");
 
-	if (key_ids[0] == 0)
-		tst_brk(TBROK, "KEYCTL_READ didn't read anything");
-
-	if (key_ids[0] != key_id_1 && key_ids[0] != key_id_2)
-		tst_brk(TBROK, "KEYCTL_READ didn't return correct key ID");
-
-	if (TEST_RETURN != sizeof(key_serial_t)) {
-		tst_brk(TBROK, "KEYCTL_READ returned %ld but expected %zu",
-			TEST_RETURN, sizeof(key_serial_t));
+	if (TEST_RETURN != sizeof(key_ids)) {
+		tst_brk(TFAIL, "KEYCTL_READ returned %ld but expected %zu",
+			TEST_RETURN, sizeof(key_ids));
 	}
 
-	tst_res(TPASS, "KEYCTL_READ didn't overrun the buffer");
+	tst_res(TPASS,
+		"KEYCTL_READ returned full count but didn't overrun the buffer");
 }
 
 static struct tst_test test = {
-- 
2.15.0.403.gc27cc4dac6-goog

