Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MJCyN-0001k6-HL
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 20:52:07 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJCyC-00078f-Gd
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 20:51:59 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1CE57106AF71D
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Jun 2009 22:51:53 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #277) id 1MJCy8-00018u-00
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 22:51:52 +0200
Date: Mon, 29 Dec 2008 14:48:19 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvzwechjcfnueu@debian>
Subject: [LTP] [PATCH] Run the eventfd test in a temporary directory,
 because it creates some files
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20081229134819.6ezsepjDWsbrkrFiikLrVtTkAggz9V5nkpM_kPAZ0wM@z>

Hello,

the eventfd test creates some files in the current directory. I think it should be creating the files in a temporary directory instead, as is already the standard with other LTP tests, because the current might be nonwriteable and the user might not want the files left there.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/eventfd/eventfd01.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index ee09752..0eed8d1 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -759,6 +759,8 @@ static void setup(void)
 	if (tst_kvercmp(2, 6, 22) < 0)
 		tst_brkm(TCONF, cleanup, "2.6.22 or greater kernel required");
 
+	/* Create a temporary directory & chdir there */
+	tst_tmpdir();
 	/* Pause if that option was specified
 	 * TEST_PAUSE contains the code to fork the test with the -c option.
 	 */
@@ -776,6 +778,7 @@ static void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
+	tst_rmdir();
 	/* exit with return code appropriate for results */
 	tst_exit();
  /*NOTREACHED*/}
-- 
1.6.3.1




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
