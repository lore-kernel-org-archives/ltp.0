From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 29 Aug 2017 11:37:02 +0800
Subject: [LTP] [PATCH v4 2/3] syscalls/keyctl: Make use of lapi/keyctl.h
In-Reply-To: <20170829033703.5772-1-fenggw-fnst@cn.fujitsu.com>
References: <20170828110206.GA21355@rei.lan>
 <20170829033703.5772-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170829033703.5772-2-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1.syscalls/keyctl02 and syscalls/keyctl03 make use of lapi/keyctl.h

2.syscalls/keyctl0* use keyutils.h fallback definition in lapi/keyctl.h
  instead of raw syscall, thus we would test the keyutils library if the
  header is present and these tests will not be disabled otherwise.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/keyctl/Makefile   |  6 +++---
 testcases/kernel/syscalls/keyctl/keyctl01.c | 12 +++---------
 testcases/kernel/syscalls/keyctl/keyctl02.c | 12 ++----------
 testcases/kernel/syscalls/keyctl/keyctl03.c | 12 ++----------
 testcases/kernel/syscalls/keyctl/keyctl04.c | 14 +++++---------
 testcases/kernel/syscalls/keyctl/keyctl05.c | 23 ++++++++++-------------
 6 files changed, 25 insertions(+), 54 deletions(-)

diff --git a/testcases/kernel/syscalls/keyctl/Makefile b/testcases/kernel/syscalls/keyctl/Makefile
index bb3d3a4..9ccb357 100644
--- a/testcases/kernel/syscalls/keyctl/Makefile
+++ b/testcases/kernel/syscalls/keyctl/Makefile
@@ -18,9 +18,9 @@
 
 top_srcdir		?= ../../../..
 
-keyctl02: LDLIBS	+=-lpthread $(KEYUTILS_LIBS)
-keyctl03: LDLIBS	+=$(KEYUTILS_LIBS)
-
 include $(top_srcdir)/include/mk/testcases.mk
 
+LDLIBS	+= $(KEYUTILS_LIBS)
+keyctl02: LDLIBS	+= -lpthread
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
index 30d51bd..5719d55 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl01.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
@@ -28,31 +28,25 @@
 #include <stdint.h>
 
 #include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "lapi/keyctl.h"
 
-typedef int32_t key_serial_t;
-
 static void do_test(void)
 {
 	key_serial_t key;
 
-	TEST(tst_syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
-		KEY_SPEC_USER_SESSION_KEYRING));
-
+	TEST(keyctl(KEYCTL_GET_KEYRING_ID, KEY_SPEC_USER_SESSION_KEYRING));
 	if (TEST_RETURN != -1)
 		tst_res(TPASS, "KEYCTL_GET_KEYRING_ID succeeded");
 	else
 		tst_res(TFAIL | TTERRNO, "KEYCTL_GET_KEYRING_ID failed");
 
 	for (key = INT32_MAX; key > INT32_MIN; key--) {
-		TEST(tst_syscall(__NR_keyctl, KEYCTL_READ, key));
+		TEST(keyctl(KEYCTL_READ, key));
 		if (TEST_RETURN == -1 && TEST_ERRNO == ENOKEY)
 			break;
 	}
 
-	TEST(tst_syscall(__NR_keyctl, KEYCTL_REVOKE, key));
-
+	TEST(keyctl(KEYCTL_REVOKE, key));
 	if (TEST_RETURN != -1) {
 		tst_res(TFAIL, "KEYCTL_REVOKE succeeded unexpectedly");
 		return;
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index b783bf7..515da96 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -35,17 +35,13 @@
  *  KEYS: Fix race between read and revoke
  */
 
-#include "config.h"
 #include <errno.h>
 #include <pthread.h>
 #include <sys/types.h>
-#ifdef HAVE_KEYUTILS_H
-# include <keyutils.h>
-#endif
+
 #include "tst_safe_pthread.h"
 #include "tst_test.h"
-
-#ifdef HAVE_KEYUTILS_H
+#include "lapi/keyctl.h"
 
 #define LOOPS	20000
 #define PATH_KEY_COUNT_QUOTA	"/proc/sys/kernel/keys/root_maxkeys"
@@ -119,7 +115,3 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = do_test,
 };
-
-#else
-	TST_TEST_TCONF("keyutils.h does not exist");
-#endif /* HAVE_KEYUTILS_H */
diff --git a/testcases/kernel/syscalls/keyctl/keyctl03.c b/testcases/kernel/syscalls/keyctl/keyctl03.c
index 41d062e..5c066f7 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl03.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl03.c
@@ -28,15 +28,11 @@
  *        an uninstantiated keyring
  */
 
-#include "config.h"
 #include <errno.h>
 #include <sys/types.h>
-#ifdef HAVE_KEYUTILS_H
-# include <keyutils.h>
-#endif
-#include "tst_test.h"
 
-#ifdef HAVE_KEYUTILS_H
+#include "tst_test.h"
+#include "lapi/keyctl.h"
 
 static void do_test(void)
 {
@@ -58,7 +54,3 @@ static void do_test(void)
 static struct tst_test test = {
 	.test_all = do_test,
 };
-
-#else
-	TST_TEST_TCONF("keyutils.h does not exist");
-#endif /* HAVE_KEYUTILS_H */
diff --git a/testcases/kernel/syscalls/keyctl/keyctl04.c b/testcases/kernel/syscalls/keyctl/keyctl04.c
index 3fef1ea..be9ceeb 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl04.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl04.c
@@ -26,29 +26,25 @@
  * keyring was leaked).
  */
 
+#include <errno.h>
+
 #include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "lapi/keyctl.h"
 
