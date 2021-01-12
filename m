From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jan 2021 20:30:38 +0100
Subject: [LTP] [PATCH 2/3] fanotify: Fix build on undefined struct
 file_handle
In-Reply-To: <20210112193039.12506-1-pvorel@suse.cz>
References: <20210112193039.12506-1-pvorel@suse.cz>
Message-ID: <20210112193039.12506-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes error:
fanotify09.c:201:32: error: dereferencing pointer to incomplete type ?struct file_handle?
  201 |  filename = (char *)file_handle->f_handle + file_handle->handle_bytes;

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 8907db052..039379961 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -12,8 +12,8 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
-#include <fcntl.h>
 #include <sys/fanotify.h>
+#include "lapi/fcntl.h"
 
 int safe_fanotify_init(const char *file, const int lineno,
 	unsigned int flags, unsigned int event_f_flags)
-- 
2.29.2

