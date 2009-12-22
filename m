Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NN8Gn-00089Y-NF
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 17:11:37 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NN8Gj-00078K-0x
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 17:11:37 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBMHA4PE026710
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Dec 2009 10:10:04 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBMHB8dl073098
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Dec 2009 10:11:09 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBMHCxtV004623
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Dec 2009 10:12:59 -0700
Received: from sergelap.hallyn.com (sig-9-76-13-122.mts.ibm.com [9.76.13.122])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP
	id nBMHCxC9004588
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Dec 2009 10:12:59 -0700
Date: Tue, 22 Dec 2009 11:11:04 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20091222171103.GA9810@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] containers: mqns: use libc's mq_open,
 not syscall(__NR_mq_open
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
To: LTP list <ltp-list@lists.sourceforge.net>

The glibc version removes the leading '/' from the message queue name.
Not doing so makes the system call fail.  We could just remove the
'/' from SLASH_MQ1, if for some reason that were preferred, but using
glibc functions when possible seems cleaner to me.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 testcases/kernel/containers/mqns/mqns_01.c |    9 ++++-----
 testcases/kernel/containers/mqns/mqns_02.c |    8 +++-----
 testcases/kernel/containers/mqns/mqns_03.c |    3 +--
 testcases/kernel/containers/mqns/mqns_04.c |    2 +-
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
index 7f41b2d..2f3bf8e 100644
--- a/testcases/kernel/containers/mqns/mqns_01.c
+++ b/testcases/kernel/containers/mqns/mqns_01.c
@@ -55,7 +55,7 @@ int check_mqueue(void *vtest)
 
 	if (read(p1[0], buf, strlen("go") + 1) < 0)
 		tst_resm(TBROK | TERRNO, "read(p1[0], ...) failed");
-	mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDONLY);
+	mqd = mq_open(SLASH_MQ1, O_RDONLY);
 	if (mqd == -1) {
 		if (write(p2[1], "notfnd", strlen("notfnd") + 1) < 0)
 			tst_resm(TBROK | TERRNO, "write(p2[1], ...) failed");
@@ -86,8 +86,7 @@ main(int argc, char *argv[])
 	if (pipe(p1) == -1) { perror("pipe"); exit(EXIT_FAILURE); }
 	if (pipe(p2) == -1) { perror("pipe"); exit(EXIT_FAILURE); }
 
-	mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0777,
-			NULL);
+	mqd = mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0777, NULL);
 	if (mqd == -1) {
 		perror("mq_open");
 		tst_resm(TFAIL, "mq_open failed\n");
@@ -100,7 +99,7 @@ main(int argc, char *argv[])
 	if (r < 0) {
 		tst_resm(TFAIL, "failed clone/unshare\n");
 		mq_close(mqd);
-		syscall(__NR_mq_unlink, SLASH_MQ1);
+		mq_unlink(SLASH_MQ1);
 		tst_exit();
 	}
 
@@ -122,7 +121,7 @@ main(int argc, char *argv[])
 
 	/* destroy the mqueue */
 	mq_close(mqd);
-	syscall(__NR_mq_unlink, SLASH_MQ1);
+	mq_unlink(SLASH_MQ1);
 
 	tst_exit();
 }
diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index aa78f65..5343d5b 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -60,8 +60,7 @@ int check_mqueue(void *vtest)
 		tst_resm(TBROK | TERRNO, "read(p1[0], ..) failed");
 	else {
 
-		mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL,
-				0777, NULL);
+		mqd = mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0777, NULL);
 		if (mqd == -1) {
 			if (write(p2[1], "mqfail", strlen("mqfail") + 1) < 0) {
 				tst_resm(TBROK | TERRNO,
@@ -85,8 +84,7 @@ int check_mqueue(void *vtest)
 					if (mq_close(mqd) < 0) {
 						tst_resm(TBROK | TERRNO,
 							"mq_close(mqd) failed");
-					} else if (syscall(__NR_mq_unlink,
-							SLASH_MQ1) < 0) {
+					} else if (mq_unlink(SLASH_MQ1) < 0) {
 						tst_resm(TBROK | TERRNO,
 							"mq_unlink(" SLASH_MQ1
 							") failed");
@@ -153,7 +151,7 @@ int main(int argc, char *argv[])
 		tst_exit();
 	} else {
 
-		mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDONLY);
+		mqd = mq_open(SLASH_MQ1, O_RDONLY);
 		if (mqd == -1) {
 			tst_resm(TPASS, "Parent process can't see the mqueue\n");
 		} else {
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index 3c9e83e..6a841b8 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -63,8 +63,7 @@ int check_mqueue(void *vtest)
 
 	read(p1[0], buf, 3); /* go */
 
-	mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755,
-			NULL);
+	mqd = mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755, NULL);
 	if (mqd == -1) {
 		write(p2[1], "mqfail", 7);
 		tst_exit();
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index 8a4a9c2..6ce9e34 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -59,7 +59,7 @@ int check_mqueue(void *vtest)
 
 	read(p1[0], buf, 3); /* go */
 
-	mqd = syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755,
+	mqd = mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0755,
 			NULL);
 	if (mqd == -1) {
 		write(p2[1], "mqfail", 7);
-- 
1.6.5.7


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
