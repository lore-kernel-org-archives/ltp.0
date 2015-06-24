Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Z7bZh-0003lp-Uk
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2015 03:42:09 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z7bZg-0004ds-NN
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2015 03:42:09 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5O3eOND031990
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Jun 2015 11:40:24 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 24 Jun 2015 11:41:33 +0800
Message-ID: <1435117293-16126-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <55892FA3.80800@oracle.com>
References: <55892FA3.80800@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] sem_conpro: cleanup code
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

* It's reasonable to allocate memory after checking
  _POSIX_SEMAPHORES.
  Allocate 'buf' on the stack to avoid the problem.

* remove meaningless printf()

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 .../functional/semaphores/sem_conpro.c                 | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c b/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
index f5f1abf..2fb9890 100644
--- a/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
+++ b/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
@@ -100,34 +100,32 @@ int main(int argc, char *argv[])
 	int occupied_value = BUF_SIZE;
 	int empty_value = 0;
 	int lock_value = 1;
-	buf_t *buf;
+	buf_t buf;
 	pthread_t con, pro;
-	buf = malloc(sizeof(buf_t));
 
 #ifndef  _POSIX_SEMAPHORES
 	printf("_POSIX_SEMAPHORES is not defined \n");
 	return PTS_UNRESOLVED;
 #endif
-	if (-1 == sem_init(&(buf->occupied), shared, occupied_value)) {
+	if (-1 == sem_init(&buf.occupied, shared, occupied_value)) {
 		perror("sem_init didn't return success \n");
-		printf("hello \n");
 		return PTS_UNRESOLVED;
 	}
-	if (-1 == sem_init(&buf->empty, shared, empty_value)) {
+	if (-1 == sem_init(&buf.empty, shared, empty_value)) {
 		perror("sem_init didn't return success \n");
 		return PTS_UNRESOLVED;
 	}
-	if (-1 == sem_init(&buf->lock, shared, lock_value)) {
+	if (-1 == sem_init(&buf.lock, shared, lock_value)) {
 		perror("sem_init didn't return success \n");
 		return PTS_UNRESOLVED;
 	}
 	in = out = 0;
 
-	pthread_create(&con, NULL, (void *)consumer, (void *)buf);
-	pthread_create(&pro, NULL, (void *)producer, (void *)buf);
+	pthread_create(&con, NULL, (void *)consumer, (void *)&buf);
+	pthread_create(&pro, NULL, (void *)producer, (void *)&buf);
 	pthread_join(con, NULL);
 	pthread_join(pro, NULL);
-	sem_destroy(&buf->occupied);
-	sem_destroy(&buf->empty);
+	sem_destroy(&buf.occupied);
+	sem_destroy(&buf.empty);
 	return PTS_PASS;
 }
-- 
1.9.3


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
