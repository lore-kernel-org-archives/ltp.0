From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed,  3 Feb 2021 08:45:19 +0100
Subject: [LTP] [PATCH 1/2] mq_timedreceive/5-3: Prevent override of errno
Message-ID: <20210203074520.18401-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

wait can override the errno set by mq_timedreceive and
the check for EINTR might fail or not fail if it should.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/mq_timedreceive/5-3.c           | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
index e773aeb14..3f252a196 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
@@ -74,16 +74,17 @@ int main(void)
 		ts.tv_nsec = 0;
 
 		if (mq_timedreceive(mqdes, msgrv, BUFFER, NULL, &ts) == -1) {
-			wait(NULL);
 			if (EINTR != errno) {
 				printf("errno != EINTR\n");
 				failure = 1;
 			}
 		} else {
-			wait(NULL);
-			printf("mq_timedreceive() succeed unexpectly\n");
+			printf("mq_timedreceive() succeeded unexpectedly\n");
 			failure = 1;
 		}
+		
+		wait(NULL);
+
 		if (mq_close(mqdes) != 0) {
 			perror("mq_close() did not return success");
 			unresolved = 1;
-- 
2.25.1

