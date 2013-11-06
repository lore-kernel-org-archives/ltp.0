Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VdyOa-0001a2-UV
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 08:23:24 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VdyOa-0004WB-3Q
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 08:23:24 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA68NGsx015705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 08:23:18 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA68NFPj019205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 08:23:16 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA68NFQY019194
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 08:23:15 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  6 Nov 2013 12:23:07 +0400
Message-Id: <1383726187-25943-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20131105164645.GB21812@rei.suse.cz>
References: <20131105164645.GB21812@rei.suse.cz>
Subject: [LTP] [PATCH V2 2/2] prot_hsymlinks: use SAFE_TOUCH
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

This test case does not need to keep the file descriptors
open after doing creat() on them. So we use SAFE_TOUCH instead
of SAFE_CREAT.

Otherwise on NFS it outputs:

TWARN  :  tst_rmdir: rmobj(/tmpdir/ltp-vdIWJBmrkz/provfaUSg) failed: remove(/tmpdir/ltp-vdIWJBmrkz/provfaUSg/tmp_root/hsym) failed; errno=66: Directory not empty

or:
TWARN  :  tst_rmdir: rmobj(/mnt/proXZmq0T) failed: unlink(/mnt/proXZmq0T/root/.nfs00000000000008470000015e) failed; errno=16: Device or resource busy

The same idea as for 8c200cb8e843724afb49fa6617fceec09ac826a5.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../security/prot_hsymlinks/prot_hsymlinks.c       |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index 558681a..e9948e3 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -45,6 +45,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
+#include "safe_file_ops.h"
 
 char *TCID = "prot_hsymlinks";
 int TST_TOTAL = 396;
@@ -414,7 +415,7 @@ static void ufiles_add(int usr, char *path, int type)
 	struct user_file *ufile = &users[usr].file[file];
 
 	if (type == IS_FILE)
-		SAFE_CREAT(cleanup, path, 0644);
+		SAFE_TOUCH(cleanup, path, 0644, NULL);
 	else
 		SAFE_MKDIR(cleanup, path, 0755);
 
-- 
1.7.1


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
