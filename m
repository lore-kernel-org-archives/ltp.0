From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Apr 2017 14:06:44 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/2] Revert "lib: Fix undefined reference
	to `mq_open' build failures"
Message-ID: <20170410120645.21076-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This reverts commit fcfb6970002454cfa29cf679a82ba92c94fb59e0.

I've misunderstand how __attribute__((weak)) is supposed to work. The
problem here is that we link statically against the libltp library and
hence dynamic linker does not even try to resolve the library internal
weak mq_open symbol and we end up using the stub regardless if we linked
the library with -lrt or not.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_safe_posix_ipc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/tst_safe_posix_ipc.c b/lib/tst_safe_posix_ipc.c
index 15f58c5..7142a25 100644
--- a/lib/tst_safe_posix_ipc.c
+++ b/lib/tst_safe_posix_ipc.c
@@ -22,13 +22,6 @@
 #include "tst_test.h"
 #include "tst_safe_posix_ipc.h"
 
-mqd_t __attribute__((weak)) mq_open(const char *name __attribute__((unused)),
-				    int oflag __attribute__((unused)), ...)
-{
-	tst_brk(TBROK, "mq_open() stub called! Missing -lrt in LDFLAGS?");
-	return 0;
-}
-
 int safe_mq_open(const char *file, const int lineno, const char *pathname,
 	int oflags, ...)
 {
-- 
2.10.2

