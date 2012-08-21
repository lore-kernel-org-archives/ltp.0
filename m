Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1T3kdW-0007yH-HY
	for ltp-list@lists.sourceforge.net; Tue, 21 Aug 2012 09:20:34 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T3kdR-0005l6-H1
	for ltp-list@lists.sourceforge.net; Tue, 21 Aug 2012 09:20:34 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7L9KMfH020683
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Aug 2012 02:20:22 -0700 (PDT)
From: Kang Kai <kai.kang@windriver.com>
Date: Tue, 21 Aug 2012 17:20:24 +0800
Message-ID: <1345540824-27133-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] pthread_detach/4-3: Fix typo
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

Fix typo.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/pthread_detach/4-3.c    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
index 5c15e93..dfa6e19 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
@@ -281,7 +281,7 @@ int main(int argc, char *argv[])
 
 	do {
 		do_it2 = 0;
-	} while (do_it2 = 0);
+	} while (do_it2);
 
 	ret = pthread_join(th_sig1, NULL);
 	if (ret)
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
