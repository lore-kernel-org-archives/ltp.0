From: Petr Vorel <pvorel@suse.cz>
Date: Sat,  3 Jun 2017 14:00:22 +0200
Subject: [LTP] [RFC PATCH v6 11/11] network: Use tst_net_vars to set up IPv4
	and IPv6 related variables
In-Reply-To: <20170603120022.13415-1-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
Message-ID: <20170603120022.13415-12-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_net_vars simplifies setup as it only needs to have passed 4 IP
addresses (2x IPv4 and 2 IPv6) and alows to define different network
part for local and remote hosts.

Rename variables in rewritten tests to use variables defined by
tst_net_vars. These scripts are run by testscripts/network.sh script
which defined these variables by setting test_net.sh, so it makes a
sense to use them.

Old tests still use IPV4_NETWORK variable instead of IPV4_LNETWORK and
IPV4_RNETWORK and have it defined locally.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh                          | 59 ++++++++++------------
 testcases/network/stress/interface/if4-addr-change |  2 +-
 .../stress/multicast/grp-operation/mcast4-lib.sh   |  6 +--
 .../network/stress/ns-tools/test_stress_net.sh     | 18 ++++---
 testcases/network/stress/route/route4-change-dst   |  4 +-
 testcases/network/stress/route/route4-change-gw    |  4 +-
 testcases/network/stress/route/route4-change-if    |  4 +-
 testcases/network/stress/route/route4-ifdown       |  8 +--
 testcases/network/stress/route/route4-lib.sh       | 20 ++++----
 testcases/network/stress/route/route4-redirect     |  4 +-
 testcases/network/stress/route/route4-rmmod        |  8 +--
 11 files changed, 68 insertions(+), 69 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 91a62f9f6..a470d1c45 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -197,19 +197,10 @@ tst_read_opts $*
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
 
@@ -248,9 +239,13 @@ tst_add_ipaddr()
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
 
@@ -495,24 +490,23 @@ export PASSWD="${PASSWD:-}"
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
+IPV4_LHOST="${IPV4_LHOST:-10.0.0.2}"
+IPV4_RHOST="${IPV4_RHOST:-10.0.0.1}"
+IPV6_LHOST="${IPV6_LHOST:-fd00:1:1:1::2}"
+IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1}"
+
+# tst_net_vars exports environment variables related to test links and networks
+# that aren't reachable through the test links.
+# See tst_net_vars -h for a list of exported variables.
+if [ -z "$TST_PARSE_VARIABLES" ]; then
+	tst_resm TINFO "Parsing variables for $IPV4_LHOST $IPV4_RHOST"
+	eval $(tst_net_vars $IPV4_LHOST $IPV4_RHOST)
+	tst_resm TINFO "Parsing variables for $IPV6_LHOST $IPV6_RHOST"
+	eval $(tst_net_vars $IPV6_LHOST $IPV6_RHOST)
+	TST_PARSE_VARIABLES="yes"
+fi
 
 export HTTP_DOWNLOAD_DIR="${HTTP_DOWNLOAD_DIR:-/var/www/html}"
 export FTP_DOWNLOAD_DIR="${FTP_DOWNLOAD_DIR:-/var/ftp}"
@@ -539,8 +533,11 @@ export MCASTNUM_HEAVY="${MCASTNUM_HEAVY:-40000}"
 
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
index 54b8fd5fb..5b9a71dc2 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -49,7 +49,7 @@ while [ $cnt -lt $NS_TIMES ]; do
 	[ $num -eq $RHOST_IPV4_HOST ] && continue
 
 	# Change IPv4 address
-	lhost_ipv4addr="${IPV4_NETWORK}.${num}"
+	lhost_ipv4addr="${IPV4_LNETWORK}.${num}"
 
 	ifconfig $(tst_iface) $lhost_ipv4addr netmask 255.255.255.0 \
 		broadcast 255.255.255.255 || \
diff --git a/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
index 5be7cd79e..21fb4c74d 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast4-lib.sh
@@ -55,10 +55,10 @@ do_setup()
 	lhost_ifname=$(tst_iface lhost $LINK_NUM)
 	rhost_ifname=$(tst_iface rhost $LINK_NUM)
 
-	set_lhost_rhost_ipv4addr $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST $RHOST_IPV4_HOST
+	set_lhost_rhost_ipv4addr $LINK_NUM $IPV4_LNETWORK $IPV4_RNETWORK $LHOST_IPV4_HOST $RHOST_IPV4_HOST
 
-	lhost_addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-	rhost_addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+	lhost_addr="${IPV4_LNETWORK}.${LHOST_IPV4_HOST}"
+	rhost_addr="${IPV4_RNETWORK}.${RHOST_IPV4_HOST}"
 
 	check_connectivity $lhost_ifname $rhost_addr
 
