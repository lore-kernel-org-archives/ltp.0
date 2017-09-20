From: Steve Muckle <smuckle.linux@gmail.com>
Date: Wed, 20 Sep 2017 13:23:06 -0700
Subject: [LTP]  [PATCH] lib/tst_test: avoid cleanup by cloned test threads
Message-ID: <20170920202306.170298-1-smuckle.linux@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some versions of glibc and bionic report the same PID for parent and
child when clone() is called with CLONE_VM but not CLONE_THREAD. This
can cause cleanup to be incorrectly run by the child.

Avoid this by using a direct syscall for getpid when running the
cleanup.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
---
 lib/tst_test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index f72de82d4..0cc78589e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -29,6 +29,7 @@
 #include "tst_test.h"
 #include "tst_device.h"
 #include "lapi/futex.h"
+#include "lapi/syscalls.h"
 #include "tst_ansi_color.h"
 #include "tst_timer_test.h"
 
@@ -276,7 +277,13 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
 {
 	print_result(file, lineno, ttype, fmt, va);
 
-	if (getpid() == main_pid)
+	/*
+	 * The getpid implementation in some C library versions may cause cloned
+	 * test threads to show the same pid as their parent when CLONE_VM is
+	 * specified but CLONE_THREAD is not. Use direct syscall to avoid
+	 * cleanup running in the child.
+	 */
+	if (syscall(SYS_getpid) == main_pid)
 		do_test_cleanup();
 
 	if (getpid() == lib_pid)
-- 
2.14.1.821.g8fa685d3b7-goog

