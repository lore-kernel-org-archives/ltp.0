Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Z7Cd0-0000TH-CL
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2015 01:03:54 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z7Ccz-0002sB-By
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2015 01:03:54 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5N1288U021823
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2015 09:02:08 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Tue, 23 Jun 2015 09:02:59 +0800
Message-ID: <1435021379-2945-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] sem_conpro: fix memory leak
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

* If _POSIX_SEMAPHORES is not defined,
  It's no need to allocate buffer.
  so, allocate buffer after checking it.

* free the memory at the end of main().

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c b/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
index f5f1abf..58657f9 100644
--- a/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
+++ b/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
@@ -102,12 +102,12 @@ int main(int argc, char *argv[])
 	int lock_value = 1;
 	buf_t *buf;
 	pthread_t con, pro;
-	buf = malloc(sizeof(buf_t));
 
 #ifndef  _POSIX_SEMAPHORES
 	printf("_POSIX_SEMAPHORES is not defined \n");
 	return PTS_UNRESOLVED;
 #endif
+	buf = malloc(sizeof(buf_t));
 	if (-1 == sem_init(&(buf->occupied), shared, occupied_value)) {
 		perror("sem_init didn't return success \n");
 		printf("hello \n");
@@ -129,5 +129,6 @@ int main(int argc, char *argv[])
 	pthread_join(pro, NULL);
 	sem_destroy(&buf->occupied);
 	sem_destroy(&buf->empty);
+	free(buf);
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
