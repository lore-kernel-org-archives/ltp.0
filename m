Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VRzB5-0007dm-M3
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 06:47:55 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VRzB4-0003r3-JR
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 06:47:55 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r946lm9f028110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Oct 2013 02:47:48 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id r946lllD025096
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Oct 2013 02:47:48 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  4 Oct 2013 08:47:44 +0200
Message-Id: <2e3e4287d2d3551db34c734971f0a3145c14a7d5.1380869051.git.jstancek@redhat.com>
In-Reply-To: <ac99f1c859b7e69d93ed09bc9223f2aabf325a5a.1380794505.git.jstancek@redhat.com>
References: <ac99f1c859b7e69d93ed09bc9223f2aabf325a5a.1380794505.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2 3/3] pthread_attr_setschedpolicy/2-1.c: bind
	threads to single CPU
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

To make sure that threads are blocked on mutex, bind all to single CPU.
Because they all use SCHED_FIFO policy with main thread having the lowest
priority, main will progress only after three created threads block on
mutex.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../interfaces/pthread_attr_setschedpolicy/2-1.c   |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
index 80ce906..af8e3e4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
@@ -20,6 +20,7 @@
  *   Date:  20/05/2011
  */
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
 #include <pthread.h>
@@ -27,11 +28,13 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <posixtest.h>
+#include <affinity.h>
 
 /* Priorities for the threads, must be unique, non-zero, and ordered */
 #define PRIO_HIGH	20
 #define PRIO_MED	10
 #define PRIO_LOW	5
+#define PRIO_MAIN	1
 
 static int priorities[3];
 
@@ -142,9 +145,20 @@ int main(void)
 	pthread_t t1;
 	pthread_t t2;
 	pthread_t t3;
+	struct sched_param sp;
 
 	status = PTS_UNRESOLVED;
 
+
+	rc = set_affinity(0);
+	if (rc)
+		FAIL_AND_EXIT("set_affinity", errno);
+
+	sp.sched_priority = PRIO_MAIN;
+	rc = pthread_setschedparam(pthread_self(), SCHED_FIFO, &sp);
+	if (rc)
+		FAIL_AND_EXIT("pthread_setschedparam()", rc);
+
 	rc = pthread_mutex_lock(&mutex);
 	if (rc)
 		FAIL_AND_EXIT("pthread_mutex_lock()", rc);
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
