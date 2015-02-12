Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YLjPH-0007pA-MB
	for ltp-list@lists.sourceforge.net; Thu, 12 Feb 2015 02:21:31 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YLjPE-000781-69
	for ltp-list@lists.sourceforge.net; Thu, 12 Feb 2015 02:21:31 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t1C2KWDr026472
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Feb 2015 10:20:32 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Thu, 12 Feb 2015 10:20:35 +0800
Message-ID: <1423707635-1147-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] doc/test-writing-guidelines.txt: fix spelling mistake
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

wrote the brackets '}' instead of the braces ')' mistakenly
during the example program.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index b220e43..6660b28 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -264,7 +264,7 @@ static void test(void)
 			tst_resm(TPASS, "getenv(" TEST_ENV ") = '"
 			         TEST_ENV_VAL "'");
 		else
-			tst_resm(TFAIL, "getenv(" TEST_ENV "} = '%s', "
+			tst_resm(TFAIL, "getenv(" TEST_ENV ") = '%s', "
 			         "expected '" TEST_ENV_VAL "'", ret);
 	} else {
 		tst_resm(TFAIL, "getenv(" TEST_ENV ") = NULL");
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
