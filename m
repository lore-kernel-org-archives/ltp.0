Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sjnaw-0003a4-Ef
	for ltp-list@lists.sourceforge.net; Wed, 27 Jun 2012 08:27:26 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Sjnas-00044F-OD
	for ltp-list@lists.sourceforge.net; Wed, 27 Jun 2012 08:27:26 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5R8RH9H009430
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jun 2012 01:27:17 -0700 (PDT)
From: Kang Kai <kai.kang@windriver.com>
Date: Wed, 27 Jun 2012 16:26:58 +0800
Message-ID: <1340785620-4444-2-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1340785620-4444-1-git-send-email-kai.kang@windriver.com>
References: <1340785620-4444-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/3] aio_cancel/4-1: fails on routerstation randomly
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

The case fails on routerstation(MIPS) board randomly. The root cause
is that the aio_write() calls already complete before call aio_cancel().
Fix it by increase BUF_SIZE.

Fill every struct aiocb with 0 at same time.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/aio_cancel/4-1.c        |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
index 75bed8c..69cc512 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
@@ -42,7 +42,7 @@
 #define TNAME "aio_cancel/4-1.c"
 
 #define BUF_NB		128
-#define BUF_SIZE	1024
+#define BUF_SIZE	(1024*1024)
 
 int main()
 {
@@ -80,6 +80,7 @@ int main()
 		       		strerror(errno));
 			return PTS_UNRESOLVED;
 		}
+		memset(aiocb[i], 0, sizeof(struct aiocb));
 		aiocb[i]->aio_fildes = fd;
 		aiocb[i]->aio_buf = malloc(BUF_SIZE);
 		if (aiocb[i]->aio_buf == NULL)
@@ -144,4 +145,4 @@ int main()
 	} while (in_progress);
 
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
