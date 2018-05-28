From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
Date: Mon, 28 May 2018 16:16:49 +0800
Subject: [LTP] [PATCH] sctputil.c: insert a space between a and datamsg
Message-ID: <20180528081649.7950-1-sunlw.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The sctputil.c:240
tst_brkm(TBROK, tst_exit, "Got a notification, expecting a"
                            "datamsg");
after the word "a" need a space, otherwise the info of TBROK is below:
sctputil.c:241: Got a notification, expecting adatamsg

Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
---
 utils/sctp/testlib/sctputil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/sctp/testlib/sctputil.c b/utils/sctp/testlib/sctputil.c
index 564925ce9..f9d9b22e9 100644
--- a/utils/sctp/testlib/sctputil.c
+++ b/utils/sctp/testlib/sctputil.c
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



