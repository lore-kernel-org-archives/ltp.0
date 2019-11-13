From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 13 Nov 2019 01:56:24 +0100
Subject: [LTP] [PATCH v2 1/3] fanotify: Move __kernel_fsid_t definition to
 correct place
In-Reply-To: <20191113005626.19585-1-petr.vorel@gmail.com>
References: <20191113005626.19585-1-petr.vorel@gmail.com>
Message-ID: <20191113005626.19585-2-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes errors:

fanotify.h:149:55: error: unknown type name ?__kernel_fsid_t?
 static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
                                                       ^~~~~~~~~~~~~~~
fanotify13.c:47:2: error: unknown type name ?__kernel_fsid_t?
  __kernel_fsid_t fsid;

Remove #ifdef HAVE_NAME_TO_HANDLE_AT wrap of __kernel_fsid_t fallback
definition to simplify preprocessor checks.

Fixes: b8aebc835 ("fanotify: Fix missing __kernel_fsid_t definition")

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 435f100d8..573ed5f59 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -116,6 +116,13 @@ struct fanotify_mark_type {
 	const char * name;
 };
 
+#ifndef __kernel_fsid_t
+typedef struct {
+	int	val[2];
+} lapi_fsid_t;
+#define __kernel_fsid_t lapi_fsid_t
+#endif /* __kernel_fsid_t */
+
 #ifndef FAN_REPORT_FID
 #define FAN_REPORT_FID		0x00000200
 
@@ -126,20 +133,13 @@ struct fanotify_event_info_header {
 };
 
 #ifdef HAVE_NAME_TO_HANDLE_AT
-#ifndef __kernel_fsid_t
-typedef struct {
-	int	val[2];
-} lapi_fsid_t;
-#define __kernel_fsid_t lapi_fsid_t
-#endif
-
 struct fanotify_event_info_fid {
 	struct fanotify_event_info_header hdr;
 	__kernel_fsid_t fsid;
 	unsigned char handle[0];
 };
-#endif
-#endif
+#endif /* HAVE_NAME_TO_HANDLE_AT */
+#endif /* ! FAN_REPORT_FID */
 
 #ifdef HAVE_NAME_TO_HANDLE_AT
 /*
-- 
2.24.0

