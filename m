Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vc7jX-0008Ou-Aq
	for ltp-list@lists.sourceforge.net; Fri, 01 Nov 2013 05:57:23 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vc7jV-0002f6-6H
	for ltp-list@lists.sourceforge.net; Fri, 01 Nov 2013 05:57:23 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA15vEf2009263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 1 Nov 2013 05:57:15 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA15vDpb022550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 1 Nov 2013 05:57:14 GMT
Received: from abhmt109.oracle.com (abhmt109.oracle.com [141.146.116.61])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA15vDai024647
	for <ltp-list@lists.sourceforge.net>; Fri, 1 Nov 2013 05:57:13 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri,  1 Nov 2013 09:57:07 +0400
Message-Id: <1383285427-6049-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] prot_hsymlinks: explicitly close file descriptors
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
Cc: vasily.isaenko@oracle.com, alexey.kodanev@oracle.com

This test case does not need to keep the file descriptors
open after doing creat() on them. So we close them right after
SAFE_CREAT.

Otherwise on NFS it outputs:

TWARN  :  tst_rmdir: rmobj(/tmpdir/ltp-vdIWJBmrkz/provfaUSg) failed: remove(/tmpdir/ltp-vdIWJBmrkz/provfaUSg/tmp_root/hsym) failed; errno=66: Directory not empty

or:
TWARN  :  tst_rmdir: rmobj(/mnt/proXZmq0T) failed: unlink(/mnt/proXZmq0T/root/.nfs00000000000008470000015e) failed; errno=16: Device or resource busy

The same idea as for 8c200cb8e843724afb49fa6617fceec09ac826a5.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../security/prot_hsymlinks/prot_hsymlinks.c       |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index 558681a..4c05e3f 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -414,7 +414,7 @@ static void ufiles_add(int usr, char *path, int type)
 	struct user_file *ufile = &users[usr].file[file];
 
 	if (type == IS_FILE)
-		SAFE_CREAT(cleanup, path, 0644);
+		close(SAFE_CREAT(cleanup, path, 0644));
 	else
 		SAFE_MKDIR(cleanup, path, 0755);
 
-- 
1.7.1


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
