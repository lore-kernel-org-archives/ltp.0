Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <cristian@regolo.cc>) id 1PgGHF-00077n-TV
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 12:39:41 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PgGHE-00045R-Ol
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 12:39:41 +0000
Received: from regolo (93-46-43-128.ip106.fastwebnet.it [93.46.43.128])
	by aiolia.regolo.cc (Postfix) with ESMTPSA id CF03C64
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 13:39:34 +0100 (CET)
Date: Fri, 21 Jan 2011 13:39:33 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110121133933.5d72795d@regolo>
Mime-Version: 1.0
Subject: [LTP] [PATCH] Fix access out of bounds in dup204.c.
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

Hi,

this should fix an access out-of-bounds.

Signed-off-by: Cristian Greco <cristian@regolo.cc>
---
 testcases/kernel/syscalls/dup2/dup204.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup204.c
b/testcases/kernel/syscalls/dup2/dup204.c index fd20ece..97f7f57 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -132,10 +132,10 @@ void cleanup()
 
 	TEST_CLEANUP;
 
-	for (i = 0; i < sizeof(fd); i++) {
+	for (i = 0; i < TST_TOTAL; i++) {
 		close(fd[i]);
 		close(nfd[i]);
 	}
 
 	tst_rmdir();
-}
\ No newline at end of file
+}
-- 
1.7.2.3


Thanks,
--
Cristian Greco
GPG key ID: 0xCF4D32E4

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
