Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1SzQ1M-0001FR-Kr
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 10:31:16 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SzQ1I-0004oo-6X
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 10:31:16 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q79AV6rY010494
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 9 Aug 2012 03:31:07 -0700 (PDT)
From: Kang Kai <kai.kang@windriver.com>
Date: Thu, 9 Aug 2012 18:30:57 +0800
Message-ID: <1344508258-25054-3-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1344508258-25054-1-git-send-email-kai.kang@windriver.com>
References: <1344508258-25054-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/3] mq_open/16-1: use tmp file to share info
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
Cc: Zhenfeng.Zhao@windriver.com

In this test case, it uses a variable to share data between child and
parent processes. But after fork there is a copy of the variable in
child process and modify it will not affect the variable in the parent
process. Then when the child process call mq_open() before parent process,
the case will fail.

Use tmp file to replace the variable. Any modification in child process
can be seen in parent process.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/mq_open/16-1.c          |   38 +++++++++++++++++--
 1 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
index b9a3215..ebd697b 100644
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
 	int pid, succeeded=0;
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
+	write(fd, "\0", 1);
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
 	if ((pid = fork()) == 0) {
 		sigset_t mask;
 		int sig;
@@ -62,7 +88,7 @@ int main()
         	childqueue = mq_open(qname, O_CREAT|O_EXCL|O_RDWR,
 				S_IRUSR | S_IWUSR, NULL);
         	if (childqueue != (mqd_t)-1) {
-			succeeded++;
+			++*(int *)pa;
 #ifdef DEBUG
 			printf("mq_open() in child succeeded\n");
 		} else {
@@ -79,7 +105,7 @@ int main()
         	queue = mq_open(qname, O_CREAT | O_EXCL |O_RDWR,
 				S_IRUSR | S_IWUSR, NULL);
         	if (queue != (mqd_t)-1) {
-			succeeded++;
+			++*(int *)pa;
 #ifdef DEBUG
 			printf("mq_open() in parent succeeded\n");
 		} else {
@@ -93,13 +119,15 @@ int main()
 			mq_close(queue);
 			mq_close(childqueue);
 			mq_unlink(qname);
+			close(fd);
+			munmap(pa, sizeof(int));
 			return PTS_UNRESOLVED;
 		}
 
 		mq_close(queue);
 		mq_close(childqueue);
 		mq_unlink(qname);
-
+		succeeded = *(int *)pa;
 		if (succeeded==0) {
 			printf("Test FAILED - mq_open() never succeeded\n");
 			return PTS_FAIL;
@@ -111,8 +139,10 @@ int main()
 		}
 
         	printf("Test PASSED\n");
+		close(fd);
+		munmap(pa, sizeof(int));
         	return PTS_PASS;
 	}
 
 	return PTS_UNRESOLVED;
-}
\ No newline at end of file
+}
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
