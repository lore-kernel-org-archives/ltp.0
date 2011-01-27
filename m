Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1PiOWi-00032b-Sx
	for ltp-list@lists.sourceforge.net; Thu, 27 Jan 2011 09:52:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PiOWh-0001vK-Dk
	for ltp-list@lists.sourceforge.net; Thu, 27 Jan 2011 09:52:28 +0000
Message-ID: <4D414061.1060502@cn.fujitsu.com>
Date: Thu, 27 Jan 2011 17:52:33 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] sched_getscheduler01.c: fix error of wrong return code
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

Hi Garrett,

"return -1" should be replaced with "tst_exit()".

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 .../sched_getscheduler/sched_getscheduler01.c      |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
index 495ed44..3e938ee 100644
--- a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
+++ b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
@@ -125,7 +125,7 @@ int main(int ac, char **av)
 	}
 	cleanup();
 
-	return -1;
+	tst_exit();
  }
 
 /*
@@ -155,4 +155,4 @@ void cleanup()
 	 */
 	TEST_CLEANUP;
 
-}
\ No newline at end of file
+}
-- 
1.7.0.1


-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
