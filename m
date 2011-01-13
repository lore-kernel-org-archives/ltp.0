Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PdI2m-0006oP-Qq
	for ltp-list@lists.sourceforge.net; Thu, 13 Jan 2011 07:56:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdI2k-0006Ea-H1
	for ltp-list@lists.sourceforge.net; Thu, 13 Jan 2011 07:56:28 +0000
Message-ID: <4D2EB02C.2050109@cn.fujitsu.com>
Date: Thu, 13 Jan 2011 15:56:28 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH] Fix a building error at pthread_join cases.
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

Fix building error of pthread_join cases.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 .../interfaces/pthread_join/threads_scenarii.c     |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/threads_scenarii.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/threads_scenarii.c
index 479b28c..ee9ccbb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/threads_scenarii.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/threads_scenarii.c
@@ -225,7 +225,6 @@ void scenar_init()
 
 			if (scenarii[ i ].schedparam == -1)
 				sp.sched_priority = sched_get_priority_min(old);
->>>>>>> origin
 
 			ret = pthread_attr_setschedparam(&scenarii[ i ].ta, &sp);
 
@@ -487,4 +486,4 @@ int main (int argc, char *argv[])
 
 	PASSED;
 }
-#endif
\ No newline at end of file
+#endif
-- 
1.7.0.4

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
