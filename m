Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1X1WoA-0003Pr-A0
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 08:19:26 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X1Wo8-0000ZP-C7
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 08:19:26 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5U8JEWF002149
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 16:19:14 +0800
Message-ID: <1404116297.3148.7.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 30 Jun 2014 16:18:17 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] waitid/waitid02.c: Add new ECHILD errno test
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
To: ltp-list <ltp-list@lists.sourceforge.net>

* Add new ECHILD errno test for waitid(2)
	idtype and id (waitid()) is not a child of the calling process.

* Cleanup: remove an useless tst_exit()

* Add tst_count = 0

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/waitid/waitid02.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
index 3806655..6259fa3 100644
--- a/testcases/kernel/syscalls/waitid/waitid02.c
+++ b/testcases/kernel/syscalls/waitid/waitid02.c
@@ -130,6 +130,16 @@ struct testcase_t tdat[] = {
 		.setup = setup6,
 		.cleanup = cleanup6
 	},
+	{
+		.msg = "P_PID, WEXITED not a child of the calling process",
+		.idtype = P_PID,
+		.id = 1,
+		.options = WEXITED,
+		.exp_ret = -1,
+		.exp_errno = ECHILD,
+		.setup = setup2,
+		.cleanup = cleanup2
+	},
 
 };
 
@@ -281,13 +291,12 @@ int main(int ac, char **av)
 	const char *msg;
 
 	msg = parse_opts(ac, av, NULL, NULL);
-	if (msg != NULL) {
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-		tst_exit();
-	}
 
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; testno++)
 			test_waitid(&tdat[testno]);
 	}
-- 
1.9.3




------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
