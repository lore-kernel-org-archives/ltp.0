From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Mar 2017 18:50:08 +0200
Subject: [LTP] [RFC] [PATCH] lib: Fix undefined reference to `mq_open' build
	failures
Message-ID: <20170329165008.6396-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It appears that since the addition of the tst_safe_posix_ipc.c to the
test library random testcases (mostly ltp-aiodio seems to be triggering
the issue) started to fail on linking with missing reference to mq_open.

The problem is that -lrt is needed for mq_open() so this commit adds a
weak stub symbol that is used as fallback when we are compiling without
-lrt.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_safe_posix_ipc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/tst_safe_posix_ipc.c b/lib/tst_safe_posix_ipc.c
index 7142a25..4c617c8 100644
--- a/lib/tst_safe_posix_ipc.c
+++ b/lib/tst_safe_posix_ipc.c
@@ -22,6 +22,13 @@
 #include "tst_test.h"
 #include "tst_safe_posix_ipc.h"
 
+mqd_t __attribute__((weak)) mq_open(const char *name __attribute__((unused)),
+				    int oflag __attribute__((unused)), ...)
+{
+	tst_brk(TBROK, "mq_open() stub called!");
+	return 0;
+}
+
 int safe_mq_open(const char *file, const int lineno, const char *pathname,
 	int oflags, ...)
 {
-- 
2.10.2

