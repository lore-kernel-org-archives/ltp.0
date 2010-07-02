Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OUZh3-0007lK-Ek
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:45 +0000
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUZh1-0003xd-3G
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:45 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp08.in.ibm.com (8.14.4/8.13.1) with ESMTP id o626O1Lv004794
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:54:01 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o626PXjL4001854
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:55:34 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o626PX5J004692
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 16:25:33 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Fri,  2 Jul 2010 11:55:25 +0530
Message-Id: <1278051930-4070-3-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
References: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 2/7] realtime/testpi-4: reuse init_pi_mutex from
	librttest
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

testpi-4 is initializing mutex step by step which can be done
by reusing the init_pi_mutex() funtion available in librttest.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-4.c |   22 +++-------------------
 1 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-4.c b/testcases/realtime/func/pi-tests/testpi-4.c
index bde3ded..53b47a8 100644
--- a/testcases/realtime/func/pi-tests/testpi-4.c
+++ b/testcases/realtime/func/pi-tests/testpi-4.c
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
@@ -233,23 +232,8 @@ int main(int argc, char *argv[])
 		exit(errno);
 	}
 
-	if (!nopi) {
-		if (pthread_mutexattr_init(&mutexattr) != 0)
-			printf("Failed to init mutexattr\n");
-
-		if (pthread_mutexattr_setprotocol(&mutexattr,
-			 PTHREAD_PRIO_INHERIT) != 0)
-			printf("Can't set protocol prio inherit\n");
-
-		if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0)
-			printf("Can't get mutexattr protocol\n");
-		else
-			printf("protocol in mutexattr is %d\n", protocol);
-
-		retc = pthread_mutex_init(glob_mutex, &mutexattr);
-		if (retc != 0)
-			printf("Failed to init mutex: %d\n", retc);
-	}
+	if (!nopi)
+		init_pi_mutex(glob_mutex);
 
 	create_other_thread(func_nonrt, NULL);
 	create_rr_thread(func_rt, NULL, 20);
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
