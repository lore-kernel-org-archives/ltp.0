Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <avagin@gmail.com>) id 1NDHit-0000Go-Mn
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 13:15:55 +0000
Received: from mailhub.sw.ru ([195.214.232.25] helo=relay.sw.ru)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NDHil-0001Ua-KR
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 13:15:55 +0000
From: Andrew Vagin <avagin@gmail.com>
Date: Wed, 25 Nov 2009 16:15:27 +0300
Message-Id: <1259154927-12569-1-git-send-email-avagin@gmail.com>
Subject: [LTP] [PATCH] clock_settime03: improve message about fail
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net, vapier@gentoo.org

---
 .../kernel/timers/clock_settime/clock_settime03.c  |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/timers/clock_settime/clock_settime03.c b/testcases/kernel/timers/clock_settime/clock_settime03.c
index 7638abd..5026242 100755
--- a/testcases/kernel/timers/clock_settime/clock_settime03.c
+++ b/testcases/kernel/timers/clock_settime/clock_settime03.c
@@ -193,7 +193,8 @@ main(int ac, char **av)
 						, testcase[i].exp_errval,
 						testcase[i].err_desc);
 			} else {
-				tst_resm(TFAIL, "clock_settime(2) failed to"
+				tst_resm(TFAIL | TTERRNO,
+						"clock_settime(2) failed to"
 						" produce expected error; %d"
 						" , errno : %s and got %ld",
 						testcase[i].exp_errno,
-- 
1.6.2.5


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
