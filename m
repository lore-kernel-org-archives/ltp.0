Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OTVIm-0001S2-4L
	for ltp-list@lists.sourceforge.net; Tue, 29 Jun 2010 07:32:16 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OTVIk-00056j-O6
	for ltp-list@lists.sourceforge.net; Tue, 29 Jun 2010 07:32:16 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5T7VsUs018034
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jun 2010 17:31:54 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5T7Vm3t1245312
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jun 2010 17:31:48 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5T7VmWY011692
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jun 2010 17:31:48 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Tue, 29 Jun 2010 13:01:46 +0530
Message-Id: <1277796706-6450-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH] realtime: rearrange the pthread attr functions order
	in librttest
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

In the recent pthread libraries, order of calling pthread_attr_setschedpolicy
and pthread_attr_setschedparam plays important role in a way that, former
should always be called followed by later.

Otherwise, pthread_attr_setschedparam always ends with error 22 (EINVAL).
This patch fixes the create_thread() in librttest library.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/lib/librttest.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
index e092f35..49fec29 100644
--- a/testcases/realtime/lib/librttest.c
+++ b/testcases/realtime/lib/librttest.c
@@ -295,8 +295,8 @@ int create_thread(void*(*func)(void*), void *arg, int prio, int policy)
 
 	pthread_attr_init(&thread->attr);
 	pthread_attr_setinheritsched(&thread->attr, PTHREAD_EXPLICIT_SCHED);
-	pthread_attr_setschedparam(&thread->attr, &param);
 	pthread_attr_setschedpolicy(&thread->attr, thread->policy);
+	pthread_attr_setschedparam(&thread->attr, &param);
 
 	if ((ret = pthread_create(&thread->pthread, &thread->attr, func, (void*)thread))) {
 		printf("pthread_create failed: %d (%s)\n", ret, strerror(ret));
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
