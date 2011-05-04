Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QHZJv-0006bA-Kb
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 10:28:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QHZJu-0000Qq-MD
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 10:28:39 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p44ASWqH017285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 May 2011 06:28:32 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Wed,  4 May 2011 18:28:26 +0800
Message-Id: <496372751cd0fb99e60661b99f2c0601ba13edfa.1304504870.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] [syscalls] mbind01: fix compile
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


a typo fix, forgot NULL in tst_brkm. And seems tst_resm+tst_exit could
be replaced by tst_brkm().

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/mbind/mbind01.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


--------------1.7.1
Content-Type: text/x-patch; name="0001-syscalls-mbind01-fix-compile.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-mbind01-fix-compile.patch"

diff --git a/testcases/kernel/mem/mbind/mbind01.c b/testcases/kernel/mem/mbind/mbind01.c
index 9d99873..fc97174 100644
--- a/testcases/kernel/mem/mbind/mbind01.c
+++ b/testcases/kernel/mem/mbind/mbind01.c
@@ -142,13 +142,11 @@ void usage(void)
 }
 #else /* libnuma v1 */
 int main(void) {
-	tst_brkm(TCONF, "XXX: test is only supported on libnuma v2.");
-	tst_exit();
+	tst_brkm(TCONF, NULL, "XXX: test is only supported on libnuma v2.");
 }
 #endif
 #else /* no NUMA */
 int main(void) {
-	tst_resm(TCONF, "no NUMA development packages installed.");
-	tst_exit();
+	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
 }
 #endif

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



