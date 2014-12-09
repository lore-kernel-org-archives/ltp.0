Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XyLqX-0008Ty-BZ
	for ltp-list@lists.sourceforge.net; Tue, 09 Dec 2014 14:33:01 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XyLqR-0002FL-Sv
	for ltp-list@lists.sourceforge.net; Tue, 09 Dec 2014 14:33:01 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id sB9EWn9k001690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Dec 2014 14:32:50 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sB9EWmPW023638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Dec 2014 14:32:49 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	sB9EWluA010612
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Dec 2014 14:32:47 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  9 Dec 2014 17:34:33 +0300
Message-Id: <1418135673-31915-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1418135673-31915-1-git-send-email-alexey.kodanev@oracle.com>
References: <1418135673-31915-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/2] network/runtest: add VxLAN IPv6 tests
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

Test two VxLAN configurations: unicast and multicast.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/network_stress.features |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/runtest/network_stress.features b/runtest/network_stress.features
index 6638b65..dd8e1a4 100644
--- a/runtest/network_stress.features
+++ b/runtest/network_stress.features
@@ -7,4 +7,9 @@ tcp_fastopen6 tcp_fastopen_run.sh -6
 
 vxlan01 vxlan01.sh
 vxlan02 vxlan02.sh
-vxlan03 vxlan03.sh
+
+vxlan_multi_03 vxlan03.sh -d multi
+vxlan_uni_03 vxlan03.sh -d uni
+
+vxlan_ipv6_multi_03 vxlan03.sh -6 -d multi
+vxlan_ipv6_uni_03 vxlan03.sh -6 -d uni
-- 
1.7.1


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
