From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 19 May 2020 14:21:10 +0530
Subject: [LTP] [PATCH 3/5] syscalls: Don't use tst_syscall() unnecessarily
In-Reply-To: <cover.1589877853.git.viresh.kumar@linaro.org>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
Message-ID: <3f3b7d669d47ae701385b43deb8280a353dd231e.1589877853.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These syscall are old enough and must have support in libc for everyone.
Don't use tst_syscall() for them unnecessarily.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 lib/parse_opts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/parse_opts.c b/lib/parse_opts.c
index a9d50589a3f9..b3ab69c0a539 100644
--- a/lib/parse_opts.c
+++ b/lib/parse_opts.c
@@ -45,7 +45,6 @@
 #include "test.h"
 #include "ltp_priv.h"
 #include "usctest.h"
-#include "tst_clocks.h"
 
 #ifndef UNIT_TEST
 #define UNIT_TEST	0
@@ -472,7 +471,7 @@ static uint64_t get_current_time(void)
 {
 	struct timespec ts;
 
-	tst_clock_gettime(CLOCK_MONOTONIC, &ts);
+	clock_gettime(CLOCK_MONOTONIC, &ts);
 
 	return (((uint64_t) ts.tv_sec) * USECS_PER_SEC) + ts.tv_nsec / 1000;
 }
-- 
2.25.0.rc1.19.g042ed3e048af

