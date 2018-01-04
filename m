From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  4 Jan 2018 21:42:50 +0100
Subject: [LTP] [RFC PATCH 2/2] lib/tst_test.c: Don't print results on archs
	without atomic
In-Reply-To: <20180104204250.7032-1-pvorel@suse.cz>
References: <20180104204250.7032-1-pvorel@suse.cz>
Message-ID: <20180104204250.7032-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index e7b9cddf1..d5d0d60b9 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -574,6 +574,7 @@ int tst_parse_float(const char *str, float *val, float min, float max)
 static void do_exit(int ret)
 {
 	if (results) {
+#ifndef LTP_NO_ATOMIC
 		printf("\nSummary:\n");
 		printf("passed   %d\n", results->passed);
 		printf("failed   %d\n", results->failed);
@@ -588,6 +589,9 @@ static void do_exit(int ret)
 
 		if (results->warnings)
 			ret |= TWARN;
+#else
+	printf("WARNING: Results not counted due missing atomic support.\n");
+#endif
 	}
 
 	do_cleanup();
-- 
2.15.1

