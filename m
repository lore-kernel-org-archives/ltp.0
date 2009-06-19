Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MJCa7-0004Ao-GW
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 20:27:03 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJCa3-0000T2-6k
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 20:27:03 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 23ACA106AEEC9
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Jun 2009 22:26:58 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #277) id 1MJCa1-0002SG-00
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 22:26:57 +0200
Date: Fri, 19 Jun 2009 16:13:25 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvzu8tm6lwynca@debian>
Subject: [LTP] [PATCH] Fix a surprising error in cacheflush01 test
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
Message-ID: <20090619141325.3fVSaLP8NylLMQMab8H3-2-YEiLHHJlUxL-aCT4DfyE@z>

Hello,

this patch fixes a strange build failure in the cacheflush test. Also, it makes the condition where it is build a little broader.

Regards
   Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../kernel/syscalls/cacheflush/cacheflush01.c      |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/cacheflush/cacheflush01.c b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
index cc2fd72..6d1c5f5 100644
--- a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
+++ b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
@@ -45,11 +45,12 @@
 #include <stdlib.h>
 #include <errno.h>
 
-#if defined __mips__
+
+#if defined __NR_cacheflush
 #include <asm/cachectl.h>
 int cacheflush(char *addr, int nbytes, int cache)
 {
-B  B  B  B return syscall(__NR_cacheflush, addr, nbytes, cache);
+	return syscall(__NR_cacheflush, addr, nbytes, cache);
 }
 #endif /* __mips__ */
 
@@ -77,7 +78,7 @@ char *TCID = "cacheflush01";  /* Test program identifier.*/
 int  testno;
 int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
 
-#if defined __mips__
+#if defined __NR_cacheflush
 /* Extern Global Functions */
 /******************************************************************************/
 /*                                                                            */
-- 
1.6.3.1




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
