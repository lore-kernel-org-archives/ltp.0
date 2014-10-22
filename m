Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XguGY-0005D1-Vt
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 11:39:47 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XguGY-0002hH-0o
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 11:39:46 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s9MBddbl006568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 11:39:39 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9MBdcKA009141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 11:39:38 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9MBdcfn013724
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 11:39:38 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 22 Oct 2014 15:41:31 +0400
Message-Id: <1413978094-10616-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2 1/3] network/test_net: add support for -6 option
	(IPv6 tests)
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

* copy read_opts() from net_cmdlib.sh library;
* replace TST_EXEC_SUFFIX with more informative name TST_IPV6;
* skip other options;

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 8cbcb70..24460f3 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -137,3 +137,18 @@ tst_iface()
 	link_num=$(( $link_num + 1 ))
 	echo "$(tst_get_ifaces $type)" | awk '{ print $'"$link_num"' }'
 }
+
+# Blank for an IPV4 test; 6 for an IPV6 test.
+TST_IPV6=
+
+tst_read_opts()
+{
+	OPTIND=0
+	while getopts ":6" opt; do
+		case "$opt" in
+		6)
+			TST_IPV6=6;;
+		esac
+	done
+	OPTIND=0
+}
-- 
1.7.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
