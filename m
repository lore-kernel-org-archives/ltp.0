Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Vo8kT-0001M2-W4
	for ltp-list@lists.sourceforge.net; Wed, 04 Dec 2013 09:28:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vo8kT-00052s-7m
	for ltp-list@lists.sourceforge.net; Wed, 04 Dec 2013 09:28:01 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rB49RrbY024964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Dec 2013 09:27:54 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rB49RqBw016697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Dec 2013 09:27:53 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rB49RqMQ016678
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Dec 2013 09:27:52 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  4 Dec 2013 13:27:32 +0400
Message-Id: <1386149252-26939-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1386149252-26939-1-git-send-email-alexey.kodanev@oracle.com>
References: <1386149252-26939-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/2] device-drivers: uaccess: enable build and run
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
 testcases/kernel/device-drivers/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 3e3d016..51b2a6c 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -4,3 +4,4 @@ rtc01 rtc01
 block_dev block_dev
 tpci tpci
 tbio tbio
+uaccess uaccess
diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index 9f80094..b4ed12b 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -22,5 +22,6 @@ SUBDIRS		:= block \
 		   pci \
 		   rtc \
 		   tbio \
+		   uaccess \
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
-- 
1.7.1


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
