From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 12 May 2020 15:28:23 +0100
Subject: [LTP] [PATCH 1/2] pty04: Remove unnecessary volatile and style fix
Message-ID: <20200512142824.13063-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/pty/pty04.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index 252babe92..bfda08b2b 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -92,7 +92,7 @@ static struct ldisc_info ldiscs[] = {
 	{N_SLCAN, "N_SLCAN", CAN_MTU},
 };
 
-static volatile int ptmx, pts, sk, mtu, no_check;
+static int ptmx, pts, sk, mtu, no_check;
 
 static int set_ldisc(int tty, const struct ldisc_info *ldisc)
 {
@@ -173,13 +173,15 @@ static void write_pty(const struct ldisc_info *ldisc)
 
 
 	written = 0;
-	ret = TST_RETRY_FUNC(try_write(ptmx, data, len, &written), TST_RETVAL_NOTNULL);
+	ret = TST_RETRY_FUNC(try_write(ptmx, data, len, &written),
+			     TST_RETVAL_NOTNULL);
 	if (ret < 0)
 		tst_brk(TBROK | TERRNO, "Failed 1st write to PTY");
 	tst_res(TPASS, "Wrote PTY 1");
 
 	written = 0;
-	ret = TST_RETRY_FUNC(try_write(ptmx, data, len, &written), TST_RETVAL_NOTNULL);
+	ret = TST_RETRY_FUNC(try_write(ptmx, data, len, &written),
+			     TST_RETVAL_NOTNULL);
 	if (ret < 0)
 		tst_brk(TBROK | TERRNO, "Failed 2nd write to PTY");
 
-- 
2.26.1

