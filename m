From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 28 Mar 2019 17:36:47 +0800
Subject: [LTP] [PATCH 2/2] syscalls/stime: detect if libc stime() is
	implemented dynamically
In-Reply-To: <1553765807-31789-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1553765807-31789-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1553765807-31789-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Don't alway skip libc stime() for Android, because bionic(Android libc)
may implement it in the future.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 m4/ltp-libc-funcs.m4                        | 2 +-
 testcases/kernel/syscalls/stime/stime_var.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/m4/ltp-libc-funcs.m4 b/m4/ltp-libc-funcs.m4
index ebbe2c9..122073f 100644
--- a/m4/ltp-libc-funcs.m4
+++ b/m4/ltp-libc-funcs.m4
@@ -10,5 +10,5 @@ dnl
 AC_DEFUN([LTP_CHECK_LIBC_FUNCS],[
 AC_CHECK_FUNCS(epoll_pwait execveat fallocate fchownat fstatat kcmp mkdirat \
 mknodat openat preadv preadv2 pwritev pwritev2 readlinkat renameat renameat2 \
-splice syncfs sync_file_range tee unshare vmsplice,,)
+splice stime syncfs sync_file_range tee unshare vmsplice,,)
 ])
diff --git a/testcases/kernel/syscalls/stime/stime_var.h b/testcases/kernel/syscalls/stime/stime_var.h
index b014f0a..48d46b3 100644
--- a/testcases/kernel/syscalls/stime/stime_var.h
+++ b/testcases/kernel/syscalls/stime/stime_var.h
@@ -8,6 +8,7 @@
 #define STIME_VAR__
 
 #include <sys/time.h>
+#include "config.h"
 #include "lapi/syscalls.h"
 
 #define TEST_VARIANTS 3
@@ -16,8 +17,8 @@ static int do_stime(time_t *ntime)
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
-- 
1.8.3.1



