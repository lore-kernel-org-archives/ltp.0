Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YDDcG-0007Oo-BV
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 14:47:44 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YDDcF-0004K0-EW
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 14:47:44 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t0JElaqB029069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Jan 2015 14:47:37 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0JElabC010199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Jan 2015 14:47:36 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0JElaDj012980
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Jan 2015 14:47:36 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 19 Jan 2015 17:49:49 +0300
Message-Id: <1421678989-28577-4-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1421678989-28577-1-git-send-email-alexey.kodanev@oracle.com>
References: <1421678989-28577-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 4/4] runtest/network-stress.appl: fix ssh test names
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
 runtest/network_stress.appl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/network_stress.appl b/runtest/network_stress.appl
index 9aee474..91dbdd3 100644
--- a/runtest/network_stress.appl
+++ b/runtest/network_stress.appl
@@ -2,8 +2,8 @@
 # Stress test for major application protocol (ssh, dns, http, ftp)
 #
 
-ssh4-stress ssh4-stress
-ssh6-stress ssh6-stress
+ssh4-stress ssh-stress
+ssh6-stress ssh-stress -6
 
 dns4-stress dns-stress
 dns6-stress dns-stress -6
-- 
1.7.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
