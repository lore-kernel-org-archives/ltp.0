From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 16 Aug 2018 14:00:17 +0200
Subject: [LTP] [PATCH v3 1/4] lib: Allow user to easily get LTP_TIMEOUT_MUL
	value
Message-ID: <20180816120020.11042-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_test.h |  1 +
 lib/tst_test.c     | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 98dacf387..0ad9025f2 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -217,6 +217,7 @@ const char *tst_strsig(int sig);
  */
 const char *tst_strstatus(int status);
 
+float tst_timeout_mul(void);
 void tst_set_timeout(int timeout);
 
 #ifndef TST_NO_DEFAULT_MAIN
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2f3d357d2..f760e05b3 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -992,26 +992,31 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
 	}
 }
 
-void tst_set_timeout(int timeout)
+float tst_timeout_mul(void)
 {
 	char *mul = getenv("LTP_TIMEOUT_MUL");
 
-	if (timeout == -1) {
-		tst_res(TINFO, "Timeout per run is disabled");
-		return;
-	}
-
-	results->timeout = timeout;
-
 	if (mul) {
 		float m = atof(mul);
 
 		if (m < 1)
 			tst_brk(TBROK, "Invalid timeout multiplier '%s'", mul);
 
-		results->timeout = results->timeout * m + 0.5;
+		return m;
+	}
+
+	return 1;
+}
+
+void tst_set_timeout(int timeout)
+{
+	if (timeout == -1) {
+		tst_res(TINFO, "Timeout per run is disabled");
+		return;
 	}
 
+	results->timeout = timeout * tst_timeout_mul() + 0.5;
+
 	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
 		results->timeout/3600, (results->timeout%3600)/60,
 		results->timeout % 60);
-- 
2.18.0

