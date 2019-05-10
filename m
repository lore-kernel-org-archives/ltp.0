From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 May 2019 20:31:30 +0200
Subject: [LTP] [RFC PATCH v2 4/6] tst_net.sh: Minor code and doc cleanup
In-Reply-To: <20190510183132.31039-1-pvorel@suse.cz>
References: <20190510183132.31039-1-pvorel@suse.cz>
Message-ID: <20190510183132.31039-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* making OPTIND local instead of setting it 0 before and after test
* remove '=' during variable initialization to empty value
* declare variables with local on single line (there some issues with
  dash when initialize more variables with default values on single local,
  but simple declaration is perfectly safe
* doc: remove dots

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
cleanup of tst_net.sh (new commit, this can be dropped).

 testcases/lib/tst_net.sh | 109 ++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 65 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index fb8c49459..8dbd17eb2 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -107,7 +107,7 @@ init_ltp_netspace()
 	tst_test_cmds ip
 	tst_require_root_
 
-	local pid=
+	local pid
 
 	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
 		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
@@ -134,7 +134,7 @@ init_ltp_netspace()
 	tst_restore_ipaddr rhost
 }
 
-# Run command on remote host.
+# Run command on remote host
 # Options:
 # -b run in background
 # -B run in background and save output to $TST_TMPDIR/bg.cmd
@@ -143,16 +143,12 @@ init_ltp_netspace()
 # RETURN: 0 on success, 1 on failure
 tst_rhost_run()
 {
-	local pre_cmd=
 	local post_cmd=' || echo RTERR'
-	local out=
 	local user="root"
-	local cmd=
-	local safe=0
-	local bg=
-
-	OPTIND=0
+	local ret=0
+	local bg cmd out output pre_cmd safe
 
+	local OPTIND
 	while getopts :bBsc:u: opt; do
 		case "$opt" in
 		b|B) [ "$TST_USE_NETNS" ] && pre_cmd= || pre_cmd="nohup"
@@ -167,17 +163,13 @@ tst_rhost_run()
 		esac
 	done
 
-	OPTIND=0
-
 	if [ -z "$cmd" ]; then
-		[ "$safe" -eq 1 ] && \
+		[ "$safe" = 1 ] && \
 			tst_brk_ TBROK "tst_rhost_run: command not defined"
 		tst_res_ TWARN "tst_rhost_run: command not defined"
 		return 1
 	fi
 
