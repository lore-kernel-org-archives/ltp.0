Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PXU14-0005pa-Vr
	for ltp-list@lists.sourceforge.net; Tue, 28 Dec 2010 07:30:42 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXU13-0002xc-2u
	for ltp-list@lists.sourceforge.net; Tue, 28 Dec 2010 07:30:42 +0000
Message-ID: <4D199160.3070103@cn.fujitsu.com>
Date: Tue, 28 Dec 2010 15:27:28 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]Fix bug of unshare
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Fix two bugs of unshare01.

1. We have test unshare(CLONE_FS) twice, the first one should be CLONE_FILES.
2. Child process forgot to invoke exit, it will cause test fail.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 testcases/kernel/syscalls/unshare/unshare01.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
index d41edd1..b82777c 100644
--- a/testcases/kernel/syscalls/unshare/unshare01.c
+++ b/testcases/kernel/syscalls/unshare/unshare01.c
@@ -176,7 +176,7 @@ int main(int ac, char **av) {
 				tst_brkm(TFAIL|TTERRNO, cleanup,
 				    "fork() failed.");
 			} else if (TEST_RETURN == 0) {
-				TEST_RETURN = unshare(CLONE_FS);
+				TEST_RETURN = unshare(CLONE_FILES);
 				if (TEST_RETURN == 0) {
 					printf("unshare with CLONE_FILES call "
 					    "succeeded\n");
@@ -268,6 +268,7 @@ int main(int ac, char **av) {
 						rval = 2;
 					}
 				}
+				exit(rval);
 			} else {
 				if (wait(&rval) == -1) {
 					tst_brkm(TBROK|TERRNO, cleanup,
-- 
1.7.0.4




-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
