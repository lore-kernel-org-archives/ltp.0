From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 24 Aug 2017 21:28:18 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/keyctl: Make use of lapi/keyctl.h &&
	Add existing test to runtest/cve
In-Reply-To: <20170824132818.14260-1-fenggw-fnst@cn.fujitsu.com>
References: <ac931c16-d892-fb72-0ac5-83655c116cad@cn.fujitsu.com>
 <20170824132818.14260-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170824132818.14260-2-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1.syscalls/keyctl02 and syscalls/keyctl03 make use of lapi/keyctl.h

2.syscalls/keyctl0* use keyutils.h fallback definition in lapi/keyctl.h
  instead of raw syscall, thus we would test the keyutils library if the
  header is present and these tests will not be disabled otherwise.

3.Add syscalls/keyctl02 and commands/keyctl01 to the CVE runtest file as
  cve-2015-7550 and cve-2016-4470 respectively.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/cve                                 |  2 ++
 testcases/kernel/syscalls/keyctl/Makefile   |  4 ++--
 testcases/kernel/syscalls/keyctl/keyctl01.c | 20 +++++++++++---------
 testcases/kernel/syscalls/keyctl/keyctl02.c | 16 ++++++----------
 testcases/kernel/syscalls/keyctl/keyctl03.c | 20 ++++++++++----------
 testcases/kernel/syscalls/keyctl/keyctl04.c | 20 +++++++++++---------
 testcases/kernel/syscalls/keyctl/keyctl05.c | 29 ++++++++++++++++-------------
 7 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/runtest/cve b/runtest/cve
index 468f0b2..5b16e9e 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -5,6 +5,8 @@ cve-2011-2496 vma03
 cve-2012-0957 cve-2012-0957
 cve-2014-0196 cve-2014-0196
 cve-2015-0235 gethostbyname_r01
+cve-2015-7550 keyctl02
+cve-2016-4470 keyctl01.sh
 cve-2016-4997 cve-2016-4997
 cve-2016-5195 dirtyc0w
 cve-2016-7042 cve-2016-7042
diff --git a/testcases/kernel/syscalls/keyctl/Makefile b/testcases/kernel/syscalls/keyctl/Makefile
index bb3d3a4..dd1f6b4 100644
--- a/testcases/kernel/syscalls/keyctl/Makefile
+++ b/testcases/kernel/syscalls/keyctl/Makefile
@@ -18,8 +18,8 @@
 
 top_srcdir		?= ../../../..
 
-keyctl02: LDLIBS	+=-lpthread $(KEYUTILS_LIBS)
-keyctl03: LDLIBS	+=$(KEYUTILS_LIBS)
+LDLIBS	+= $(KEYUTILS_LIBS)
+keyctl02: LDLIBS	+= -lpthread
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
index 30d51bd..345fa8c 100644
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
@@ -66,6 +60,14 @@ static void do_test(void)
 	tst_res(TPASS | TTERRNO, "KEYCTL_REVOKE failed as expected");
 }
 
+static void setup(void)
+{
+#ifndef HAVE_KEYUTILS_H
+	tst_res(TINFO, "keyutils.h does not exist, using fallback definition");
+#endif /* HAVE_KEYUTILS_H */
+}
+
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = do_test,
 };
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index b783bf7..f285212 100644
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
@@ -103,6 +99,10 @@ static void do_test(void)
 
 static void setup(void)
 {
+#ifndef HAVE_KEYUTILS_H
+	tst_res(TINFO, "keyutils.h does not exist, using fallback definition");
+#endif /* HAVE_KEYUTILS_H */
+
 	SAFE_FILE_SCANF(PATH_KEY_COUNT_QUOTA, "%d", &orig_maxkeys);
 	SAFE_FILE_PRINTF(PATH_KEY_COUNT_QUOTA, "%d", orig_maxkeys + LOOPS);
 }
@@ -119,7 +119,3 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = do_test,
 };
-
-#else
-	TST_TEST_TCONF("keyutils.h does not exist");
-#endif /* HAVE_KEYUTILS_H */
diff --git a/testcases/kernel/syscalls/keyctl/keyctl03.c b/testcases/kernel/syscalls/keyctl/keyctl03.c
index 41d062e..aa560f0 100644
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
@@ -55,10 +51,14 @@ static void do_test(void)
 		tst_res(TPASS, "Bug not reproduced");
 }
 
+static void setup(void)
+{
+#ifndef HAVE_KEYUTILS_H
+	tst_res(TINFO, "keyutils.h does not exist, using fallback definition");
+#endif /* HAVE_KEYUTILS_H */
+}
+
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = do_test,
 };
-
-#else
-	TST_TEST_TCONF("keyutils.h does not exist");
-#endif /* HAVE_KEYUTILS_H */
diff --git a/testcases/kernel/syscalls/keyctl/keyctl04.c b/testcases/kernel/syscalls/keyctl/keyctl04.c
index 3fef1ea..9a57dcf 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl04.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl04.c
@@ -27,28 +27,22 @@
  */
 
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
@@ -57,6 +51,14 @@ static void do_test(void)
 		tst_res(TFAIL, "thread keyring was leaked!");
 }
 
