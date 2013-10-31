Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VbnpI-0004X1-UH
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:42:00 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VbnpI-0004U4-3n
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 08:42:00 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9V8fr6R005949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 08:41:54 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9V8fqqu012916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 08:41:53 GMT
Received: from abhmt108.oracle.com (abhmt108.oracle.com [141.146.116.60])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9V8fqHt007541
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 08:41:52 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 31 Oct 2013 12:41:47 +0400
Message-Id: <1383208907-9881-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] fcntl/fcntl16: close fd before unlink
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

This testcase fails on NFS but doesn't remove its
working directory on exit (NFS silly rename):

TWARN  :  tst_rmdir: rmobj(/mnt/fcn1GHJ8g) failed: unlink(/mnt/fcn1GHJ8g/.nfs0000000000000c4200000001) failed; errno=16: Device or resource busy

Fixed.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/fcntl/fcntl16.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
index 8bdb6b5..12696a8 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl16.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
@@ -476,6 +476,7 @@ int run_test(int file_flag, int file_mode, int start, int end)
 			tst_resm(TFAIL, "First parent lock failed");
 			tst_resm(TFAIL, "Test case %d, errno = %d", test + 1,
 				 errno);
+			close(fd);
 			unlink(tmpname);
 			return 1;
 		}
@@ -489,6 +490,7 @@ int run_test(int file_flag, int file_mode, int start, int end)
 				tst_resm(TFAIL, "Second parent lock failed");
 				tst_resm(TFAIL, "Test case %d, errno = %d",
 					 test + 1, errno);
+				close(fd);
 				unlink(tmpname);
 				return 1;
 			}
@@ -559,6 +561,7 @@ int run_test(int file_flag, int file_mode, int start, int end)
 			tst_resm(TFAIL, "Third parent lock failed");
 			tst_resm(TFAIL, "Test case %d, errno = %d",
 				 test + 1, errno);
+			close(fd);
 			unlink(tmpname);
 			return 1;
 		}
@@ -572,6 +575,7 @@ int run_test(int file_flag, int file_mode, int start, int end)
 				tst_resm(TINFO, "Fourth parent lock failed");
 				tst_resm(TINFO, "Test case %d, errno = %d",
 					 test + 1, errno);
+				close(fd);
 				unlink(tmpname);
 				return 1;
 			}
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
