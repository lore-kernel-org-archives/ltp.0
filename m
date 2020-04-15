From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 13:26:34 +0200
Subject: [LTP] [PATCH v2 8/9] realtime: Fix linking error with -fno-common
In-Reply-To: <20200415112635.14144-1-pvorel@suse.cz>
References: <20200415112635.14144-1-pvorel@suse.cz>
Message-ID: <20200415112635.14144-9-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

by declaring iters_per_us as static and moving from header into
C source.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/realtime/include/librttest.h | 1 -
 testcases/realtime/lib/librttest.c     | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/realtime/include/librttest.h b/testcases/realtime/include/librttest.h
index c18236200..b829f4089 100644
--- a/testcases/realtime/include/librttest.h
+++ b/testcases/realtime/include/librttest.h
@@ -66,7 +66,6 @@ extern char *optarg;
 
 #define _MAXTHREADS 256
 #define CALIBRATE_LOOPS 100000
-unsigned long iters_per_us;
 
 #define NS_PER_MS 1000000
 #define NS_PER_US 1000
diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
index 36790581e..722d99d50 100644
--- a/testcases/realtime/lib/librttest.c
+++ b/testcases/realtime/lib/librttest.c
@@ -63,6 +63,7 @@
 
 static LIST_HEAD(_threads);
 static atomic_t _thread_count = { -1 };
+static unsigned long iters_per_us;
 
 pthread_mutex_t _buffer_mutex;
 char *_print_buffer = NULL;
-- 
2.26.0

