Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1PanjD-00040b-RJ
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:09:59 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PanjC-0005BY-NA
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:09:59 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 95EA7170138
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Jan 2011 19:09:52 +0800 (CST)
Received: from mailserver.fnst.cn.fujitus.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id p06B4kpi019356
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 19:04:46 +0800
Message-ID: <4D25A37D.9080303@cn.fujitsu.com>
Date: Thu, 06 Jan 2011 19:11:57 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D259E4A.2050704@cn.fujitsu.com>
In-Reply-To: <4D259E4A.2050704@cn.fujitsu.com>
Subject: [LTP]  [PATCH 12/13]Add a missing variable TST_TOTAL
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
  .../kernel/syscalls/socketpair/socketpair02.c      |    6 ++++--
  1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/socketpair/socketpair02.c 
b/testcases/kernel/syscalls/socketpair/socketpair02.c
index e898066..7ac74f3 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair02.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
@@ -65,7 +65,8 @@
  extern char *TESTDIR;        /* temporary dir created by tst_tmpdir() */

  /* Global Variables */
-char *TCID = "socketpair02";    /* test program identifier.              */
+char *TCID = "socketpair02";    /* test program identifier.*/
+int TST_TOTAL = 1;

  /* Extern Global Functions */
  /******************************************************************************/
@@ -162,4 +163,5 @@ int main(int argc, char *argv[])
      tst_resm(TPASS, "socketpair(SOCK_NONBLOCK) PASSED");
      cleanup();
      tst_exit();
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
