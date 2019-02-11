From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 11 Feb 2019 21:07:47 +0300
Subject: [LTP] [PATCH 4/4] netstress: increase timeout errors counter
In-Reply-To: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
References: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1549908467-15609-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Make sure we avoid false-positives with stress test scenarious.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 63fbaed..06882b1 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -88,7 +88,7 @@ static char *server_addr	= "localhost";
 static char *source_addr;
 static char *server_bg;
 static int busy_poll		= -1;
-static int max_etime_cnt = 12; /* ~30 sec max timeout if no connection */
+static int max_etime_cnt = 21; /* ~60 sec max timeout if no connection */
 static int max_eshutdown_cnt = 10;
 static int max_pmtu_err = 10;
 
-- 
1.7.1

