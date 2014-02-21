Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sweekar.pinto@oracle.com>) id 1WGogn-0000L7-IL
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 11:54:45 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WGogm-0002un-FY
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 11:54:45 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1LBsc1x003528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 11:54:38 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1LBsbAW002759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 11:54:38 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1LBsbPY014705
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 11:54:37 GMT
From: Sweekar Pinto <sweekar.pinto@oracle.com>
Date: Thu, 20 Feb 2014 19:05:53 -0500
Message-Id: <1392941153-8643-3-git-send-email-sweekar.pinto@oracle.com>
In-Reply-To: <1392941153-8643-1-git-send-email-sweekar.pinto@oracle.com>
References: <1392941153-8643-1-git-send-email-sweekar.pinto@oracle.com>
Subject: [LTP] [PATCH v2 3/3] Change crashkernel param to 256M@128M
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

-We always get "crashkernel reservation failed -memory is in use"
 with crashkernel=64M@16M or crashkernel=128M@16M on all of our
 x86 test hardware. Here 256M@128M seems to be the best fit
 based on empirical data.

Signed-off-by: Sweekar Pinto <sweekar.pinto@oracle.com>
---
 testcases/kdump/lib/setup.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kdump/lib/setup.sh b/testcases/kdump/lib/setup.sh
index 5bc54bb..3e53f1a 100755
--- a/testcases/kdump/lib/setup.sh
+++ b/testcases/kdump/lib/setup.sh
@@ -86,11 +86,11 @@ echo "Modify Boot Loader."
 if [ "${arch}" = "ppc64" ]; then
     args="crashkernel=256M@32M xmon=off"
 elif [ "${arch}" = "i686" ]; then
-    args="crashkernel=128M@16M nmi_watchdog=1"
+    args="crashkernel=256M@128M nmi_watchdog=1"
 elif [ "${arch}" = "ia64" ]; then
     args="crashkernel=512M@256M"
 else
-    args="crashkernel=128M@16M"
+    args="crashkernel=256M@128M"
 fi
 
 if [ -x "/sbin/grubby" ]; then
-- 
1.7.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
