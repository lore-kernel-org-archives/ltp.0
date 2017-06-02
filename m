From: Chunyu Hu <chuhu@redhat.com>
Date: Fri,  2 Jun 2017 15:28:15 +0800
Subject: [LTP] [PATCH] Make getrusage04 be able to loop more times
Message-ID: <1496388495-30584-1-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The -i or -I will break when the tv_usec of timeval gets to
1000000, so usually we can't loop for too many times with -i
or -I. Approximately 1000 times loop will break with a false
positive failure:

getrusage04    0  TINFO  :  utime:       53636us; stime:      989510us
getrusage04    0  TINFO  :  utime:       53682us; stime:      999301us
getrusage04    0  TINFO  :  utime:       53718us; stime:        8906us
getrusage04    1  TFAIL  :  getrusage04.c:133: stime increased > 11000us:

Sometimes we need to run more than one second user/sys time,
here consider the carry-over to timeval.tv_sec when timeval.tv_usec
gets overflow, and print out the second info of utime and stime for
providing needed test info.

Also fix warn casused by the var types with '-Wsign-compare'

getrusage04.c:121:16: warning: comparison between signed and...
     if (udelta > 1000 + (BIAS_MAX * factor_nr)) {

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 testcases/kernel/syscalls/getrusage/getrusage04.c | 24 +++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index a5b3f65..6b36cec 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -82,7 +82,8 @@ static void cleanup(void);
 int main(int argc, char *argv[])
 {
 	struct rusage usage;
-	unsigned long ulast, udelta, slast, sdelta;
+	unsigned long ulast, slast,  ulasts, slasts;
+	long udelta, sdelta, udeltas, sdeltas;
 	int i, lc;
 	char msg_string[BUFSIZ];
 
@@ -104,28 +105,33 @@ int main(int argc, char *argv[])
 		tst_count = 0;
 		i = 0;
 		SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
-		tst_resm(TINFO, "utime:%12luus; stime:%12luus",
-			 usage.ru_utime.tv_usec, usage.ru_stime.tv_usec);
+		tst_resm(TINFO, "utime:%lus %12luus; stime:%lus %12luus",
+			 usage.ru_utime.tv_sec, usage.ru_utime.tv_usec,
+				usage.ru_stime.tv_sec, usage.ru_stime.tv_usec);
 		ulast = usage.ru_utime.tv_usec;
 		slast = usage.ru_stime.tv_usec;
+		ulasts = usage.ru_utime.tv_sec;
+		slasts = usage.ru_stime.tv_sec;
 
 		while (i < RECORD_MAX) {
 			SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
 			udelta = usage.ru_utime.tv_usec - ulast;
 			sdelta = usage.ru_stime.tv_usec - slast;
+			udeltas = usage.ru_utime.tv_sec - ulasts;
+			sdeltas = usage.ru_stime.tv_sec - slasts;
 			if (udelta > 0 || sdelta > 0) {
 				i++;
-				tst_resm(TINFO, "utime:%12luus; stime:%12luus",
-					 usage.ru_utime.tv_usec,
-					 usage.ru_stime.tv_usec);
-				if (udelta > 1000 + (BIAS_MAX * factor_nr)) {
+				tst_resm(TINFO, "utime:%lus %12luus; stime:%lus %12luus",
+					usage.ru_utime.tv_sec, usage.ru_utime.tv_usec,
+					usage.ru_stime.tv_sec, usage.ru_stime.tv_usec);
+				if (udelta > 1000 + (BIAS_MAX * factor_nr) && !udeltas) {
 					sprintf(msg_string,
 						"utime increased > %ldus:",
 						1000 + BIAS_MAX * factor_nr);
 					tst_brkm(TFAIL, cleanup, msg_string,
 						 " delta = %luus", udelta);
 				}
-				if (sdelta > 1000 + (BIAS_MAX * factor_nr)) {
+				if (sdelta > 1000 + (BIAS_MAX * factor_nr) && !sdeltas) {
 					sprintf(msg_string,
 						"stime increased > %ldus:",
 						1000 + BIAS_MAX * factor_nr);
@@ -135,6 +141,8 @@ int main(int argc, char *argv[])
 			}
 			ulast = usage.ru_utime.tv_usec;
 			slast = usage.ru_stime.tv_usec;
+			ulasts = usage.ru_utime.tv_sec;
+			slasts = usage.ru_stime.tv_sec;
 			busyloop(100000);
 		}
 	}
-- 
1.8.3.1

