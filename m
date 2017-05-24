From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 24 May 2017 11:40:27 +0300
Subject: [LTP] [PATCH 1/4] lib/test_net: print TPASS/TFAIL inside tst_ping()
In-Reply-To: <1495615230-29045-1-git-send-email-alexey.kodanev@oracle.com>
References: <1495615230-29045-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1495615230-29045-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since there is no usage of 'expected fail' in the tests with
tst_ping() and new shell library doesn't support passing shell
functions to EXPECT_PASS, set test result inside tst_ping.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index dae066b..2ed6fb4 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -426,9 +426,9 @@ tst_ping()
 			-s $size -i 0 > /dev/null 2>&1
 		ret=$?
 		if [ $ret -eq 0 ]; then
-			tst_resm TINFO "tst_ping IPv${TST_IPV6:-4} msg_size $size pass"
+			tst_resm TPASS "tst_ping IPv${TST_IPV6:-4} msg_size $size pass"
 		else
-			tst_resm TINFO "tst_ping IPv${TST_IPV6:-4} msg_size $size fail"
+			tst_resm TFAIL "tst_ping IPv${TST_IPV6:-4} msg_size $size fail"
 			break
 		fi
 	done
-- 
1.7.1

