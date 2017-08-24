From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 Aug 2017 01:44:30 +0200
Subject: [LTP] [RFC PATCH v9 1/7] lib/test_net.sh: Add unused IP address
	helper functions
In-Reply-To: <20170824234436.18145-1-pvorel@suse.cz>
References: <20170824234436.18145-1-pvorel@suse.cz>
Message-ID: <20170824234436.18145-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh | 66 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index c11747a27..585ab51fe 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -219,7 +219,7 @@ tst_ipaddr()
 {
 	local type="${1:-lhost}"
 	local ipv="${TST_IPV6:-4}"
-	local tst_host=
+	local tst_host
 
 	if [ "$type" = "lhost" ]; then
 		eval "tst_host=\$LHOST_IPV${ipv}_HOST"
@@ -234,6 +234,70 @@ tst_ipaddr()
 	fi
 }
 
+# Get IP address of unused network, specified by either by type and
+# counter or by net and host.
+# tst_ipaddr_un [-cCOUNTER] [TYPE]
+# tst_ipaddr_un NET_ID [HOST_ID]
+# TYPE: { lhost | rhost }; Default value is 'lhost'.
+# COUNTER: Integer value for counting HOST_ID and NET_ID. Default is 1.
+# NET_ID: Integer or hex value of net. For IPv4 is 3rd octet, for IPv6 is 3rd
+# hextet.
+# HOST_ID: Integer or hex value of host. For IPv4 is 4th octet, for IPv6 is the
+# last hextet. Default value is 0.
+tst_ipaddr_un()
+{
+	local counter host_id net_id max_host_id max_net_id tmp type
+	local OPTIND
+
+	while getopts "c:" opt; do
+		case $opt in
+			c) counter="$OPTARG";;
+		esac
+	done
+	shift $(($OPTIND - 1))
+
+	[ "$TST_IPV6" ] && max_net_id=65535 || max_net_id=255
+
+	if [ $# -eq 0 -o "$1" = "lhost" -o "$1" = "rhost" ]; then
+		[ -z "$counter" ] && counter=1
+		[ $counter -lt 1 ] && counter=1
+		type="${1:-lhost}"
+		max_host_id=$((max_net_id - 1))
+		tmp=$((counter * 2))
+		[ "$type" = "rhost" ] && tmp=$((tmp - 1))
+
+		host_id=$((tmp % max_host_id))
+		net_id=$((tmp / max_host_id))
+
+		if [ $host_id -eq 0 ]; then
+			host_id=$max_host_id
+			net_id=$((net_id - 1))
+		fi
+	else
+		net_id="$1"
+		host_id="${2:-0}"
+		max_host_id=$max_net_id
+		if [ "$TST_IPV6" ]; then
+			net_id=$(printf %d $net_id)
+			host_id=$(printf %d $host_id)
+		fi
+		[ $net_id -lt 0 ] && net_id=0
+		[ $host_id -lt 0 ] && host_id=1
+	fi
+
+	net_id=$((net_id % max_net_id))
+	host_id=$((host_id % max_host_id))
+
+	if [ "$TST_IPV6" ]; then
+		[ $host_id -gt 0 ] && host_id="$(printf %x $host_id)" || host_id=
+		[ $net_id -gt 0 ] && net_id="$(printf %x $net_id)" || net_id=
+		[ "$net_id" ] && net_id=":$net_id"
+		echo "${IPV6_NET32_UNUSED}${net_id}::${host_id}"
+	else
+		echo "${IPV4_NET16_UNUSED}.${net_id}.${host_id}"
+	fi
+}
+
 # tst_init_iface [TYPE] [LINK]
 # TYPE: { lhost | rhost }; Default value is 'lhost'.
 # LINK: link number starting from 0. Default value is '0'.
-- 
2.14.0

