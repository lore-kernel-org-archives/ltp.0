From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 15:24:27 +0200
Subject: [LTP] [PATCH v5 2/8] tst_net.sh: Add -p option to return prefix in
 tst_ipaddr_un()
In-Reply-To: <20191011132433.24197-1-pvorel@suse.cz>
References: <20191011132433.24197-1-pvorel@suse.cz>
Message-ID: <20191011132433.24197-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ reformat docs a bit

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 2f6f0b275..0d6c29407 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -357,28 +357,33 @@ tst_ipaddr()
 
 # Get IP address of unused network, specified either by type and counter
 # or by net and host.
-# tst_ipaddr_un [-cCOUNTER] [TYPE]
-# tst_ipaddr_un NET_ID [HOST_ID]
-# TYPE: { lhost | rhost }; Default value is 'lhost'.
-# COUNTER: Integer value for counting HOST_ID and NET_ID. Default is 1.
-# NET_ID: Integer or hex value of net. For IPv4 is 3rd octet, for IPv6
-# is 3rd hextet.
-# HOST_ID: Integer or hex value of host. For IPv4 is 4th octet, for
-# IPv6 is the last hextet. Default value is 0.
+# tst_ipaddr_un [-cCOUNTER] [-p] [TYPE]
+# tst_ipaddr_un [-p] NET_ID [HOST_ID]
+#
+# TYPE: { lhost | rhost } (default: 'lhost')
+# NET_ID: integer or hex value of net (IPv4: 3rd octet, IPv6: 3rd hextet)
+# HOST_ID: integer or hex value of host (IPv4: 4th octet, IPv6: the last
+# hextet, default: 0)
+#
+# OPTIONS
+# -c COUNTER: integer value for counting HOST_ID and NET_ID (default: 1)
+# -p: print also prefix
 tst_ipaddr_un()
 {
-	local counter host_id net_id max_host_id max_net_id tmp type
+	local counter host_id max_host_id max_net_id net_id prefix tmp type
 	local OPTIND
 
-	while getopts "c:" opt; do
+	while getopts "c:p" opt; do
 		case $opt in
 			c) counter="$OPTARG";;
+			p) [ "$TST_IPV6" ] && prefix="/64" || prefix="/24";;
 		esac
 	done
 	shift $(($OPTIND - 1))
 
 	[ "$TST_IPV6" ] && max_net_id=65535 || max_net_id=255
 
+	# counter
 	if [ $# -eq 0 -o "$1" = "lhost" -o "$1" = "rhost" ]; then
 		[ -z "$counter" ] && counter=1
 		[ $counter -lt 1 ] && counter=1
@@ -394,7 +399,7 @@ tst_ipaddr_un()
 			host_id=$max_host_id
 			net_id=$((net_id - 1))
 		fi
-	else
+	else # net_id & host_id
 		net_id="$1"
 		host_id="${2:-0}"
 		if [ "$TST_IPV6" ]; then
@@ -409,14 +414,14 @@ tst_ipaddr_un()
 	host_id=$((host_id % max_net_id))
 
 	if [ -z "$TST_IPV6" ]; then
-		echo "${IPV4_NET16_UNUSED}.${net_id}.${host_id}"
+		echo "${IPV4_NET16_UNUSED}.${net_id}.${host_id}${prefix}"
 		return
 	fi
 
 	[ $host_id -gt 0 ] && host_id="$(printf %x $host_id)" || host_id=
 	[ $net_id -gt 0 ] && net_id="$(printf %x $net_id)" || net_id=
 	[ "$net_id" ] && net_id=":$net_id"
-	echo "${IPV6_NET32_UNUSED}${net_id}::${host_id}"
+	echo "${IPV6_NET32_UNUSED}${net_id}::${host_id}${prefix}"
 }
 
 # tst_init_iface [TYPE] [LINK]
-- 
2.23.0

