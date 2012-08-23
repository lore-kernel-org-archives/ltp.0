Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T4RKZ-0007wO-9F
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 06:55:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T4RKT-0006PQ-8I
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 06:55:51 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7N6tda0001589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Aug 2012 02:55:39 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q7N6tcrR022661
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Aug 2012 02:55:38 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 23 Aug 2012 08:55:36 +0200
Message-Id: <0b20ceed0020e979ec36629e552f77acf96467cc.1345704746.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] pthread_cond_signal: don't count pthread_cond_signals
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Don't count how many pthread_cond_signals it took,
if any fails SIGALRM will trigger testcase failure.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../interfaces/pthread_cond_signal/1-1.c           |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
index bf55b31..5808fed 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
@@ -134,9 +134,7 @@ int main()
 	alarm(5);
 
 	/* loop to wake up the rest threads */
-	i=0;
-	while (waken_num < THREAD_NUM) {
-		++i;
+	for (i=1; i<THREAD_NUM; i++) {
 		fprintf(stderr,"[Main thread] signals to wake up the next thread\n");
 		if (pthread_cond_signal(&td.cond) != 0) {
 			fprintf(stderr,"Main failed to signal the condition\n");
@@ -145,12 +143,6 @@ int main()
 		usleep(100);
 	}
 
-	if (i >= THREAD_NUM) {
-		fprintf(stderr,"[Main thread] had to signal the condition %i times\n", i+1);
-		fprintf(stderr,"[Main thread] to wake up %i threads\n. Test FAILED.\n", THREAD_NUM);
-		exit(PTS_FAIL);
-	}
-
 	/* join all secondary threads */
 	for (i=0; i<THREAD_NUM; i++) {
 	    	if (pthread_join(thread[i], NULL) != 0) {
-- 
1.7.1


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
