From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jan 2021 20:30:37 +0100
Subject: [LTP] [PATCH 1/3] lapi: Move struct file_handle into lapi/fcntl.h
In-Reply-To: <20210112193039.12506-1-pvorel@suse.cz>
References: <20210112193039.12506-1-pvorel@suse.cz>
Message-ID: <20210112193039.12506-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

that way it can be used in fanotify tests
(some of use the struct, but not name_to_handle_at() syscall)
and the struct is defined in <fcntl.h> anyway.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/fcntl.h             | 10 ++++++++++
 include/lapi/name_to_handle_at.h |  9 +--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index d6665915f..ab460beb3 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -6,6 +6,7 @@
 #ifndef __LAPI_FCNTL_H__
 #define __LAPI_FCNTL_H__
 
+#include "config.h"
 #include <fcntl.h>
 #include <sys/socket.h>
 
@@ -140,4 +141,13 @@
 # define MAX_HANDLE_SZ	128
 #endif
 
+#ifndef HAVE_NAME_TO_HANDLE_AT
+struct file_handle {
+	unsigned int handle_bytes;
+	int handle_type;
+	/* File identifier.  */
+	unsigned char f_handle[0];
+};
+#endif /* HAVE_NAME_TO_HANDLE_AT */
+
 #endif /* __LAPI_FCNTL_H__ */
diff --git a/include/lapi/name_to_handle_at.h b/include/lapi/name_to_handle_at.h
index 3484133d1..275db4ae0 100644
--- a/include/lapi/name_to_handle_at.h
+++ b/include/lapi/name_to_handle_at.h
@@ -15,13 +15,6 @@
 #include "tst_test.h"
 
 #ifndef HAVE_NAME_TO_HANDLE_AT
-struct file_handle {
-	unsigned int handle_bytes;
-	int handle_type;
-	/* File identifier.  */
-	unsigned char f_handle[0];
-};
-
 static inline int name_to_handle_at(int dfd, const char *pathname,
                                     struct file_handle *handle,
                                     int *mount_id, int flags)
@@ -35,7 +28,7 @@ static inline int open_by_handle_at(int mount_fd, struct file_handle *handle,
 {
 	return tst_syscall(__NR_open_by_handle_at, mount_fd, handle, flags);
 }
-#endif
+#endif /* HAVE_NAME_TO_HANDLE_AT */
 
 /* Returns a valid pointer on success, NULL on errors */
 static inline struct file_handle *
-- 
2.29.2

