Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XguGd-0001G7-Ni
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 11:39:51 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XguGc-0002hP-Qt
	for ltp-list@lists.sourceforge.net; Wed, 22 Oct 2014 11:39:51 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s9MBdijE001701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 11:39:45 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9MBdhK1009361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 11:39:44 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9MBdhA1004622
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Oct 2014 11:39:43 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 22 Oct 2014 15:41:33 +0400
Message-Id: <1413978094-10616-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1413978094-10616-1-git-send-email-alexey.kodanev@oracle.com>
References: <1413978094-10616-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2 3/3] network/test_net: add tst_init_iface() and
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
v2: replace TST_EXEC_SUFFIX with TST_IPV6

 testcases/lib/test_net.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index b6d4e7d..f8f3f61 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -174,3 +174,50 @@ tst_ipaddr()
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
+	local ipv=${TST_IPV6:-"4"}
+
+	tst_init_iface lhost $link_num
+	tst_init_iface rhost $link_num
+
+	local iface=$(tst_iface $type $link_num)
+
+	local mask=24
+	[ "$TST_IPV6" ] && mask=64
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
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
