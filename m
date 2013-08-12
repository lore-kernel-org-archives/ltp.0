Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1V8puT-0003TA-3L
	for ltp-list@lists.sourceforge.net; Mon, 12 Aug 2013 11:03:37 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V8puR-0008IN-OJ
	for ltp-list@lists.sourceforge.net; Mon, 12 Aug 2013 11:03:37 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7CB3T9W032373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Aug 2013 07:03:29 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id r7CB3SCT008967
	for <ltp-list@lists.sourceforge.net>; Mon, 12 Aug 2013 07:03:29 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 12 Aug 2013 13:03:25 +0200
Message-Id: <a4b10219d9304cc8ea0fb62447640710d72d05c6.1376300996.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] aio_fsync: wait until aio_fsync completes
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

This patch introduces wait so that testcases exit doesn't race
with completion of aio_fsync.

This is to avoid SIGSEGV:
 #0  0x000003fffd1f4a24 in _IO_flush_all_lockp () at genops.c:850
 #1  0x000003fffd1f4b8e in _IO_cleanup () at genops.c:1010
 #2  0x000003fffd1a88f6 in __run_exit_handlers () at exit.c:90
 #3  0x000003fffd1a89b0 in __GI_exit () at exit.c:99
 #4  0x000003fffd18c822 in __libc_start_main () at libc-start.c:292
 #5  0x0000000080000b76 in _start ()

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/aio_fsync/8-1.c         |   14 ++++++++++++++
 .../conformance/interfaces/aio_fsync/8-2.c         |   14 ++++++++++++++
 .../conformance/interfaces/aio_fsync/8-3.c         |   14 ++++++++++++++
 .../conformance/interfaces/aio_fsync/8-4.c         |   14 ++++++++++++++
 .../conformance/interfaces/aio_fsync/9-1.c         |   14 ++++++++++++++
 5 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
index d03dc76..356a21e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
@@ -73,6 +73,20 @@ int main(void)
 		exit(PTS_FAIL);
 	}
 
+	/* wait for aio_fsync */
+	do {
+		usleep(10000);
+		ret = aio_error(&aiocb_fsync);
+	} while (ret == EINPROGRESS);
+
+	ret = aio_return(&aiocb_fsync);
+	if (ret) {
+		printf(TNAME " Error at aio_return(): %d (%s)\n",
+			ret, strerror(errno));
+		close(fd);
+		return PTS_FAIL;
+	}
+
 	close(fd);
 	printf("Test PASSED\n");
 	return PTS_PASS;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
index 7215872..65e36d0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
@@ -73,6 +73,20 @@ int main(void)
 		exit(PTS_FAIL);
 	}
 
+	/* wait for aio_fsync */
+	do {
+		usleep(10000);
+		ret = aio_error(&aiocb_fsync);
+	} while (ret == EINPROGRESS);
+
+	ret = aio_return(&aiocb_fsync);
+	if (ret) {
+		printf(TNAME " Error at aio_return(): %d (%s)\n",
+			ret, strerror(errno));
+		close(fd);
+		return PTS_FAIL;
+	}
+
 	close(fd);
 	printf("Test PASSED\n");
 	return PTS_PASS;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
index 1126e84..794ee49 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
@@ -73,6 +73,20 @@ int main(void)
 		exit(PTS_FAIL);
 	}
 
+	/* wait for aio_fsync */
+	do {
+		usleep(10000);
+		ret = aio_error(&aiocb_fsync);
+	} while (ret == EINPROGRESS);
+
+	ret = aio_return(&aiocb_fsync);
+	if (ret) {
+		printf(TNAME " Error at aio_return(): %d (%s)\n",
+			ret, strerror(errno));
+		close(fd);
+		return PTS_FAIL;
+	}
+
 	close(fd);
 	printf("Test PASSED\n");
 	return PTS_PASS;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
index e0e83a7..7a212e6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
@@ -73,6 +73,20 @@ int main(void)
 		exit(PTS_FAIL);
 	}
 
+	/* wait for aio_fsync */
+	do {
+		usleep(10000);
+		ret = aio_error(&aiocb_fsync);
+	} while (ret == EINPROGRESS);
+
+	ret = aio_return(&aiocb_fsync);
+	if (ret) {
+		printf(TNAME " Error at aio_return(): %d (%s)\n",
+			ret, strerror(errno));
+		close(fd);
+		return PTS_FAIL;
+	}
+
 	close(fd);
 	printf("Test PASSED\n");
 	return PTS_PASS;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
index f0e7ee2..a8b0ec1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
@@ -72,6 +72,20 @@ int main(void)
 		exit(PTS_FAIL);
 	}
 
+	/* wait for aio_fsync */
+	do {
+		usleep(10000);
+		ret = aio_error(&aiocb_fsync);
+	} while (ret == EINPROGRESS);
+
+	ret = aio_return(&aiocb_fsync);
+	if (ret) {
+		printf(TNAME " Error at aio_return(): %d (%s)\n",
+			ret, strerror(errno));
+		close(fd);
+		return PTS_FAIL;
+	}
+
 	close(fd);
 	printf("Test PASSED\n");
 	return PTS_PASS;
-- 
1.7.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
