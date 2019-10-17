From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 17 Oct 2019 23:16:12 +0200
Subject: [LTP] [COMMITTED][PATCH 1/1] fanotify: Fix missing __kernel_fsid_t
 definition
Message-ID: <20191017211612.19090-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

which is needed for fallback definition when FAN_REPORT_FID is missing.
Instead of including <asm/posix_types.h> where it's defined we just
define the missing bit.

This fixes build error at least on musl.

Acked-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Jan Stancek <jstancek@redhat.com>
Suggested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 1c7623d3b..435f100d8 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -126,6 +126,13 @@ struct fanotify_event_info_header {
 };
 
 #ifdef HAVE_NAME_TO_HANDLE_AT
+#ifndef __kernel_fsid_t
+typedef struct {
+	int	val[2];
+} lapi_fsid_t;
+#define __kernel_fsid_t lapi_fsid_t
+#endif
+
 struct fanotify_event_info_fid {
 	struct fanotify_event_info_header hdr;
 	__kernel_fsid_t fsid;
-- 
2.23.0

