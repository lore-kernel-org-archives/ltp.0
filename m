Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z735h-000242-UY
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 14:52:53 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z735c-0003NQ-4j
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 14:52:53 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t5MEqggk007984
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:52:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t5MEqfxd019239
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:52:41 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t5MEqfHC018144
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:52:41 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 22 Jun 2015 17:55:41 +0300
Message-Id: <1434984942-20691-4-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1434984942-20691-1-git-send-email-alexey.kodanev@oracle.com>
References: <1434984942-20691-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 4/5] kernel/io/stress_floppy/datafiles: ignore
	generated *K_file
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
 .../io/stress_floppy/datafiles/dumpdir/.gitignore  |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/io/stress_floppy/datafiles/dumpdir/.gitignore

diff --git a/testcases/kernel/io/stress_floppy/datafiles/dumpdir/.gitignore b/testcases/kernel/io/stress_floppy/datafiles/dumpdir/.gitignore
new file mode 100644
index 0000000..79e5b99
--- /dev/null
+++ b/testcases/kernel/io/stress_floppy/datafiles/dumpdir/.gitignore
@@ -0,0 +1 @@
+*K_file
-- 
1.7.1


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