-	local output=
-	local ret=0
 	if [ -n "${TST_USE_SSH:-}" ]; then
 		output=`ssh -n -q $user@$RHOST "sh -c \
 			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
@@ -191,7 +183,7 @@ tst_rhost_run()
 	echo "$output" | grep -q 'RTERR$' && ret=1
 	if [ $ret -eq 1 ]; then
 		output=$(echo "$output" | sed 's/RTERR//')
-		[ "$safe" -eq 1 ] && \
+		[ "$safe" = 1 ] && \
 			tst_brk_ TBROK "'$cmd' failed on '$RHOST': '$output'"
 	fi
 
@@ -200,8 +192,8 @@ tst_rhost_run()
 	return $ret
 }
 
-# Run command on both lhost and rhost.
-# tst_net_run [-s] [-l LPARAM] [-r RPARAM] [ -q ] CMD [ARG [ARG2]]
+# Run command on both lhost and rhost
+# tst_net_run [-s] [-l LPARAM] [-r RPARAM] [-q] CMD [ARG [ARG2]]
 # Options:
 # -l LPARAM: parameter passed to CMD in lhost
 # -r RPARAM: parameter passed to CMD in rhost
@@ -211,14 +203,7 @@ tst_rhost_run()
 # RETURN: 0 on success, 1 on missing CMD or exit code on lhost or rhost
 tst_net_run()
 {
-	local cmd
-	local lparams
-	local rparams
-	local lsafe
-	local rsafe
-	local lret
-	local rret
-	local quiet
+	local cmd lparams lret lsafe quiet rparams rret rsafe
 
 	local OPTIND
 	while getopts l:qr:s opt; do
@@ -275,9 +260,9 @@ EXPECT_RHOST_FAIL()
 	fi
 }
 
-# Get test interface names for local/remote host.
+# Get test interface names for local/remote host
 # tst_get_ifaces [TYPE]
-# TYPE: { lhost | rhost }; Default value is 'lhost'.
+# TYPE: { lhost | rhost }, default value is 'lhost'
 tst_get_ifaces()
 {
 	local type="${1:-lhost}"
@@ -288,14 +273,13 @@ tst_get_ifaces()
 	fi
 }
 
-# Get HW addresses from defined test interface names.
+# Get HW addresses from defined test interface names
 # tst_get_hwaddrs [TYPE]
-# TYPE: { lhost | rhost }; Default value is 'lhost'.
+# TYPE: { lhost | rhost }, default value is 'lhost'
 tst_get_hwaddrs()
 {
 	local type="${1:-lhost}"
-	local addr=
-	local list=
+	local addr list
 
 	for eth in $(tst_get_ifaces $type); do
 
@@ -311,26 +295,26 @@ tst_get_hwaddrs()
 	echo "$list"
 }
 
-# Get test HW address.
+# Get test HW address
 # tst_hwaddr [TYPE] [LINK]
-# TYPE: { lhost | rhost }; Default value is 'lhost'.
-# LINK: link number starting from 0. Default value is '0'.
+# TYPE: { lhost | rhost }, default value is 'lhost'
+# LINK: link number starting from 0. Default value is '0'
 tst_hwaddr()
 {
 	tst_test_cmds awk
 
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
-	local hwaddrs=
+	local hwaddrs
 	link_num=$(( $link_num + 1 ))
 	[ "$type" = "lhost" ] && hwaddrs=$LHOST_HWADDRS || hwaddrs=$RHOST_HWADDRS
 	echo "$hwaddrs" | awk '{ print $'"$link_num"' }'
 }
 
-# Get test interface name.
+# Get test interface name
 # tst_iface [TYPE] [LINK]
-# TYPE: { lhost | rhost }; Default value is 'lhost'.
-# LINK: link number starting from 0. Default value is '0'.
+# TYPE: { lhost | rhost }, default value is 'lhost'
+# LINK: link number starting from 0, default value is '0'
 tst_iface()
 {
 	tst_test_cmds awk
@@ -343,7 +327,7 @@ tst_iface()
 
 # Get IP address
 # tst_ipaddr [TYPE]
-# TYPE: { lhost | rhost }; Default value is 'lhost'.
+# TYPE: { lhost | rhost }, default value is 'lhost'
 tst_ipaddr()
 {
 	local type="${1:-lhost}"
@@ -355,13 +339,13 @@ tst_ipaddr()
 }
 
 # Get IP address of unused network, specified either by type and counter
-# or by net and host.
+# or by net and host
 # tst_ipaddr_un [-cCOUNTER] [TYPE]
 # tst_ipaddr_un NET_ID [HOST_ID]
-# TYPE: { lhost | rhost }; Default value is 'lhost'.
-# COUNTER: Integer value for counting HOST_ID and NET_ID. Default is 1.
+# TYPE: { lhost | rhost }, default value is 'lhost'
+# COUNTER: Integer value for counting HOST_ID and NET_ID, default is 1
 # NET_ID: Integer or hex value of net. For IPv4 is 3rd octet, for IPv6
-# is 3rd hextet.
+# is 3rd hextet
 # HOST_ID: Integer or hex value of host. For IPv4 is 4th octet, for
 # IPv6 is the last hextet. Default value is 0.
 tst_ipaddr_un()
@@ -419,8 +403,8 @@ tst_ipaddr_un()
 }
 
 # tst_init_iface [TYPE] [LINK]
-# TYPE: { lhost | rhost }; Default value is 'lhost'.
-# LINK: link number starting from 0. Default value is '0'.
+# TYPE: { lhost | rhost }, default value is 'lhost'
+# LINK: link number starting from 0, default value is '0'
 tst_init_iface()
 {
 	local type="${1:-lhost}"
@@ -453,6 +437,7 @@ tst_init_iface()
 # -a IP: IP address to be added, default value is
 #   $(tst_ipaddr)/$IPV{4,6}_{L,R}PREFIX
 # -s safe option, if something goes wrong, will exit with TBROK
+# RETURN: 0 on success, 1 on failure
 tst_add_ipaddr()
 {
 	local addr dad lsafe mask rsafe
@@ -492,8 +477,8 @@ tst_add_ipaddr()
 
 # tst_restore_ipaddr [TYPE] [LINK]
 # Restore default ip addresses defined in network.sh
-# TYPE: { lhost | rhost }; Default value is 'lhost'.
-# LINK: link number starting from 0. Default value is '0'.
+# TYPE: { lhost | rhost }, default value is 'lhost'
+# LINK: link number starting from 0, default value is '0'
 tst_restore_ipaddr()
 {
 	tst_test_cmds ip
@@ -517,10 +502,9 @@ tst_restore_ipaddr()
 # wait for IPv6 DAD completion
 tst_wait_ipv6_dad()
 {
-	local ret=
-	local i=
 	local iface_loc=${1:-$(tst_iface)}
 	local iface_rmt=${2:-$(tst_iface rhost)}
+	local i ret
 
 	for i in $(seq 1 50); do
 		ip a sh $iface_loc | grep -q tentative
@@ -549,24 +533,24 @@ tst_netload()
 	local expect_res="pass"
 	local ret=0
 	local type="tcp"
-	local hostopt=
-	local setup_srchost=0
+	local hostopt
+	local setup_srchost
 	# common options for client and server
-	local cs_opts=
+	local cs_opts
 
 	local c_num="$TST_NETLOAD_CLN_NUMBER"
 	local c_requests="$TST_NETLOAD_CLN_REQUESTS"
-	local c_opts=
+	local c_opts
 
 	# number of server replies after which TCP connection is closed
 	local s_replies="${TST_NETLOAD_MAX_SRV_REPLIES:-500000}"
-	local s_opts=
+	local s_opts
 
 	if [ ! "$TST_NEEDS_TMPDIR" = 1 ]; then
 		tst_brk_ TBROK "Using tst_netload requires setting TST_NEEDS_TMPDIR=1"
 	fi
 
-	OPTIND=0
+	local OPTIND
 	while getopts :a:H:d:n:N:r:R:S:b:t:T:fFe:m:A:D: opt; do
 		case "$opt" in
 		a) c_num="$OPTARG" ;;
@@ -592,7 +576,6 @@ tst_netload()
 		*) tst_brk_ TBROK "tst_netload: unknown option: $OPTARG" ;;
 		esac
 	done
-	OPTIND=0
 
 	[ "$setup_srchost" = 1 ] && s_opts="${s_opts}-S $hostopt "
 
@@ -690,11 +673,10 @@ tst_icmp()
 {
 	local timeout=1
 	local msg_sizes=56
-	local opts=
-	local num=
 	local ret=0
+	local num opts
 
-	OPTIND=0
+	local OPTIND
 	while getopts :t:s: opt; do
 		case "$opt" in
 		t) timeout="$OPTARG" ;;
@@ -702,7 +684,6 @@ tst_icmp()
 		*) opts="-$OPTARG $opts" ;;
 		esac
 	done
-	OPTIND=0
 
 	local num=$(echo "$msg_sizes" | wc -w)
 	timeout="$(($timeout / $num))"
@@ -725,15 +706,13 @@ tst_icmp()
 }
 
 # tst_set_sysctl NAME VALUE [safe]
-# It can handle netns case when sysctl not namespaceified.
+# It can handle netns case when sysctl not namespaceified
 tst_set_sysctl()
 {
 	local name="$1"
 	local value="$2"
-	local safe=
+	local rparam safe
 	[ "$3" = "safe" ] && safe="-s"
-
-	local rparam=
 	[ "$TST_USE_NETNS" = "yes" ] && rparam="-r '-e'"
 
 	tst_net_run $safe $rparam "sysctl -q -w $name=$value"
@@ -755,7 +734,7 @@ tst_default_max_pkt()
 [ -z "$RHOST" ] && TST_USE_NETNS="yes"
 export RHOST="$RHOST"
 export PASSWD="${PASSWD:-}"
-# Don't use it in new tests, use tst_rhost_run() from tst_net.sh instead.
+# Don't use it in new tests, use tst_rhost_run() from tst_net.sh instead
 export LTP_RSH="${LTP_RSH:-rsh -n}"
 
 # Test Links
-- 
2.21.0