diff --git a/testcases/network/stress/ns-tools/test_stress_net.sh b/testcases/network/stress/ns-tools/test_stress_net.sh
index 3c890fe47..599d9acf1 100644
--- a/testcases/network/stress/ns-tools/test_stress_net.sh
+++ b/testcases/network/stress/ns-tools/test_stress_net.sh
@@ -19,7 +19,7 @@
 
 # Library for all network/stress/ tests.
 
-# using variables IPV4_NETWORK LHOST_IPV4_HOST RHOST_IPV4_HOST and some functions
+# using variables IPV4_LNETWORK IPV4_RNETWORK LHOST_IPV4_HOST RHOST_IPV4_HOST and some functions
 . test_net.sh
 
 tst_check_cmds ifconfig killall
@@ -35,7 +35,7 @@ IPV4_NETMASK="255.255.255.0"
 IPV4_NETMASK_NUM=24
 
 # Broadcast address of the tested network
-IPV4_BROADCAST=${IPV4_NETWORK}.255
+IPV4_BROADCAST=${IPV4_RNETWORK}.255
 # Prefix of the Multicast Address
 MCAST_IPV4_ADDR_PREFIX="224.10"
 # Multicast Address
@@ -80,18 +80,20 @@ set_ipv4addr_check()
 
 # Set an IPv4 address on local and remote interfaces.
 # LINK_NUM: link number starting from 0. Default value is '0'.
-# NETWORK_PART: network part of local and remote IP address
+# LNETWORK_PART: network part of local IP address
+# RNETWORK_PART: network part of remote IP address
 # LHOST_PART: host part of local IP address
 # RHOST_PART: host part of remote IP address
 set_lhost_rhost_ipv4addr()
 {
 	local link_num="$1"
-	local network_part="$2"
-	local lhost_part="$3"
-	local rhost_part="$4"
+	local lnetwork_part="$2"
+	local rnetwork_part="$3"
+	local lhost_part="$4"
+	local rhost_part="$5"
 
-	set_ipv4addr_check lhost $link_num $network_part $lhost_part
-	set_ipv4addr_check rhost $link_num $network_part $rhost_part
+	set_ipv4addr_check lhost $link_num $lnetwork_part $lhost_part
+	set_ipv4addr_check rhost $link_num $rnetwork_part $rhost_part
 }
 
 # Check connectivity with tst_ping.
diff --git a/testcases/network/stress/route/route4-change-dst b/testcases/network/stress/route/route4-change-dst
index 26510bc8b..89f4a267d 100644
--- a/testcases/network/stress/route/route4-change-dst
+++ b/testcases/network/stress/route/route4-change-dst
@@ -31,10 +31,10 @@ do_setup()
 	# Initialize the interfaces of the remote host
 	tst_init_iface rhost $LINK_NUM
 
-	set_ipv4addr_check rhost $LINK_NUM $IPV4_NETWORK $RHOST_IPV4_HOST
+	set_ipv4addr_check rhost $LINK_NUM $IPV4_RNETWORK $RHOST_IPV4_HOST
 
 	# IPv4 address of the remote host (gateway)
-	rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+	rhost_ipv4addr="${IPV4_RNETWORK}.${RHOST_IPV4_HOST}"
 
 	lhost_ifname=$(tst_iface lhost $LINK_NUM)
 	rhost_ifname=$(tst_iface rhost $LINK_NUM)
diff --git a/testcases/network/stress/route/route4-change-gw b/testcases/network/stress/route/route4-change-gw
index 00773f676..a91fade35 100644
--- a/testcases/network/stress/route/route4-change-gw
+++ b/testcases/network/stress/route/route4-change-gw
@@ -42,7 +42,7 @@ do_setup()
 	# Set IPv4 address to the interface of the remote host
 	rhost_part=$RHOST_IPV4_HOST_TOP
 	while [ $rhost_part -le $RHOST_IPV4_HOST_LAST ]; do
-		tst_rhost_run -s -c "ip addr add ${IPV4_NETWORK}.${rhost_part}/$IPV4_NETMASK_NUM broadcast $IPV4_BROADCAST dev $rhost_ifname"
+		tst_rhost_run -s -c "ip addr add ${IPV4_RNETWORK}.${rhost_part}/$IPV4_NETMASK_NUM broadcast $IPV4_BROADCAST dev $rhost_ifname"
 		rhost_part=$(($rhost_part + 1))
 	done
 }
@@ -56,7 +56,7 @@ do_cleanup()
 do_setup
 
 for cmd_name in rt_cmd ip_cmd; do
