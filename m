Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OHUJr-00026u-VR
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:03:43 +0000
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OHUJq-00068s-Kt
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:03:43 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4R2xu7A012418
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 08:29:56 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R43Whk3477606
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:33:32 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R43WbG031928
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 14:03:32 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 09:33:25 +0530
Message-Id: <1274933006-4754-5-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
References: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 4/5] realtime: code cleanup on pi-test 5
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

This patch cleans up the test so as to follow C coding style standards.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: John Stultz <johnstul@us.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-5.c |   76 ++++++++++++++-------------
 1 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-5.c b/testcases/realtime/func/pi-tests/testpi-5.c
index faf3d8d..b3ea6ef 100644
--- a/testcases/realtime/func/pi-tests/testpi-5.c
+++ b/testcases/realtime/func/pi-tests/testpi-5.c
@@ -30,6 +30,7 @@
  *
  *
  * HISTORY
+ *      2010-04-22 Code cleanup by Gowrishankar
  *
  *
  *****************************************************************************/
@@ -39,54 +40,55 @@
 #include <string.h>
 #include <unistd.h>
 #include <librttest.h>
-pthread_mutex_t  child_mutex;
+pthread_mutex_t child_mutex;
 
-void* child_thread (void* arg)
+void *child_thread(void *arg)
 {
-    int ret;
+	int ret;
 
-    ret = pthread_mutex_lock(&child_mutex);
-    if (ret != 0)
-	printf("child thread: Failed to lock child_mutex: %d\n", ret);
-    else
-	printf("child_thread: got lock\n");
+	ret = pthread_mutex_lock(&child_mutex);
+	if (ret != 0)
+		printf("child thread: Failed to lock child_mutex: %d\n", ret);
+	else
+		printf("child_thread: got lock\n");
 
-    sleep(2);
+	sleep(2);
 
-    printf("child_thread: Trying to get lock 2nd time\n");
-    ret = pthread_mutex_lock(&child_mutex);
-    if (ret != 0)
-	printf("child thread: Failed to lock child_mutex: %d\n", ret);
-    else
-	printf("child_thread: got lock 2nd time !!\n");
+	printf("child_thread: Trying to get lock 2nd time\n");
+	ret = pthread_mutex_lock(&child_mutex);
+	if (ret != 0)
+		printf("child thread: Failed to lock child_mutex: %d\n", ret);
+	else
+		printf("child_thread: got lock 2nd time !!\n");
 
-    return NULL;
+	return NULL;
 }
 
-int do_test(int argc, char ** argv)
+int do_test(int argc, char **argv)
 {
-    pthread_mutexattr_t mutexattr;
-    int retc, protocol;
+	pthread_mutexattr_t mutexattr;
+	int retc, protocol;
 
-    if (pthread_mutexattr_init(&mutexattr) != 0) {
-      printf("Failed to init mutexattr\n");
-    };
-    if (pthread_mutexattr_setprotocol(&mutexattr, PTHREAD_PRIO_INHERIT) != 0) {
-      printf("Can't set protocol prio inherit\n");
-    }
-    if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0) {
-      printf("Can't get mutexattr protocol\n");
-    } else {
-      printf("protocol in mutexattr is %d\n", protocol);
-    }
-    if ((retc = pthread_mutex_init(&child_mutex, &mutexattr)) != 0) {
-      printf("Failed to init mutex: %d\n", retc);
-    }
+	if (pthread_mutexattr_init(&mutexattr) != 0)
+		printf("Failed to init mutexattr\n");
 
-    create_other_thread(child_thread, NULL);
-    join_threads();
-    
-    return 0;
+	if (pthread_mutexattr_setprotocol(&mutexattr,\
+		PTHREAD_PRIO_INHERIT) != 0)
+		printf("Can't set protocol prio inherit\n");
+
+	if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0)
+		printf("Can't get mutexattr protocol\n");
+	else
+		printf("protocol in mutexattr is %d\n", protocol);
+
+	retc = pthread_mutex_init(&child_mutex, &mutexattr);
+	if (retc != 0)
+		printf("Failed to init mutex: %d\n", retc);
+
+	create_other_thread(child_thread, NULL);
+	join_threads();
+
+	return 0;
 }
 
 #include "test-skeleton.c"
-- 
1.7.1


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
