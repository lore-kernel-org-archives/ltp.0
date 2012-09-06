Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1T9UeZ-0005Br-6v
	for ltp-list@lists.sourceforge.net; Thu, 06 Sep 2012 05:29:23 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T9UeY-0007K4-07
	for ltp-list@lists.sourceforge.net; Thu, 06 Sep 2012 05:29:23 +0000
From: Kang Kai <kai.kang@windriver.com>
Date: Thu, 6 Sep 2012 13:29:10 +0800
Message-ID: <1346909350-716-2-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1346909350-716-1-git-send-email-kai.kang@windriver.com>
References: <1346909350-716-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mq_open/16-1: use tmp file to share info
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
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net

In this test case, it uses a variable to share data between child and
parent processes. But after fork there is a copy of the variable in
child process and modify it will not affect the variable in the parent
process. Then when the child process call mq_open() before parent
process, the case will fail.

Use tmp file to replace the variable. Any modification in child process
can be seen in parent process.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/mq_open/16-1.c          |   39 +++++++++++++++++++-
 1 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
index e07ce86..eadac81 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
@@ -20,9 +20,11 @@
  * this is fine (will have some false positives, but no false negatives).
  */
 
+#include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <mqueue.h>
 #include <signal.h>
@@ -32,11 +34,15 @@
 #include "posixtest.h"
 
 #define NAMESIZE 50
+#define TNAME "mq_open/16-1.c"
 
 int main()
 {
 	char qname[NAMESIZE];
+	char fname[NAMESIZE];
 	int pid, succeeded = 0;
+	int fd;
+	void *pa = NULL;
 	mqd_t childqueue, queue;
 
 	/*
@@ -47,6 +53,26 @@ int main()
 
 	sprintf(qname, "/mq_open_16-1_%d", getpid());
 
+	sprintf(fname, "/tmp/pts_mq_open_16_1_%d", getpid());
+	unlink(fname);
+	fd = open(fname, O_CREAT | O_RDWR | O_EXCL,
+		 S_IRUSR | S_IWUSR);
+	if (fd == -1) {
+		printf(TNAME " Error at open(): %s\n", strerror(errno));
+		exit(PTS_UNRESOLVED);
+	}
+	/* file is empty now, will cause "Bus error" */
+	write(fd, fname, sizeof(int));
+	unlink(fname);
+
+	pa = mmap(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (pa == MAP_FAILED) {
+		printf(TNAME " Error at mmap: %s\n", strerror(errno));
+		close(fd);
+		exit(PTS_FAIL);
+	}
+	*(int *)pa = 0;
+
 	pid = fork();
 	if (pid == 0) {
 		sigset_t mask;
@@ -63,7 +89,7 @@ int main()
 		childqueue = mq_open(qname, O_CREAT | O_EXCL | O_RDWR,
 				     S_IRUSR | S_IWUSR, NULL);
 		if (childqueue != (mqd_t) -1) {
-			succeeded++;
+			++*(int *)pa;
 #ifdef DEBUG
 			printf("mq_open() in child succeeded\n");
 		} else {
@@ -80,7 +106,7 @@ int main()
 		queue = mq_open(qname, O_CREAT | O_EXCL | O_RDWR,
 				S_IRUSR | S_IWUSR, NULL);
 		if (queue != (mqd_t) -1) {
-			succeeded++;
+			++*(int *)pa;
 #ifdef DEBUG
 			printf("mq_open() in parent succeeded\n");
 		} else {
@@ -94,6 +120,8 @@ int main()
 			mq_close(queue);
 			mq_close(childqueue);
 			mq_unlink(qname);
+			close(fd);
+			munmap(pa, sizeof(int));
 			return PTS_UNRESOLVED;
 		}
 
@@ -101,17 +129,24 @@ int main()
 		mq_close(childqueue);
 		mq_unlink(qname);
 
+		succeeded = *(int *)pa;
 		if (succeeded == 0) {
 			printf("Test FAILED - mq_open() never succeeded\n");
+			close(fd);
+			munmap(pa, sizeof(int));
 			return PTS_FAIL;
 		}
 
 		if (succeeded > 1) {
 			printf("Test FAILED - mq_open() succeeded twice\n");
+			close(fd);
+			munmap(pa, sizeof(int));
 			return PTS_FAIL;
 		}
 
 		printf("Test PASSED\n");
+		close(fd);
+		munmap(pa, sizeof(int));
 		return PTS_PASS;
 	}
 
-- 
1.7.5.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
