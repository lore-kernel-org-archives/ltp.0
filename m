Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XxB9k-0000W9-11
	for ltp-list@lists.sourceforge.net; Sat, 06 Dec 2014 08:56:00 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XxB9i-00088x-T2
	for ltp-list@lists.sourceforge.net; Sat, 06 Dec 2014 08:56:00 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sB68tUkj009761
	for <ltp-list@lists.sourceforge.net>; Sat, 6 Dec 2014 16:55:30 +0800
Message-ID: <1417856007.2526.12.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Sat, 6 Dec 2014 16:53:27 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] test.sh: tst_resm and tst_brkm enhance
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
To: ltp-list <ltp-list@lists.sourceforge.net>

If the output information is too long, we need a newline.
But tst_resm and tst_brkm only print $1 and $2.
This patch will make them print all parameters.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/lib/test.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index eecbfba..9606b21 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -45,9 +45,11 @@ tst_resm()
 	local mask=$?
 	LTP_RET_VAL=$((LTP_RET_VAL|mask))
 
-	echo "$TCID $TST_COUNT $1 : $2"
+	local ret=$1
+	shift
+	echo "$TCID $TST_COUNT $ret : $@"
 
-	case "$1" in
+	case "$ret" in
 	TPASS|TFAIL)
 	TST_COUNT=$((TST_COUNT+1));;
 	esac
@@ -62,7 +64,9 @@ tst_brkm()
 	*) tst_brkm TBROK "Invalid tst_brkm type '$1'";;
 	esac
 
-	tst_resm "$1" "$2"
+	local ret=$1
+	shift
+	tst_resm "$ret" "$@"
 	tst_exit
 }
 
-- 
1.9.3




------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
