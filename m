From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 May 2018 14:22:22 +0200
Subject: [LTP] [RFC PATCH 3/3] net/virt_lib.sh: Use positional parameters in
	TST_PARSE_ARGS function
In-Reply-To: <20180503122222.2996-1-pvorel@suse.cz>
References: <20180503122222.2996-1-pvorel@suse.cz>
Message-ID: <20180503122222.2996-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

as it's now supported also for legacy API.

Major problem was with using global $opt instead of $1 (dependency on
how the library function implemented), but avoiding using $OPTARG
directly is also preferable.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/virt/virt_lib.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 0f75bb030..1fd02ac9b 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -31,7 +31,7 @@
 
 virt_lib_parse_args()
 {
-	case "$opt" in
+	case "$1" in
 	h)
 		echo "Usage:"
 		echo "h        help"
@@ -40,8 +40,8 @@ virt_lib_parse_args()
 		echo "6        run over IPv6"
 		exit 0
 	;;
-	i) start_id=$OPTARG ;;
-	d) vxlan_dst_addr=$OPTARG ;;
+	i) start_id=$2 ;;
+	d) vxlan_dst_addr=$2 ;;
 	*)
 		tst_brkm TBROK "unknown option: $opt"
 	;;
-- 
2.16.3

