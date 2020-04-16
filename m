From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Apr 2020 12:45:47 +0200
Subject: [LTP] [PATCH 1/2] net: Add $TST_NET_DATAROOT variable
Message-ID: <20200416104548.27897-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Because $LTPROOT/testcases/bin/datafiles is used only by network tests,
once all network tests are rewritten into new API, it should the
location should be changed into some network specific path.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh  | 2 ++
 testcases/lib/tst_test.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index dd0c712c3..e887700bd 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -888,6 +888,8 @@ if [ -z "$_tst_net_parse_variables" ]; then
 	export _tst_net_parse_variables="yes"
 fi
 
+export TST_NET_DATAROOT="$LTPROOT/testcases/bin/datafiles"
+
 export TST_NETLOAD_CLN_REQUESTS="${TST_NETLOAD_CLN_REQUESTS:-10000}"
 export TST_NETLOAD_CLN_NUMBER="${TST_NETLOAD_CLN_NUMBER:-2}"
 export TST_NETLOAD_BINDTODEVICE="${TST_NETLOAD_BINDTODEVICE-1}"
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 0ddab62cf..1d8a71d9f 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -506,7 +506,7 @@ tst_run()
 			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
 			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
-			NET_MAX_PKT);;
+			NET_DATAROOT|NET_MAX_PKT);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
-- 
2.26.0

