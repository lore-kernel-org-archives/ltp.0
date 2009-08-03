Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <monstr@monstr.eu>) id 1MXxnP-0003JR-BG
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 13:41:47 +0000
Received: from [89.31.47.178] (helo=monstr.eu)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXxnJ-00040P-SR
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 13:41:47 +0000
From: michal.simek@petalogix.com
Date: Mon,  3 Aug 2009 15:24:16 +0200
Message-Id: <0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
In-Reply-To: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>
References: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>
Subject: [LTP] [PATCH 1/4] utimensat: Remove utimensat_user from script
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
Cc: ltp-list@lists.sourceforge.net, monstr@monstr.eu

From: Michal Simek <monstr@monstr.eu>

We can use nobody user instead of creating new one
for this special test. Latest busybox source
code not support userdel, useradd that's why
is better to use user which exists.

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 .../kernel/syscalls/utimensat/utimensat_tests.sh   |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
index 19c59c7..d0e940a 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
@@ -243,8 +243,7 @@ run_test()
 }
 #=====================================================================
 
-user_tester=utimensat_tester
-useradd $user_tester
+user_tester=nobody
 sudo -u $user_tester mkdir -p $TEST_DIR
 
 chown root $LTPROOT/testcases/bin/$TEST_PROG
@@ -434,7 +433,6 @@ echo "============================================================"
 
 echo
 
-userdel -r utimensat_tester
 rm -rf $TEST_PROG
 uname -a
 date
-- 
1.5.5.1


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
