From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Jan 2019 16:13:55 +0100
Subject: [LTP] [PATCH] [COMMITTED] syscalls/clock_settime02: Fix build.
Message-ID: <20190130151355.25041-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Include lapi/posix_clocks.h in order to fix compilation on older
distributions.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/clock_settime/clock_settime02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
index 8db417b6b..a6df4940a 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime02.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
@@ -11,6 +11,7 @@
 #include "config.h"
 #include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "lapi/posix_clocks.h"
 #include "tst_timer.h"
 #include "tst_safe_clocks.h"
 
-- 
2.19.2

