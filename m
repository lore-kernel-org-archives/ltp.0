Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <cristian@regolo.cc>) id 1PgGH6-00076m-CX
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 12:39:32 +0000
Received: from aiolia.regolo.cc ([178.79.135.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PgGH5-0004OD-51
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 12:39:32 +0000
Received: from regolo (93-46-43-128.ip106.fastwebnet.it [93.46.43.128])
	by aiolia.regolo.cc (Postfix) with ESMTPSA id 5018464
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 13:39:25 +0100 (CET)
Date: Fri, 21 Jan 2011 13:39:22 +0100
From: Cristian Greco <cristian@regolo.cc>
Message-ID: <20110121133922.7103ddbb@regolo>
Mime-Version: 1.0
Subject: [LTP] [PATCH] Fix missing curly bracket in abort01.c.
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

this should fix a missing bracket.

Signed-off-by: Cristian Greco <cristian@regolo.cc>
---
 testcases/kernel/syscalls/abort/abort01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/abort/abort01.c
b/testcases/kernel/syscalls/abort/abort01.c index 7c1f74f..ab0250f
100644 --- a/testcases/kernel/syscalls/abort/abort01.c
+++ b/testcases/kernel/syscalls/abort/abort01.c
@@ -107,7 +107,7 @@ int main(int argc, char *argv[])
 		if ((kidpid = FORK_OR_VFORK()) == 0) {
 #ifdef UCLINUX
 			if (self_exec(argv[0], "")) {
-				if (!instress())
+				if (!instress()) {
 					perror("fork failed");
 					exit(1);
 				}
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
