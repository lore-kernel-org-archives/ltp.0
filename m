From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 25 Jul 2019 13:10:24 +0200
Subject: [LTP] [PATCH v3 2/5] tst_net.sh: Add -m option to return mask in
 tst_ipaddr_un()
In-Reply-To: <20190725111027.18716-1-pvorel@suse.cz>
References: <20190725111027.18716-1-pvorel@suse.cz>
Message-ID: <20190725111027.18716-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ reformat docs a bit

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 54e975473..df91fd772 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -353,22 +353,25 @@ tst_ipaddr()
 
 # Get IP address of unused network, specified either by type and counter
 # or by net and host.
-# tst_ipaddr_un [-cCOUNTER] [TYPE]
+# tst_ipaddr_un [-cCOUNTER] [-m] [TYPE]
 # tst_ipaddr_un NET_ID [HOST_ID]
-# TYPE: { lhost | rhost }; Default value is 'lhost'.
-# COUNTER: Integer value for counting HOST_ID and NET_ID. Default is 1.
-# NET_ID: Integer or hex value of net. For IPv4 is 3rd octet, for IPv6
-# is 3rd hextet.
-# HOST_ID: Integer or hex value of host. For IPv4 is 4th octet, for
-# IPv6 is the last hextet. Default value is 0.
+#
+# OPTIONS
+# -c COUNTER: integer value for counting HOST_ID and NET_ID (default: 1)
+# -m: print also mask
+# TYPE: { lhost | rhost } (default: 'lhost')
+# NET_ID: integer or hex value of net (IPv4: 3rd octet, IPv6: 3rd hextet)
+# HOST_ID: integer or hex value of host (IPv4: 4th octet, IPv6: the last
+# hextet, default: 0)
 tst_ipaddr_un()
 {
-	local counter host_id net_id max_host_id max_net_id tmp type
+	local counter host_id mask max_host_id max_net_id net_id tmp type
 	local OPTIND
 
-	while getopts "c:" opt; do
+	while getopts "c:m" opt; do
 		case $opt in
 			c) counter="$OPTARG";;
+			m) [ "$TST_IPV6" ] && mask="/64" || mask="/24";;
 		esac
 	done
 	shift $(($OPTIND - 1))
@@ -405,14 +408,14 @@ tst_ipaddr_un()
 	host_id=$((host_id % max_net_id))
 
 	if [ -z "$TST_IPV6" ]; then
-		echo "${IPV4_NET16_UNUSED}.${net_id}.${host_id}"
+		echo "${IPV4_NET16_UNUSED}.${net_id}.${host_id}${mask}"
 		return
 	fi
 
 	[ $host_id -gt 0 ] && host_id="$(printf %x $host_id)" || host_id=
 	[ $net_id -gt 0 ] && net_id="$(printf %x $net_id)" || net_id=
 	[ "$net_id" ] && net_id=":$net_id"
-	echo "${IPV6_NET32_UNUSED}${net_id}::${host_id}"
+	echo "${IPV6_NET32_UNUSED}${net_id}::${host_id}${mask}"
 }
 
 # tst_init_iface [TYPE] [LINK]
-- 
2.22.0

