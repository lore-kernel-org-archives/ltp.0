Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanl.fnst@cn.fujitsu.com>) id 1U2d4Z-0007ut-Ho
	for ltp-list@lists.sourceforge.net; Tue, 05 Feb 2013 07:36:07 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U2d4X-0003tr-Uo
	for ltp-list@lists.sourceforge.net; Tue, 05 Feb 2013 07:36:07 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r157Zwll022791
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Feb 2013 15:35:58 +0800
From: Yan Lei <yanl.fnst@cn.fujitsu.com>
Date: Tue, 5 Feb 2013 15:33:05 +0800
Message-Id: <1360049585-6091-1-git-send-email-yanl.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] fix race at exit by checking if write completed
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
Cc: Yan Lei <yanl.fnst@cn.fujitsu.com>

The same issue as:
    commit 352358cd9f69f6e8296cc201b14bae938287796e
    Author: Jan Stancek <jstancek@redhat.com>
    Date: Mon, 28 Jan 2013 11:36:48 +0100
    aio_fsync/2-1.c: fix race at exit, check if write completed
This patch waits for aio_fsync to complete and after that
checks that previously queued write is also completed.

Signed-off-by: Yan Lei <yanl.fnst@cn.fujitsu.com>

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
index f30f472..6f0098d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
@@ -27,7 +27,7 @@ int main()
 {
 	char tmpfname[256];
 	char buf[BUF_SIZE];
-	int fd;
+	int fd, ret;
 	struct aiocb aiocb_write;
 	struct aiocb aiocb_fsync;
 
@@ -62,10 +62,28 @@ int main()
 		printf(TNAME " Error at aio_fsync(): %s\n", strerror(errno));
 		exit(PTS_FAIL);
 	}
+	/* wait for aio_fsync */
+	do {
+		usleep(10000);
+		ret = aio_error(&aiocb_fsync);
+	} while (ret == EINPROGRESS);
 
-	close(fd);
+	ret = aio_return(&aiocb_fsync);
+	if (ret) {
+		printf(TNAME " Error at aio_return(): %d (%s)\n",
+			ret, strerror(errno));
+		close(fd);
+		return PTS_FAIL;
+	}
 
-	/* we didn't check if the operation is really performed */
+	/* check that aio_write is completed at this point */
+	ret = aio_error(&aiocb_write);
+	if (ret == EINPROGRESS) {
+		printf(TNAME " aiocb_write still in progress\n");
+		close(fd);
+		return PTS_FAIL;
+	}
 
-	return PTS_UNTESTED;
+	close(fd);
+	return PTS_PASS;
 }
-- 
1.8.1.rc3.11.g86c3e6e


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
