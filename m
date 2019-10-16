From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Wed, 16 Oct 2019 18:15:17 +0200
Subject: [LTP] [PATCH v3 2/4] tst_test.c: Add tst_multiply_timeout()
In-Reply-To: <20191016161519.11256-1-cfamullaconrad@suse.de>
References: <1571225126.8494.1.camel@suse.de>
 <20191016161519.11256-1-cfamullaconrad@suse.de>
Message-ID: <20191016161519.11256-2-cfamullaconrad@suse.de>
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
 lib/tst_test.c     | 41 ++++++++++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 84acf2c59..aaea128ba 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -267,6 +267,7 @@ const char *tst_strsig(int sig);
 const char *tst_strstatus(int status);
 
 unsigned int tst_timeout_remaining(void);
+unsigned int tst_multiply_timeout(unsigned int timeout);
 void tst_set_timeout(int timeout);
 
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 6239acf89..6d92d8775 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -36,6 +36,7 @@ struct tst_test *tst_test;
 static const char *tid;
 static int iterations = 1;
 static float duration = -1;
+static int timeout_mul = -1;
 static pid_t main_pid, lib_pid;
 static int mntpoint_mounted;
 static int ovl_mounted;
@@ -1093,25 +1094,43 @@ unsigned int tst_timeout_remaining(void)
 	return 0;
 }
 
-void tst_set_timeout(int timeout)
+unsigned int tst_multiply_timeout(unsigned int timeout)
 {
-	char *mul = getenv("LTP_TIMEOUT_MUL");
+	char *mul;
+	float mul_float;
+
+	if (timeout_mul == -1){
+		mul = getenv("LTP_TIMEOUT_MUL");
+		if (mul) {
+			timeout_mul = mul_float = atof(mul);
+			if (timeout_mul != mul_float){
+				timeout_mul++;
+				tst_res(TINFO, "ceiling LTP_TIMEOUT_MUL to %d", timeout_mul);
+			}
+		} else {
+			timeout_mul = 1;
+		}
+	}
+	if (timeout_mul < 1)
+		tst_brk(TBROK, "LTP_TIMEOUT_MUL need to be int >= 1! (%d)", timeout_mul);
+
+	if (timeout < 1)
+		tst_brk(TBROK, "timeout need to be >= 1! (%d)", timeout);
+
+	return timeout * timeout_mul;
+}
 
+void tst_set_timeout(int timeout)
+{
 	if (timeout == -1) {
 		tst_res(TINFO, "Timeout per run is disabled");
 		return;
 	}
 
-	results->timeout = timeout;
+	if (timeout < 1)
+		tst_brk(TBROK, "timeout need to be >= 1! (%d)", timeout);
 
-	if (mul) {
-		float m = atof(mul);
-
-		if (m < 1)
-			tst_brk(TBROK, "Invalid timeout multiplier '%s'", mul);
-
-		results->timeout = results->timeout * m + 0.5;
-	}
+	results->timeout = tst_multiply_timeout(timeout);
 
 	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
 		results->timeout/3600, (results->timeout%3600)/60,
-- 
2.16.4

