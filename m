Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QEAHQ-0000PP-1z
	for ltp-list@lists.sourceforge.net; Mon, 25 Apr 2011 01:08:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QEAHP-0005Ww-3Y
	for ltp-list@lists.sourceforge.net; Mon, 25 Apr 2011 01:08:00 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3P17rUh004373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Sun, 24 Apr 2011 21:07:53 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Mon, 25 Apr 2011 09:07:37 +0800
Message-Id: <2b206ae4190619ae155651ae96351a8bccba5cdf.1303693637.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] get_mempolicy, mbind: use TCONF rather than TBROK
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


get_mempolicy01 and mbind01 testcases are designed for NUMA api v1 which
means they could not be run on systems with NUMA api v2. If so, the
tests should give a TCONF message rather than TBROK.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 .../syscalls/get_mempolicy/get_mempolicy01.c       |    2 +-
 testcases/kernel/syscalls/mbind/mbind01.c          |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-get_mempolicy-mbind-use-TCONF-rather-than-TBROK.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-get_mempolicy-mbind-use-TCONF-rather-than-TBROK.patch"

diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index b36ede3..faebd8b 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -377,7 +377,7 @@ int main(int argc, char **argv) {
 }
 #else
 int main(void) {
-	tst_brkm(TBROK, NULL, "XXX: test is broken on libnuma v2 (read numa_helpers.h for more details).");
+	tst_brkm(TCONF, NULL, "XXX: test is broken on libnuma v2 (read numa_helpers.h for more details).");
 	tst_exit();
 }
 #endif
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 5f9a198..297f074 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -405,7 +405,7 @@ int main(int argc, char **argv) {
 }
 #else /* libnuma v2 */
 int main(void) {
-	tst_resm(TBROK, "XXX: test is broken on libnuma v2 (read numa_helpers.h for more details).");
+	tst_resm(TCONF, "XXX: test is broken on libnuma v2 (read numa_helpers.h for more details).");
 	tst_exit();
 }
 #endif
@@ -414,4 +414,4 @@ int main(void) {
 	tst_resm(TCONF, "System doesn't have required numa support");
 	tst_exit();
 }
-#endif
\ No newline at end of file
+#endif

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



