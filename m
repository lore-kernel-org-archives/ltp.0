Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1Ur8RR-0002VI-3g
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 15:12:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ur8RP-00034i-Bk
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 15:12:29 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5OFCLJv008322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Jun 2013 11:12:21 -0400
From: Eryu Guan <eguan@redhat.com>
Date: Mon, 24 Jun 2013 23:12:07 +0800
Message-Id: <1372086727-27722-1-git-send-email-eguan@redhat.com>
Subject: [LTP] [PATCH] dup2/dup205: close all fds before tst_rmdir()
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

Close all open fds before calling tst_rmdir() to avoid TWARN caused by
NFS silly rename when removing temp dir caused by NFS silly rename.

dup205      0  TWARN  :  tst_rmdir: rmobj(/mnt/nfs/dupbA5J5i) failed: unlink(/mnt/nfs/dupbA5J5i/.nfs0000000000f4805b00000005) failed; errno=16: Device or resource busy

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/syscalls/dup2/dup205.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
index c728fcc..0528beb 100644
--- a/testcases/kernel/syscalls/dup2/dup205.c
+++ b/testcases/kernel/syscalls/dup2/dup205.c
@@ -112,8 +112,8 @@ int main(int ac, char *av[])
 			}
 		}
 		unlink(pfilname);
-		if (ifile > 0)
-			close(fildes[ifile - 1]);
+		for (ifile = fildes[0]; ifile < min + 10; ifile++)
+			close(fildes[ifile]);
 		if (local_flag == PASSED) {
 			tst_resm(TPASS, "Test passed.");
 		} else {
-- 
1.8.3.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
