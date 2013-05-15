Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1UccWo-0007TY-MZ
	for ltp-list@lists.sourceforge.net; Wed, 15 May 2013 14:18:02 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UccWn-00027a-D3
	for ltp-list@lists.sourceforge.net; Wed, 15 May 2013 14:18:02 +0000
From: Markos Chandras <markos.chandras@gmail.com>
Date: Wed, 15 May 2013 15:17:44 +0100
Message-ID: <1368627464-10750-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] prot_hsymlinks.c: Define _GNU_SOURCE which is
	required for O_DIRECTORY
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

From: Markos Chandras <markos.chandras@imgtec.com>

O_DIRECTORY is only available if _GNU_SOURCE is defined
in uClibc toolchains.

This is similar to 0d0c695c8c6657710d1a8ecb4f1264dcd405276b
"open11.c: Define _GNU_SOURCE which is required for O_DIRECTORY"

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index 8feef99..1eec0f9 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -31,6 +31,7 @@
  * of the file or he doesn't have write access to the file.
  */
 
+#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <pwd.h>
-- 
1.8.2.1



------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
