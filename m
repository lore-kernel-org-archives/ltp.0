Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lina.zhao@windriver.com>) id 1Oxbgz-0007Rt-V5
	for ltp-list@lists.sourceforge.net; Mon, 20 Sep 2010 08:25:42 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Oxbgv-0003EL-Dv
	for ltp-list@lists.sourceforge.net; Mon, 20 Sep 2010 08:25:41 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o8K8PVH4001978
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Sep 2010 01:25:31 -0700 (PDT)
Message-ID: <4C971A85.4030000@windriver.com>
Date: Mon, 20 Sep 2010 16:25:41 +0800
From: "lina.zhao" <lina.zhao@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050906080909090409030607"
Subject: [LTP] [patch] madvise03 address issue
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
--------------050906080909090409030607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In the ltp madvise03 case, it will allocate a share memory
whose size is equal to the max share memory value.
The max share memory value can be changed to a bigger one
through change /proc/sys/kernel/shmmax.
then the 0x22000000 is not a invalid address.
So change the address to NULL to let the system choose a valid address.

Thanks,

Lina

--------------050906080909090409030607
Content-Type: text/x-diff;
 name="0001-madvise03-address-issue.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-madvise03-address-issue.patch"

From adbdd3f74ab425a654523234ca24034d40468519 Mon Sep 17 00:00:00 2001
From: Lina Zhao <lina.zhao@windriver.com>
Date: Mon, 20 Sep 2010 15:41:42 +0800
Subject: [PATCH] madvise03 address issue

In the ltp madvise03 case, it will allocate a share memory
whose size is equal to the max share memory value.
The max share memory value can be changed to a bigger one
through change /proc/sys/kernel/shmmax.
then the 0x22000000 is not a invalid address.
So change the address to NULL to let the system choose a valid address.

Signed-off-by: Lina Zhao <lina.zhao@windriver.com>
---
 testcases/kernel/syscalls/madvise/madvise03.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise03.c b/testcases/kernel/syscalls/madvise/madvise03.c
index 2527865..269f292 100644
--- a/testcases/kernel/syscalls/madvise/madvise03.c
+++ b/testcases/kernel/syscalls/madvise/madvise03.c
@@ -203,14 +203,14 @@ int main(int argc, char *argv[])
 			tst_brkm(TBROK, cleanup, "shmget error");
 		}
 
-		/* Attach shared memory segment to 0x22000000 address */
+		/* Attach shared memory segment to random address */
 		if ((addr1 =
-		     shmat(shmid1, (void *)0x22000000, 0)) == (void *)-1) {
+		     shmat(shmid1, NULL, 0)) == (void *)-1) {
 			tst_brkm(TBROK, cleanup, "shmat error");
 		}
 
 		/*(1) Test case for MADV_REMOVE */
-		TEST(madvise((void *)0x22000000, 4096, MADV_REMOVE));
+		TEST(madvise((void *)addr1, 4096, MADV_REMOVE));
 		check_and_print("MADV_REMOVE");
 
 		/*(2) Test case for MADV_DONTFORK */
-- 
1.6.3.1


--------------050906080909090409030607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--------------050906080909090409030607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050906080909090409030607--

