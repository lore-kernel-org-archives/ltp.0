Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OHURa-0004Lj-RB
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:42 +0000
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OHURZ-0005mh-EF
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:42 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4R37tMq021099
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 08:37:55 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R4BVo53031210
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:31 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R4BV7D021210
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 14:11:31 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 09:41:21 +0530
Message-Id: <1274933486-4876-2-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
References: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 1/6] realtime: reuse init_pi_mutex from librttest
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
To: Linux Test Project <ltp-list@lists.sourceforge.net>
Cc: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

testpi-1 and testpi-2 are initializing mutex step by step which can be done
by reusing the init_pi_mutex() funtion available in librttest.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-1.c |   22 +++-------------------
 testcases/realtime/func/pi-tests/testpi-2.c |   22 +++-------------------
 2 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-1.c b/testcases/realtime/func/pi-tests/testpi-1.c
index b503c0c..dc3c30b 100644
--- a/testcases/realtime/func/pi-tests/testpi-1.c
+++ b/testcases/realtime/func/pi-tests/testpi-1.c
@@ -199,8 +199,7 @@ void *func_noise(void *arg)
  */
 int main(int argc, char *argv[])
 {
-	pthread_mutexattr_t mutexattr;
-	int i, retc, protocol, nopi = 0;
+	int i, retc, nopi = 0;
 	cpu_set_t mask;
 	CPU_ZERO(&mask);
 	CPU_SET(0, &mask);
@@ -228,23 +227,8 @@ int main(int argc, char *argv[])
 
 	printf("Start %s\n", argv[0]);
 
-	if (!nopi) {
-		if (pthread_mutexattr_init(&mutexattr) != 0)
-			printf("Failed to init mutexattr\n");
-
-		if (pthread_mutexattr_setprotocol(&mutexattr,\
-			 PTHREAD_PRIO_INHERIT) != 0)
-			printf("Can't set protocol prio inherit\n");
-
-		if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0)
-			printf("Can't get mutexattr protocol\n");
-		else
-			printf("protocol in mutexattr is %d\n", protocol);
-
-		retc = pthread_mutex_init(&glob_mutex, &mutexattr);
-		if (retc != 0)
-			printf("Failed to init mutex: %d\n", retc);
-	}
+	if (!nopi)
+		init_pi_mutex(&glob_mutex);
 
 	create_other_thread(func_nonrt, NULL);
 	create_rr_thread(func_rt, NULL, 20);
diff --git a/testcases/realtime/func/pi-tests/testpi-2.c b/testcases/realtime/func/pi-tests/testpi-2.c
index 8e29e16..4220aba 100644
--- a/testcases/realtime/func/pi-tests/testpi-2.c
+++ b/testcases/realtime/func/pi-tests/testpi-2.c
@@ -200,8 +200,7 @@ void *func_noise(void *arg)
  */
 int main(int argc, char *argv[])
 {
-	pthread_mutexattr_t mutexattr;
-	int i, retc, protocol, nopi = 0;
+	int i, retc, nopi = 0;
 	cpu_set_t mask;
 	CPU_ZERO(&mask);
 	CPU_SET(0, &mask);
@@ -228,23 +227,8 @@ int main(int argc, char *argv[])
 
 	printf("Start %s\n", argv[0]);
 
-	if (!nopi) {
-		if (pthread_mutexattr_init(&mutexattr) != 0)
-			printf("Failed to init mutexattr\n");
-
-		if (pthread_mutexattr_setprotocol(&mutexattr,\
-			PTHREAD_PRIO_INHERIT) != 0)
-			printf("Can't set protocol prio inherit\n");
-
-		if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0)
-			printf("Can't get mutexattr protocol\n");
-		else
-			printf("protocol in mutexattr is %d\n", protocol);
-
-		retc = pthread_mutex_init(&glob_mutex, &mutexattr);
-		if (retc != 0)
-			printf("Failed to init mutex: %d\n", retc);
-	}
+	if (!nopi)
+		init_pi_mutex(&glob_mutex);
 
 	create_rr_thread(func_lowrt, NULL, 10);
 	create_rr_thread(func_rt, NULL, 20);
-- 
1.7.1


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
