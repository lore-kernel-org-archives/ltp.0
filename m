From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 3 May 2018 16:52:45 +0800
Subject: [LTP] [PATCH] nfs/nfs_lib.sh: Fix wrong getopts parameter handling
Message-ID: <1525337565-10101-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If nfs_lib.sh didn't use TST_OPTS and passed getopts parameter to
tst_net.sh which could only handle -6, it caused getopts error:
----------------------------------------------------------------
/opt/ltp/testcases/bin/nfs01: illegal option -- v
/opt/ltp/testcases/bin/tst_net.sh: line 37: ?: command not found
----------------------------------------------------------------

We use TST_OPTS and TST_PARSE_ARGS to fix this issue.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 0abf39d..28c43ba 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -20,8 +20,12 @@ NFILES=${NFILES:=1000}
 SOCKET_TYPE="${SOCKET_TYPE:-udp}"
 NFS_TYPE=${NFS_TYPE:=nfs}
 
-while getopts :ht:v:6 opt; do
-	case "$opt" in
+TST_OPTS=":hv:t:"
+TST_PARSE_ARGS=nfs_parse_args
+
+nfs_parse_args()
+{
+	case "$1" in
 	h)
 		echo "Usage:"
 		echo "h        help"
@@ -30,15 +34,11 @@ while getopts :ht:v:6 opt; do
 		echo "6        run over IPv6"
 		exit 0
 	;;
-	v) VERSION=$OPTARG ;;
-	t) SOCKET_TYPE=$OPTARG ;;
-	6) # skip, test_net library already processed it
-	;;
-	*)
-		tst_brkm TBROK "unknown option: $opt"
-	;;
+	v) VERSION=$OPTARG;;
+	t) SOCKET_TYPE=$OPTARG;;
+	*) tst_brkm TBROK "unknown option: $1"
 	esac
-done
+}
 
 get_socket_type()
 {
-- 
1.8.3.1



