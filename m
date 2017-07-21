From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Jul 2017 06:04:07 +0200
Subject: [LTP] [RFC PATCH v7 11/11] network: Use tools to set up IPv4 and
	IPv6 related variables
In-Reply-To: <20170721040407.868-1-pvorel@suse.cz>
References: <20170721040407.868-1-pvorel@suse.cz>
Message-ID: <20170721040407.868-12-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Tools (tst_net_ip_prefix, tst_net_iface_prefix, tst_net_vars)
simplify setup as it only needs to have passed 4 IP addresses
(IPv4 lhost + rhost and IPv6 lhost + rhost).

It's possible to define different network part for local
and remote hosts.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh                          | 94 +++++++++++++++-------
 testcases/network/stress/interface/if4-addr-change | 17 ++--
 2 files changed, 75 insertions(+), 36 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index cecb0bab2..95510f7cf 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -230,19 +230,10 @@ tst_read_opts $*
 tst_ipaddr()
 {
 	local type="${1:-lhost}"
-	local ipv="${TST_IPV6:-4}"
-	local tst_host=
-
-	if [ "$type" = "lhost" ]; then
-		eval "tst_host=\$LHOST_IPV${ipv}_HOST"
-	else
-		eval "tst_host=\$RHOST_IPV${ipv}_HOST"
-	fi
-
 	if [ "$TST_IPV6" ]; then
-		echo "${IPV6_NETWORK}:${tst_host}"
+		[ "$type" = "lhost" ] && echo "$IPV6_LHOST" || echo "$IPV6_RHOST"
 	else
-		echo "${IPV4_NETWORK}.${tst_host}"
+		[ "$type" = "lhost" ] && echo "$IPV4_LHOST" || echo "$IPV4_RHOST"
 	fi
 }
 
