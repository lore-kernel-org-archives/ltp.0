Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1SuDir-0005vu-7M
	for ltp-list@lists.sourceforge.net; Thu, 26 Jul 2012 02:22:41 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SuDiq-0000Nz-1u
	for ltp-list@lists.sourceforge.net; Thu, 26 Jul 2012 02:22:41 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q6Q2MXgw009528
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 25 Jul 2012 19:22:33 -0700 (PDT)
From: Kang Kai <kai.kang@windriver.com>
Date: Thu, 26 Jul 2012 10:22:29 +0800
Message-ID: <1343269349-24981-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] aio_suspend/3-1: cancel the aio_write operations
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

After aio_suspend, call aio_cancel to cancel other aio_write operations
then wait them to canceld or complete.

If don't do that, it fails with "Segmentation fault" on routerstation(mips)
board randomly about in 1000 continuous test. The reason may be some
aio_writes don't complete before close the file, that cause some resouse
don't be released and finally cause segment fault.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/aio_suspend/3-1.c       |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
index 15120e1..49d204a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
@@ -87,6 +87,21 @@ int main()
 		exit(PTS_FAIL);
 	}
 
+	if (aio_cancel(fd, NULL) == -1) {
+		printf(TNAME " Error at aio_cancel(): %s\n", strerror(errno));
+		exit(PTS_FAIL);
+	}
+
+
+	while (1) {
+		for (i = 0; i < NAIOCB; ++i) {
+			if (aio_error(&aiocb[i]) == EINPROGRESS)
+				break;
+		}
+		if (i == NAIOCB)
+			break;
+	}
+
 	close(fd);
 	printf("Test PASSED\n");
 	return PTS_PASS;
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
