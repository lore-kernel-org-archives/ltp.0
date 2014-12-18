Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Maxin.John@enea.com>) id 1Y1dvc-0002kB-JV
	for ltp-list@lists.sourceforge.net; Thu, 18 Dec 2014 16:27:52 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1Y1dvb-0001us-BO
	for ltp-list@lists.sourceforge.net; Thu, 18 Dec 2014 16:27:52 +0000
From: <maxin.john@gmail.com>
Date: Thu, 18 Dec 2014 17:27:37 +0100
Message-ID: <1418920057-53786-1-git-send-email-maxin.john@gmail.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] run-posix-option-group-test: remove set -x debug
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
Cc: "Maxin B. John" <maxin.john@enea.com>

From: "Maxin B. John" <maxin.john@enea.com>

remove "set -x" in the shell script

Signed-off-by: Maxin B. John <maxin.john@enea.com>
---
 testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
index 17f6e49..0477bd7 100755
--- a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
+++ b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
@@ -22,7 +22,6 @@ EOF
 
 run_option_group_tests()
 {
-	set -x
 	for test_script in $(find $1 -name run.sh); do
 		(cd "$(dirname "$test_script")" && ./$(basename "$test_script"))
 	done
-- 
1.9.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
