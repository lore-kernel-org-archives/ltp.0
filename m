Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YL1Qc-0004ls-Gb
	for ltp-list@lists.sourceforge.net; Tue, 10 Feb 2015 03:23:58 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YL1Qb-0006a1-BK
	for ltp-list@lists.sourceforge.net; Tue, 10 Feb 2015 03:23:58 +0000
Message-ID: <1423538564.27932.4.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 10 Feb 2015 11:22:44 +0800
In-Reply-To: <54C893E8.7020609@cn.fujitsu.com>
References: <1422336738-617-1-git-send-email-liwang@redhat.com>
	<20150127153140.GG16759@rei.suse.de>
	<2114349772.1193590.1422414177762.JavaMail.zimbra@redhat.com>
	<54C893E8.7020609@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] hugeshmat04: fix typo
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
Cc: ltp-list@lists.sourceforge.net

From ecec5dda24d573f48862e1d05e15d14bfef5a463 Mon Sep 17 00:00:00 2001
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 10 Feb 2015 11:20:32 +0800
Subject: [PATCH] hugeshmat04: fix typo

hugeshamt04 --> hugeshmat04
      ^^              ^^

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/hugetlb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 805141d..7fcaa01 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -10,7 +10,7 @@ hugemmap05_3 hugemmap05 -s -m
 hugeshmat01 hugeshmat01 -i 5
 hugeshmat02 hugeshmat02 -i 5
 hugeshmat03 hugeshmat03 -i 5
-hugeshmat04 hugeshamt04 -i 5
+hugeshmat04 hugeshmat04 -i 5
 
 hugeshmctl01 hugeshmctl01 -i 5
 hugeshmctl02 hugeshmctl02 -i 5
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
