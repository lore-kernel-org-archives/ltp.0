Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WTAXu-000725-Di
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:40:38 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WTAXs-00077u-Ks
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:40:38 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2RDeUX1022930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:40:31 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDeTPT027353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:40:29 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDeTor022457
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:40:29 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 27 Mar 2014 17:40:43 +0400
Message-Id: <1395927643-11670-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] device-drivers/rcu: add test to
	device-drivers/Makefile
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
 testcases/kernel/device-drivers/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index d207736..37b6c64 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -21,6 +21,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
 SUBDIRS		:= acpi \
 		   block \
 		   pci \
+		   rcu \
 		   rtc \
 		   tbio \
 		   uaccess
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
