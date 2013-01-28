Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Tzm5P-0001Hy-BH
	for ltp-list@lists.sourceforge.net; Mon, 28 Jan 2013 10:37:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tzm5J-0004cr-Jf
	for ltp-list@lists.sourceforge.net; Mon, 28 Jan 2013 10:37:11 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0SAaxd9026949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Jan 2013 05:36:59 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 28 Jan 2013 11:36:48 +0100
Message-Id: <4b6d511bffcb48649da90750ac07179bf9923292.1359366562.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2] aio_fsync/2-1.c: fix race at exit,
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

This patch waits for aio_fsync to complete and after that
checks that previously queued write is also completed.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/aio_fsync/2-1.c         |   26 ++++++++++++++++---
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
index a534513..09da565 100644
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
 
@@ -63,9 +63,27 @@ int main(void)
 		exit(PTS_FAIL);
 	}
 
-	close(fd);
+	/* wait for aio_fsync */
+	do {
+		usleep(10000);
+		ret = aio_error(&aiocb_fsync);
+	} while (ret == EINPROGRESS);
 
-	/* we didn't check if the operation is really performed */
+	ret = aio_return(&aiocb_fsync);
+	if (ret) {
+		printf(TNAME " Error at aio_return(): %d (%s)\n",
+			ret, strerror(errno));
+		close(fd);
+		return PTS_FAIL;
+	}
 
-	return PTS_UNTESTED;
+	/* check that aio_write is completed at this point */
+	ret = aio_error(&aiocb_write);
+	if (ret == EINPROGRESS) {
+		printf(TNAME " aiocb_write still in progress\n");
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
