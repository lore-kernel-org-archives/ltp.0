Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lliubbo@gmail.com>) id 1QKPpH-0001IK-U8
	for ltp-list@lists.sourceforge.net; Thu, 12 May 2011 06:56:47 +0000
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]
	helo=TX2EHSOBE009.bigfish.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1QKPpH-0007lf-5h
	for ltp-list@lists.sourceforge.net; Thu, 12 May 2011 06:56:47 +0000
From: Bob Liu <lliubbo@gmail.com>
Date: Thu, 12 May 2011 14:59:53 +0800
Message-ID: <1305183593-25512-1-git-send-email-lliubbo@gmail.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] testcases: syscall: sockioctl: fix except return val
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
To: ltp-list@lists.sf.net

Since new kerenl change, sockioctl01 always fail like this:

sockioctl01    4  TFAIL  :  ATMARK on UDP ; returned -1 (expected -1), errno
25 (expected 22)

This patch fix the except return val from EINVAL to ENOTTY.

Signed-off-by: Bob Liu <lliubbo@gmail.com>
---
 sockioctl01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index aa66bc3..6ad7a4a 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -108,7 +108,7 @@ struct test_case_t {		/* test case structure */
 	{
 	PF_INET, SOCK_DGRAM, 0, SIOCATMARK, &optval,
 		    (struct sockaddr *)&fsin1, sizeof(fsin1), -1,
-		    EINVAL, setup1, cleanup1, "ATMARK on UDP"}
+		    ENOTTY, setup1, cleanup1, "ATMARK on UDP"}
 	, {
 	PF_INET, SOCK_DGRAM, 0, SIOCGIFCONF, &ifc,
 		    (struct sockaddr *)&fsin1, sizeof(fsin1), 0,
-- 
1.6.3.3



------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
