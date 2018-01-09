From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue,  9 Jan 2018 14:08:45 -0800
Subject: [LTP] [PATCH v2 1/2] lapi/keyctl.h: add key permission constants
Message-ID: <20180109220846.211823-1-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Add the key permission constants to keyctl.h so that they don't have to
be defined in each test that uses them.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/lapi/keyctl.h                       | 35 +++++++++++++++++++++++++++++
 testcases/kernel/syscalls/keyctl/keyctl05.c |  3 ---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 4b8098a59..5f6ddaae3 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -144,4 +144,39 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_SET_TIMEOUT 15
 #endif
 
+/* key permissions */
+#ifndef KEY_POS_VIEW
+# define KEY_POS_VIEW    0x01000000
+# define KEY_POS_READ    0x02000000
+# define KEY_POS_WRITE   0x04000000
+# define KEY_POS_SEARCH  0x08000000
+# define KEY_POS_LINK    0x10000000
+# define KEY_POS_SETATTR 0x20000000
+# define KEY_POS_ALL     0x3f000000
+
+# define KEY_USR_VIEW    0x00010000
+# define KEY_USR_READ    0x00020000
+# define KEY_USR_WRITE   0x00040000
+# define KEY_USR_SEARCH  0x00080000
+# define KEY_USR_LINK    0x00100000
+# define KEY_USR_SETATTR 0x00200000
+# define KEY_USR_ALL     0x003f0000
+
+# define KEY_GRP_VIEW    0x00000100
+# define KEY_GRP_READ    0x00000200
+# define KEY_GRP_WRITE   0x00000400
+# define KEY_GRP_SEARCH  0x00000800
+# define KEY_GRP_LINK    0x00001000
+# define KEY_GRP_SETATTR 0x00002000
+# define KEY_GRP_ALL     0x00003f00
+
+# define KEY_OTH_VIEW    0x00000001
+# define KEY_OTH_READ    0x00000002
+# define KEY_OTH_WRITE   0x00000004
+# define KEY_OTH_SEARCH  0x00000008
+# define KEY_OTH_LINK    0x00000010
+# define KEY_OTH_SETATTR 0x00000020
+# define KEY_OTH_ALL     0x0000003f
+#endif /* !KEY_POS_VIEW */
+
 #endif	/* KEYCTL_H__ */
diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index 9ba61200c..c04d1f5b0 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -43,9 +43,6 @@
 #include "tst_test.h"
 #include "lapi/keyctl.h"
 
-#define KEY_POS_WRITE	0x04000000
-#define KEY_POS_ALL	0x3f000000
-
 /*
  * A valid payload for the "asymmetric" key type.  This is an x509 certificate
  * in DER format, generated using:
-- 
2.16.0.rc1.238.g530d649a79-goog

