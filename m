From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jan 2018 10:17:58 +0100
Subject: [LTP] [RFC] [PATCH] lib/parse_opts: Use CLOCK_MONOTONIC for -I
	option
Message-ID: <20180123091758.23639-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is follow up patch for the old library.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/parse_opts.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/parse_opts.c b/lib/parse_opts.c
index 3a879e44e..56a7c4c00 100644
--- a/lib/parse_opts.c
+++ b/lib/parse_opts.c
@@ -39,12 +39,13 @@
 #include <sys/signal.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include <sys/time.h>
+#include <time.h>
 #include <stdint.h>
 
 #include "test.h"
 #include "ltp_priv.h"
 #include "usctest.h"
+#include "tst_clocks.h"
 
 #ifndef UNIT_TEST
 #define UNIT_TEST	0
@@ -467,16 +468,13 @@ int usc_global_setup_hook(void)
 
 #define USECS_PER_SEC	1000000	/* microseconds per second */
 
-/***********************************************************************
- * Returns current time in microseconds since 1970.
- ***********************************************************************/
 static uint64_t get_current_time(void)
 {
-	struct timeval curtime;
+	struct timespec ts;
 
-	gettimeofday(&curtime, NULL);
+	tst_clock_gettime(CLOCK_MONOTONIC, &ts);
 
-	return (((uint64_t) curtime.tv_sec) * USECS_PER_SEC) + curtime.tv_usec;
+	return (((uint64_t) ts.tv_sec) * USECS_PER_SEC) + ts.tv_nsec / 1000;
 }
 
 /***********************************************************************
-- 
2.13.6

