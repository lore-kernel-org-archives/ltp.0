Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Xbpqe-0006Jb-Vn
	for ltp-list@lists.sourceforge.net; Wed, 08 Oct 2014 11:56:05 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xbpqd-00047D-NP
	for ltp-list@lists.sourceforge.net; Wed, 08 Oct 2014 11:56:04 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s98BtvoR023840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Oct 2014 11:55:57 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s98Btutr013095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Oct 2014 11:55:57 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s98Btudh005399
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Oct 2014 11:55:56 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  8 Oct 2014 15:57:43 +0400
Message-Id: <1412769465-16030-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/3] network/test_net: add support for -6 option (IPv6
	tests)
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
Cc: vasily.isaenko@oracle.com

copy read_opts() from net_cmdlib.sh library

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 8cbcb70..2436264 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -137,3 +137,21 @@ tst_iface()
 	link_num=$(( $link_num + 1 ))
 	echo "$(tst_get_ifaces $type)" | awk '{ print $'"$link_num"' }'
 }
+
+# Blank for an IPV4 test; 6 for an IPV6 test.
+TST_EXEC_SUFFIX=
+
+tst_read_opts()
+{
+	OPTIND=0
+	while getopts "6" opt; do
+		case "$opt" in
+		6)
+			TST_EXEC_SUFFIX=6;;
+		*)
+			tst_brkm TBROK "tst_read_opts: unknown option: $opt"
+		;;
+		esac
+	done
+	OPTIND=0
+}
-- 
1.7.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
