From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Oct 2017 20:33:22 +0200
Subject: [LTP] [PATCH v3 05/18] syscalls/request_key: Port to use
	lapi/keyctl.h header
In-Reply-To: <20171012183335.24568-1-pvorel@suse.cz>
References: <20171012183335.24568-1-pvorel@suse.cz>
Message-ID: <20171012183335.24568-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/keyctl.h                              | 24 ++++++++++++++++++++++
 .../kernel/syscalls/request_key/request_key01.c    | 14 +------------
 .../kernel/syscalls/request_key/request_key02.c    | 15 ++------------
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 021d94868..b48bc1a3e 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -70,15 +70,27 @@ static inline long keyctl(int cmd, ...)
 # define KEY_SPEC_THREAD_KEYRING -1
 #endif
 
+#ifndef KEY_SPEC_PROCESS_KEYRING
+# define KEY_SPEC_PROCESS_KEYRING -2
+#endif
+
 #ifndef KEY_SPEC_SESSION_KEYRING
 # define KEY_SPEC_SESSION_KEYRING -3
 #endif
 
+#ifndef KEY_SPEC_USER_SESSION_KEYRING
+#define KEY_SPEC_USER_SESSION_KEYRING -5
+#endif
+
 /* request-key default keyrings */
 #ifndef KEY_REQKEY_DEFL_THREAD_KEYRING
 # define KEY_REQKEY_DEFL_THREAD_KEYRING 1
 #endif
 
+#ifndef KEY_REQKEY_DEFL_DEFAULT
+#define KEY_REQKEY_DEFL_DEFAULT	0
+#endif
+
 /* keyctl commands */
 #ifndef KEYCTL_GET_KEYRING_ID
 # define KEYCTL_GET_KEYRING_ID 0
@@ -92,6 +104,10 @@ static inline long keyctl(int cmd, ...)
 # define KEYCTL_UPDATE 2
 #endif
 
+#ifndef KEYCTL_REVOKE
+# define KEYCTL_REVOKE 3
+#endif
+
 #ifndef KEYCTL_SETPERM
 # define KEYCTL_SETPERM 5
 #endif
@@ -100,8 +116,16 @@ static inline long keyctl(int cmd, ...)
 # define KEYCTL_UNLINK 9
 #endif
 
+#ifndef KEYCTL_READ
+# define KEYCTL_READ 11
+#endif
+
 #ifndef KEYCTL_SET_REQKEY_KEYRING
 # define KEYCTL_SET_REQKEY_KEYRING 14
 #endif
 
+#ifndef KEYCTL_SET_TIMEOUT
+#define KEYCTL_SET_TIMEOUT 15
+#endif
+
 #endif	/* KEYCTL_H__ */
diff --git a/testcases/kernel/syscalls/request_key/request_key01.c b/testcases/kernel/syscalls/request_key/request_key01.c
index d46bafac0..457466cff 100644
--- a/testcases/kernel/syscalls/request_key/request_key01.c
+++ b/testcases/kernel/syscalls/request_key/request_key01.c
@@ -25,16 +25,10 @@
 *
 */
 
-#include "config.h"
 #include <errno.h>
-#include <sys/types.h>
-#ifdef HAVE_KEYUTILS_H
-# include <keyutils.h>
-#endif
 
 #include "tst_test.h"
-
-#ifdef HAVE_KEYUTILS_H
+#include "lapi/keyctl.h"
 
 static int key;
 
@@ -64,9 +58,3 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = verify_request_key,
 };
-
-#else
-
-TST_TEST_TCONF("keyutils.h was missing at compilation");
-
-#endif /* HAVE_LINUX_KEYCTL_H */
diff --git a/testcases/kernel/syscalls/request_key/request_key02.c b/testcases/kernel/syscalls/request_key/request_key02.c
index 9bba24119..5744378d7 100644
--- a/testcases/kernel/syscalls/request_key/request_key02.c
+++ b/testcases/kernel/syscalls/request_key/request_key02.c
@@ -29,15 +29,10 @@
 *
 */
 
-#include "config.h"
 #include <errno.h>
-#include <sys/types.h>
-#ifdef HAVE_KEYUTILS_H
-# include <keyutils.h>
-#endif
-#include "tst_test.h"
 
-#ifdef HAVE_KEYUTILS_H
+#include "tst_test.h"
+#include "lapi/keyctl.h"
 
 static int key1;
 static int key2;
@@ -111,9 +106,3 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_request_key,
 };
-
-#else
-
-TST_TEST_TCONF("keyutils.h was missing at compilation");
-
-#endif /* HAVE_LINUX_KEYCTL_H */
-- 
2.14.2

