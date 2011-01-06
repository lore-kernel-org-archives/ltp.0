Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1PanWd-0006ee-Ht
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 10:56:59 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PanWc-0004QC-2q
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 10:56:59 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 63E9F170138
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Jan 2011 18:56:39 +0800 (CST)
Received: from mailserver.fnst.cn.fujitus.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id p06ApXge019087
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 18:51:33 +0800
Message-ID: <4D25A065.1090407@cn.fujitsu.com>
Date: Thu, 06 Jan 2011 18:58:45 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D259E4A.2050704@cn.fujitsu.com>
In-Reply-To: <4D259E4A.2050704@cn.fujitsu.com>
Subject: [LTP]  [PATCH 03/13]Add a missing ";"
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
  .../kernel/syscalls/getpagesize/getpagesize01.c    |    8 +++++---
  1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/getpagesize/getpagesize01.c 
b/testcases/kernel/syscalls/getpagesize/getpagesize01.c
index 09c229e..9b6e27e 100644
--- a/testcases/kernel/syscalls/getpagesize/getpagesize01.c
+++ b/testcases/kernel/syscalls/getpagesize/getpagesize01.c
@@ -77,8 +77,9 @@ int main(int ac, char **av)

          /* check return code */
          if (TEST_RETURN == -1) {
-            tst_resm(TFAIL|TTERRNO, "getpagesize failed"),
-            continue;    /* next loop for MTKERNEL */
+            tst_resm(TFAIL|TTERRNO, "getpagesize failed");
+            /* next loop for MTKERNEL */
+            continue;
          }

          if (STD_FUNCTIONAL_TEST) {
@@ -126,4 +127,5 @@ void cleanup()
       * print errno log if that option was specified.
       */
      TEST_CLEANUP;
-}
\ No newline at end of file
+}
+
-- 
1.7.0.4


-- 
Best Regards,
Tang chen
--------------------------------------------------
Tang Chen
Development Dept.I
Nanjing Fujitsu Nanda Software Tech. Co., Ltd.(FNST)
No.6 Wenzhu Road, Nanjing, 210012, China
TEL: +86+25-86630566-8513
FUJITSU INTERNAL: 7998-8513
FAX: +86+25-83317685
EMail: tangchen@cn.fujitsu.com
--------------------------------------------------
This communication is for use by the intended recipient(s) only and may contain information that is privileged, confidential and exempt from disclosure under applicable law. If you are not an intended recipient of this communication, you are hereby notified that any dissemination, distribution or copying hereof is strictly prohibited.  If you have received this communication in error, please notify me by reply e-mail, permanently delete this communication from your system, and destroy any hard copies you may have printed



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
