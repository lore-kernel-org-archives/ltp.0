Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X2H4e-0007Ex-0d
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 09:43:32 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X2H4b-0007bl-QR
	for ltp-list@lists.sourceforge.net; Wed, 02 Jul 2014 09:43:31 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s629hL9b012529
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jul 2014 17:43:21 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 2 Jul 2014 17:40:08 +0800
Message-ID: <1404294010-18698-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/3] lib/tst_res.c: introduce a simple function
	tst_reset_exitval()
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

T_exitval is defined as 'static int' in lib/tst_res.c, so it won't be
accessed directly from other source files.

Consider below scenario:
If a testcase need to fork a child process to do test work, indeed child
process is ok to call tst_resm() or tst_brkm(), in the end, child process
should also call tst_exit() to report the test result to parent process.

Then we should avoid the potential risk introduced by the kernel COW mechanism
when forking, so every child process should first call tst_reset_exitval() at
the beginning of the test.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 include/test.h | 1 +
 lib/tst_res.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/test.h b/include/test.h
index a4a23e3..3d8bb7c 100644
--- a/include/test.h
+++ b/include/test.h
@@ -118,6 +118,7 @@ extern int Forker_npids;
 
 /* lib/tst_res.c */
 const char *strttype(int ttype);
+void tst_reset_exitval(void);
 void tst_res(int ttype, const char *fname, const char *arg_fmt, ...)
 	__attribute__ ((format (printf, 3, 4)));
 void tst_resm(int ttype, const char *arg_fmt, ...)
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 31186e0..079fc42 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -224,6 +224,10 @@ const char *strttype(int ttype)
 /* Include table of signals and tst_strsig() function*/
 #include "signame.h"
 
+void tst_reset_exitval(void)
+{
+	T_exitval = 0;
+}
 /*
  * tst_res() - Main result reporting function.  Handle test information
  *             appropriately depending on output display mode.  Call
-- 
1.8.2.1


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
