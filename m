Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1Z5uQq-0007fZ-Tm
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 11:26:00 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z5uQo-0007w1-Qp
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 11:26:00 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQ6027BRVR3MN00@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 20:25:51 +0900 (KST)
Date: Fri, 19 Jun 2015 11:25:51 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <144413988.54651434713150877.JavaMail.weblogic@ep2mlwas06b>
Subject: [LTP]  [PATCH]: Fix memory leak by freeing buf
Reply-To: manjeet.p@samsung.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, AKHILESH KUMAR <akhilesh.k@samsung.com>

From: Manjeet Pawar <manjeet.p@samsung.com>
Date: Fri, 19 Jun 2015 16:45:54 +0530
Subject: [PATCH] testcases/open_posix_testsuite/functional/semaphores: Fix memory leak by freeing buf

This patch fix memory leak by freeing memory leak before function return

Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 .../functional/semaphores/sem_conpro.c             |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c b/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
index f5f1abf..f3a4cfb 100644
--- a/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
+++ b/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
@@ -106,19 +106,23 @@ int main(int argc, char *argv[])
 
 #ifndef  _POSIX_SEMAPHORES
 	printf("_POSIX_SEMAPHORES is not defined \n");
+	free(buf);
 	return PTS_UNRESOLVED;
 #endif
 	if (-1 == sem_init(&(buf->occupied), shared, occupied_value)) {
 		perror("sem_init didn't return success \n");
 		printf("hello \n");
+		free(buf);
 		return PTS_UNRESOLVED;
 	}
 	if (-1 == sem_init(&buf->empty, shared, empty_value)) {
 		perror("sem_init didn't return success \n");
+		free(buf);
 		return PTS_UNRESOLVED;
 	}
 	if (-1 == sem_init(&buf->lock, shared, lock_value)) {
 		perror("sem_init didn't return success \n");
+		free(buf);
 		return PTS_UNRESOLVED;
 	}
 	in = out = 0;
@@ -129,5 +133,6 @@ int main(int argc, char *argv[])
 	pthread_join(pro, NULL);
 	sem_destroy(&buf->occupied);
 	sem_destroy(&buf->empty);
+	free(buf);
 	return PTS_PASS;
 }
-- 
1.7.9.5

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
