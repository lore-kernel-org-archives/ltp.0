Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1WenVK-00056C-OI
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 15:30:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WenVI-00074X-Sy
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 15:30:02 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3SFTqFd025986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Apr 2014 15:29:53 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3SFTpW8011069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Apr 2014 15:29:51 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3SFTpkw022266
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Apr 2014 15:29:51 GMT
From: shuang.qiu@oracle.com
Date: Mon, 28 Apr 2014 23:29:39 +0800
Message-Id: <1398698979-6938-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] device-drivers/rtc: Use /dev/rtc0 as device node for
	rtc test
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

From: Shuang Qiu <shuang.qiu@oracle.com>

The old rtc device node /dev/rtc is not much supported on some
of the distributes,i.e. RHEL5 or OL5.Use the newer one /dev/rtc0 instead.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 runtest/kernel_misc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 01b0acb..1a294b6 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -1,6 +1,6 @@
 kmsg01 kmsg01
 fw_load fw_load
-rtc01 rtc01
+rtc01 rtc01 -d /dev/rtc0
 block_dev block_dev
 tpci tpci
 tbio tbio
-- 
1.7.9.5


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
