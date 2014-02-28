Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WJL66-0002rs-Mx
	for ltp-list@lists.sourceforge.net; Fri, 28 Feb 2014 10:55:18 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WJL65-0007Mg-Ve
	for ltp-list@lists.sourceforge.net; Fri, 28 Feb 2014 10:55:18 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1SAtBO4020612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Feb 2014 10:55:12 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1SAtB4x026615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Feb 2014 10:55:11 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1SAtB8K026115
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Feb 2014 10:55:11 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 28 Feb 2014 14:55:18 +0400
Message-Id: <1393584918-11415-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1393584918-11415-1-git-send-email-alexey.kodanev@oracle.com>
References: <1393584918-11415-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/2] network: vxlan: add test to runtest/network_stress
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
 runtest/network_stress.udp |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/runtest/network_stress.udp b/runtest/network_stress.udp
index bfe9d85..de471b9 100644
--- a/runtest/network_stress.udp
+++ b/runtest/network_stress.udp
@@ -65,3 +65,5 @@ udp6-multi-diffnic04 udp6-multi-diffnic04
 udp6-multi-diffnic05 udp6-multi-diffnic05
 udp6-multi-diffnic06 udp6-multi-diffnic06
 udp6-multi-diffnic07 udp6-multi-diffnic07
+
+vxlan01.sh vxlan01.sh
-- 
1.7.1


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
