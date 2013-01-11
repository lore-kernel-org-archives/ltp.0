Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanl.fnst@cn.fujitsu.com>) id 1TtTFJ-0005aj-9k
	for ltp-list@lists.sourceforge.net; Fri, 11 Jan 2013 01:17:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TtTFH-0006GP-Up
	for ltp-list@lists.sourceforge.net; Fri, 11 Jan 2013 01:17:21 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r0B1HAvb030966
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Jan 2013 09:17:10 +0800
From: Yan Lei <yanl.fnst@cn.fujitsu.com>
Date: Fri, 11 Jan 2013 09:15:25 +0800
Message-Id: <1357866925-21275-1-git-send-email-yanl.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] add \n in end of output
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
To: ltp-list@lists.sourceforge.net, Yan Lei <yanl.fnst@cn.fujitsu.com>

Signed-off-by: Yan Lei <yanl.fnst@cn.fujitsu.com>
---
 testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
index fbefa7b..5828ed2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
@@ -48,7 +48,7 @@ int main(void)
 	}
 
 	if (pa == MAP_FAILED)
-		printf("Test FAILED: Expected EINVAL got %s", strerror(errno));
+		printf("Test FAILED: Expected EINVAL got %s\n", strerror(errno));
 	else
 		printf("Test FAILED: mmap() succedded unexpectedly\n");
 
-- 
1.8.1.rc3.11.g86c3e6e


------------------------------------------------------------------------------
Master HTML5, CSS3, ASP.NET, MVC, AJAX, Knockout.js, Web API and
much more. Get web development skills now with LearnDevNow -
350+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122812
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
