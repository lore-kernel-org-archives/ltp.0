Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z735f-0003kb-Uo
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 14:52:51 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z735a-0003NO-OV
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 14:52:51 +0000
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t5MEqe9c026928
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:52:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t5MEqe1h019108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:52:40 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t5MEqbZh024267
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Jun 2015 14:52:37 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 22 Jun 2015 17:55:38 +0300
Message-Id: <1434984942-20691-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/5] network/mc_opts: gitignore built binaries
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

Renamed in 5a7056d46366 ("multicast/mc_opts: Some cleanup")

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/.gitignore |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
index 95a3862..ae3402c 100644
--- a/testcases/network/.gitignore
+++ b/testcases/network/.gitignore
@@ -15,8 +15,8 @@
 /multicast/mc_commo/mc_recv
 /multicast/mc_commo/mc_send
 /multicast/mc_member/member
-/multicast/mc_opts/opts
-/multicast/mc_opts/opts_e
+/multicast/mc_opts/mc_verify_opts
+/multicast/mc_opts/mc_verify_opts_error
 /nfs/nfs01/open_files
 /nfs/nfs04/nfs04_create_file
 /nfs/nfs_fsstress/fsstress
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
