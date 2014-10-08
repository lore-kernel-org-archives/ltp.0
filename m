Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Xbpqk-0001hE-LP
	for ltp-list@lists.sourceforge.net; Wed, 08 Oct 2014 11:56:10 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xbpqj-0005BF-Rc
	for ltp-list@lists.sourceforge.net; Wed, 08 Oct 2014 11:56:10 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s98Bu3FC001023
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Oct 2014 11:56:04 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s98Bu2oc028409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Oct 2014 11:56:03 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s98Bu2wf007073
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Oct 2014 11:56:02 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  8 Oct 2014 15:57:45 +0400
Message-Id: <1412769465-16030-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1412769465-16030-1-git-send-email-alexey.kodanev@oracle.com>
References: <1412769465-16030-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 3/3] network/test_net: add tst_init_iface() and
	tst_set_ipaddr()
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 8d0b6ad..52abda4 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -177,3 +177,50 @@ tst_ipaddr()
 		echo "${IPV4_NETWORK}.${tst_host}"
 	fi
 }
+
+# tst_init_iface [TYPE] [LINK]
+# TYPE: { lhost | rhost }; Default value is 'lhost'.
+# LINK: link number starting from 0. Default value is '0'.
+tst_init_iface()
+{
+	local type=${1:-"lhost"}
+	local link_num=${2:-"0"}
+
+	local iface=$(tst_iface $type $link_num)
+	tst_resm TINFO "initialize '$type' '$iface' interface"
+
+	if [ "$type" = "lhost" ]; then
+		ip link set $iface down || tst_brkm TBROK "interface down failed"
+		ip route flush dev $iface || tst_brkm TBROK "route flush failed"
+		ip addr flush dev $iface || tst_brkm TBROK "addr flush failed"
+		ip link set $iface up || tst_brkm TBROK "interface up failed"
+	else
+		tst_rhost_run -s -c "ip link set $iface down"
+		tst_rhost_run -s -c "ip route flush dev $iface"
+		tst_rhost_run -s -c "ip addr flush dev $iface"
+		tst_rhost_run -s -c "ip link set $iface up"
+	fi
+}
+
+# tst_set_ipaddr [LINK]
+# LINK: link number starting from 0. Default value is '0'.
+tst_set_ipaddr()
+{
+	local link_num=${1:-"0"}
+	local ipv=${TST_EXEC_SUFFIX:-"4"}
+
+	tst_init_iface lhost $link_num
+	tst_init_iface rhost $link_num
+
+	local iface=$(tst_iface $type $link_num)
+
+	local mask=24
+	[ "$TST_EXEC_SUFFIX" = "6" ] && mask=64
+
+	tst_resm TINFO "set local ipv${ipv} addr $(tst_ipaddr)/$mask"
+	ip addr add $(tst_ipaddr)/$mask dev $iface || \
+		tst_brkm TBROK "failed to add IP address"
+
+	tst_resm TINFO "set remote ipv${ipv} addr $(tst_ipaddr rhost)/$mask"
+	tst_rhost_run -s -c "ip addr add $(tst_ipaddr rhost)/$mask dev $iface"
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
