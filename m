From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed,  3 Feb 2021 08:45:20 +0100
Subject: [LTP] [PATCH 2/2] mq_timedreceive_5-3: Fix test for timestamp after
 INT32_MAX
In-Reply-To: <20210203074520.18401-1-lkml@jv-coder.de>
References: <20210203074520.18401-1-lkml@jv-coder.de>
Message-ID: <20210203074520.18401-2-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The timeout for mq_timedreceive is absolute. Using INT32_MAX
breaks this test after 2038-01-19.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/mq_timedreceive/5-3.c               | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
index 3f252a196..89d40721e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
@@ -28,6 +28,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <time.h>
 #include "posixtest.h"
 
 #define TEST "5-3"
@@ -70,7 +71,7 @@ int main(void)
 		sigemptyset(&act.sa_mask);
 		sigaction(SIGABRT, &act, 0);
 
-		ts.tv_sec = INT32_MAX;
+		ts.tv_sec = time(NULL) + 5;
 		ts.tv_nsec = 0;
 
 		if (mq_timedreceive(mqdes, msgrv, BUFFER, NULL, &ts) == -1) {
-- 
2.25.1

