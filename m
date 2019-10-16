From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 16 Oct 2019 23:15:01 +0200
Subject: [LTP] [PATCH 1/1] fanotify: Fix missing __kernel_fsid_t definition
Message-ID: <20191016211501.3777-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

which is missing at least on musl which doesn't have FAN_REPORT_FID
support.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 1c7623d3b..01a2d52bd 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -35,6 +35,10 @@
 #include <errno.h>
 #include <fcntl.h>
 
+#if !defined(FAN_REPORT_FID) && defined(HAVE_NAME_TO_HANDLE_AT)
+#include <asm/posix_types.h> // __kernel_fsid_t
+#endif
+
 #if defined(HAVE_SYS_FANOTIFY_H)
 
 #include <sys/fanotify.h>
-- 
2.23.0

