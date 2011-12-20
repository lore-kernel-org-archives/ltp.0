Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <YanFeng.Shang@windriver.com>) id 1RcqIK-00013G-Nt
	for ltp-list@lists.sourceforge.net; Tue, 20 Dec 2011 03:23:12 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RcqII-0003uc-B1
	for ltp-list@lists.sourceforge.net; Tue, 20 Dec 2011 03:23:12 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBK3N49w019092
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Mon, 19 Dec 2011 19:23:04 -0800 (PST)
From: Shang Yanfeng <YanFeng.Shang@windriver.com>
Date: Tue, 20 Dec 2011 11:23:02 +0800
Message-ID: <1324351382-22497-1-git-send-email-YanFeng.Shang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] redefine NCPU = sysconf(_SC_NPROCESSORS_CONF)
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
To: ltp-list@lists.sourceforge.net

testcase create NCPU=4 threads running with a high priority with the same sched
policy and one with a low-priority. The low-priority thread should not run
until the other threads stop running, unless the machine has more than NCPU processors
when cpu core >4,testcase failed. redefine NCPU = sysconf(_SC_NPROCESSORS_CONF)

signed-off-by: YanFeng.Shang  <YanFeng.Shang@windriver.com>
---
 .../conformance/interfaces/pthread_create/1-6.c    |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-6.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-6.c
index 5424439..932367a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_create/1-6.c
@@ -78,7 +78,7 @@
 #endif
 
 /* The value below shall be >= to the # of CPU on the test architecture */
-#define NCPU 	(4)
+#define NCPU sysconf(_SC_NPROCESSORS_CONF) 
 
 /********************************************************************************************/
 /***********************************    Test cases  *****************************************/
@@ -274,4 +274,4 @@ void * threaded (void * arg)
 	if (ret == -1)  {  UNRESOLVED(errno, "Failed to post the semaphore");  }
 
 	return arg;
-}
\ No newline at end of file
+}
-- 
1.6.3.1


------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
