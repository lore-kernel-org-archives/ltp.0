From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 6 Sep 2017 17:56:22 +0800
Subject: [LTP] [PATCH 2/3] syscalls/add_key: Make use of lapi/keyctl.h
In-Reply-To: <20170906095623.10358-1-fenggw-fnst@cn.fujitsu.com>
References: <20170906095623.10358-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170906095623.10358-2-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/add_key/Makefile    |  2 ++
 testcases/kernel/syscalls/add_key/add_key01.c | 18 ++++--------------
 testcases/kernel/syscalls/add_key/add_key02.c | 18 +++++-------------
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/testcases/kernel/syscalls/add_key/Makefile b/testcases/kernel/syscalls/add_key/Makefile
index 2ef86f0..c3e9ac1 100644
--- a/testcases/kernel/syscalls/add_key/Makefile
+++ b/testcases/kernel/syscalls/add_key/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+LDLIBS  += $(KEYUTILS_LIBS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/add_key/add_key01.c b/testcases/kernel/syscalls/add_key/add_key01.c
index ac561d7..6756702 100644
--- a/testcases/kernel/syscalls/add_key/add_key01.c
+++ b/testcases/kernel/syscalls/add_key/add_key01.c
@@ -24,28 +24,18 @@
  *	      Manas Kumar Nayak maknayak@in.ibm.com>
  */
 
-#include "config.h"
-#ifdef HAVE_LINUX_KEYCTL_H
-# include <linux/keyctl.h>
-#endif
+#include <errno.h>
+
 #include "tst_test.h"
-#include "lapi/syscalls.h"
+#include "lapi/keyctl.h"
 
 static void verify_add_key(void)
 {
-#ifdef HAVE_LINUX_KEYCTL_H
-
-	TEST(tst_syscall(__NR_add_key, "keyring", "wjkey", NULL, 0,
-	                 KEY_SPEC_THREAD_KEYRING));
-
+	TEST(add_key("keyring", "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING));
 	if (TEST_RETURN == -1)
 		tst_res(TFAIL | TTERRNO, "add_key call failed");
 	else
 		tst_res(TPASS, "add_key call succeeded");
-
-#else
-	tst_brk(TCONF, "linux/keyctl.h was missing upon compilation.");
-#endif /* HAVE_LINUX_KEYCTL_H */
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index a742824..ce46730 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -32,14 +32,11 @@
  * than dereferencing NULL.
  */
 
-#include "config.h"
-#ifdef HAVE_LINUX_KEYCTL_H
-# include <linux/keyctl.h>
-#endif
+#include <errno.h>
+
 #include "tst_test.h"
-#include "lapi/syscalls.h"
+#include "lapi/keyctl.h"
 
-#ifdef HAVE_LINUX_KEYCTL_H
 struct tcase {
 	const char *type;
 	size_t plen;
@@ -58,13 +55,11 @@ struct tcase {
 	{ "user",		64 },
 	{ "logon",              64 },
 };
-#endif /* HAVE_LINUX_KEYCTL_H */
 
 static void verify_add_key(unsigned int i)
 {
-#ifdef HAVE_LINUX_KEYCTL_H
-	TEST(tst_syscall(__NR_add_key, tcases[i].type, "abc:def",
-			 NULL, tcases[i].plen, KEY_SPEC_PROCESS_KEYRING));
+	TEST(add_key(tcases[i].type,
+		"abc:def", NULL, tcases[i].plen, KEY_SPEC_PROCESS_KEYRING));
 
 	if (TEST_RETURN != -1) {
 		tst_res(TFAIL,
@@ -97,9 +92,6 @@ static void verify_add_key(unsigned int i)
 
 	tst_res(TFAIL | TTERRNO, "unexpected error with key type '%s'",
 		tcases[i].type);
-#else
-	tst_brk(TCONF, "linux/keyctl.h was missing upon compilation.");
-#endif /* HAVE_LINUX_KEYCTL_H */
 }
 
 static struct tst_test test = {
-- 
2.9.4



