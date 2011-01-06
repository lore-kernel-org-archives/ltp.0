Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1PanSL-00073W-A9
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 10:52:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PanSJ-0006mt-R4
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 10:52:33 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id A170817012C
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Jan 2011 18:52:20 +0800 (CST)
Received: from mailserver.fnst.cn.fujitus.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id p06AlEvl018976
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 18:47:14 +0800
Message-ID: <4D259F62.7040102@cn.fujitsu.com>
Date: Thu, 06 Jan 2011 18:54:26 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D259E4A.2050704@cn.fujitsu.com>
In-Reply-To: <4D259E4A.2050704@cn.fujitsu.com>
Subject: [LTP]  [PATCH 01/13]Add missing parameters for tst_brkm()
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
  testcases/kernel/syscalls/fchmod/fchmod03.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmod/fchmod03.c 
b/testcases/kernel/syscalls/fchmod/fchmod03.c
index 9c4ab34..d0c1255 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod03.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod03.c
@@ -178,7 +178,7 @@ void cleanup()
      TEST_CLEANUP;

      if (close(fd) == -1)
-        tst_brkm(TWARN|TERRNO, "close failed");
+        tst_brkm(TWARN|TERRNO, NULL, "close failed");

      tst_rmdir();

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
