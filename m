From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 16:07:15 +0200
Subject: [LTP] [PATCH 1/2] tst_net.sh: Add variable for supported protocol
In-Reply-To: <20210714140716.1568-1-pvorel@suse.cz>
References: <20210714140716.1568-1-pvorel@suse.cz>
Message-ID: <20210714140716.1568-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

via TST_NET_IPV{4,6}_ONLY variables.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh  | 8 ++++++++
 testcases/lib/tst_test.sh | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 511fb7eb1..b90fd9dfa 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -59,6 +59,14 @@ tst_net_remote_tmpdir()
 
 tst_net_setup()
 {
+	if [ "$TST_NET_IPV4_ONLY" = 1 -a $TST_IPVER = 6 ]; then
+		tst_brk TCONF "Test must be run on IPv4 only"
+	fi
+
+	if [ "$TST_NET_IPV6_ONLY" = 1 -a $TST_IPVER = 4 ]; then
+		tst_brk TCONF "Test must be run on IPv6 only"
+	fi
+
 	tst_net_remote_tmpdir
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c6aa2c487..6e64ef0ff 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -577,7 +577,7 @@ tst_run()
 			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
 			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
-			NET_SKIP_VARIABLE_INIT);;
+			NET_IPV4_ONLY|NET_IPV6_ONLY|NET_SKIP_VARIABLE_INIT);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
-- 
2.32.0

