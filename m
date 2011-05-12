Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lliubbo@gmail.com>) id 1QKR5y-00017D-K6
	for ltp-list@lists.sourceforge.net; Thu, 12 May 2011 08:18:06 +0000
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]
	helo=TX2EHSOBE001.bigfish.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1QKR5x-00089t-Qu
	for ltp-list@lists.sourceforge.net; Thu, 12 May 2011 08:18:06 +0000
From: Bob Liu <lliubbo@gmail.com>
Date: Thu, 12 May 2011 16:37:12 +0800
Message-ID: <1305189432-24927-1-git-send-email-lliubbo@gmail.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] testcases: syscall: readlink: fix except return val
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

This kernel commit "readlinkat(), fchownat() and fstatat() with empty relative
pathnames"(65cfc6722361570bfe255698d9cd4dccaf47570d) broken POSIX scope which
makes readlink03 fail like this:

readlink03    1  TFAIL  :  readlink() failed, Symlink Pathname is empty,
errno=22, expected errno=2

This patch fix the except return val from -ENOENT to -EINVAL.

Signed-off-by: Bob Liu <lliubbo@gmail.com>
---
 testcases/kernel/syscalls/readlink/readlink03.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
index 0535b25..dbc20e6 100644
--- a/testcases/kernel/syscalls/readlink/readlink03.c
+++ b/testcases/kernel/syscalls/readlink/readlink03.c
@@ -132,7 +132,7 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
 	TEST_FILE2, "File is not symbolic link", EINVAL, 1, no_setup}, {
 	Longpathname, "Symlink path too long", ENAMETOOLONG, 1, lpath_setup},
 	{
-	"", "Symlink Pathname is empty", ENOENT, 1, no_setup}, {
+	"", "Symlink Pathname is empty", EINVAL, 1, no_setup}, {
 	NULL, NULL, 0, 0, no_setup}
 };
 
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