-typedef int32_t key_serial_t;
-
 static void do_test(void)
 {
 	key_serial_t tid_keyring;
 
-	TEST(tst_syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
-			 KEY_SPEC_THREAD_KEYRING, 1));
+	TEST(keyctl(KEYCTL_GET_KEYRING_ID, KEY_SPEC_THREAD_KEYRING, 1));
 	if (TEST_RETURN < 0)
 		tst_brk(TBROK | TTERRNO, "failed to create thread keyring");
 	tid_keyring = TEST_RETURN;
 
-	TEST(tst_syscall(__NR_keyctl, KEYCTL_SET_REQKEY_KEYRING,
-			 KEY_REQKEY_DEFL_THREAD_KEYRING));
+	TEST(keyctl(KEYCTL_SET_REQKEY_KEYRING, KEY_REQKEY_DEFL_THREAD_KEYRING));
 	if (TEST_RETURN < 0)
 		tst_brk(TBROK | TTERRNO, "failed to set reqkey keyring");
 
-	TEST(tst_syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
-			 KEY_SPEC_THREAD_KEYRING, 0));
+	TEST(keyctl(KEYCTL_GET_KEYRING_ID, KEY_SPEC_THREAD_KEYRING, 0));
 	if (TEST_RETURN < 0)
 		tst_brk(TBROK | TTERRNO, "failed to get thread keyring ID");
 	if (TEST_RETURN == tid_keyring)
diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index 922d2b4..9ba6120 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -37,13 +37,12 @@
  *    laid out the crash may not actually occur.
  */
 
+#include <errno.h>
 #include <stdlib.h>
+
 #include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "lapi/keyctl.h"
 
-typedef int32_t key_serial_t;
-
 #define KEY_POS_WRITE	0x04000000
 #define KEY_POS_ALL	0x3f000000
 
@@ -89,7 +88,7 @@ static const char x509_cert[] =
 
 static void new_session_keyring(void)
 {
-	TEST(tst_syscall(__NR_keyctl, KEYCTL_JOIN_SESSION_KEYRING, NULL));
+	TEST(keyctl(KEYCTL_JOIN_SESSION_KEYRING, NULL));
 	if (TEST_RETURN < 0)
 		tst_brk(TBROK | TTERRNO, "failed to join new session keyring");
 }
@@ -101,8 +100,7 @@ static void test_update_nonupdatable(const char *type,
 
 	new_session_keyring();
 
-	TEST(tst_syscall(__NR_add_key, type, "desc", payload, plen,
-			 KEY_SPEC_SESSION_KEYRING));
+	TEST(add_key(type, "desc", payload, plen, KEY_SPEC_SESSION_KEYRING));
 	if (TEST_RETURN < 0) {
 		if (TEST_ERRNO == ENODEV) {
 			tst_res(TCONF, "kernel doesn't support key type '%s'",
@@ -130,7 +128,7 @@ static void test_update_nonupdatable(const char *type,
 	 * Non-updatable keys don't start with write permission, so we must
 	 * explicitly grant it.
 	 */
-	TEST(tst_syscall(__NR_keyctl, KEYCTL_SETPERM, keyid, KEY_POS_ALL));
+	TEST(keyctl(KEYCTL_SETPERM, keyid, KEY_POS_ALL));
 	if (TEST_RETURN != 0) {
 		tst_res(TBROK | TTERRNO,
 			"failed to grant write permission to '%s' key", type);
@@ -138,7 +136,7 @@ static void test_update_nonupdatable(const char *type,
 	}
 
 	tst_res(TINFO, "Try to update the '%s' key...", type);
-	TEST(tst_syscall(__NR_keyctl, KEYCTL_UPDATE, keyid, payload, plen));
+	TEST(keyctl(KEYCTL_UPDATE, keyid, payload, plen));
 	if (TEST_RETURN == 0) {
 		tst_res(TBROK,
 			"updating '%s' key unexpectedly succeeded", type);
@@ -165,8 +163,8 @@ static void test_update_setperm_race(void)
 
 	new_session_keyring();
 
-	TEST(tst_syscall(__NR_add_key, "user", "desc", payload, sizeof(payload),
-			 KEY_SPEC_SESSION_KEYRING));
+	TEST(add_key("user", "desc", payload, sizeof(payload),
+		KEY_SPEC_SESSION_KEYRING));
 	if (TEST_RETURN < 0) {
 		tst_res(TBROK | TTERRNO, "failed to add 'user' key");
 		return;
@@ -178,7 +176,7 @@ static void test_update_setperm_race(void)
 
 		for (i = 0; i < 10000; i++) {
 			perm ^= KEY_POS_WRITE;
-			TEST(syscall(__NR_keyctl, KEYCTL_SETPERM, keyid, perm));
+			TEST(keyctl(KEYCTL_SETPERM, keyid, perm));
 			if (TEST_RETURN != 0)
 				tst_brk(TBROK | TTERRNO, "setperm failed");
 		}
@@ -187,8 +185,7 @@ static void test_update_setperm_race(void)
 
 	tst_res(TINFO, "Try to update the 'user' key...");
 	for (i = 0; i < 10000; i++) {
-		TEST(tst_syscall(__NR_keyctl, KEYCTL_UPDATE, keyid,
-				 payload, sizeof(payload)));
+		TEST(keyctl(KEYCTL_UPDATE, keyid, payload, sizeof(payload)));
 		if (TEST_RETURN != 0 && TEST_ERRNO != EACCES) {
 			tst_res(TBROK | TTERRNO, "failed to update 'user' key");
 			return;
-- 
2.9.4



