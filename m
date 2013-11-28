Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Vm0XN-0003ES-Us
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 12:17:41 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vm0XN-0001mw-4z
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 12:17:41 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rASCHYak028197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Nov 2013 12:17:35 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rASCHXqI005652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Nov 2013 12:17:34 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rASCHXPr009904
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Nov 2013 12:17:33 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 28 Nov 2013 16:17:15 +0400
Message-Id: <1385641035-12291-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1385641035-12291-1-git-send-email-alexey.kodanev@oracle.com>
References: <1385641035-12291-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 3/3] device-drivers: acpi: enable build and run
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
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/kernel_misc                      |    1 +
 testcases/kernel/device-drivers/Makefile |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 3e3d016..c421ea0 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -4,3 +4,4 @@ rtc01 rtc01
 block_dev block_dev
 tpci tpci
 tbio tbio
+ltp_acpi ltp_acpi
diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index 9f80094..15294cf 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -18,7 +18,8 @@ top_srcdir	?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-SUBDIRS		:= block \
+SUBDIRS		:= acpi \
+		   block \
 		   pci \
 		   rtc \
 		   tbio \
-- 
1.7.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
