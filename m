From: dongshijiang <dongshijiang@inspur.com>
Date: Tue, 8 Jun 2021 04:44:31 -0400
Subject: [LTP] [PATCH] fix pan/ltp-pan return values
Message-ID: <20210608084431.62769-1-dongshijiang@inspur.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When performing an LTP test, if there are only "PASS" and "TCONF" in the test results, but "runltp" displays "INFO: ltp-pan reported all tests PASS", I think it should give something like "INFO: ltp-pan reported some "tests FAIL or TCONF" prompt.

Signed-off-by: dongshijiang <dongshijiang@inspur.com>
---
 pan/ltp-pan.c | 2 +-
 runltp        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 298072fe0..05690f7c9 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -770,7 +770,7 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 					"child %d exited with status %d\n",
 					cpid, w);
 			--*num_active;
-			if (w != 0 && w != TCONF)
+			if (w != 0)
 				ret++;
 		} else if (WIFSTOPPED(stat_loc)) {	/* should never happen */
 			w = WSTOPSIG(stat_loc);
diff --git a/runltp b/runltp
index 4447da156..539e7800d 100755
--- a/runltp
+++ b/runltp
@@ -811,7 +811,7 @@ EOF
       VALUE=0
       export LTP_EXIT_VALUE=0;
     else
-      echo "INFO: ltp-pan reported some tests FAIL"
+      echo "INFO: ltp-pan reported some tests FAIL or TCONF"
       VALUE=1
       export LTP_EXIT_VALUE=1;
     fi
-- 
2.27.0

