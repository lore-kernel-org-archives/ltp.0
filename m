From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Oct 2018 15:10:02 +0200
Subject: [LTP] [PATCH v2] syscalls/keyctl02: wait for last key to be garbage
	collected
Message-ID: <79fc54a1540ed236a5539d9f848cc18045aa6c4d.1539781539.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: #409

This tests creates a lot of keys, which are revoked, but they may
not all be destroyed by the time test finishes. This can create
problems for subsequent tests which will hit quota limit and fail.

This patch adds loop, that periodically sleeps and checks if last
test key has been garbage collected yet.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/lapi/keyctl.h                       |  4 +++
 testcases/kernel/syscalls/keyctl/keyctl02.c | 39 ++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 3 deletions(-)

Changes in v2:
  - drop KEYCTL_INVALIDATE ifdef
  - add KEYCTL_INVALIDATE to lapi/...
  - check for EOPNOTSUPP when using KEYCTL_INVALIDATE
  - tested as far back as 2.6.32

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 8ad8db64fad8..9f5892e06858 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -148,6 +148,10 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_SET_TIMEOUT 15
 #endif
 
+#ifndef KEYCTL_INVALIDATE
+# define KEYCTL_INVALIDATE 21
+#endif
+
 /* key permissions */
 #ifndef KEY_POS_VIEW
 # define KEY_POS_VIEW    0x01000000
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index 515da96e3b2c..3d43577cfe13 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -44,6 +44,7 @@
 #include "lapi/keyctl.h"
 
 #define LOOPS	20000
+#define MAX_WAIT_FOR_GC_MS 5000
 #define PATH_KEY_COUNT_QUOTA	"/proc/sys/kernel/keys/root_maxkeys"
 
 static int orig_maxkeys;
@@ -69,8 +70,8 @@ static void *do_revoke(void *arg)
 
 static void do_test(void)
 {
-	int i;
-	key_serial_t key;
+	int i, ret;
+	key_serial_t key, key_inv;
 	pthread_t pth[4];
 
 	for (i = 0; i < LOOPS; i++) {
@@ -94,13 +95,45 @@ static void do_test(void)
 		SAFE_PTHREAD_JOIN(pth[3], NULL);
 	}
 
+	/*
+	 * Kernel should start garbage collect when last reference to key
+	 * is removed (see key_put()). Since we are adding keys with identical
+	 * description and type, each replacement should schedule a gc run,
+	 * see comment@__key_link().
+	 *
+	 * We create extra key here, to remove reference to last revoked key.
+	 */
+	key_inv = add_key("user", "ltptestkey", "foo", 3,
+		KEY_SPEC_PROCESS_KEYRING);
+	if (key_inv == -1)
+		tst_brk(TBROK | TERRNO, "Failed to add key");
+
+	/*
+	 * If we have invalidate, we can drop extra key immediately as well,
+	 * which also schedules gc.
+	 */
+	if (keyctl(KEYCTL_INVALIDATE, key_inv) == -1 && errno != EOPNOTSUPP)
+		tst_brk(TBROK | TERRNO, "Failed to invalidate key");
+
+	/*
+	 * At this point we are quite confident that gc has been scheduled,
+	 * so we wait and periodically check for last test key to be removed.
+	 */
+	for (i = 0; i < MAX_WAIT_FOR_GC_MS; i += 100) {
+		ret = keyctl(KEYCTL_REVOKE, key);
+		if (ret == -1 && errno == ENOKEY)
+			break;
+		usleep(100*1000);
+	}
+
+	tst_res(TINFO, "waiting for key gc took: %d ms", i);
 	tst_res(TPASS, "Bug not reproduced");
 }
 
 static void setup(void)
 {
 	SAFE_FILE_SCANF(PATH_KEY_COUNT_QUOTA, "%d", &orig_maxkeys);
-	SAFE_FILE_PRINTF(PATH_KEY_COUNT_QUOTA, "%d", orig_maxkeys + LOOPS);
+	SAFE_FILE_PRINTF(PATH_KEY_COUNT_QUOTA, "%d", orig_maxkeys + LOOPS + 1);
 }
 
 static void cleanup(void)
-- 
1.8.3.1

