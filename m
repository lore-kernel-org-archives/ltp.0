Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1Slzu8-0007Bz-J2
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 10:00:20 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Slzu4-0002Ph-1p
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 10:00:20 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q63A0APa018870
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Tue, 3 Jul 2012 03:00:10 -0700 (PDT)
From: Kang Kai <kai.kang@windriver.com>
Date: Tue, 3 Jul 2012 17:59:59 +0800
Message-ID: <1341309599-10008-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] pthread_cond_signal/1-1: fails on routerstation
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

Case pthread_cond_signal/1-1 fails on routerstation. The OS is Yocto
linux 1.2 with kernel 3.0.24, and c library is eglibc 2.15.

The fail log:
  [Thread 0x0x2c56d4b0] started and locked the mutex
  [Thread 0x0x2c56d4b0] is waiting for the cond
  [Thread 0x0x2bd6d4b0] started and locked the mutex
  [Thread 0x0x2bd6d4b0] is waiting for the cond
  [Thread 0x0x2b56d4b0] started and locked the mutex
  [Thread 0x0x2b56d4b0] is waiting for the cond
  [Main thread] signals a condition
  [Thread 0x0x2c56d4b0] was wakened and acquired the mutex again
  [Thread 0x0x2c56d4b0] released the mutex
  [Main thread] 1 waiters were wakened
  [Main thread] signals to wake up the next thread
  [Thread 0x0x2bd6d4b0] was wakened and acquired the mutex again
  [Thread 0x0x2bd6d4b0] released the mutex
  [Main thread] signals to wake up the next thread
  [Main thread] signals to wake up the next thread
  [Main thread] signals to wake up the next thread
  [Main thread] signals to wake up the next thread
  [Main thread] signals to wake up the next thread
  [Thread 0x0x2b56d4b0] was wakened and acquired the mutex again
  [Main thread] had to signal the condition 7 times
  [Main thread] to wake up 3 threads
  . Test FAILED.

The main thread call pthread_cond_signal try to signal the child threads
those are waiting on the condition, then call usleep(100) to relinquish
the cpu. But 100 useconds is not enough and the main thread continue to
run. So the case fails.

Increase the sleep timeto 1000 useconds to make the case pass.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../interfaces/pthread_cond_signal/1-1.c           |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
index bf55b31..910931d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
@@ -142,7 +142,7 @@ int main()
 			fprintf(stderr,"Main failed to signal the condition\n");
 			exit(PTS_UNRESOLVED);
 		}
-		usleep(100);
+		usleep(1000);
 	}
 
 	if (i >= THREAD_NUM) {
@@ -160,4 +160,4 @@ int main()
 	}
 	printf("Test PASSED\n");
 	return PTS_PASS;
-}
\ No newline at end of file
+}
-- 
1.7.5.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