@@ -281,9 +272,13 @@ tst_add_ipaddr()
 {
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
+	local mask
 
-	local mask=24
-	[ "$TST_IPV6" ] && mask=64
+	if [ "$TST_IPV6" ]; then
+		[ "$type" = "lhost" ] && mask=$IPV6_LPREFIX || mask=$IPV6_RPREFIX
+	else
+		[ "$type" = "lhost" ] && mask=$IPV4_LPREFIX || mask=$IPV4_RPREFIX
+	fi
 
 	local iface=$(tst_iface $type $link_num)
 
@@ -529,25 +524,58 @@ export PASSWD="${PASSWD:-}"
 export LTP_RSH="${LTP_RSH:-rsh -n}"
 
 # Test Links
-# Set first three octets of the network address, default is '10.0.0'
-export IPV4_NETWORK="${IPV4_NETWORK:-10.0.0}"
-# Set local host last octet, default is '2'
-export LHOST_IPV4_HOST="${LHOST_IPV4_HOST:-2}"
-# Set remote host last octet, default is '1'
-export RHOST_IPV4_HOST="${RHOST_IPV4_HOST:-1}"
-# Set the reverse of IPV4_NETWORK
-export IPV4_NET_REV="${IPV4_NET_REV:-0.0.10}"
-# Set first three octets of the network address, default is 'fd00:1:1:1'
-export IPV6_NETWORK="${IPV6_NETWORK:-fd00:1:1:1}"
-# Set local host last octet, default is '2'
-export LHOST_IPV6_HOST="${LHOST_IPV6_HOST:-:2}"
-# Set remote host last octet, default is '1'
-export RHOST_IPV6_HOST="${RHOST_IPV6_HOST:-:1}"
-
-# Networks that aren't reachable through the test links
-export IPV4_NET16_UNUSED="${IPV4_NET16_UNUSED:-10.23}"
-export IPV6_NET32_UNUSED="${IPV6_NET32_UNUSED:-fd00:23}"
+# IPV{4,6}_{L,R}HOST can be set with or without prefix (e.g. IP or IP/prefix),
+# but if you use IP/prefix form, /prefix will be removed by tst_net_vars.
+IPV4_LHOST="${IPV4_LHOST:-10.0.0.2/24}"
+IPV4_RHOST="${IPV4_RHOST:-10.0.0.1/24}"
+IPV6_LHOST="${IPV6_LHOST:-fd00:1:1:1::2/64}"
+IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
+
+# tst_net_ip_prefix
+# Strip prefix from IP address and save both If no prefix found sets
+# default prefix.
+#
+# tst_net_iface_prefix reads prefix and interface from rtnetlink.
+# If nothing found sets default prefix value.
+#
+# tst_net_vars exports environment variables related to test links and
+# networks that aren't reachable through the test links.
+# Not run for netns (init_ltp_netspace is not called, no links setup yet).
+#
+# For full list of exported environment variables see:
+# tst_net_ip_prefix -h
+# tst_net_iface_prefix -h
+# tst_net_vars -h
+if [ -z "$TST_PARSE_VARIABLES" ]; then
+	tst_resm TINFO "Parsing IP and prefixes"
+	set -x
+	eval "$(tst_net_ip_prefix $IPV4_LHOST)" || exit $?
+	eval "$(tst_net_ip_prefix -r $IPV4_RHOST)" || exit $?
+	eval "$(tst_net_ip_prefix $IPV6_LHOST)" || exit $?
+	eval "$(tst_net_ip_prefix -r $IPV6_RHOST)" || exit $?
+	set +x
+
+	if [ "$TST_USE_NETNS" != "yes" ]; then
+		tst_resm TINFO "Parsing prefixes and ifaces from rtnetlink"
+		set -x
+		eval "$(tst_net_iface_prefix $IPV4_LHOST)" || exit $?
+		eval "$(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST)" || exit $?
+		eval "$(tst_net_iface_prefix $IPV6_LHOST)" || exit $?
+		eval "$(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST)" || exit $?
+		set +x
+	fi
 
+	tst_resm TINFO "Parsing all remaining variables"
+	set -x
+	eval "$(tst_net_vars $IPV4_LHOST/$IPV4_LPREFIX $IPV4_RHOST/$IPV4_RPREFIX)" || exit $?
+	eval "$(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX $IPV6_RHOST/$IPV6_RPREFIX)" || exit $?
+	set +x
+
+	export TST_PARSE_VARIABLES="yes"
+fi
+
+# The rest of variables for networks that aren't reachable through the test links.
+# IPV4_NET16_UNUSED and IPV6_NET32_UNUSED are set by tst_net_vars.
 export OCTET_3_IPV4_UNUSED=${OCTET_3_IPV4_UNUSED:-23} # x.x.N.x
 export OCTET_4_LHOST_IPV4_HOST_UNUSED=${OCTET_4_LHOST_IPV4_HOST_UNUSED:-2} # x.x.x.N
 export OCTET_4_RHOST_IPV4_HOST_UNUSED=${OCTET_4_RHOST_IPV4_HOST_UNUSED:-1} # x.x.x.N
@@ -564,6 +592,7 @@ export RHOST_IPV6_HOST_UNUSED="${OCTET_3_IPV6_UNUSED}:${OCTET_4_RHOST_IPV6_HOST_
 export LHOST_IPV6_UNUSED="${IPV6_NET32_UNUSED}:$LHOST_IPV6_HOST_UNUSED"
 export RHOST_IPV6_UNUSED="${IPV6_NET32_UNUSED}:$RHOST_IPV6_HOST_UNUSED"
 
+# Directories for http and ftp stress tests
 export HTTP_DOWNLOAD_DIR="${HTTP_DOWNLOAD_DIR:-/var/www/html}"
 export FTP_DOWNLOAD_DIR="${FTP_DOWNLOAD_DIR:-/var/ftp}"
 export FTP_UPLOAD_DIR="${FTP_UPLOAD_DIR:-/var/ftp/pub}"
@@ -589,8 +618,11 @@ export MCASTNUM_HEAVY="${MCASTNUM_HEAVY:-4000}"
 
 # Warning: make sure to set valid interface names and IP addresses below.
 # Set names for test interfaces, e.g. "eth0 eth1"
+# This is fallback for LHOST_IFACES in case tst_net_vars finds nothing or we
+# want to use more ifaces.
 export LHOST_IFACES="${LHOST_IFACES:-eth0}"
 export RHOST_IFACES="${RHOST_IFACES:-eth0}"
+
 # Set corresponding HW addresses, e.g. "00:00:00:00:00:01 00:00:00:00:00:02"
 export LHOST_HWADDRS="${LHOST_HWADDRS:-$(tst_get_hwaddrs lhost)}"
 export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
index 567f86643..a7469c252 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -48,12 +48,19 @@ while [ $cnt -lt $NS_TIMES ]; do
 
 	[ $num -eq $RHOST_IPV4_HOST ] && continue
 
-	# Change IPv4 address
-	lhost_ipv4addr="${IPV4_NETWORK}.${num}"
+	# check prefix and fix values for prefix != 24
+	add_to_net=
+	if [ $IPV4_LPREFIX -lt 8 -o $IPV4_LPREFIX -ge 32 ] ; then
+		tst_brkm TCONF "test must be with prefix >= 8 and prefix < 32 ($IPV4_LPREFIX)"
+	elif [ $IPV4_LPREFIX -lt 16 ]; then # N.x.x.num
+		add_to_net=".0.1"
+	elif [ $IPV4_LPREFIX -lt 24 ]; then # N.N.x.num
+		add_to_net=".1"
+	fi
 
-	ifconfig $(tst_iface) $lhost_ipv4addr netmask 255.255.255.0 \
-		broadcast 255.255.255.255 || \
-		tst_brkm TFAIL "Failed to change into ${lhost_ipv4addr}"
+	# Change IPv4 address
+	ROD ifconfig $(tst_iface) ${IPV4_LNETWORK}${add_to_net}.${num} netmask \
+		$IPV4_LNETMASK broadcast $IPV4_LBROADCAST
 
 	cnt=$(($cnt + 1))
 
-- 
2.13.2

