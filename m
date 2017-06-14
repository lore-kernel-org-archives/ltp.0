From: Chunyu Hu <chuhu@redhat.com>
Date: Wed, 14 Jun 2017 13:19:45 +0800
Subject: [LTP] [PATCH v2] syscalls/getrusage04: make getrusage04 be able to
	loop more times
Message-ID: <1497417585-17588-1-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The -i or -I will break when the tv_usec of timeval gets to 1000000,
as a carry-over to second from usec happens there. So usually we can't
loop for too many times with -i or -I. Approximately 1000 times test
will break with a false positive failure in my x86 box:

getrusage04    0  TINFO  :  utime:       53636us; stime:      989510us
getrusage04    0  TINFO  :  utime:       53682us; stime:      999301us
getrusage04    0  TINFO  :  utime:       53718us; stime:        8906us
getrusage04    1  TFAIL  :  getrusage04.c:133: stime increased > 11000us:

Use ltp new timer compare api to fix this. First use new api to get
the diff timeval direclty, then use new api to convert diff timeval
to us. And print out the second info of utime and stime for providing
needed test info.

After the patch, warn caused by the var types with '-Wsign-compare'
is fixed as well.

getrusage04.c:121:16: warning: comparison between signed and...
     if (udelta > 1000 + (BIAS_MAX * factor_nr)) {

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 testcases/kernel/syscalls/getrusage/getrusage04.c | 37 ++++++++++++-----------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index a5b3f65..7289fe0 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -43,15 +43,13 @@
 #define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/resource.h>
-#include <sys/time.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <time.h>
 
 #include "test.h"
 #include "safe_macros.h"
-#include "lapi/posix_clocks.h"
+#include "tst_timer.h"
 
 char *TCID = "getrusage04";
 int TST_TOTAL = 1;
@@ -82,7 +80,8 @@ static void cleanup(void);
 int main(int argc, char *argv[])
 {
 	struct rusage usage;
-	unsigned long ulast, udelta, slast, sdelta;
+	struct timeval ulast, slast, udelta, sdelta;
+
 	int i, lc;
 	char msg_string[BUFSIZ];
 
@@ -104,28 +103,30 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 		i = 0;
 		SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
-		tst_resm(TINFO, "utime:%12luus; stime:%12luus",
-			 usage.ru_utime.tv_usec, usage.ru_stime.tv_usec);
-		ulast = usage.ru_utime.tv_usec;
-		slast = usage.ru_stime.tv_usec;
+		tst_resm(TINFO, "utime: %lus %12luus; stime: %lus %12luus",
+			 usage.ru_utime.tv_sec, usage.ru_utime.tv_usec,
+				usage.ru_stime.tv_sec, usage.ru_stime.tv_usec);
+		ulast = usage.ru_utime;
+		slast = usage.ru_stime;
 
 		while (i < RECORD_MAX) {
 			SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
-			udelta = usage.ru_utime.tv_usec - ulast;
-			sdelta = usage.ru_stime.tv_usec - slast;
-			if (udelta > 0 || sdelta > 0) {
+			udelta = tst_timeval_diff(usage.ru_utime, ulast);
+			sdelta = tst_timeval_diff(usage.ru_stime, slast);
+			if (tst_timeval_to_us(udelta) > 0 ||
+					tst_timeval_to_us(sdelta) > 0) {
 				i++;
-				tst_resm(TINFO, "utime:%12luus; stime:%12luus",
-					 usage.ru_utime.tv_usec,
-					 usage.ru_stime.tv_usec);
-				if (udelta > 1000 + (BIAS_MAX * factor_nr)) {
+				tst_resm(TINFO, "utime: %lus %12luus; stime: %lus %12luus",
+					usage.ru_utime.tv_sec, usage.ru_utime.tv_usec,
+					usage.ru_stime.tv_sec, usage.ru_stime.tv_usec);
+				if (tst_timeval_to_us(udelta) > 1000 + (BIAS_MAX * factor_nr)) {
 					sprintf(msg_string,
 						"utime increased > %ldus:",
 						1000 + BIAS_MAX * factor_nr);
 					tst_brkm(TFAIL, cleanup, msg_string,
 						 " delta = %luus", udelta);
 				}
-				if (sdelta > 1000 + (BIAS_MAX * factor_nr)) {
+				if (tst_timeval_to_us(sdelta) > 1000 + (BIAS_MAX * factor_nr)) {
 					sprintf(msg_string,
 						"stime increased > %ldus:",
 						1000 + BIAS_MAX * factor_nr);
@@ -133,8 +134,8 @@ int main(int argc, char *argv[])
 						 " delta = %luus", sdelta);
 				}
 			}
-			ulast = usage.ru_utime.tv_usec;
-			slast = usage.ru_stime.tv_usec;
+			ulast = usage.ru_utime;
+			slast = usage.ru_stime;
 			busyloop(100000);
 		}
 	}
-- 
1.8.3.1