-	do_test_common "gw" $cmd_name $LINK_NUM 1 $lhost_ifname "${IPV4_NETWORK}.$RHOST_IPV4_HOST_TOP" $RHOST_IPV4_HOST_TOP $RHOST_IPV4_HOST_LAST
+	do_test_common "gw" $cmd_name $LINK_NUM 1 $lhost_ifname "${IPV4_RNETWORK}.$RHOST_IPV4_HOST_TOP" $RHOST_IPV4_HOST_TOP $RHOST_IPV4_HOST_LAST
 done
 
 do_cleanup
diff --git a/testcases/network/stress/route/route4-change-if b/testcases/network/stress/route/route4-change-if
index 3e0c25915..957945d3a 100644
--- a/testcases/network/stress/route/route4-change-if
+++ b/testcases/network/stress/route/route4-change-if
@@ -52,7 +52,7 @@ do_setup()
 		tst_init_iface rhost $link_num
 
 		# Set IPv4 address to the interface of the remote host
-		set_ipv4addr_check rhost ${link_num} "${IPV4_NETWORK_PRE}.${link_num}" ${RHOST_IPV4_HOST}
+		set_ipv4addr_check rhost ${link_num} "${IPV4_RNETWORK_PRE}.${link_num}" ${RHOST_IPV4_HOST}
 
 		link_num=$(( $link_num + 1 ))
 	done
@@ -72,7 +72,7 @@ do_cleanup()
 
 do_setup
 for cmd_name in rt_cmd ip_cmd; do
-	do_test_common "if" $cmd_name $LINK_NUM $link_total $lhost_ifname $IPV4_NETWORK_PRE
+	do_test_common "if" $cmd_name $LINK_NUM $link_total $lhost_ifname $IPV4_RNETWORK_PRE
 done
 do_cleanup
 tst_exit
