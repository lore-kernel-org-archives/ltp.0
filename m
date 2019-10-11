From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 11 Oct 2019 07:31:34 +0200
Subject: [LTP] [PATCH] open_posix/timer_getoverrun/2-3: Fix test for systems
 with low timer precision
Message-ID: <20191011053134.18416-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

On systems with low timer precision the test always fails, because the allowed
maximum number of overruns is calculated from the expected overruns + 10%.
If the expected overruns is less than 200, there is no tollerance.
This happens, if the precision of the timer is less than or equal to 4ms.
E.g. qemu-arm64 without high resolution timer the accuracy is only 4ms.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/timer_getoverrun/2-3.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
index 96b7d01e6..3df3a9f01 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
@@ -55,6 +55,7 @@ int main(void)
 	int overruns;
 	int valuensec, intervalnsec, expectedoverruns;
 	int fudge;
+	int duration;
 
 	if (sigemptyset(&set) != 0) {
 		perror("sigemptyset() did not return success\n");
@@ -94,11 +95,15 @@ int main(void)
 
 	valuensec = tsres.tv_nsec;
 	intervalnsec = 2 * valuensec;
-	//expectedoverruns = (1000000000 - valuensec) / intervalnsec;
-	expectedoverruns = 1000000000 / intervalnsec - 1;
+	expectedoverruns = 0;
+	duration = 0;
+	while (expectedoverruns < 1000) {
+		duration++;
+		expectedoverruns = duration * (1000000000 / intervalnsec - 1);
+	}
 
-	printf("value = %d sec, interval = %d nsec, "
-	       "expected overruns = %d\n", 1, intervalnsec, expectedoverruns);
+	printf("duration = %d sec, interval = %d nsec, "
+	       "expected overruns = %d\n", duration, intervalnsec, expectedoverruns);
 
 	its.it_interval.tv_sec = 0;
 	its.it_interval.tv_nsec = intervalnsec;
@@ -113,7 +118,7 @@ int main(void)
 	}
 	//tssleep.tv_nsec = valuensec + (expectedoverruns*intervalnsec);
 	tssleep.tv_nsec = 0;
-	tssleep.tv_sec = 2;
+	tssleep.tv_sec = duration + 1;
 	if (nanosleep(&tssleep, NULL) != 0) {
 		perror("nanosleep() did not return success\n");
 		return PTS_UNRESOLVED;
-- 
2.20.1

