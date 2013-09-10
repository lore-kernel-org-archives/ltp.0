Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VJQHJ-0007YX-9B
	for ltp-list@lists.sourceforge.net; Tue, 10 Sep 2013 15:54:57 +0000
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id A21FFA4EB7
	for <ltp-list@lists.sourceforge.net>;
	Tue, 10 Sep 2013 17:54:50 +0200 (CEST)
Date: Tue, 10 Sep 2013 17:55:10 +0200
From: chrubis@suse.cz
Message-ID: <20130910155508.GA25865@rei.Home>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] typo in runtest/mm?
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

Hi!
I've been looking at test results and found (what I think) is a typo in
test name:

diff --git a/runtest/mm b/runtest/mm
index a39becd..28151b5 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -72,7 +72,7 @@ ksm04_1 ksm04 -u 128
ksm05 ksm05 -I 10
ksm06 ksm06
ksm06_1 ksm06 -n 10
-ksn06_2 ksm06 -n 10000
+ksm06_2 ksm06 -n 10000

Should I apply this patch?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
