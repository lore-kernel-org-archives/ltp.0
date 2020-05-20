From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 May 2020 15:26:04 +0800
Subject: [LTP] [PATCH] tirpc: Pass all extra client options to client program
Message-ID: <20200520072605.12614-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

New rpc_test.sh only passes the first extra client option to
client program if extra client options are two or more.
For example, only "1" is passed into tirpc_rpc_broadcast_exp:
-------------------------------------------
./runltp -f net.tirpc_tests -s tirpc_rpc_broadcast_exp
...
tag=tirpc_rpc_broadcast_exp stime=1589957933
cmdline="rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_broadcast_exp -e "1 2""
...
rpc_test 1 TFAIL: tirpc_rpc_broadcast_exp 10.0.0.2 536875000 1 failed unexpectedly
-------------------------------------------
For extra client options, use comma as a delimiter in net.tirpc_tests
and replace it with white space in rpc_test.sh

Fixes: 3190368d2df8 ("rpc/rpc_test.sh: Rewrite into new shell API")
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/net.tirpc_tests                     | 2 +-
 testcases/network/rpc/rpc-tirpc/rpc_test.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/net.tirpc_tests b/runtest/net.tirpc_tests
index 48e9ba3f5..8aa69ef4d 100644
--- a/runtest/net.tirpc_tests
+++ b/runtest/net.tirpc_tests
@@ -38,7 +38,7 @@ tirpc_clnt_control rpc_test.sh -s tirpc_svc_3 -c tirpc_clnt_control
 tirpc_rpc_reg rpc_test.sh -c tirpc_rpc_reg
 tirpc_rpc_call rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_call
 tirpc_rpc_broadcast rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_broadcast
-tirpc_rpc_broadcast_exp rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_broadcast_exp -e "1 2"
+tirpc_rpc_broadcast_exp rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_broadcast_exp -e "1,2"
 
 tirpc_clnt_create rpc_test.sh -s tirpc_svc_2 -c tirpc_clnt_create
 tirpc_clnt_create_timed rpc_test.sh -s tirpc_svc_2 -c tirpc_clnt_create_timed
diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index dc97213d0..bcefadbdb 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -37,7 +37,7 @@ rpc_parse_args()
 {
 	case "$1" in
 		c) CLIENT="$OPTARG" ;;
-		e) CLIENT_EXTRA_OPTS="$OPTARG" ;;
+		e) CLIENT_EXTRA_OPTS="${OPTARG//','/' '}" ;;
 		s) SERVER="$OPTARG" ;;
 	esac
 }
-- 
2.21.0



