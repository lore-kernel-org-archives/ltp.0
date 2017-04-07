From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 7 Apr 2017 13:58:20 +0800
Subject: [LTP] [PATCH] pan/ltp-pan.c: fix incorrect number of total tests
Message-ID: <1491544700-6312-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The number of total tests should indicate the number of tests
which have been run, but it indicates the number of tests defined
in command-file.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 pan/ltp-pan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 1614c70..beed623 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -645,7 +645,7 @@ int main(int argc, char **argv)
 				strerror(errno));
 		fprintf(logfile,
 			"\n-----------------------------------------------\n");
-		fprintf(logfile, "Total Tests: %d\n", coll->cnt);
+		fprintf(logfile, "Total Tests: %d\n", (coll->cnt - starts));
 		fprintf(logfile, "Total Skipped Tests: %d\n", tconfcnt);
 		fprintf(logfile, "Total Failures: %d\n", failcnt);
 		fprintf(logfile, "Kernel Version: %s\n", unamebuf.release);
-- 
1.8.3.1



