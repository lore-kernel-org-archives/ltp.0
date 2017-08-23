From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 23 Aug 2017 19:00:32 +0800
Subject: [LTP] [PATCH 2/2] syscalls/keyctl: Make use of lapi/keyctl.h && Add
	existing test to runtest/cve
In-Reply-To: <20170823110032.1795-1-fenggw-fnst@cn.fujitsu.com>
References: <20170823110032.1795-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170823110032.1795-2-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* keyctl02 and keyctl03 make use of lapi/keyctl.h
* Add keyctl02 to the CVE runtest file as cve-2015-7550

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/cve                                 |  1 +
 testcases/kernel/syscalls/keyctl/Makefile   |  3 +--
 testcases/kernel/syscalls/keyctl/keyctl02.c | 21 ++++++++-------------
 testcases/kernel/syscalls/keyctl/keyctl03.c | 22 ++++++++++------------
 4 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/runtest/cve b/runtest/cve
index 468f0b2..602f858 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -5,6 +5,7 @@ cve-2011-2496 vma03
 cve-2012-0957 cve-2012-0957
 cve-2014-0196 cve-2014-0196
 cve-2015-0235 gethostbyname_r01
+cve-2015-7550 keyctl02
 cve-2016-4997 cve-2016-4997
 cve-2016-5195 dirtyc0w
 cve-2016-7042 cve-2016-7042
diff --git a/testcases/kernel/syscalls/keyctl/Makefile b/testcases/kernel/syscalls/keyctl/Makefile
index bb3d3a4..b3f4f9a 100644
--- a/testcases/kernel/syscalls/keyctl/Makefile
+++ b/testcases/kernel/syscalls/keyctl/Makefile
@@ -18,8 +18,7 @@
 
 top_srcdir		?= ../../../..
 
-keyctl02: LDLIBS	+=-lpthread $(KEYUTILS_LIBS)
-keyctl03: LDLIBS	+=$(KEYUTILS_LIBS)
+keyctl02: LDLIBS	+=-lpthread
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index b783bf7..73ba25a 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -35,17 +35,16 @@
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
+#include "lapi/syscalls.h"
+#include "lapi/keyctl.h"
 
-#ifdef HAVE_KEYUTILS_H
+typedef int32_t key_serial_t;
 
 #define LOOPS	20000
 #define PATH_KEY_COUNT_QUOTA	"/proc/sys/kernel/keys/root_maxkeys"
@@ -57,7 +56,7 @@ static void *do_read(void *arg)
 	key_serial_t key = (unsigned long)arg;
 	char buffer[4] = { 0 };
 
-	keyctl(KEYCTL_READ, key, buffer, 4);
+	tst_syscall(__NR_keyctl, KEYCTL_READ, key, buffer, 4);
 
 	return NULL;
 }
@@ -66,7 +65,7 @@ static void *do_revoke(void *arg)
 {
 	key_serial_t key = (unsigned long)arg;
 
-	keyctl(KEYCTL_REVOKE, key);
+	tst_syscall(__NR_keyctl, KEYCTL_REVOKE, key);
 
 	return NULL;
 }
@@ -78,8 +77,8 @@ static void do_test(void)
 	pthread_t pth[4];
 
 	for (i = 0; i < LOOPS; i++) {
-		key = add_key("user", "ltptestkey", "foo", 3,
-			KEY_SPEC_PROCESS_KEYRING);
+		key = tst_syscall(__NR_add_key, "user", "ltptestkey",
+			"foo", 3, KEY_SPEC_PROCESS_KEYRING);
 		if (key == -1)
 			tst_brk(TBROK | TERRNO, "Failed to add key");
 
@@ -119,7 +118,3 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = do_test,
 };
-
-#else
-	TST_TEST_TCONF("keyutils.h does not exist");
-#endif /* HAVE_KEYUTILS_H */
diff --git a/testcases/kernel/syscalls/keyctl/keyctl03.c b/testcases/kernel/syscalls/keyctl/keyctl03.c
index 41d062e..bdc4b29 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl03.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl03.c
@@ -28,27 +28,29 @@
  *        an uninstantiated keyring
  */
 
-#include "config.h"
 #include <errno.h>
 #include <sys/types.h>
-#ifdef HAVE_KEYUTILS_H
-# include <keyutils.h>
-#endif
+
 #include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/keyctl.h"
 
-#ifdef HAVE_KEYUTILS_H
+typedef int32_t key_serial_t;
 
 static void do_test(void)
 {
 	key_serial_t key;
 
-	key = add_key("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
+	key = tst_syscall(__NR_add_key,
+		"user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
 	if (key == -1)
 		tst_brk(TBROK, "Failed to add key");
 
-	request_key("keyring", "foo", "bar", KEY_SPEC_THREAD_KEYRING);
+	tst_syscall(__NR_request_key,
+		"keyring", "foo", "bar", KEY_SPEC_THREAD_KEYRING);
 
-	TEST(keyctl(KEYCTL_UNLINK, key, KEY_SPEC_SESSION_KEYRING));
+	TEST(tst_syscall(__NR_keyctl,
+		KEYCTL_UNLINK, key, KEY_SPEC_SESSION_KEYRING));
 	if (TEST_RETURN)
 		tst_res(TFAIL | TTERRNO, "keyctl unlink failed");
 	else
@@ -58,7 +60,3 @@ static void do_test(void)
 static struct tst_test test = {
 	.test_all = do_test,
 };
-
-#else
-	TST_TEST_TCONF("keyutils.h does not exist");
-#endif /* HAVE_KEYUTILS_H */
-- 
2.9.4