+static void setup(void)
+{
+#ifndef HAVE_KEYUTILS_H
+	tst_res(TINFO, "keyutils.h does not exist, using fallback definition");
+#endif /* HAVE_KEYUTILS_H */
+}
+
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = do_test,
 };
diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index 922d2b4..1ec73a8 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -39,11 +39,8 @@
 
 #include <stdlib.h>
 #include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "lapi/keyctl.h"
 
-typedef int32_t key_serial_t;
-
 #define KEY_POS_WRITE	0x04000000
 #define KEY_POS_ALL	0x3f000000
 
@@ -89,7 +86,7 @@ static const char x509_cert[] =
 
 static void new_session_keyring(void)
 {
-	TEST(tst_syscall(__NR_keyctl, KEYCTL_JOIN_SESSION_KEYRING, NULL));
+	TEST(keyctl(KEYCTL_JOIN_SESSION_KEYRING, NULL));
 	if (TEST_RETURN < 0)
 		tst_brk(TBROK | TTERRNO, "failed to join new session keyring");
 }
@@ -101,8 +98,7 @@ static void test_update_nonupdatable(const char *type,
 
 	new_session_keyring();
 
-	TEST(tst_syscall(__NR_add_key, type, "desc", payload, plen,
-			 KEY_SPEC_SESSION_KEYRING));
+	TEST(add_key(type, "desc", payload, plen, KEY_SPEC_SESSION_KEYRING));
 	if (TEST_RETURN < 0) {
 		if (TEST_ERRNO == ENODEV) {
 			tst_res(TCONF, "kernel doesn't support key type '%s'",
@@ -130,7 +126,7 @@ static void test_update_nonupdatable(const char *type,
 	 * Non-updatable keys don't start with write permission, so we must
 	 * explicitly grant it.
 	 */
-	TEST(tst_syscall(__NR_keyctl, KEYCTL_SETPERM, keyid, KEY_POS_ALL));
+	TEST(keyctl(KEYCTL_SETPERM, keyid, KEY_POS_ALL));
 	if (TEST_RETURN != 0) {
 		tst_res(TBROK | TTERRNO,
 			"failed to grant write permission to '%s' key", type);
@@ -138,7 +134,7 @@ static void test_update_nonupdatable(const char *type,
 	}
 
 	tst_res(TINFO, "Try to update the '%s' key...", type);
-	TEST(tst_syscall(__NR_keyctl, KEYCTL_UPDATE, keyid, payload, plen));
+	TEST(keyctl(KEYCTL_UPDATE, keyid, payload, plen));
 	if (TEST_RETURN == 0) {
 		tst_res(TBROK,
 			"updating '%s' key unexpectedly succeeded", type);
@@ -165,8 +161,8 @@ static void test_update_setperm_race(void)
 
 	new_session_keyring();
 
-	TEST(tst_syscall(__NR_add_key, "user", "desc", payload, sizeof(payload),
-			 KEY_SPEC_SESSION_KEYRING));
+	TEST(add_key("user", "desc", payload, sizeof(payload),
+		KEY_SPEC_SESSION_KEYRING));
 	if (TEST_RETURN < 0) {
 		tst_res(TBROK | TTERRNO, "failed to add 'user' key");
 		return;
@@ -178,7 +174,7 @@ static void test_update_setperm_race(void)
 
 		for (i = 0; i < 10000; i++) {
 			perm ^= KEY_POS_WRITE;
-			TEST(syscall(__NR_keyctl, KEYCTL_SETPERM, keyid, perm));
+			TEST(keyctl(KEYCTL_SETPERM, keyid, perm));
 			if (TEST_RETURN != 0)
 				tst_brk(TBROK | TTERRNO, "setperm failed");
 		}
@@ -187,8 +183,7 @@ static void test_update_setperm_race(void)
 
 	tst_res(TINFO, "Try to update the 'user' key...");
 	for (i = 0; i < 10000; i++) {
-		TEST(tst_syscall(__NR_keyctl, KEYCTL_UPDATE, keyid,
-				 payload, sizeof(payload)));
+		TEST(keyctl(KEYCTL_UPDATE, keyid, payload, sizeof(payload)));
 		if (TEST_RETURN != 0 && TEST_ERRNO != EACCES) {
 			tst_res(TBROK | TTERRNO, "failed to update 'user' key");
 			return;
@@ -218,8 +213,16 @@ static void do_test(unsigned int i)
 	}
 }
 
+static void setup(void)
+{
+#ifndef HAVE_KEYUTILS_H
+	tst_res(TINFO, "keyutils.h does not exist, using fallback definition");
+#endif /* HAVE_KEYUTILS_H */
+}
+
 static struct tst_test test = {
 	.tcnt = 3,
+	.setup = setup,
 	.test = do_test,
 	.forks_child = 1,
 };
-- 
2.9.4



