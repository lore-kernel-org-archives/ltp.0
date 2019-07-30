From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 30 Jul 2019 13:45:30 +0800
Subject: [LTP] [PATCH v3 2/5] m4: remove useless ltp-time.m4
In-Reply-To: <1564465533-2475-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190729144227.GA8824@dell5510>
 <1564465533-2475-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1564465533-2475-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

No testcase used these macros defined in ltp-time.m4, and these
(CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE, CLOCK_MONOTONIC_COARSE)
have been defined in lapi/posix_clocks.h. Removing it is safe.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac   |  1 -
 m4/ltp-time.m4 | 12 ------------
 2 files changed, 13 deletions(-)
 delete mode 100644 m4/ltp-time.m4

diff --git a/configure.ac b/configure.ac
index 640ba0cba..b0eddcbf8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -253,7 +253,6 @@ LTP_CHECK_SYSCALL_QUOTACTL
 LTP_CHECK_SYSCALL_SIGNALFD
 LTP_CHECK_SYSCALL_UTIMENSAT
 LTP_CHECK_TASKSTATS
-LTP_CHECK_TIME
 LTP_CHECK_TIMERFD
 test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
 LTP_CHECK_TPACKET_V3
diff --git a/m4/ltp-time.m4 b/m4/ltp-time.m4
deleted file mode 100644
index 205ba6d5a..000000000
--- a/m4/ltp-time.m4
+++ /dev/null
@@ -1,12 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Author: Ngie Cooper <yaneurabeya@gmail.com>
-
-dnl For all directly related time syscalls
-AC_DEFUN([LTP_CHECK_TIME],[
-	AC_CHECK_DECLS([CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE, CLOCK_MONOTONIC_COARSE],,,[
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-#include <time.h>
-])
-])
-- 
2.18.1