diff --git a/testcases/network/stress/route/route4-ifdown b/testcases/network/stress/route/route4-ifdown
index 1c81a1f74..916944443 100644
--- a/testcases/network/stress/route/route4-ifdown
+++ b/testcases/network/stress/route/route4-ifdown
@@ -27,11 +27,11 @@ do_setup()
 {
 	do_cleanup_common
 
-	set_ipv4addr_check rhost ${LINK_NUM} ${IPV4_NETWORK} ${RHOST_IPV4_HOST}
-	rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+	set_ipv4addr_check rhost ${LINK_NUM} ${IPV4_RNETWORK} ${RHOST_IPV4_HOST}
+	rhost_ipv4addr="${IPV4_RNETWORK}.${RHOST_IPV4_HOST}"
 
-	set_ipv4addr_check lhost ${LINK_NUM} ${IPV4_NETWORK} ${LHOST_IPV4_HOST}
-	lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
+	set_ipv4addr_check lhost ${LINK_NUM} ${IPV4_LNETWORK} ${LHOST_IPV4_HOST}
+	lhost_ipv4addr="${IPV4_LNETWORK}.${LHOST_IPV4_HOST}"
 
 	lhost_ifname=$(tst_iface lhost $LINK_NUM)
 	rhost_ifname=$(tst_iface rhost $LINK_NUM)
diff --git a/testcases/network/stress/route/route4-lib.sh b/testcases/network/stress/route/route4-lib.sh
index e1823b8f1..977cb506c 100644
--- a/testcases/network/stress/route/route4-lib.sh
+++ b/testcases/network/stress/route/route4-lib.sh
@@ -27,13 +27,13 @@ export TCID="`basename $0`"
 . test_stress_net.sh
 
 # The first 2 ocnted of the Network portion of the gateway address
-# FIXME: calculate it from IPV4_NETWORK variable as test expects IPV4_NETWORK
+# FIXME: calculate it from IPV4_RNETWORK variable as test expects IPV4_RNETWORK
 # to be 10.0.0 and prefix 24.
-IPV4_NETWORK_PRE=${IPV4_NETWORK_PRE:-"10.0"}
+IPV4_RNETWORK_PRE=${IPV4_RNETWORK_PRE:-"10.0"}
 
 # The destination network
-# FIXME: generate DST_NETWORK_PREFIX randomly based on IPV4_NETWORK variable as
-# test expects IPV4_NETWORK to be 10.0.0 and prefix 24.
+# FIXME: generate DST_NETWORK_PREFIX randomly based on IPV4_RNETWORK variable as
+# test expects IPV4_LNETWORK and IPV4_RNETWORK to be 10.0.0 and prefix 24.
 DST_NETWORK_PREFIX="10.10" # 10.10.n.0/24
 DST_NETWORK="${DST_NETWORK_PREFIX}.0" # 10.10.0.0/24
 DST_HOST=5
@@ -177,14 +177,14 @@ do_test_common()
 		done
 		link_num=0
 		lhost_ifname="`get_lhost_ifname_loop $link_num`"
-		gateway="${IPV4_NETWORK_PRE}.${link_num}.${RHOST_IPV4_HOST}"
+		gateway="${IPV4_RNETWORK_PRE}.${link_num}.${RHOST_IPV4_HOST}"
 	else
 		tst_resm TINFO "preparing connectivity"
 		if [ "$test_field" = "gw" ]; then
 			rhost_part=$rhost_part_first
-			gateway="${IPV4_NETWORK}.${rhost_part}"
+			gateway="${IPV4_RNETWORK}.${rhost_part}"
 		fi
-		prepare_connectivity $lhost_ifname $link_num $IPV4_NETWORK $LHOST_IPV4_HOST $gateway
+		prepare_connectivity $lhost_ifname $link_num $IPV4_LNETWORK $LHOST_IPV4_HOST $gateway
 	fi
 
 	if [ "$test_field" != "dst" ]; then
@@ -215,14 +215,14 @@ do_test_common()
 			link_num=$(($link_num + 1))
 			[ $link_num -ge $link_total ] && link_num=0
 			lhost_ifname="$(get_lhost_ifname_loop $link_num)"
-			gateway="${IPV4_NETWORK_PRE}.${link_num}.${RHOST_IPV4_HOST}"
+			gateway="${IPV4_RNETWORK_PRE}.${link_num}.${RHOST_IPV4_HOST}"
 			task="change"
 		elif [ "$test_field" = "gw" ]; then
 			pre_rhost_part=$rhost_part
 			rhost_part=$(($rhost_part + 1))
 			[ $rhost_part -gt $rhost_part_last ] && rhost_part=$rhost_part_first
-			gateway="${IPV4_NETWORK}.${rhost_part}"
-			gateway2="${IPV4_NETWORK}.${pre_rhost_part}"
+			gateway="${IPV4_RNETWORK}.${rhost_part}"
+			gateway2="${IPV4_RNETWORK}.${pre_rhost_part}"
 			task="change"
 		fi
 
diff --git a/testcases/network/stress/route/route4-redirect b/testcases/network/stress/route/route4-redirect
index 718c96b33..a0d0e3aa2 100644
--- a/testcases/network/stress/route/route4-redirect
+++ b/testcases/network/stress/route/route4-redirect
@@ -43,10 +43,10 @@ do_setup()
 	sleep 3
 	tst_rhost_run -s -c "ip addr flush dev $rhost_ifname"
 
-	set_ipv4addr_check lhost $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST
+	set_ipv4addr_check lhost $LINK_NUM $IPV4_LNETWORK $LHOST_IPV4_HOST
 
 	tst_resm TINFO "add route to the initial gateway"
-	manipulate_route "route" "add" ${DST_NETWORK}.0 $IPV4_NETMASK_NUM $IPV4_NETMASK ${IPV4_NETWORK}.${RHOST_IPV4_HOST} $lhost_ifname
+	manipulate_route "route" "add" ${DST_NETWORK}.0 $IPV4_NETMASK_NUM $IPV4_NETMASK ${IPV4_LNETWORK}.${RHOST_IPV4_HOST} $lhost_ifname
 	if [ $? -ne 0 ]; then
 		tst_brkm TBROK "failed to add the gateway to $gateway"
 		return
diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
index 45ab0dd67..13d91ae85 100644
--- a/testcases/network/stress/route/route4-rmmod
+++ b/testcases/network/stress/route/route4-rmmod
@@ -38,9 +38,9 @@ do_setup()
 	tst_check_cmds ethtool
 	do_cleanup
 
-	set_lhost_rhost_ipv4addr $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST $RHOST_IPV4_HOST
-	lhost_ipv4addr="${IPV4_NETWORK}.${LHOST_IPV4_HOST}"
-	rhost_ipv4addr="${IPV4_NETWORK}.${RHOST_IPV4_HOST}"
+	set_lhost_rhost_ipv4addr $LINK_NUM $IPV4_LNETWORK $IPV4_RNETWORK $LHOST_IPV4_HOST $RHOST_IPV4_HOST
+	lhost_ipv4addr="${IPV4_LNETWORK}.${LHOST_IPV4_HOST}"
+	rhost_ipv4addr="${IPV4_RNETWORK}.${RHOST_IPV4_HOST}"
 	lhost_ifname=$(tst_iface lhost $LINK_NUM)
 	rhost_ifname=$(tst_iface rhost $LINK_NUM)
 
@@ -100,7 +100,7 @@ test_body()
 		# if we use netns we need to reset it as unloading driver breaks it
 		reset_ltp_netspace
 
-		set_ipv4addr_check lhost $LINK_NUM $IPV4_NETWORK $LHOST_IPV4_HOST
+		set_ipv4addr_check lhost $LINK_NUM $IPV4_LNETWORK $LHOST_IPV4_HOST
 
 		cnt=$(($cnt + 1))
 	done
-- 
2.12.2

