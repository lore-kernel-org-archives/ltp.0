From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Oct 2017 20:33:21 +0200
Subject: [LTP] [PATCH v3 04/18] lapi/keyctl.h: Add doc and reorder
	definitions
In-Reply-To: <20171012183335.24568-1-pvorel@suse.cz>
References: <20171012183335.24568-1-pvorel@suse.cz>
Message-ID: <20171012183335.24568-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/keyctl.h | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 3e7ce4708..021d94868 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -65,12 +65,23 @@ static inline long keyctl(int cmd, ...)
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
+#ifndef KEY_SPEC_SESSION_KEYRING
+# define KEY_SPEC_SESSION_KEYRING -3
+#endif
+
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
@@ -89,16 +100,8 @@ static inline long keyctl(int cmd, ...)
 # define KEYCTL_UNLINK 9
 #endif
 
-#ifndef KEY_SPEC_THREAD_KEYRING
-# define KEY_SPEC_THREAD_KEYRING -1
-#endif
-
-#ifndef KEY_SPEC_SESSION_KEYRING
-# define KEY_SPEC_SESSION_KEYRING -3
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

