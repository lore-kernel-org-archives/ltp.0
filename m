Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nobuhiro@andestech.com>) id 1Mm6q9-0005bu-43
	for ltp-list@lists.sourceforge.net; Fri, 11 Sep 2009 14:11:05 +0000
Received: from 59-124-160-117.hinet-ip.hinet.net ([59.124.160.117]
	helo=ATCPCS06.andestech.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mm6q1-0003ku-HT
	for ltp-list@lists.sourceforge.net; Fri, 11 Sep 2009 14:11:02 +0000
From: Nobuhiro Lin <nobuhiro@andestech.com>
Date: Fri, 11 Sep 2009 21:20:33 +0800
Message-Id: <1252675233-19350-1-git-send-email-nobuhiro@andestech.com>
Subject: [LTP] [PATCH] pselect01: Fixed the checking logic to also consider
	some variation.
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
To: ltp-list@lists.sourceforge.net

From: nobuhiro <nobuhiro@andestech.com>

Sometimes we may get failed results that the measured time is 1 second longer than expected.
As fixed by Craig Meier earlier, the sleeps may last slightly more than total_sec.
Also considering the time() overhead, we should expect the sleeps to last between
total_sec and (total_sec+1) seconds.

Signed-off-by: Nobuhiro Lin <nobuhiro@andestech.com>
---
 testcases/kernel/syscalls/pselect/pselect01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index 08d168f..1778dfe 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -108,7 +108,7 @@ int main()
 			    NULL);
 		end = time(&t);
 
-		if (total_sec >= (end - start))
+		if(((end - start) >= total_sec) && ((end - start) <= total_sec + 1))
 			tst_resm(TPASS, "Sleep time was correct");
 		else
 			tst_resm(TFAIL, "Sleep time was incorrect:%d != %d",
-- 
1.6.3.1


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
