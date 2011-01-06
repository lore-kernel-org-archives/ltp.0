Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1PanYU-0007Q8-Th
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 10:58:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PanYT-0007CG-WC
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 10:58:54 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id CEB8B170141
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Jan 2011 18:58:47 +0800 (CST)
Received: from mailserver.fnst.cn.fujitus.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id p06Arffi019139
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 18:53:42 +0800
Message-ID: <4D25A0E5.10407@cn.fujitsu.com>
Date: Thu, 06 Jan 2011 19:00:53 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D259E4A.2050704@cn.fujitsu.com>
In-Reply-To: <4D259E4A.2050704@cn.fujitsu.com>
Subject: [LTP]  [PATCH 04/13]Correct the wrong parameters names
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
  testcases/kernel/syscalls/lchown/lchown02.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/lchown/lchown02.c 
b/testcases/kernel/syscalls/lchown/lchown02.c
index 9a213a2..04cb943 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -151,7 +151,7 @@ int main(int argc, char *argv[])
      gid_t group_id;
      int i;

-    if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+    if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
          tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

      setup();
-- 
1.7.0.4

-- 
Best Regards,
Tang chen



------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
