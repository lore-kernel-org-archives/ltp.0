Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VbpM5-0001GP-MY
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 10:19:57 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VbpM4-0003HV-No
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 10:19:57 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9VAJn4c011059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 10:19:50 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9VAJm0f018370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 10:19:49 GMT
Received: from abhmt111.oracle.com (abhmt111.oracle.com [141.146.116.63])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9VAJmof006844
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 10:19:48 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Thu, 31 Oct 2013 18:19:21 +0800
Message-Id: <1383214761-1385-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] rwho01: fix getting hostnames from command output and
	a typo
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Fix the way the script gets hostnames from rwho/ruptime command output,
and the mistake that $COUNT is used instead of $TST_COUNT in do_test().
---
 testcases/network/tcp_cmds/rwho/rwho01 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/network/tcp_cmds/rwho/rwho01 b/testcases/network/tcp_cmds/rwho/rwho01
index 2c82ef1..eb31642 100755
--- a/testcases/network/tcp_cmds/rwho/rwho01
+++ b/testcases/network/tcp_cmds/rwho/rwho01
@@ -106,18 +106,18 @@ do_test()
 
     while [ $TST_COUNT -le $NUMLOOPS ]; do
         rwho -a > $OUTFILE
-        HOST=`awk "\\$2 ~ /$LHOST>/" $OUTFILE | cut -f1 -d: | sort -u`
+        HOST=`grep $LHOST $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
         [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in rwho outfile"
-        HOST=`awk "\\$2 ~ /$RHOSTNAME>/" $OUTFILE | cut -f1 -d: | sort -u`
+        HOST=`grep $RHOSTNAME $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
         [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in rwho outfile"
 
         ruptime -a > $OUTFILE
-        HOST=`awk "\\$1 ~ /$LHOST>/" $OUTFILE | sort -u`
+        HOST=`grep $LHOST $OUTFILE | sed 's/ .*//' | uniq`
         [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in ruptime outfile"
-        HOST=`awk "\\$1 ~ /$RHOSTNAME>/" $OUTFILE | sort -u`
+        HOST=`grep $RHOSTNAME $OUTFILE | sed 's/ .*//' | uniq`
         [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in ruptime outfile"
 
-        tst_resm TINFO "Test $COUNT of $NUMLOOPS complete"
+        tst_resm TINFO "Test $TST_COUNT of $NUMLOOPS complete"
         incr_tst_count
     done
 }
-- 
1.8.4


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
