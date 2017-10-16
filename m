From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Oct 2017 17:41:52 +0200
Subject: [LTP] [PATCH v4 01/14] lapi/keyctl.h: Add doc and reorder
	definitions
In-Reply-To: <20171016154205.4814-1-pvorel@suse.cz>
References: <20171016154205.4814-1-pvorel@suse.cz>
Message-ID: <20171016154205.4814-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/keyctl.h | 55 +++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 73f4fdc90..f3fb0c347 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -65,12 +65,35 @@ static inline long keyctl(int cmd, ...)
 }
 #endif /* HAVE_KEYUTILS_H */
 
-#ifndef KEYCTL_GET_KEYRING_ID
-# define KEYCTL_GET_KEYRING_ID 0
+/* special process keyring shortcut IDs */
+#ifndef KEY_SPEC_THREAD_KEYRING
+# define KEY_SPEC_THREAD_KEYRING -1
 #endif
 
-#ifndef KEYCTL_SET_REQKEY_KEYRING
-# define KEYCTL_SET_REQKEY_KEYRING 14
+#ifndef KEY_SPEC_PROCESS_KEYRING
+# define KEY_SPEC_PROCESS_KEYRING -2
+#endif
+
+#ifndef KEY_SPEC_SESSION_KEYRING
+# define KEY_SPEC_SESSION_KEYRING -3
+#endif
+
+#ifndef KEY_SPEC_USER_KEYRING
+# define KEY_SPEC_USER_KEYRING -4
+#endif
+
+
+#ifndef KEY_SPEC_USER_SESSION_KEYRING
+# define KEY_SPEC_USER_SESSION_KEYRING -5
+#endif
+/* request-key default keyrings */
+#ifndef KEY_REQKEY_DEFL_THREAD_KEYRING
+# define KEY_REQKEY_DEFL_THREAD_KEYRING 1
+#endif
+
+/* keyctl commands */
+#ifndef KEYCTL_GET_KEYRING_ID
+# define KEYCTL_GET_KEYRING_ID 0
 #endif
 
 #ifndef KEYCTL_JOIN_SESSION_KEYRING
@@ -97,28 +120,8 @@ static inline long keyctl(int cmd, ...)
 # define KEYCTL_READ 11
 #endif
 
-#ifndef KEY_SPEC_THREAD_KEYRING
-# define KEY_SPEC_THREAD_KEYRING -1
-#endif
-
-#ifndef KEY_SPEC_PROCESS_KEYRING
-# define KEY_SPEC_PROCESS_KEYRING -2
-#endif
-
-#ifndef KEY_SPEC_SESSION_KEYRING
-# define KEY_SPEC_SESSION_KEYRING -3
-#endif
-
-#ifndef KEY_SPEC_USER_KEYRING
-# define KEY_SPEC_USER_KEYRING -4
-#endif
-
-#ifndef KEY_SPEC_USER_SESSION_KEYRING
-# define KEY_SPEC_USER_SESSION_KEYRING -5
-#endif
-
-#ifndef KEY_REQKEY_DEFL_THREAD_KEYRING
-# define KEY_REQKEY_DEFL_THREAD_KEYRING 1
+#ifndef KEYCTL_SET_REQKEY_KEYRING
+# define KEYCTL_SET_REQKEY_KEYRING 14
 #endif
 
 #endif	/* KEYCTL_H__ */
-- 
2.14.2

