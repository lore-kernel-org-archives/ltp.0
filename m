Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1O7EVc-0001at-0h
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 21:09:28 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O7EVb-0006h4-3f
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 21:09:27 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3SL3eKt027386
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 15:03:40 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o3SL9874113858
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 15:09:08 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3SL94bT018236
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 15:09:04 -0600
Date: Wed, 28 Apr 2010 16:09:06 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100428210906.GA20572@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH 1/4] mqns: strip leading / from mq names
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

So the tests can pass

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 testcases/kernel/containers/mqns/mqns.h    |    2 ++
 testcases/kernel/containers/mqns/mqns_01.c |    8 ++++----
 testcases/kernel/containers/mqns/mqns_02.c |    8 ++++----
 testcases/kernel/containers/mqns/mqns_03.c |    2 +-
 testcases/kernel/containers/mqns/mqns_04.c |    2 +-
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/containers/mqns/mqns.h b/testcases/kernel/containers/mqns/mqns.h
index e5912d5..1c624c2 100644
--- a/testcases/kernel/containers/mqns/mqns.h
+++ b/testcases/kernel/containers/mqns/mqns.h
@@ -10,6 +10,8 @@
 #define DEV_MQUEUE "/dev/mqueue"
 #define DEV_MQUEUE2 "/dev/mqueue2"
 #define SLASH_MQ1 "/MQ1"
+#define NOSLASH_MQ1 "MQ1"
 #define SLASH_MQ2 "/MQ2"
+#define NOSLASH_MQ2 "MQ2"
 
 #endif /* __MQNS_H */
diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index 7f41b2d..515ed51 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -55,7 +55,7 @@ int check_mqueue(void *vtest)
 
 	if (read(p1[0], buf, strlen("go") + 1) < 0)
 		tst_resm(TBROK | TERRNO, "read(p1[0], ...) failed");
-	mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDONLY);
+	mqd = syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
 	if (mqd == -1) {
 		if (write(p2[1], "notfnd", strlen("notfnd") + 1) < 0)
 			tst_resm(TBROK | TERRNO, "write(p2[1], ...) failed");
@@ -86,7 +86,7 @@ main(int argc, char *argv[])
 	if (pipe(p1) == -1) { perror("pipe"); exit(EXIT_FAILURE); }
 	if (pipe(p2) == -1) { perror("pipe"); exit(EXIT_FAILURE); }
 
-	mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0777,
+	mqd = syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0777,
 			NULL);
 	if (mqd == -1) {
 		perror("mq_open");
@@ -100,7 +100,7 @@ main(int argc, char *argv[])
 	if (r < 0) {
 		tst_resm(TFAIL, "failed clone/unshare\n");
 		mq_close(mqd);
-		syscall(__NR_mq_unlink, SLASH_MQ1);
+		syscall(__NR_mq_unlink, NOSLASH_MQ1);
 		tst_exit();
 	}
 
@@ -122,7 +122,7 @@ main(int argc, char *argv[])
 
 	/* destroy the mqueue */
 	mq_close(mqd);
-	syscall(__NR_mq_unlink, SLASH_MQ1);
+	syscall(__NR_mq_unlink, NOSLASH_MQ1);
 
 	tst_exit();
 }
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index aa78f65..8f783ba 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -60,7 +60,7 @@ int check_mqueue(void *vtest)
 		tst_resm(TBROK | TERRNO, "read(p1[0], ..) failed");
 	else {
 
-		mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL,
+		mqd = syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR|O_CREAT|O_EXCL,
 				0777, NULL);
 		if (mqd == -1) {
 			if (write(p2[1], "mqfail", strlen("mqfail") + 1) < 0) {
@@ -86,9 +86,9 @@ int check_mqueue(void *vtest)
 						tst_resm(TBROK | TERRNO,
 							"mq_close(mqd) failed");
 					} else if (syscall(__NR_mq_unlink,
-							SLASH_MQ1) < 0) {
+							NOSLASH_MQ1) < 0) {
 						tst_resm(TBROK | TERRNO,
-							"mq_unlink(" SLASH_MQ1
+							"mq_unlink(" NOSLASH_MQ1
 							") failed");
 					} else if (write(p2[1], "done",
 							strlen("done") + 1)
@@ -153,7 +153,7 @@ int main(int argc, char *argv[])
 		tst_exit();
 	} else {
 
-		mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDONLY);
+		mqd = syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
 		if (mqd == -1) {
 			tst_resm(TPASS, "Parent process can't see the mqueue\n");
 		} else {
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index 3c9e83e..83db75c 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -63,7 +63,7 @@ int check_mqueue(void *vtest)
 
 	read(p1[0], buf, 3); /* go */
 
-	mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755,
+	mqd = syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755,
 			NULL);
 	if (mqd == -1) {
 		write(p2[1], "mqfail", 7);
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index 8a4a9c2..98d4e39 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -59,7 +59,7 @@ int check_mqueue(void *vtest)
 
 	read(p1[0], buf, 3); /* go */
 
-	mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755,
+	mqd = syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755,
 			NULL);
 	if (mqd == -1) {
 		write(p2[1], "mqfail", 7);
-- 
1.7.0


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
