From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Wed, 11 Sep 2019 18:52:24 +0200
Subject: [LTP] [PATCH v2 2/3] tst_test.c: Add tst_adjust_timeout()
In-Reply-To: <20190911165225.2122-1-cfamullaconrad@suse.de>
References: <20190911085536.25546-1-cfamullaconrad@suse.de>
 <20190911165225.2122-1-cfamullaconrad@suse.de>
Message-ID: <20190911165225.2122-2-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This function is used to adjust timeout values with environment
variables like LTP_TIMEOUT_MUL.

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 include/tst_test.h |  1 +
 lib/tst_test.c     | 32 ++++++++++++++++++++------------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index cdeaf6ad0..908015846 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -261,6 +261,7 @@ const char *tst_strsig(int sig);
 const char *tst_strstatus(int status);
 
 unsigned int tst_timeout_remaining(void);
+unsigned int tst_adjust_timeout(unsigned int timeout);
 void tst_set_timeout(int timeout);
 
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index d2cf92608..1283dba1a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -36,6 +36,7 @@ struct tst_test *tst_test;
 static const char *tid;
 static int iterations = 1;
 static float duration = -1;
+static float timeout_mul = -1;
 static pid_t main_pid, lib_pid;
 static int mntpoint_mounted;
 static int ovl_mounted;
@@ -1087,25 +1088,32 @@ unsigned int tst_timeout_remaining(void)
 	return 0;
 }
 
-void tst_set_timeout(int timeout)
+unsigned int tst_adjust_timeout(unsigned int timeout)
 {
-	char *mul = getenv("LTP_TIMEOUT_MUL");
+	char *mul;
+	if (timeout_mul == -1){
+		mul = getenv("LTP_TIMEOUT_MUL");
+		if (mul) {
+			timeout_mul = atof(mul);
+			if (timeout_mul < 1)
+				tst_brk(TBROK,
+					"Invalid timeout multiplier '%s'",
+					mul);
+		} else {
+			timeout_mul = 1;
+		}
+	}
+	return timeout * timeout_mul + 0.5;
+}
 
+void tst_set_timeout(int timeout)
+{
 	if (timeout == -1) {
 		tst_res(TINFO, "Timeout per run is disabled");
 		return;
 	}
 
-	results->timeout = timeout;
-
-	if (mul) {
-		float m = atof(mul);
-
-		if (m < 1)
-			tst_brk(TBROK, "Invalid timeout multiplier '%s'", mul);
-
-		results->timeout = results->timeout * m + 0.5;
-	}
+	results->timeout = tst_adjust_timeout(timeout);
 
 	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
 		results->timeout/3600, (results->timeout%3600)/60,
-- 
2.16.4

