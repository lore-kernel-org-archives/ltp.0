Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QD9l9-0006x2-61
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 06:22:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QD9l8-0003eV-EJ
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 06:22:31 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3M6MOWB011476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Apr 2011 02:22:24 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Fri, 22 Apr 2011 14:22:14 +0800
Message-Id: <14a46a643c1e7c7b912be1a237067f79b203baa1.1303453311.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] [mm] mbind01: fix compile issue in RHEL5
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


mem/mbind01 was designed to test NUMA v2 lib, it will cause compile
error with old NUMA API version, this patch fixes this issue.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/mbind/mbind01.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-mm-mbind01-fix-compile-issue-in-RHEL5.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-mbind01-fix-compile-issue-in-RHEL5.patch"

diff --git a/testcases/kernel/mem/mbind/mbind01.c b/testcases/kernel/mem/mbind/mbind01.c
index 2bac1ca..9d99873 100644
--- a/testcases/kernel/mem/mbind/mbind01.c
+++ b/testcases/kernel/mem/mbind/mbind01.c
@@ -45,6 +45,8 @@ int TST_TOTAL = 1;
 #include <string.h>
 #include <errno.h>
 
+#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
+
 static unsigned long pagesize;
 static int opt_node;
 static char *opt_nodestr;
@@ -138,7 +140,12 @@ void usage(void)
 {
 	printf("  -n      Number of NUMA nodes\n");
 }
-
+#else /* libnuma v1 */
+int main(void) {
+	tst_brkm(TCONF, "XXX: test is only supported on libnuma v2.");
+	tst_exit();
+}
+#endif
 #else /* no NUMA */
 int main(void) {
 	tst_resm(TCONF, "no NUMA development packages installed.");

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Fulfilling the Lean Software Promise
Lean software platforms are now widely adopted and the benefits have been 
demonstrated beyond question. Learn why your peers are replacing JEE 
containers with lightweight application servers - and what you can gain 
from the move. http://p.sf.net/sfu/vmware-sfemails
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



