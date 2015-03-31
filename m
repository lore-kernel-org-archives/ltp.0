Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Ycqwu-0005MJ-Kl
	for ltp-list@lists.sourceforge.net; Tue, 31 Mar 2015 07:51:00 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ycqws-0000uQ-Es
	for ltp-list@lists.sourceforge.net; Tue, 31 Mar 2015 07:51:00 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t2V7nlj6000369
	for <ltp-list@lists.sourceforge.net>; Tue, 31 Mar 2015 15:49:47 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Tue, 31 Mar 2015 15:46:10 +0800
Message-ID: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/6] lib6/runcc.c: use TCONF instead of TBROK when no
	C compiler is present
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

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/network/lib6/runcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/lib6/runcc.c b/testcases/network/lib6/runcc.c
index 91a0b16..3a89598 100644
--- a/testcases/network/lib6/runcc.c
+++ b/testcases/network/lib6/runcc.c
@@ -93,7 +93,7 @@ int runcc(char *tname, char *filename0, char *program)
 		 cflags, filename0, filename);
 	es = system(cmd);
 	if (WEXITSTATUS(es) == 127) {
-		tst_resm(TBROK, "can't run C compiler: \"%s\"", cmd);
+		tst_resm(TCONF, "can't run C compiler: \"%s\"", cmd);
 		if (unlink(filename) < 0)
 			tst_resm(TWARN, "%s; unlink \"%s\" failed: %s", tname,
 				 filename, strerror(errno));
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
