Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PXTJk-0004gT-Bl
	for ltp-list@lists.sourceforge.net; Tue, 28 Dec 2010 06:45:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXTJi-0001rm-AQ
	for ltp-list@lists.sourceforge.net; Tue, 28 Dec 2010 06:45:56 +0000
Message-ID: <4D1986DE.50309@cn.fujitsu.com>
Date: Tue, 28 Dec 2010 14:42:38 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]fix bug of tst_brk
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Test will fail if invoke tst_brk with (TCONF | TERRNO), it's not our expectation.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 lib/tst_res.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index 2debd44..193653f 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -616,21 +616,21 @@ void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...)
 		sprintf(Warn_mesg, "tst_brk(): Invalid Type: %d.  Using TBROK",
 			ttype_result);
 		tst_print(TCID, 0, TWARN, Warn_mesg);
-		ttype = TBROK;
+		ttype = (ttype & ~ttype_result) | TBROK;
 	}
 
 	/* Print the first result, if necessary. */
 	if (Tst_count < TST_TOTAL)
 		tst_res(ttype, fname, "%s", tmesg);
 
-	if (ttype == TCONF) {
+	if (ttype_result == TCONF) {
 		tst_res(ttype, NULL,
 			"Remaining cases not appropriate for configuration");
 	} else {
-		if (ttype == TRETR)
+		if (ttype_result == TRETR)
 			tst_res(ttype, NULL, "Remaining cases retired");
 		else
-			tst_res(TBROK, NULL, "Remaining cases broken");
+			tst_res(ttype, NULL, "Remaining cases broken");
 	}
 	Expand_varargs = TRUE;
 
-- 
1.7.0.4




-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
