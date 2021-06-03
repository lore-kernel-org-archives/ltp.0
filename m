From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 Jun 2021 17:10:11 +0200
Subject: [LTP] [PATCH 1/2] tst_net.sh: Allow to skip initialization
Message-ID: <20210603151012.14760-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

with TST_NET_SKIP_VARIABLE_INIT=1.
Useful for testing the library itself.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh  | 2 ++
 testcases/lib/tst_test.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index fc5719057..db1db4790 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -933,6 +933,8 @@ tst_default_max_pkt()
 	echo "$((mtu + mtu / 10))"
 }
 
+[ -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
+
 # Management Link
 [ -z "$RHOST" ] && TST_USE_NETNS="yes"
 export RHOST="$RHOST"
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 66ffde4eb..8b4e9cb60 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -559,6 +559,7 @@ tst_run()
 			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
 			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
+			NET_SKIP_VARIABLE_INIT);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
-- 
2.31.1

