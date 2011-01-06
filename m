Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1PaniE-0007DI-FL
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:08:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PaniD-00081R-KY
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:08:58 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id E8A7D17013B
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Jan 2011 19:08:51 +0800 (CST)
Received: from mailserver.fnst.cn.fujitus.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id p06B2i5a019320
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 19:03:46 +0800
Message-ID: <4D25A333.40501@cn.fujitsu.com>
Date: Thu, 06 Jan 2011 19:10:43 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D259E4A.2050704@cn.fujitsu.com>
In-Reply-To: <4D259E4A.2050704@cn.fujitsu.com>
Subject: [LTP]  [PATCH 11/13]Fix the wrong using of perror()
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
  .../syscalls/sched_setparam/sched_setparam03.c     |    6 ++++--
  1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c 
b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
index eb70588..16f3d3a 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
@@ -121,7 +121,8 @@ int main(int ac, char **av)
              TEST(sched_setparam(getppid(), &param));

              if (TEST_RETURN == -1) {
-                perror("sched_setparam returned %ld", TEST_RETURN);
+                fprintf(stderr, "sched_setparam returned %ld: "
+                    "%s\n", TEST_RETURN, strerror(errno));
                  exit(0);
              }
              exit(1);
@@ -201,4 +202,5 @@ int verify_priority()

      tst_resm(TWARN, "sched_getparam() failed");
      return 0;
-}
\ No newline at end of file
+}
+
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
