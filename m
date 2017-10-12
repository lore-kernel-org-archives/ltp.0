From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 12 Oct 2017 13:42:24 -0700
Subject: [LTP] [PATCH v2 1/4] lapi/keyctl.h: add a few missing definitions
In-Reply-To: <20171012204227.116510-1-ebiggers3@gmail.com>
References: <20171012204227.116510-1-ebiggers3@gmail.com>
Message-ID: <20171012204227.116510-2-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

KEYCTL_REVOKE, KEYCTL_READ, KEY_SPEC_PROCESS_KEYRING, and
KEY_SPEC_USER_SESSION_KEYRING are used by existing tests.
KEY_SPEC_USER_KEYRING will be used by an upcoming test.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/lapi/keyctl.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 3e7ce4708..73f4fdc90 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -81,6 +81,10 @@ static inline long keyctl(int cmd, ...)
 # define KEYCTL_UPDATE 2
 #endif
 
+#ifndef KEYCTL_REVOKE
+# define KEYCTL_REVOKE 3
+#endif
+
 #ifndef KEYCTL_SETPERM
 # define KEYCTL_SETPERM 5
 #endif
@@ -89,14 +93,30 @@ static inline long keyctl(int cmd, ...)
 # define KEYCTL_UNLINK 9
 #endif
 
+#ifndef KEYCTL_READ
+# define KEYCTL_READ 11
+#endif
+
 #ifndef KEY_SPEC_THREAD_KEYRING
 # define KEY_SPEC_THREAD_KEYRING -1
 #endif
 
+#ifndef KEY_SPEC_PROCESS_KEYRING
+# define KEY_SPEC_PROCESS_KEYRING -2
+#endif
+
 #ifndef KEY_SPEC_SESSION_KEYRING
 # define KEY_SPEC_SESSION_KEYRING -3
 #endif
 
+#ifndef KEY_SPEC_USER_KEYRING
+# define KEY_SPEC_USER_KEYRING -4
+#endif
+
+#ifndef KEY_SPEC_USER_SESSION_KEYRING
+# define KEY_SPEC_USER_SESSION_KEYRING -5
+#endif
+
 #ifndef KEY_REQKEY_DEFL_THREAD_KEYRING
 # define KEY_REQKEY_DEFL_THREAD_KEYRING 1
 #endif
-- 
2.15.0.rc0.271.g36b669edcc-goog

