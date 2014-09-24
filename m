Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XWoB4-0008Vu-IC
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 15:08:22 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XWoB2-0005c3-Rm
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 15:08:22 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s8OF8EVx002346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Sep 2014 15:08:15 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8OF8DXG026489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Sep 2014 15:08:14 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8OF8De5015008
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Sep 2014 15:08:13 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 24 Sep 2014 19:09:52 +0400
Message-Id: <1411571394-14917-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/3] network/test_net: add tst_ipaddr
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

Some tests require IP addresses, either IPv4 or IPv6.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 6d49ba5..b4e61cf 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -208,3 +208,25 @@ tst_read_opts()
 	done
 	OPTIND=0
 }
+
+# Get IP address
+# tst_ipaddr [TYPE]
+# TYPE: { lhost | rhost }; Default value is 'lhost'.
+tst_ipaddr()
+{
+	local type=${1:-"lhost"}
+	local ipv=${TST_EXEC_SUFFIX:-"4"}
+	local tst_host=
+
+	if [ "type" = "lhost" ]; then
+		eval "tst_host=\$LHOST_IPV${ipv}_HOST"
+	else
+		eval "tst_host=\$RHOST_IPV${ipv}_HOST"
+	fi
+
+	if [ "$TST_EXEC_SUFFIX" = "6" ]; then
+		echo "${IPV6_NETWORK}:${tst_host}"
+	else
+		echo "${IPV4_NETWORK}:${tst_host}"
+	fi
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
