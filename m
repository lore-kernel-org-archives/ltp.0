From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
Date: Mon, 4 Jun 2018 11:26:28 +0800
Subject: [LTP] [PATCH] sctp: insert a space to isolate two word
Message-ID: <20180604032628.2737-1-sunlw.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In statement tst_brkm(TBROK, tst_exit, "a b"
              "c");
There is need a space between word "b" and "c" to isolate these
two words, otherwise will print "a bc"

Reported-by: Wei Xingshen <weixshen@gmail.com>
Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
---
 utils/sctp/testlib/sctputil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/sctp/testlib/sctputil.c b/utils/sctp/testlib/sctputil.c
index 564925ce9..6f873d8d2 100644
--- a/utils/sctp/testlib/sctputil.c
+++ b/utils/sctp/testlib/sctputil.c
@@ -198,7 +198,7 @@ test_check_buf_notification(void *buf, int datalen, int msg_flags,
 		
 	sn = (union sctp_notification *)buf;
 	if (sn->sn_header.sn_type != expected_sn_type)
-		tst_brkm(TBROK, tst_exit, "Unexpected notification:%d"
+		tst_brkm(TBROK, tst_exit, "Unexpected notification:%d "
 			 "expected:%d", sn->sn_header.sn_type,
 			  expected_sn_type);
 	
@@ -237,7 +237,7 @@ test_check_buf_data(void *buf, int datalen, int msg_flags,
 		    uint32_t expected_ppid)
 {
 	if (msg_flags & MSG_NOTIFICATION)
-		tst_brkm(TBROK, tst_exit, "Got a notification, expecting a"
+		tst_brkm(TBROK, tst_exit, "Got a notification, expecting a "
 			 "datamsg");
 
 	if (expected_datalen <= 0)
-- 
2.17.0



