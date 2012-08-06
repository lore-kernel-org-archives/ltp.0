Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1SyIX2-0002kw-Rs
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 08:19:20 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SyIWy-0007LE-G9
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 08:19:20 +0000
From: Kang Kai <kai.kang@windriver.com>
Date: Mon, 6 Aug 2012 16:19:04 +0800
Message-ID: <1344241144-25750-2-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1344241144-25750-1-git-send-email-kai.kang@windriver.com>
References: <1344241144-25750-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] aio_suspend/3-1: wait all aio_write complete
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net, Zhenfeng.Zhao@windriver.com

After aio_suspend, wait all aio_write operations to complete.

If don't do that, it fails with "Segmentation fault" on routerstation(mips)
board randomly about in 1000 continuous test. The reason may be some
aio_writes don't complete before close the file, that cause some resouse
don't be released and finally cause segment fault.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/aio_suspend/3-1.c       |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
index 15120e1..e8e9705 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
@@ -46,6 +46,7 @@ int main()
 	struct aiocb aiocb[NAIOCB];
 	const struct aiocb *list[NENT];
 	int i;
+	int ret;
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
@@ -87,6 +88,17 @@ int main()
 		exit(PTS_FAIL);
 	}
 
+	for (i = 0; i < NAIOCB; ++i) {
+		do {
+			usleep(10000);
+			ret = aio_error(&aiocb[i]);
+		} while (ret == EINPROGRESS);
+		if (aio_return(&aiocb[i]) == -1) {
+			printf(TNAME " Error at aio_return(): %s\n", strerror(errno));
+			exit(PTS_FAIL);
+		}
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
