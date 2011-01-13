Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PdHrw-0006E0-0w
	for ltp-list@lists.sourceforge.net; Thu, 13 Jan 2011 07:45:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdHrt-00027r-S5
	for ltp-list@lists.sourceforge.net; Thu, 13 Jan 2011 07:45:15 +0000
Message-ID: <4D2EAD4B.8040800@cn.fujitsu.com>
Date: Thu, 13 Jan 2011 15:44:11 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [POSIX][PATCH] Fix a building error at pi_test case.
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

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 .../functional/threads/pi_test/pitest-4.c          |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
index dca4f07..ad940dc 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
@@ -217,7 +217,7 @@ void *thread_tb2(void *arg)
 	DPRINTF(stdout, "#EVENT %f Thread TB2 Started\n",
 		seconds_read() - base_time);
 
-	boost_time.tv_sec = time(NULL) + *(time_t *)timeoutsec;
+	boost_time.tv_sec = time(NULL) + *(time_t *)arg;
 	boost_time.tv_nsec = 0;
 
 	t0 = seconds_read();
@@ -341,4 +341,4 @@ int main(int argc, char **argv)
 	ts_stop = 1;
 	DPRINTF(stderr,"Main Thread: stop sampler thread\n");
 	return 0;
-}
\ No newline at end of file
+}
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
