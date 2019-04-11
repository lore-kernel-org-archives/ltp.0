From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 11 Apr 2019 17:12:05 +0800
Subject: [LTP] [PATCH v2] syscalls/clock_adjtime: Fix compiler error
In-Reply-To: <20190411074640.GA1498@rei>
References: <20190411074640.GA1498@rei>
Message-ID: <1554973925-4250-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

'ADJ_OFFSET_SS_READ' 'ADJ_NANO' 'STA_NANO' and 'ADJ_MICRO' are not defined on
some old distros, so add them into a new 'include/lapi/timex.h' to fix it.

Also move ADJ_ALL macro into this new header file.

These macros are introduced by the following commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=52bfb36
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eea83d8

sys_clock_adjtime are introduced by the following commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=339dc

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/posix_clocks.h                   |  4 ---
 include/lapi/timex.h                          | 30 +++++++++++++++++++
 .../syscalls/clock_adjtime/clock_adjtime.h    |  1 +
 3 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100644 include/lapi/timex.h

diff --git a/include/lapi/posix_clocks.h b/include/lapi/posix_clocks.h
index b1f7a7c55..4914479ac 100644
--- a/include/lapi/posix_clocks.h
+++ b/include/lapi/posix_clocks.h
@@ -11,10 +11,6 @@
 
 #define MAX_CLOCKS 16
 
-#define ADJ_ALL (ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR |  \
-		 ADJ_ESTERROR | ADJ_STATUS | ADJ_TIMECONST |  \
-		 ADJ_TICK)
-
 #ifndef CLOCK_MONOTONIC_RAW
 # define CLOCK_MONOTONIC_RAW 4
 #endif
diff --git a/include/lapi/timex.h b/include/lapi/timex.h
new file mode 100644
index 000000000..c2c9e4d8d
--- /dev/null
+++ b/include/lapi/timex.h
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+#ifndef LAPI_TIMEX_H__
+# define LAPI_TIMEX_H__
+
+#define ADJ_ALL (ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR |  \
+		 ADJ_ESTERROR | ADJ_STATUS | ADJ_TIMECONST |  \
+		 ADJ_TICK)
+
+#ifndef ADJ_OFFSET_SS_READ
+# define ADJ_OFFSET_SS_READ 0xa001
+#endif
+
+#ifndef ADJ_NANO
+# define ADJ_NANO 0x2000
+#endif
+
+#ifndef STA_NANO
+# define STA_NANO 0x2000
+#endif
+
+#ifndef ADJ_MICRO
+# define ADJ_MICRO 0x1000
+#endif
+
+#endif/* LAPI_TIMEX_H__ */
diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
index 34b97fdfa..d7f553a3a 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
@@ -14,6 +14,7 @@
 #include <pwd.h>
 #include <sys/timex.h>
 #include <sys/types.h>
+#include "lapi/timex.h"
 
 static int sys_clock_adjtime(clockid_t, struct timex *);
 static void timex_show(char *, struct timex);
-- 
2.18.1



