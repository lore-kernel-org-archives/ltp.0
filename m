Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MIYM5-0004yF-O6
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:29:53 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIYM4-0005m2-Bc
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:29:53 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id F391710661A2F
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 02:31:23 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277) id 1MIXRT-0000TR-00
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:31:23 +0200
Date: Wed, 17 Jun 2009 17:27:31 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvwg6ylrlwynca@debian>
Subject: [LTP] [PATCH] Use __i386__ instead of _i386__ in HTutils.c
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
Message-ID: <20090617152731.YvzckVWNa1ptrVji2vBOdDYkt1SN1qtEzffubNMgZZ4@z>

This is probably a typo, the macro defined on 386 systems is named __i386__, not _i386__

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../sched/hyperthreading/ht_affinity/HTutils.c     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c b/testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c
index 5f37d1f..9d6e1c0 100644
--- a/testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c
+++ b/testcases/kernel/sched/hyperthreading/ht_affinity/HTutils.c
@@ -60,7 +60,7 @@ int is_ht_kernel()
 
 inline void cpuid(int op, int *eax, int *ebx, int *ecx, int *edx)
 {
-#ifndef _i386__
+#ifndef __i386__
 	return;
 #else
 	__asm__("cpuid"
-- 
1.6.3.1




------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
