Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sjnb0-0007U3-6z
	for ltp-list@lists.sourceforge.net; Wed, 27 Jun 2012 08:27:30 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Sjnau-0004Bf-UI
	for ltp-list@lists.sourceforge.net; Wed, 27 Jun 2012 08:27:30 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5R8RJoa009436
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jun 2012 01:27:19 -0700 (PDT)
From: Kang Kai <kai.kang@windriver.com>
Date: Wed, 27 Jun 2012 16:27:00 +0800
Message-ID: <1340785620-4444-4-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1340785620-4444-1-git-send-email-kai.kang@windriver.com>
References: <1340785620-4444-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] aio_write/7-1: check aio resource limitation
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

Similiar with aio_read/9-1, this case try to overflow the aio queue by
call NUM_AIOCBS times aio_write.
But for some system, the queue has no limit. So check the _SC_AIO_MAX,
if no limit then return UNSUPPORT.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/aio_write/7-1.c         |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
index 164e9ae..3857136 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
@@ -50,7 +50,7 @@ int main()
 	int err;
 	int ret;
 
-	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
+	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L || sysconf(_SC_AIO_MAX) == -1)
 		return PTS_UNSUPPORTED;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_write_4_1_%d",
@@ -106,4 +106,4 @@ int main()
 	printf (TNAME " PASSED\n");
 
 	return PTS_PASS;
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
