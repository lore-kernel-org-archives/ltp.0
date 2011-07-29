Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Yi.Zhao@windriver.com>) id 1Qmg9Y-0006BW-V4
	for ltp-list@lists.sourceforge.net; Fri, 29 Jul 2011 06:02:32 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qmg9V-0007gZ-2i
	for ltp-list@lists.sourceforge.net; Fri, 29 Jul 2011 06:02:32 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p6T62McG022580
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Jul 2011 23:02:22 -0700 (PDT)
From: Yi Zhao <yi.zhao@windriver.com>
Date: Fri, 29 Jul 2011 14:02:17 +0800
Message-ID: <1311919337-22442-1-git-send-email-yi.zhao@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] run-all-posix-option-group-tests.sh: Fix a spelling
	mistake
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

The script can not work due to this mistake.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../bin/run-all-posix-option-group-tests.sh        |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/bin/run-all-posix-option-group-tests.sh b/testcases/open_posix_testsuite/bin/run-all-posix-option-group-tests.sh
index a9b2c05..39ff989 100755
--- a/testcases/open_posix_testsuite/bin/run-all-posix-option-group-tests.sh
+++ b/testcases/open_posix_testsuite/bin/run-all-posix-option-group-tests.sh
@@ -8,7 +8,7 @@
 #
 
 FAILED=0
-RPOG_SCRIPT="$(dirname "$0")/run-posix-option-group-test.sh"
+PROG_SCRIPT="$(dirname "$0")/run-posix-option-group-test.sh"
 
 for option_group in AIO MEM MSG SEM SIG THR TMR TPS; do
 	if ! $PROG_SCRIPT $option_group; then
-- 
1.7.1


------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
