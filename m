Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TyiBt-0000jC-1T
	for ltp-list@lists.sourceforge.net; Fri, 25 Jan 2013 12:15:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TyiBm-0006rd-Td
	for ltp-list@lists.sourceforge.net; Fri, 25 Jan 2013 12:15:29 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0PCFGL8007465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Jan 2013 07:15:17 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id r0PCFFIs022551
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Jan 2013 07:15:16 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 25 Jan 2013 13:15:12 +0100
Message-Id: <04824307bb134b47b19291f8e3e100447919c496.1359115534.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] aio_fsync/2-1.c: fix race at exit,
	check if write completed
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
To: ltp-list@lists.sourceforge.net

This is same issue as:
  commit 4558bfae923a715ac78b5b3d3ecdfa16f9424808
  Author: Jan Stancek <jstancek@redhat.com>
  Date:   Wed Dec 5 12:49:47 2012 +0100
      aio_read/7-1.c: fix race at exit

This patch waits for aio_fsync to complete, and after that
checks that previously queued write is also completed.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/aio_fsync/2-1.c         |   24 ++++++++++++++++---
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
index a534513..3a4c7fb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
@@ -27,7 +27,7 @@ int main(void)
 {
 	char tmpfname[256];
 	char buf[BUF_SIZE];
-	int fd;
+	int fd, ret;
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
@@ -63,9 +63,25 @@ int main(void)
 		exit(PTS_FAIL);
 	}
 
-	close(fd);
+	/* wait for aio_fsync */
+	do {
+		usleep(10000);
+		ret = aio_error(&aiocb_fsync);
+	} while (ret == EINPROGRESS);
 
-	/* we didn't check if the operation is really performed */
+	if (aio_return(&aiocb_fsync)) {
+		printf(TNAME " Error at aio_return()\n");
+		close(fd);
+		return PTS_FAIL;
+	}
 
-	return PTS_UNTESTED;
+	/* check that aio_write is completed at this point */
+	ret = aio_error(&aiocb_write);
+	if (ret == EINPROGRESS) {
+		printf(TNAME " aiocb_write error() : %s\n", strerror(ret));
+		close(fd);
+		return PTS_FAIL;
+	}
+	close(fd);
+	return PTS_PASS;
 }
-- 
1.7.1


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
