From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Wed,  9 Jun 2021 11:38:49 -0300
Subject: [LTP] [PATCH] common_timers: define NSEC_PER_SEC as long long to
 avoid overflow on 32-bit
Message-ID: <20210609143849.298147-1-cascardo@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When multiplying 30 with NSEC_PER_SEC, the result would overflow on 32-bit
platforms, unless there was promotion to long long, which is what
tst_ts_from_ns expects.

futex_wake04, which uses that, would end up getting EINVAL when calling futex,
because timespec_valid would fail, as tv_nsec would have an invalid value.

After this change, futex_wake04 passes on i386.

Reported-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 include/lapi/common_timers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
index 8da3abec24b2..953741d73810 100644
--- a/include/lapi/common_timers.h
+++ b/include/lapi/common_timers.h
@@ -12,7 +12,7 @@
 #include "lapi/posix_clocks.h"
 
 #ifndef NSEC_PER_SEC
-#define NSEC_PER_SEC (1000000000L)
+#define NSEC_PER_SEC (1000000000LL)
 #endif
 
 static const clock_t clock_list[] = {
-- 
2.30.2

