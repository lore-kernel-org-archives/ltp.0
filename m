Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1ROj5G-0005Yy-ER
	for ltp-list@lists.sourceforge.net; Fri, 11 Nov 2011 04:51:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ROj5F-0007SG-HD
	for ltp-list@lists.sourceforge.net; Fri, 11 Nov 2011 04:51:22 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAB4pFfb005346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 10 Nov 2011 23:51:15 -0500
From: Eryu Guan <eguan@redhat.com>
Date: Fri, 11 Nov 2011 12:52:34 +0800
Message-Id: <1320987154-28844-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7"
Subject: [LTP] [PATCH] syscall/dup03: Close all open files in cleanup
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
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.7
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


The 'silly rename' mechanism of NFS creates temporary file .nfsXXX in
NFS mount. The cleanup() in dup03.c doesn't close all open files and
leaves .nfsXXX file in the testing directory. Then rmdir(2) complains
about "Directory not empty".

dup03       1  TPASS  :  dup failed as expected with EMFILE
dup03       0  TWARN  :  tst_rmdir: rmobj(/mnt/nfs/dupxesX9v) failed: remove(/mnt/nfs/dupxesX9v) failed; errno=39: Directory not empty

So close all open files in cleanup().

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/syscalls/dup/dup03.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


--------------1.7.7
Content-Type: text/x-patch;
	name="0001-syscall-dup03-Close-all-open-files-in-cleanup.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscall-dup03-Close-all-open-files-in-cleanup.patch"

diff --git a/testcases/kernel/syscalls/dup/dup03.c b/testcases/kernel/syscalls/dup/dup03.c
index 0b82956..6f29c21 100644
--- a/testcases/kernel/syscalls/dup/dup03.c
+++ b/testcases/kernel/syscalls/dup/dup03.c
@@ -217,8 +217,8 @@ void cleanup()
 
 	TEST_CLEANUP;
 
-	for (i = 3; i <= nfds; i++)
+	for (i = 0; i <= nfds; i++)
 		close(fd[i]);
 
 	tst_rmdir();
-}
\ No newline at end of file
+}

--------------1.7.7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
--------------1.7.7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.7--



