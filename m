Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1RxrHb-00087u-LM
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 02:41:19 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RxrHX-0005vM-RY
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 02:41:19 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q1G2f9Z6011003
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Feb 2012 18:41:09 -0800 (PST)
From: Kang Kai <kai.kang@windriver.com>
Date: Thu, 16 Feb 2012 10:41:07 +0800
Message-ID: <1329360067-14421-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] aio_cancel/3-1: call aio_read before aio_cancel
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

The case calls aio_error() with an invalid aiocbp, but it should do
some asynchronous I/O operations first, so call aio_read() and then
test the aio_error().

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/aio_error/3-1.c         |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
index 8b6c2f5..6665da1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
@@ -68,6 +68,9 @@ int main()
 	aiocb.aio_reqprio = -1;
 	aiocb.aio_nbytes = BUF_SIZE;
 
+	/* Just do aio_read() or aio_write */
+	aio_read(&aiocb);
+
 	ret = aio_error(&aiocb);
 
 	if (ret != EINVAL)
@@ -80,4 +83,4 @@ int main()
 	close(fd);
 	printf ("Test PASSED\n");
 	return PTS_PASS;
-}
\ No newline at end of file
+}
-- 
1.7.5.4


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
