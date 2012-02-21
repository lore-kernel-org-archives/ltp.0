Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1RziVY-0000tE-98
	for ltp-list@lists.sourceforge.net; Tue, 21 Feb 2012 05:43:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RziVW-00015b-OV
	for ltp-list@lists.sourceforge.net; Tue, 21 Feb 2012 05:43:24 +0000
Message-ID: <4F432EF6.40601@cn.fujitsu.com>
Date: Tue, 21 Feb 2012 13:43:18 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 2/2] shmem_2nstest: fix a bug of hang
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>


commit d2e9f84 replace fprintf() with snprintf() in tst_print(), but this will
cause container_test.sh hang in case shmem_2nstest.

If compile tst_res.c without -O[level], the case will not hang.

When I test the following cases:
# ./shmem_2nstest none
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : none
shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
shmem_2nstest    1  TPASS  :  Plain cloned process able to access shmem segment created
# ./shmem_2nstest unshare
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : unshare
shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
shmem_2nstest    0  TINFO  :  Cont2: Able to allocate shmem seg with the same key
shmem_2nstest    1  TPASS  :  unshare : In namespace2 unable to access the shmem seg created in Namespace1
# ./shmem_2nstest clone
shmem_2nstest    0  TINFO  :  Shared Memory namespace test : clone

this will hang up.

So I think tst_resm("Cont1") will cause hang.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 .../kernel/containers/sysvipc/shmem_2nstest.c      |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/shmem_2nstest.c b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
index 7a468ad..28e91ff 100644
--- a/testcases/kernel/containers/sysvipc/shmem_2nstest.c
+++ b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
@@ -69,8 +69,8 @@ int check_shmem1(void *vtest)
 	if (id1 == -1)
 		tst_brkm(TFAIL|TERRNO, NULL, "shmget failed");
 
-	tst_resm(TINFO, "Cont1: Able to create shared mem segment");
 	write(p1[1], "done", 5);
+	tst_resm(TINFO, "Cont1: Able to create shared mem segment");
 	tst_exit();
 }
 
-- 
1.7.1

-- 
Best Regards,
Peng


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
