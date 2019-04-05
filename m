From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 5 Apr 2019 16:07:39 +0800
Subject: [LTP] [PATCH v3 2/3] syscalls/stime: Add libc stime() detection
In-Reply-To: <1554451660-30245-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1554451660-30245-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1554451660-30245-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Don't alway skip libc stime() for Android because bionic(Android libc)
may implement it in the future.

Also add break to fix potential compiler warnings.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 configure.ac                                | 1 +
 testcases/kernel/syscalls/stime/stime_var.h | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index bc5ba74..4208ae7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -78,6 +78,7 @@ AC_CHECK_FUNCS([ \
     renameat \
     renameat2 \
     splice \
+    stime \
     syncfs \
     sync_file_range \
     tee \
diff --git a/testcases/kernel/syscalls/stime/stime_var.h b/testcases/kernel/syscalls/stime/stime_var.h
index b014f0a..342f762 100644
--- a/testcases/kernel/syscalls/stime/stime_var.h
+++ b/testcases/kernel/syscalls/stime/stime_var.h
@@ -8,6 +8,7 @@
 #define STIME_VAR__
 
 #include <sys/time.h>
+#include "config.h"
 #include "lapi/syscalls.h"
 
 #define TEST_VARIANTS 3
@@ -16,11 +17,12 @@ static int do_stime(time_t *ntime)
 {
 	switch (tst_variant) {
 	case 0:
-#ifdef __ANDROID__
-		tst_brk(TCONF, "libc stime() is not implemented on Android");
+#ifndef HAVE_STIME
+		tst_brk(TCONF, "libc stime() is not implemented");
 #else
 		return stime(ntime);
 #endif
+		break;
 	case 1:
 		return tst_syscall(__NR_stime, ntime);
 	case 2: {
-- 
1.8.3.1



