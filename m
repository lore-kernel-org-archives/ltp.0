Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WW3U0-0004CW-Fq
	for ltp-list@lists.sourceforge.net; Fri, 04 Apr 2014 12:44:32 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WW3Tz-0001vH-Mr
	for ltp-list@lists.sourceforge.net; Fri, 04 Apr 2014 12:44:32 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s34CiPBB013481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Apr 2014 12:44:25 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s34CiOCF025441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Apr 2014 12:44:25 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s34CiOGH024101
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Apr 2014 12:44:24 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri,  4 Apr 2014 16:44:41 +0400
Message-Id: <1396615481-13156-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1396615481-13156-1-git-send-email-alexey.kodanev@oracle.com>
References: <1396615481-13156-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2 2/2] network: vxlan: add tests to
	runtest/network_stress
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
 runtest/network_stress.udp |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/runtest/network_stress.udp b/runtest/network_stress.udp
index bfe9d85..2f62c14 100644
--- a/runtest/network_stress.udp
+++ b/runtest/network_stress.udp
@@ -65,3 +65,7 @@ udp6-multi-diffnic04 udp6-multi-diffnic04
 udp6-multi-diffnic05 udp6-multi-diffnic05
 udp6-multi-diffnic06 udp6-multi-diffnic06
 udp6-multi-diffnic07 udp6-multi-diffnic07
+
+vxlan01 vxlan01.sh
+vxlan02 vxlan02.sh
+vxlan03 vxlan03.sh
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
