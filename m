From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 13 Nov 2019 01:56:25 +0100
Subject: [LTP] [PATCH v2 2/3] fanotify: Rework checks for fallback
 definitions
In-Reply-To: <20191113005626.19585-1-petr.vorel@gmail.com>
References: <20191113005626.19585-1-petr.vorel@gmail.com>
Message-ID: <20191113005626.19585-3-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add autoconf checks for struct fanotify_event_info_fid
and struct fanotify_event_info_header.

Instead of detecting via FAN_REPORT_FID or HAVE_NAME_TO_HANDLE_AT.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Changes v1->v2:
New commit.

 configure.ac                                  |  1 +
 m4/ltp-fanotify.m4                            |  7 +++++++
 testcases/kernel/syscalls/fanotify/fanotify.h | 14 ++++++++------
 3 files changed, 16 insertions(+), 6 deletions(-)
 create mode 100644 m4/ltp-fanotify.m4

diff --git a/configure.ac b/configure.ac
index 62c5a0bb4..71738b72d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -212,6 +212,7 @@ LTP_CHECK_CAPABILITY_SUPPORT
 LTP_CHECK_CC_WARN_OLDSTYLE
 LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 LTP_CHECK_CRYPTO
+LTP_CHECK_FANOTIFY
 LTP_CHECK_FIDEDUPE
 LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_FTS_H
diff --git a/m4/ltp-fanotify.m4 b/m4/ltp-fanotify.m4
new file mode 100644
index 000000000..e7b77d8a4
--- /dev/null
+++ b/m4/ltp-fanotify.m4
@@ -0,0 +1,7 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
+
+AC_DEFUN([LTP_CHECK_FANOTIFY],[
+AC_CHECK_TYPES([struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
+AC_CHECK_TYPES([struct fanotify_event_info_fid],,,[#include <sys/fanotify.h>])
+])
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 573ed5f59..9d2fded13 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -101,6 +101,10 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 #define FAN_OPEN_EXEC_PERM	0x00040000
 #endif
 
+#ifndef FAN_REPORT_FID
+#define FAN_REPORT_FID		0x00000200
+#endif
+
 /*
  * FAN_ALL_PERM_EVENTS has been deprecated, so any new permission events
  * are not to be added to it. To cover the instance where a new permission
@@ -123,23 +127,21 @@ typedef struct {
 #define __kernel_fsid_t lapi_fsid_t
 #endif /* __kernel_fsid_t */
 
-#ifndef FAN_REPORT_FID
-#define FAN_REPORT_FID		0x00000200
-
+#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
 struct fanotify_event_info_header {
 	uint8_t info_type;
 	uint8_t pad;
 	uint16_t len;
 };
+#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER */
 
-#ifdef HAVE_NAME_TO_HANDLE_AT
+#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID
 struct fanotify_event_info_fid {
 	struct fanotify_event_info_header hdr;
 	__kernel_fsid_t fsid;
 	unsigned char handle[0];
 };
-#endif /* HAVE_NAME_TO_HANDLE_AT */
-#endif /* ! FAN_REPORT_FID */
+#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
 
 #ifdef HAVE_NAME_TO_HANDLE_AT
 /*
-- 
2.24.0

