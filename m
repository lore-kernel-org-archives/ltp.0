Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z735b-0004kJ-2a
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 14:52:47 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z735Z-0001F6-8B
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 14:52:47 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t5MEqdLD026849
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:52:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t5MEqdnR018956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:52:39 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t5MEqcrS003792
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:52:38 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 22 Jun 2015 17:55:39 +0300
Message-Id: <1434984942-20691-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1434984942-20691-1-git-send-email-alexey.kodanev@oracle.com>
References: <1434984942-20691-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/5] network/mc_member: gitignore built binaries
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

Renamed in cb49919064fe ("multicast/mc_member: Some cleanup")

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/.gitignore |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
index ae3402c..aa6d4da 100644
--- a/testcases/network/.gitignore
+++ b/testcases/network/.gitignore
@@ -14,7 +14,7 @@
 /multicast/mc_gethost/mc_gethost
 /multicast/mc_commo/mc_recv
 /multicast/mc_commo/mc_send
-/multicast/mc_member/member
+/multicast/mc_member/mc_member_test
 /multicast/mc_opts/mc_verify_opts
 /multicast/mc_opts/mc_verify_opts_error
 /nfs/nfs01/open_files
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
