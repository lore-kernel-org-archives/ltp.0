From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Feb 2019 00:43:58 +0100
Subject: [LTP] [PATCH 1/2] Include lapi/posix_clocks.h in tst_safe_clocks.h
Message-ID: <20190225234359.8165-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Although this not needed, users of tst_safe_clocks.h usually need also
posix clock flags and it's safer to load them automatically so fixes
like 938a1023d are not needed any more.

+ minor copyright formatting cleanup.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_safe_clocks.h                                 | 8 +++++---
 testcases/kernel/syscalls/clock_gettime/clock_gettime01.c | 1 -
 testcases/kernel/syscalls/clock_gettime/clock_gettime02.c | 1 -
 testcases/kernel/syscalls/clock_settime/clock_settime02.c | 1 -
 testcases/kernel/syscalls/statx/statx06.c                 | 1 -
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index 553f8464a..d5cd83394 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -1,11 +1,13 @@
-// SPDX-License-Identifier: GPL-2.0 or later
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
- *  Email : code@zilogic.com
+ * Copyright (c) 2019, Linux Test Project
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email : code@zilogic.com
  */
 
 #include <time.h>
 #include "tst_test.h"
+#include "lapi/posix_clocks.h"
 
 static inline void safe_clock_getres(const char *file, const int lineno,
 	clockid_t clk_id, struct timespec *res)
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
index f8028f0f6..d365823b2 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
@@ -18,7 +18,6 @@
 
 #include "config.h"
 #include "tst_timer.h"
-#include "lapi/posix_clocks.h"
 #include "tst_safe_clocks.h"
 #include "tst_test.h"
 #include "lapi/syscalls.h"
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
index c08f0f0de..2a29a71e6 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
@@ -21,7 +21,6 @@
 #include "config.h"
 #include "tst_test.h"
 #include "lapi/syscalls.h"
-#include "lapi/posix_clocks.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
 
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
index a6df4940a..8db417b6b 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime02.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
@@ -11,7 +11,6 @@
 #include "config.h"
 #include "tst_test.h"
 #include "lapi/syscalls.h"
-#include "lapi/posix_clocks.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
 
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index 524022499..831f73092 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -45,7 +45,6 @@
 #include "lapi/stat.h"
 #include "lapi/mount.h"
 #include "lapi/fcntl.h"
-#include "lapi/posix_clocks.h"
 
 #define MOUNT_POINT "mount_ext"
 #define TEST_FILE MOUNT_POINT"/test_file.txt"
-- 
2.20.1

