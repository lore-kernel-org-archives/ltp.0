From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Jun 2018 17:10:46 +0200
Subject: [LTP] [PATCH v2 7/8] net/{stress, virt}: Migrate virt_lib.sh,
	ipsec_lib.sh + tests using them
In-Reply-To: <20180622151047.13002-1-pvorel@suse.cz>
References: <20180622151047.13002-1-pvorel@suse.cz>
Message-ID: <20180622151047.13002-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It was needed to migrate it all in once, as macsec0{1,2}.sh tests are
using both libraries.

This includes:
* Create setup, getopts and helper function for both libraries.
* Using TST_TEST_DATA and TST_TEST_DATA_IFS in many test cases
(simplify tests and allow to have more TST_CNT to keep readability of
output + required by udp_ipsec.sh and udp_ipsec_vti.sh otherwise it'd
need to use getopts to determine type of udp, as passing parameter to
tst_run is not not recommended to new API).
* Put code into TST_TESTFUNC functions.
* Move anything based on TST_IPV6 to TST_SETUP setup functions (as
TST_IPV6 is not set until setup)

Other changes:
* udp_ipsec{,_vti}.sh: were calling do_test() twice, with parameter.
Now they use correctly TST_CNT and no params.
Order of running tests changed. Before first were run udp tests for all
items in $IPSEC_SIZE_ARRAY, then all udp_lite tests. Now for each item
in $IPSEC_SIZE_ARRAY both udp and udp_lite tests are run.
* gre01.sh: Move back device type setting (changed in 57738337a
"network/gre01: fix device type setting").

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/dccp/dccp_ipsec.sh   |  19 +-
 .../network/stress/dccp/dccp_ipsec_vti.sh     |  19 +-
 .../network/stress/icmp/icmp-uni-basic.sh     |  26 +--
 testcases/network/stress/icmp/icmp-uni-vti.sh |  24 +--
 testcases/network/stress/ipsec/ipsec_lib.sh   | 159 ++++++++---------
 testcases/network/stress/sctp/sctp_ipsec.sh   |  20 +--
 .../network/stress/sctp/sctp_ipsec_vti.sh     |  20 +--
 testcases/network/stress/tcp/tcp_ipsec.sh     |  22 +--
 testcases/network/stress/tcp/tcp_ipsec_vti.sh |  21 +--
 testcases/network/stress/udp/udp_ipsec.sh     |  24 ++-
 testcases/network/stress/udp/udp_ipsec_vti.sh |  24 ++-
 testcases/network/virt/geneve01.sh            |  42 ++---
 testcases/network/virt/gre01.sh               |  31 ++--
 testcases/network/virt/ipvlan01.sh            |  14 +-
 testcases/network/virt/macsec01.sh            |  36 ++--
 testcases/network/virt/macsec02.sh            |  38 ++--
 testcases/network/virt/macvlan01.sh           |  14 +-
 testcases/network/virt/macvtap01.sh           |  14 +-
 testcases/network/virt/virt_lib.sh            | 167 +++++++-----------
 testcases/network/virt/vlan01.sh              |  19 +-
 testcases/network/virt/vlan02.sh              |  12 +-
 testcases/network/virt/vlan03.sh              |  50 +++---
 testcases/network/virt/vxlan01.sh             |  15 +-
 testcases/network/virt/vxlan02.sh             |  16 +-
 testcases/network/virt/vxlan03.sh             |  38 ++--
 25 files changed, 404 insertions(+), 480 deletions(-)

diff --git a/testcases/network/stress/dccp/dccp_ipsec.sh b/testcases/network/stress/dccp/dccp_ipsec.sh
index d1afd4569..ef80bf979 100755
--- a/testcases/network/stress/dccp/dccp_ipsec.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec.sh
@@ -1,25 +1,18 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=dccp_ipsec
-TST_TOTAL=3
 TST_NEEDS_TMPDIR=1
-TST_CLEANUP="tst_ipsec_cleanup"
-
+TST_TESTFUNC=do_test
+TST_SETUP=tst_ipsec_setup
+TST_CLEANUP=tst_ipsec_cleanup
 . ipsec_lib.sh
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $(tst_ipaddr rhost) -T dccp -n $p -N $p \
-			-r $IPSEC_REQUESTS
-	done
+	tst_netload -H $(tst_ipaddr rhost) -T dccp -n $2 -N $2 -r $IPSEC_REQUESTS
 }
 
-tst_ipsec_setup
-
-do_test
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/dccp/dccp_ipsec_vti.sh b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
index f5ff1029d..ee2b0d4ca 100755
--- a/testcases/network/stress/dccp/dccp_ipsec_vti.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
@@ -1,25 +1,18 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=dccp_ipsec_vti
-TST_TOTAL=3
 TST_NEEDS_TMPDIR=1
-TST_CLEANUP="tst_ipsec_cleanup"
-
+TST_TESTFUNC=do_test
+TST_SETUP=tst_ipsec_setup_vti
+TST_CLEANUP=tst_ipsec_cleanup
 . ipsec_lib.sh
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $ip_rmt_tun -T dccp -n $p -N $p \
-			-r $IPSEC_REQUESTS
-	done
+	tst_netload -H $ip_rmt_tun -T dccp -n $2 -N $2 -r $IPSEC_REQUESTS
 }
 
-tst_ipsec_setup_vti
-
-do_test
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index b168a821c..5980b81e5 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -1,21 +1,25 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Hangbin Liu <haliu@redhat.com>
 
-TCID=${TCID:-icmp-uni-basic}
-TST_TOTAL=1
-TST_COUNT=1
-TST_CLEANUP="tst_ipsec_cleanup"
-
+TST_TESTFUNC=do_test
+TST_SETUP=do_setup
+TST_CLEANUP=tst_ipsec_cleanup
 . ipsec_lib.sh
 
-tst_ipsec_setup
-
-PING_MAX="$IPSEC_REQUESTS"
+do_setup()
+{
+	tst_ipsec_setup
+	PING_MAX="$IPSEC_REQUESTS"
+	tst_res TINFO "Sending ICMP messages"
+}
 
-tst_resm TINFO "Sending ICMP messages"
-tst_ping $(tst_iface) $(tst_ipaddr rhost) $IPSEC_SIZE_ARRAY
+do_test()
+{
+	tst_ping $(tst_iface) $(tst_ipaddr rhost) $2
+}
 
-tst_exit
+tst_run
diff --git a/testcases/network/stress/icmp/icmp-uni-vti.sh b/testcases/network/stress/icmp/icmp-uni-vti.sh
index 9a7fba59f..24eca177c 100755
--- a/testcases/network/stress/icmp/icmp-uni-vti.sh
+++ b/testcases/network/stress/icmp/icmp-uni-vti.sh
@@ -1,24 +1,24 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=icmp-uni-vti
-TST_TOTAL=1
-TST_CLEANUP="tst_ipsec_cleanup"
-
+TST_TESTFUNC=do_test
+TST_SETUP=do_setup
+TST_CLEANUP=tst_ipsec_cleanup
 . ipsec_lib.sh
 
-do_test()
+do_setup()
 {
+	tst_ipsec_setup_vti
 	PING_MAX="$IPSEC_REQUESTS"
-
-	tst_resm TINFO "Sending ICMP messages"
-	tst_ping $tst_vti $ip_rmt_tun $IPSEC_SIZE_ARRAY
+	tst_res TINFO "Sending ICMP messages"
 }
 
-tst_ipsec_setup_vti
-
-do_test
+do_test()
+{
+	tst_ping $tst_vti $ip_rmt_tun $2
+}
 
-tst_exit
+tst_run
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index e851d46e4..aedba9b7c 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -15,54 +15,78 @@ AALGO="sha1"
 CALGO="deflate"
 
 IPSEC_REQUESTS="500"
-IPSEC_SIZE_ARRAY="${IPSEC_SIZE_ARRAY:-10:100:1000:2000:10000:65000}"
+
+ipsec_lib_usage()
+{
+	echo "l n     n is the number of test link when tests run"
+	echo "m x     x is ipsec mode, could be transport / tunnel"
+	echo "p x     x is ipsec protocol, could be ah / esp / comp"
+	echo "s x     x is icmp message size array"
+	echo "S n     n is IPsec SPI value"
+	echo "k x     key for vti interface"
+	echo "A x     Authenticated encryption with associated data algorithm"
+	echo "e x     Encryption algorithm"
+	echo "a x     Authentication algorithm"
+	echo "c x     Compression algorithm"
+	echo "r x     Num of requests, PING_MAX or netstress' '-r' opt"
+}
 
 ipsec_lib_parse_args()
 {
 	case "$1" in
-	h)
-		echo "Usage:"
-		echo "h        help"
-		echo "l n      n is the number of test link when tests run"
-		echo "m x      x is ipsec mode, could be transport / tunnel"
-		echo "p x      x is ipsec protocol, could be ah / esp / comp"
-		echo "s x      x is icmp message size array (items separated by ':')"
-		echo "S n      n is IPsec SPI value"
-		echo "k x      key for vti interface"
-		echo "A x      Authenticated encryption with associated data algorithm"
-		echo "e x      Encryption algorithm"
-		echo "a x      Authentication algorithm"
-		echo "c x      Compression algorithm"
-		echo "r x      Num of requests, PING_MAX or netstress' '-r' opt"
-		echo "6        run over IPv6"
-		exit 0
-	;;
-	l) LINK_NUM=$2 ;;
-	m) IPSEC_MODE=$2 ;;
-	p) IPSEC_PROTO=$2 ;;
-	s) IPSEC_SIZE_ARRAY="$2" ;;
-	S) SPI=$2 ;;
-	k) VTI_KEY=$2 ;;
-	A) AEALGO=$2 ;;
-	e) EALGO=$2 ;;
-	a) AALGO=$2 ;;
-	c) CALGO=$2 ;;
-	r) IPSEC_REQUESTS="$2" ;;
-	*) tst_brkm TBROK "unknown option: $1" ;;
+	l) LINK_NUM=$2;;
+	m) IPSEC_MODE=$2;;
+	p) IPSEC_PROTO=$2;;
+	s) TST_TEST_DATA="$2"; TST_TEST_DATA_IFS=":";;
+	S) SPI=$2;;
+	k) VTI_KEY=$2;;
+	A) AEALGO=$2;;
+	e) EALGO=$2;;
+	a) AALGO=$2;;
+	c) CALGO=$2;;
+	r) IPSEC_REQUESTS="$2";;
+	esac
+}
+
+ipsec_lib_setup()
+{
+	case $AEALGO in
+	rfc4106_128|rfc4543_128) AEALGO_KEY=$(get_key 160);;
+	rfc4106_192|rfc4543_192) AEALGO_KEY=$(get_key 224);;
+	rfc4106_256|rfc4543_256) AEALGO_KEY=$(get_key 288);;
+	rfc4309_128) AEALGO_KEY=$(get_key 152);;
+	rfc4309_192) AEALGO_KEY=$(get_key 216);;
+	rfc4309_256) AEALGO_KEY=$(get_key 280);;
 	esac
 
-	local IFS=":"
-	local tmp="$IPSEC_SIZE_ARRAY"
-	local p
-	for p in $IPSEC_SIZE_ARRAY; do
-		tmp="$p "
-	done
-	IPSEC_SIZE_ARRAY="$tmp"
+	case $EALGO in
+	des) EALGO_KEY=$(get_key 64);;
+	des3_ede) EALGO_KEY=$(get_key 192);;
+	cast5) EALGO_KEY=$(get_key 128);;
+	blowfish) EALGO_KEY=$(get_key 448);;
+	aes|twofish|camellia|serpent) EALGO_KEY=$(get_key 256);;
+	*) tst_brk TBROK "unknown enc alg: $EALGO";;
+	esac
+
+	case $AALGO in
+	sha1|rmd160) AALGO_KEY=$(get_key 160);;
+	sha256) AALGO_KEY=$(get_key 256);;
+	sha384) AALGO_KEY=$(get_key 384);;
+	sha512) AALGO_KEY=$(get_key 512);;
+	*) tst_brk TBROK "unknown auth alg: $AALGO";;
+	esac
+
+	SPI=${SPI:-1000}
+	VTI_KEY=${VTI_KEY:-10}
+	cleanup_vti=
+	ALG=
+	ALGR=
 }
 
-TST_OPTS="hl:m:p:s:S:k:A:e:a:c:r:"
+TST_OPTS="l:m:p:s:S:k:A:e:a:c:r:"
 TST_PARSE_ARGS=ipsec_lib_parse_args
-TST_USE_LEGACY_API=1
+TST_SETUP=${TST_SETUP:-ipsec_lib_setup}
+TST_USAGE=ipsec_lib_usage
 . tst_net.sh
 
 get_key()
@@ -72,43 +96,12 @@ get_key()
 	echo "0x$(hexdump -vn $bytes -e '1/1 "%02x"' /dev/urandom)"
 }
 
-case $AEALGO in
-rfc4106_128|rfc4543_128) AEALGO_KEY=$(get_key 160) ;;
-rfc4106_192|rfc4543_192) AEALGO_KEY=$(get_key 224) ;;
-rfc4106_256|rfc4543_256) AEALGO_KEY=$(get_key 288) ;;
-rfc4309_128) AEALGO_KEY=$(get_key 152) ;;
-rfc4309_192) AEALGO_KEY=$(get_key 216) ;;
-rfc4309_256) AEALGO_KEY=$(get_key 280) ;;
-esac
-
-case $EALGO in
-des) EALGO_KEY=$(get_key 64) ;;
-des3_ede) EALGO_KEY=$(get_key 192) ;;
-cast5) EALGO_KEY=$(get_key 128) ;;
-blowfish) EALGO_KEY=$(get_key 448) ;;
-aes|twofish|camellia|serpent) EALGO_KEY=$(get_key 256) ;;
-*) tst_brkm TBROK "unknown enc alg: $EALGO" ;;
-esac
-
-case $AALGO in
-sha1|rmd160) AALGO_KEY=$(get_key 160) ;;
-sha256) AALGO_KEY=$(get_key 256) ;;
-sha384) AALGO_KEY=$(get_key 384) ;;
-sha512) AALGO_KEY=$(get_key 512) ;;
-*) tst_brkm TBROK "unknown auth alg: $AALGO" ;;
-esac
-
-SPI=${SPI:-1000}
-VTI_KEY=${VTI_KEY:-10}
-cleanup_vti=
-ALG=
-ALGR=
-
 tst_ipsec_setup()
 {
+	ipsec_lib_setup
 	# Configure SAD/SPD
 	if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
-		tst_resm TINFO "IPsec[$IPSEC_PROTO/$IPSEC_MODE]"
+		tst_res TINFO "IPsec[$IPSEC_PROTO/$IPSEC_MODE]"
 		tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
 		tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
 	fi
@@ -125,8 +118,6 @@ tst_ipsec_cleanup()
 		ip li del $cleanup_vti 2>/dev/null
 		tst_rhost_run -c "ip li del $cleanup_vti 2>/dev/null"
 	fi
-
-	[ "$TST_NEEDS_TMPDIR" = 1 ] && tst_rmdir
 }
 
 ipsec_set_algoline()
@@ -161,7 +152,7 @@ ipsec_set_algoline()
 		ALGR=$ALG
 		;;
 	*)
-		tst_brkm TCONF "tst_ipsec protocol mismatch"
+		tst_brk TCONF "tst_ipsec protocol mismatch"
 		;;
 	esac
 }
@@ -173,11 +164,11 @@ ipsec_try()
 	if echo "$output" | grep -q "TERR"; then
 		echo "$output" | grep -q \
 			'RTNETLINK answers: Function not implemented' && \
-			tst_brkm TCONF "'$@': not implemented"
+			tst_brk TCONF "'$@': not implemented"
 		echo "$output" | grep -q \
 			'RTNETLINK answers: Operation not supported' && \
-			tst_brkm TCONF "'$@': not supported (maybe missing 'ip${TST_IPV6}_vti' kernel module)"
-		tst_brkm TBROK "$@ failed: $output"
+			tst_brk TCONF "'$@': not supported (maybe missing 'ip${TST_IPV6}_vti' kernel module)"
+		tst_brk TBROK "$@ failed: $output"
 	fi
 }
 
@@ -189,7 +180,7 @@ ipsec_try()
 tst_ipsec()
 {
 	if [ $# -ne 3 ]; then
-		tst_brkm TCONF "tst_ipsec parameter mismatch"
+		tst_brk TCONF "tst_ipsec parameter mismatch"
 	fi
 
 	local target=$1
@@ -237,7 +228,7 @@ tst_ipsec()
 tst_ipsec_vti()
 {
 	if [ $# -ne 4 ]; then
-		tst_brkm TCONF "tst_ipsec_vti parameter mismatch"
+		tst_brk TCONF "tst_ipsec_vti parameter mismatch"
 	fi
 
 	local target=$1
@@ -255,7 +246,7 @@ tst_ipsec_vti()
 	local rd="dev $(tst_iface rhost)"
 
 	ip li add type vti help 2>&1 | grep -q vti || \
-		tst_brkm TCONF "iproute doesn't support 'vti'"
+		tst_brk TCONF "iproute doesn't support 'vti'"
 
 	ipsec_set_algoline
 
@@ -296,6 +287,8 @@ tst_ipsec_vti()
 #  * ip_rmt_tun - remote IP address
 tst_ipsec_setup_vti()
 {
+	ipsec_lib_setup
+
 	if_loc=$(tst_iface)
 	if_rmt=$(tst_iface rhost)
 
@@ -304,7 +297,7 @@ tst_ipsec_setup_vti()
 
 	tst_vti="ltp_vti0"
 
-	tst_resm TINFO "Test vti$TST_IPV6 + IPsec[$IPSEC_PROTO/$IPSEC_MODE]"
+	tst_res TINFO "Test vti$TST_IPV6 + IPsec[$IPSEC_PROTO/$IPSEC_MODE]"
 
 	tst_ipsec_vti lhost $ip_loc $ip_rmt $tst_vti
 	tst_ipsec_vti rhost $ip_rmt $ip_loc $tst_vti
@@ -322,7 +315,7 @@ tst_ipsec_setup_vti()
 		ROD ip route add ${IPV4_NET16_UNUSED}.1.0/$mask dev $tst_vti
 	fi
 
-	tst_resm TINFO "Add IPs to vti tunnel, " \
+	tst_res TINFO "Add IPs to vti tunnel, " \
 		       "loc: $ip_loc_tun/$mask, rmt: $ip_rmt_tun/$mask"
 
 	ROD ip a add $ip_loc_tun/$mask dev $tst_vti nodad
diff --git a/testcases/network/stress/sctp/sctp_ipsec.sh b/testcases/network/stress/sctp/sctp_ipsec.sh
index ee9018f01..8a7b885d9 100755
--- a/testcases/network/stress/sctp/sctp_ipsec.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec.sh
@@ -1,25 +1,19 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=sctp_ipsec
-TST_TOTAL=3
 TST_NEEDS_TMPDIR=1
-TST_CLEANUP="tst_ipsec_cleanup"
-
+TST_TESTFUNC=do_test
+TST_SETUP=tst_ipsec_setup
+TST_CLEANUP=tst_ipsec_cleanup
 . ipsec_lib.sh
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $(tst_ipaddr rhost) -T sctp -n $p -N $p \
-			-r $IPSEC_REQUESTS -S $(tst_ipaddr)
-	done
+	tst_netload -H $(tst_ipaddr rhost) -T sctp -n $2 -N $2 \
+		-r $IPSEC_REQUESTS -S $(tst_ipaddr)
 }
 
-tst_ipsec_setup
-
-do_test
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/sctp/sctp_ipsec_vti.sh b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
index ed851475a..d0f24c727 100755
--- a/testcases/network/stress/sctp/sctp_ipsec_vti.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
@@ -1,25 +1,19 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=sctp_ipsec_vti
-TST_TOTAL=3
 TST_NEEDS_TMPDIR=1
-TST_CLEANUP="tst_ipsec_cleanup"
-
+TST_SETUP=tst_ipsec_setup_vti
+TST_CLEANUP=tst_ipsec_cleanup
+TST_TESTFUNC=do_test
 . ipsec_lib.sh
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $ip_rmt_tun -T sctp -n $p -N $p \
-			-r $IPSEC_REQUESTS -S $ip_loc_tun
-	done
+	tst_netload -H $ip_rmt_tun -T sctp -n $2 -N $2 -r $IPSEC_REQUESTS \
+		-S $ip_loc_tun
 }
 
-tst_ipsec_setup_vti
-
-do_test
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/tcp/tcp_ipsec.sh b/testcases/network/stress/tcp/tcp_ipsec.sh
index 0f875948c..d62272db0 100755
--- a/testcases/network/stress/tcp/tcp_ipsec.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec.sh
@@ -1,27 +1,21 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=tcp_ipsec
-TST_TOTAL=3
 TST_NEEDS_TMPDIR=1
-TST_CLEANUP="tst_ipsec_cleanup"
+TST_TESTFUNC=do_test
+TST_SETUP=tst_ipsec_setup
+TST_CLEANUP=tst_ipsec_cleanup
+. ipsec_lib.sh
 
 max_requests=10
 
-. ipsec_lib.sh
-
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $(tst_ipaddr rhost) -n $p -N $p \
-			-r $IPSEC_REQUESTS -R $max_requests
-	done
+	tst_netload -H $(tst_ipaddr rhost) -n $2 -N $2 -r $IPSEC_REQUESTS \
+		-R $max_requests
 }
 
-tst_ipsec_setup
-
-do_test
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/tcp/tcp_ipsec_vti.sh b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
index 13a67d3bb..f7bbbc6e9 100755
--- a/testcases/network/stress/tcp/tcp_ipsec_vti.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
@@ -1,27 +1,20 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=tcp_ipsec_vti
-TST_TOTAL=3
 TST_NEEDS_TMPDIR=1
-TST_CLEANUP="tst_ipsec_cleanup"
+TST_TESTFUNC=do_test
+TST_SETUP=tst_ipsec_setup_vti
+TST_CLEANUP=tst_ipsec_cleanup
+. ipsec_lib.sh
 
 max_requests=10
 
-. ipsec_lib.sh
-
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $ip_rmt_tun -n $p -N $p \
-			-r $IPSEC_REQUESTS -R $max_requests
-	done
+	tst_netload -H $ip_rmt_tun -n $2 -N $2 -r $IPSEC_REQUESTS -R $max_requests
 }
 
-tst_ipsec_setup_vti
-
-do_test
-
-tst_exit
+tst_run
diff --git a/testcases/network/stress/udp/udp_ipsec.sh b/testcases/network/stress/udp/udp_ipsec.sh
index 9c46fc6c0..b59070ebe 100755
--- a/testcases/network/stress/udp/udp_ipsec.sh
+++ b/testcases/network/stress/udp/udp_ipsec.sh
@@ -1,26 +1,22 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=udp_ipsec
-TST_TOTAL=6
 TST_NEEDS_TMPDIR=1
-TST_CLEANUP="tst_ipsec_cleanup"
-
+TST_TESTFUNC=do_test
+TST_SETUP=tst_ipsec_setup
+TST_CNT=2
+TST_CLEANUP=tst_ipsec_cleanup
 . ipsec_lib.sh
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $(tst_ipaddr rhost) -T $1 -n $p -N $p \
-			-r $IPSEC_REQUESTS
-	done
-}
+	local type="udp"
+	[ $1 -eq 2 ] && type="udp_lite"
 
-tst_ipsec_setup
-
-do_test udp
-do_test udp_lite
+	tst_netload -H $(tst_ipaddr rhost) -T $type -n $2 -N $2 -r $IPSEC_REQUESTS
+}
 
-tst_exit
+tst_run
diff --git a/testcases/network/stress/udp/udp_ipsec_vti.sh b/testcases/network/stress/udp/udp_ipsec_vti.sh
index 1b138afb6..65b48eaa4 100755
--- a/testcases/network/stress/udp/udp_ipsec_vti.sh
+++ b/testcases/network/stress/udp/udp_ipsec_vti.sh
@@ -1,26 +1,22 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=udp_ipsec_vti
-TST_TOTAL=6
 TST_NEEDS_TMPDIR=1
-TST_CLEANUP="tst_ipsec_cleanup"
-
+TST_TESTFUNC=do_test
+TST_CNT=2
+TST_SETUP=tst_ipsec_setup_vti
+TST_CLEANUP=tst_ipsec_cleanup
 . ipsec_lib.sh
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $ip_rmt_tun -T $1 -n $p -N $p \
-			-r $IPSEC_REQUESTS
-	done
-}
+	local type="udp"
+	[ $1 -eq 2 ] && type="udp_lite"
 
-tst_ipsec_setup_vti
-
-do_test udp
-do_test udp_lite
+	tst_netload -H $ip_rmt_tun -T $type -n $2 -N $2 -r $IPSEC_REQUESTS
+}
 
-tst_exit
+tst_run
diff --git a/testcases/network/virt/geneve01.sh b/testcases/network/virt/geneve01.sh
index 91d03883d..8ddb97258 100755
--- a/testcases/network/virt/geneve01.sh
+++ b/testcases/network/virt/geneve01.sh
@@ -1,10 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2016-2017 Oracle and/or its affiliates.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=geneve01
-TST_TOTAL=1
 TST_NEEDS_TMPDIR=1
 TST_OPTS="hi:d:"
 TST_PARSE_ARGS=virt_lib_parse_args
@@ -16,26 +15,29 @@ start_id=16700000
 # that is why using here 'vxlan_*' library functions.
 vxlan_dst_addr="uni"
 
+TST_TESTFUNC=do_test
+TST_CLEANUP=virt_cleanup
 . virt_lib.sh
 
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
 [ "$VIRT_PERF_THRESHOLD" -lt 160 ] && VIRT_PERF_THRESHOLD=160
 
-TST_CLEANUP="virt_cleanup"
-
-if [ -z $ip_local -o -z $ip_remote ]; then
-	tst_brkm TBROK "you must specify IP address"
-fi
-
-tst_resm TINFO "the same VNI must work"
-# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
-vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE" "id 0xFFFFFE"
-virt_netperf_msg_sizes
-virt_cleanup_rmt
-
-tst_resm TINFO "different VNI shall not work together"
-vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE" "id 0xFFFFFD"
-virt_minimize_timeout
-virt_compare_netperf "fail"
-
-tst_exit
+do_test()
+{
+	if [ -z $ip_local -o -z $ip_remote ]; then
+		tst_brk TBROK "you must specify IP address"
+	fi
+
+	tst_res TINFO "the same VNI must work"
+	# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
+	vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE" "id 0xFFFFFE"
+	virt_netperf_msg_sizes
+	virt_cleanup_rmt
+
+	tst_res TINFO "different VNI shall not work together"
+	vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE" "id 0xFFFFFD"
+	virt_minimize_timeout
+	virt_compare_netperf "fail"
+}
+
+tst_run
diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index efb78a940..27373fd4a 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015-2017 Oracle and/or its affiliates.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
@@ -7,23 +8,25 @@
 # tunnel between two hosts, then will compare TCP performance
 # with and without GRE using ping or netstress test.
 
-TCID=gre01
-TST_TOTAL=1
 TST_NEEDS_TMPDIR=1
-
-virt_type="gre"
+TST_TESTFUNC=virt_netperf_msg_sizes
+TST_SETUP=do_setup
+TST_CLEANUP=virt_cleanup
 . virt_lib.sh
 
-TST_CLEANUP="virt_cleanup"
-
-if [ -z $ip_local -o -z $ip_remote ]; then
-	tst_brkm TBROK "you must specify IP address"
-fi
+do_setup()
+{
+	virt_type="gre"
+	[ "$TST_IPV6" ] && virt_type="ip6gre"
+	virt_lib_setup
 
-tst_resm TINFO "test $virt_type"
-virt_setup "local $(tst_ipaddr) remote $(tst_ipaddr rhost) dev $(tst_iface)" \
-"local $(tst_ipaddr rhost) remote $(tst_ipaddr) dev $(tst_iface rhost)"
+	if [ -z $ip_local -o -z $ip_remote ]; then
+		tst_brk TBROK "you must specify IP address"
+	fi
 
-virt_netperf_msg_sizes
+	tst_res TINFO "test $virt_type"
+	virt_setup "local $(tst_ipaddr) remote $(tst_ipaddr rhost) dev $(tst_iface)" \
+	"local $(tst_ipaddr rhost) remote $(tst_ipaddr) dev $(tst_iface rhost)"
+}
 
-tst_exit
+tst_run
diff --git a/testcases/network/virt/ipvlan01.sh b/testcases/network/virt/ipvlan01.sh
index 426b2cb6b..f0a546668 100755
--- a/testcases/network/virt/ipvlan01.sh
+++ b/testcases/network/virt/ipvlan01.sh
@@ -1,20 +1,16 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create and then delete ipvlan
 # interface multiple times.
 
-TCID=ipvlan01
-TST_TOTAL=2
-
 virt_type="ipvlan"
-
+TST_TEST_DATA="mode l2,mode l3"
+TST_TEST_DATA_IFS=","
+TST_TESTFUNC=virt_test_02
 . virt_lib.sh
 
-options="mode l2,mode l3"
-
-virt_test_02 "$options"
-
-tst_exit
+tst_run
diff --git a/testcases/network/virt/macsec01.sh b/testcases/network/virt/macsec01.sh
index cf038e7ca..725d469e7 100755
--- a/testcases/network/virt/macsec01.sh
+++ b/testcases/network/virt/macsec01.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
@@ -7,30 +8,33 @@
 # with default MACsec configuration, compare performance with similar
 # IPsec configuration on master interface.
 
-TCID=macsec01
-TST_TOTAL=16
-TST_NEEDS_TMPDIR=1
-
 virt_type="macsec"
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
+IPSEC_MODE="transport"
+IPSEC_PROTO="ah"
 
+TST_NEEDS_TMPDIR=1
+TST_TESTFUNC=virt_netperf_msg_sizes
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
 . ipsec_lib.sh
 . virt_lib.sh
 
-cleanup()
+do_setup()
+{
+	ipsec_lib_setup
+
+	tst_res TINFO "setup IPsec $IPSEC_MODE/$IPSEC_PROTO $EALGO"
+	tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
+	tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
+
+	virt_macsec_setup
+}
+
+do_cleanup()
 {
 	virt_cleanup
 	tst_ipsec_cleanup
 }
-TST_CLEANUP="cleanup"
-
-IPSEC_MODE=transport
-IPSEC_PROTO=ah
-tst_resm TINFO "setup IPsec $IPSEC_MODE/$IPSEC_PROTO $EALGO"
-tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
-tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
-
-virt_macsec_setup
-virt_netperf_msg_sizes
 
-tst_exit
+tst_run
diff --git a/testcases/network/virt/macsec02.sh b/testcases/network/virt/macsec02.sh
index 63c035e44..575b5c4e0 100755
--- a/testcases/network/virt/macsec02.sh
+++ b/testcases/network/virt/macsec02.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
@@ -7,31 +8,34 @@
 # with enabled frame encryption and replay protection, compare
 # performance with similar IPsec configuration on master interface.
 
-TCID=macsec02
-TST_TOTAL=16
-TST_NEEDS_TMPDIR=1
-
 virt_type="macsec"
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
+IPSEC_MODE="transport"
+IPSEC_PROTO="esp_aead"
+EALGO="aes"
 
+TST_NEEDS_TMPDIR=1
+TST_TESTFUNC=virt_netperf_msg_sizes
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
 . ipsec_lib.sh
 . virt_lib.sh
 
-cleanup()
+do_setup()
+{
+	ipsec_lib_setup
+
+	tst_res TINFO "setup IPsec $IPSEC_MODE/$IPSEC_PROTO $EALGO"
+	tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
+	tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
+
+	virt_macsec_setup "replay on window 300 encrypt on protect on"
+}
+
+do_cleanup()
 {
 	virt_cleanup
 	tst_ipsec_cleanup
 }
-TST_CLEANUP="cleanup"
-
-IPSEC_MODE=transport
-IPSEC_PROTO=esp_aead
-EALGO=aes
-tst_resm TINFO "setup IPsec $IPSEC_MODE/$IPSEC_PROTO $EALGO"
-tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
-tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
-
-virt_macsec_setup "replay on window 300 encrypt on protect on"
-virt_netperf_msg_sizes
 
-tst_exit
+tst_run
diff --git a/testcases/network/virt/macvlan01.sh b/testcases/network/virt/macvlan01.sh
index f37851f50..3c4fda50b 100755
--- a/testcases/network/virt/macvlan01.sh
+++ b/testcases/network/virt/macvlan01.sh
@@ -1,20 +1,16 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create and then delete macvlan
 # interface multiple times.
 
-TCID=macvlan01
-TST_TOTAL=4
-
 virt_type="macvlan"
-
+TST_TEST_DATA="mode private,mode vepa,mode bridge,mode passthru"
+TST_TEST_DATA_IFS=","
+TST_TESTFUNC=virt_test_02
 . virt_lib.sh
 
-options="mode private,mode vepa,mode bridge,mode passthru"
-
-virt_test_02 "$options"
-
-tst_exit
+tst_run
diff --git a/testcases/network/virt/macvtap01.sh b/testcases/network/virt/macvtap01.sh
index 21fd96777..93a3d34f7 100755
--- a/testcases/network/virt/macvtap01.sh
+++ b/testcases/network/virt/macvtap01.sh
@@ -1,20 +1,16 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create and then delete macvtap
 # interface multiple times.
 
-TCID=macvtap01
-TST_TOTAL=4
-
 virt_type="macvtap"
-
+TST_TEST_DATA="mode private,mode vepa,mode bridge,mode passthru"
+TST_TEST_DATA_IFS=","
+TST_TESTFUNC=virt_test_02
 . virt_lib.sh
 
-options="mode private,mode vepa,mode bridge,mode passthru"
-
-virt_test_02 "$options"
-
-tst_exit
+tst_run
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index f92c38fd2..9960b9553 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
@@ -15,30 +16,52 @@
 #          them in cleanup function. See "start_vni" variable which can
 #          solve it.
 
+TST_SETUP="${TST_SETUP:-virt_lib_setup}"
+TST_CLEANUP="${TST_CLEANUP:-cleanup_vifaces}"
+trap "tst_brk TBROK 'test interrupted'" INT
+
+virt_lib_usage()
+{
+	echo "i n     start ID to use"
+	echo "d x     VxLAN destination address, 'uni' or 'multi'"
+}
+
 virt_lib_parse_args()
 {
 	case "$1" in
-	h)
-		echo "Usage:"
-		echo "h        help"
-		echo "i n      start ID to use"
-		echo "d x      VxLAN destination address, 'uni' or 'multi'"
-		echo "6        run over IPv6"
-		exit 0
-	;;
 	i) start_id=$2 ;;
 	d) vxlan_dst_addr=$2 ;;
-	*)
-		tst_brkm TBROK "unknown option: $1"
+	esac
+}
+
+virt_lib_setup()
+{
+	case "$virt_type" in
+	vxlan|geneve)
+		if tst_kvcmp -lt "3.8"; then
+			tst_brk TCONF "test must be run with kernel 3.8 or newer"
+		fi
+
+		if [ "$TST_IPV6" ] && tst_kvcmp -lt "3.12"; then
+			tst_brk TCONF "test must be run with kernels >= 3.12"
+		fi
+
+		# newer versions of 'ip' complain if this option not set
+		ip li add type vxlan help 2>&1 | grep -q dstport && vxlan_dstport=1
 	;;
 	esac
+
+	tst_check_cmds "ip"
+
+	virt_add ltp_v0 || \
+		tst_brk TCONF "iproute2 or kernel doesn't support $virt_type"
+
+	ROD_SILENT "ip link delete ltp_v0"
 }
 
-TST_USE_LEGACY_API=1
+TST_NEEDS_ROOT=1
 . tst_net.sh
 
-[ -n "$TST_IPV6" -a "$virt_type" = "gre" ] && virt_type="ip6gre"
-
 ip_local=$(tst_ipaddr)
 ip_virt_local="$(TST_IPV6= tst_ipaddr_un)"
 ip6_virt_local="$(TST_IPV6=6 tst_ipaddr_un)"
@@ -53,7 +76,7 @@ vxlan_dstport=0
 
 cleanup_vifaces()
 {
-	tst_resm TINFO "cleanup virtual interfaces..."
+	tst_res TINFO "cleanup virtual interfaces..."
 	local viface=`ip li | sed -nE 's/^[0-9]+: (ltp_v[0-9]+)[@:].+/\1/p'`
 	for vx in $viface; do
 		ip link delete $vx
@@ -73,12 +96,8 @@ virt_cleanup_rmt()
 virt_cleanup()
 {
 	virt_cleanup_rmt
-	[ "$TST_NEEDS_TMPDIR" = 1 ] && tst_rmdir
 }
 
-TST_CLEANUP="cleanup_vifaces"
-trap "tst_brkm TBROK 'test interrupted'" INT
-
 virt_add()
 {
 	local vname=$1
@@ -137,12 +156,13 @@ virt_multiple_add_test()
 {
 	local opt="$@"
 	local max=$(($start_id + $NS_TIMES - 1))
+	local i
 
-	tst_resm TINFO "add $NS_TIMES $virt_type, then delete"
+	tst_res TINFO "add $NS_TIMES $virt_type, then delete"
 
 	for i in $(seq $start_id $max); do
 		virt_add ltp_v$i id $i $opt || \
-			tst_brkm TFAIL "failed to create 'ltp_v0 $opt'"
+			tst_brk TFAIL "failed to create 'ltp_v0 $opt'"
 		ROD_SILENT "ip link set ltp_v$i up"
 	done
 
@@ -151,23 +171,24 @@ virt_multiple_add_test()
 		ROD_SILENT "ip link delete ltp_v$i"
 	done
 
-	tst_resm TPASS "done"
+	tst_res TPASS "done"
 }
 
 virt_add_delete_test()
 {
 	local opt="$@"
 	local max=$(($NS_TIMES - 1))
+	local i
 
-	tst_resm TINFO "add/del $virt_type $NS_TIMES times"
+	tst_res TINFO "add/del $virt_type $NS_TIMES times"
 
 	for i in $(seq 0 $max); do
 		virt_add ltp_v0 $opt || \
-			tst_brkm TFAIL "failed to create 'ltp_v0 $opt'"
+			tst_brk TFAIL "failed to create 'ltp_v0 $opt'"
 		ROD_SILENT "ip link set ltp_v0 up"
 		ROD_SILENT "ip link delete ltp_v0"
 	done
-	tst_resm TPASS "done"
+	tst_res TPASS "done"
 }
 
 virt_setup()
@@ -175,11 +196,11 @@ virt_setup()
 	local opt="$1"
 	local opt_r="${2:-$1}"
 
-	tst_resm TINFO "setup local ${virt_type} with '$opt'"
+	tst_res TINFO "setup local ${virt_type} with '$opt'"
 	virt_add ltp_v0 $opt || \
-		tst_brkm TBROK "failed to create 'ltp_v0 $opt'"
+		tst_brk TBROK "failed to create 'ltp_v0 $opt'"
 
-	tst_resm TINFO "setup rhost ${virt_type} with '$opt_r'"
+	tst_res TINFO "setup rhost ${virt_type} with '$opt_r'"
 	virt_add_rhost "$opt_r"
 
 	ROD_SILENT "ip addr add ${ip6_virt_local}/64 dev ltp_v0 nodad"
@@ -212,11 +233,11 @@ virt_minimize_timeout()
 vxlan_setup_subnet_uni()
 {
 	if tst_kvcmp -lt "3.10"; then
-		tst_brkm TCONF "test must be run with kernel 3.10 or newer"
+		tst_brk TCONF "test must be run with kernel 3.10 or newer"
 	fi
 
 	[ "$(ip li add type $virt_type help 2>&1 | grep remote)" ] || \
-		tst_brkm TCONF "iproute doesn't support remote unicast address"
+		tst_brk TCONF "iproute doesn't support remote unicast address"
 
 	local opt="$1 remote $(tst_ipaddr rhost)"
 	local opt_r="$2 remote $(tst_ipaddr)"
@@ -265,26 +286,26 @@ virt_compare_netperf()
 	tst_netload -H $ip_remote $opts -d res_ipv4
 
 	local lt="$(cat res_ipv4)"
-	tst_resm TINFO "time lan($lt) $virt_type IPv4($vt) and IPv6($vt6) ms"
+	tst_res TINFO "time lan($lt) $virt_type IPv4($vt) and IPv6($vt6) ms"
 
 	per=$(( $vt * 100 / $lt - 100 ))
 	per6=$(( $vt6 * 100 / $lt - 100 ))
 
 	case "$virt_type" in
 	vxlan|geneve)
-		tst_resm TINFO "IP4 $virt_type over IP$TST_IPVER slower by $per %"
-		tst_resm TINFO "IP6 $virt_type over IP$TST_IPVER slower by $per6 %"
+		tst_res TINFO "IP4 $virt_type over IP$TST_IPVER slower by $per %"
+		tst_res TINFO "IP6 $virt_type over IP$TST_IPVER slower by $per6 %"
 	;;
 	*)
-		tst_resm TINFO "IP4 $virt_type slower by $per %"
-		tst_resm TINFO "IP6 $virt_type slower by $per6 %"
+		tst_res TINFO "IP4 $virt_type slower by $per %"
+		tst_res TINFO "IP6 $virt_type slower by $per6 %"
 	esac
 
 	if [ "$per" -ge "$VIRT_PERF_THRESHOLD" -o \
 	     "$per6" -ge "$VIRT_PERF_THRESHOLD" ]; then
-		tst_resm TFAIL "Test failed, threshold: $VIRT_PERF_THRESHOLD %"
+		tst_res TFAIL "Test failed, threshold: $VIRT_PERF_THRESHOLD %"
 	else
-		tst_resm TPASS "Test passed, threshold: $VIRT_PERF_THRESHOLD %"
+		tst_res TPASS "Test passed, threshold: $VIRT_PERF_THRESHOLD %"
 	fi
 }
 
@@ -292,7 +313,7 @@ virt_check_cmd()
 {
 	$@ > /dev/null 2>&1
 	if [ $? -ne 0 ]; then
-		tst_resm TCONF "'$@' option(s) not supported, skipping it"
+		tst_res TCONF "'$@' option(s) not supported, skipping it"
 		return 1
 	fi
 	ROD_SILENT "ip li delete ltp_v0"
@@ -329,6 +350,7 @@ virt_macsec_setup()
 virt_netperf_msg_sizes()
 {
 	local sizes="100 1000 2000 10000"
+	local s
 	client_requests=20000
 
 	for s in $sizes; do
@@ -336,76 +358,23 @@ virt_netperf_msg_sizes()
 	done
 }
 
-# Check if we can create then delete virtual interface n times.
-# virt_test_01 [OPTIONS]
-# OPTIONS - different options separated by comma.
+# Check if we can create then delete virtual interface.
 virt_test_01()
 {
 	start_id="${start_id:-1}"
-	local opts="${1:-}"
-	local n=0
-
-	while true; do
-		n=$((n + 1))
-		p="$(echo $opts | cut -d',' -f$n)"
-		if [ -z "$p" -a $n -gt 1 ]; then
-			break
-		fi
-
-		tst_resm TINFO "add $virt_type with '$p'"
 
-		virt_check_cmd virt_add ltp_v0 id 0 $p || continue
-
-		virt_multiple_add_test "$p"
-	done
+	tst_res TINFO "add $virt_type with '$2'"
+	virt_check_cmd virt_add ltp_v0 id 0 $2 || return
+	virt_multiple_add_test "$2"
 }
 
-# Check if we can create then delete virtual interface n times.
-# virt_test_02 [OPTIONS]
-# OPTIONS - different options separated by comma.
+# Check if we can create then delete virtual interface.
 virt_test_02()
 {
 	start_id="${start_id:-1}"
-	local opts="${1:-}"
-	local n=0
-
-	while true; do
-		n=$((n + 1))
-		p="$(echo $opts | cut -d',' -f$n)"
-		if [ -z "$p" -a $n -gt 1 ]; then
-			break
-		fi
-
-		tst_resm TINFO "add and then delete $virt_type with '$p'"
-
-		virt_check_cmd virt_add ltp_v0 $p || continue
 
-		virt_add_delete_test "$p"
-
-		start_id=$(($start_id + $NS_TIMES))
-	done
+	tst_res TINFO "add and then delete $virt_type with '$2'"
+	virt_check_cmd virt_add ltp_v0 $2 || return
+	virt_add_delete_test "$2"
+	start_id=$(($start_id + $NS_TIMES))
 }
-
-tst_require_root
-
-case "$virt_type" in
-vxlan|geneve)
-	if tst_kvcmp -lt "3.8"; then
-		tst_brkm TCONF "test must be run with kernel 3.8 or newer"
-	fi
-
-	if [ "$TST_IPV6" ] && tst_kvcmp -lt "3.12"; then
-		tst_brkm TCONF "test must be run with kernels >= 3.12"
-	fi
-
-	# newer versions of 'ip' complain if this option not set
-	ip li add type vxlan help 2>&1 | grep -q dstport && vxlan_dstport=1
-;;
-esac
-
-tst_check_cmds "ip"
-
-virt_add ltp_v0 || \
-	tst_brkm TCONF "iproute2 or kernel doesn't support $virt_type"
-
-ROD_SILENT "ip link delete ltp_v0"
diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
index 4dceae82f..69d2564cb 100755
--- a/testcases/network/virt/vlan01.sh
+++ b/testcases/network/virt/vlan01.sh
@@ -1,17 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create multiple VLAN interfaces.
 
-TCID=vlan01
-TST_TOTAL=9
-
-virt_type="vlan"
-
-. virt_lib.sh
-
 p0="protocol 802.1Q"
 p1="protocol 802.1ad"
 lb0="loose_binding off"
@@ -19,9 +13,12 @@ lb1="loose_binding on"
 rh0="reorder_hdr off"
 rh1="reorder_hdr on"
 
-options=" ,$p0 $lb0 $rh0,$p0 $lb0 $rh1,$p0 $lb1 $rh0,$p0 $lb1 $rh1,\
-$p1 $lb0 $rh0,$p1 $lb0 $rh1,$p1 $lb1 $rh0,$p1 $lb1 $rh1,"
+virt_type="vlan"
 
-virt_test_01 "$options"
+TST_TEST_DATA=",$p0 $lb0 $rh0,$p0 $lb0 $rh1,$p0 $lb1 $rh0,$p0 $lb1 $rh1,\
+$p1 $lb0 $rh0,$p1 $lb0 $rh1,$p1 $lb1 $rh0,$p1 $lb1 $rh1"
+TST_TEST_DATA_IFS=","
+TST_TESTFUNC=virt_test_01
+. virt_lib.sh
 
-tst_exit
+tst_run
diff --git a/testcases/network/virt/vlan02.sh b/testcases/network/virt/vlan02.sh
index 2b84a7cd0..04a8a5c60 100755
--- a/testcases/network/virt/vlan02.sh
+++ b/testcases/network/virt/vlan02.sh
@@ -1,18 +1,20 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create and then delete VLAN
 # interface 4095 times.
 
-TCID=vlan02
-TST_TOTAL=1
-
 virt_type="vlan"
 
+TST_TESTFUNC=do_test
 . virt_lib.sh
 
-virt_add_delete_test "id 4094"
+do_test()
+{
+	virt_add_delete_test "id 4094"
+}
 
-tst_exit
+tst_run
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index 33bfaf84c..adadd76fd 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015-2017 Oracle and/or its affiliates.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
@@ -10,20 +11,6 @@
 # Test-case 2: The same as above but must fail, because VLAN allows
 #              to communicate only within the same VLAN segment.
 
-TCID=vlan03
-TST_TOTAL=6
-TST_NEEDS_TMPDIR=1
-
-virt_type="vlan"
-
-. virt_lib.sh
-
-TST_CLEANUP="virt_cleanup"
-
-if [ -z $ip_local -o -z $ip_remote ]; then
-	tst_brkm TBROK "you must specify IP address"
-fi
-
 p0="protocol 802.1Q"
 p1="protocol 802.1ad"
 lb0="loose_binding off"
@@ -31,23 +18,38 @@ lb1="loose_binding on"
 rh0="reorder_hdr off"
 rh1="reorder_hdr on"
 
-opts=" ,$p0 $lb0 $rh1,$p1 $lb1 $rh1"
+virt_type="vlan"
+
+TST_NEEDS_TMPDIR=1
+TST_TEST_DATA=",$p0 $lb0 $rh1,$p1 $lb1 $rh1"
+TST_TEST_DATA_IFS=","
+TST_TESTFUNC=do_test
+TST_SETUP=do_setup
+TST_CLEANUP=virt_cleanup
+. virt_lib.sh
 
-for n in $(seq 1 3); do
-	p="$(echo $opts | cut -d',' -f$n)"
+do_setup()
+{
+	if [ -z $ip_local -o -z $ip_remote ]; then
+		tst_brk TBROK "you must specify IP address"
+	fi
+	virt_lib_setup
+}
 
-	virt_check_cmd virt_add ltp_v0 id 0 $p || continue
+do_test()
+{
+	virt_check_cmd virt_add ltp_v0 id 0 $2 || return
 
-	tst_resm TINFO "networks with the same VLAN ID must work"
-	virt_setup "id 4094 $p" "id 4094 $p"
+	tst_res TINFO "networks with the same VLAN ID must work"
+	virt_setup "id 4094 $2" "id 4094 $2"
 	virt_netperf_msg_sizes
 	virt_cleanup_rmt
 
-	tst_resm TINFO "different VLAN ID shall not work together"
-	virt_setup "id 4093 $p" "id 4094 $p"
+	tst_res TINFO "different VLAN ID shall not work together"
+	virt_setup "id 4093 $2" "id 4094 $2"
 	virt_minimize_timeout
 	virt_compare_netperf "fail"
 	virt_cleanup_rmt
-done
+}
 
-tst_exit
+tst_run
diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
index 49bcb942a..531691531 100755
--- a/testcases/network/virt/vxlan01.sh
+++ b/testcases/network/virt/vxlan01.sh
@@ -1,23 +1,22 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create multiple VXLAN interfaces.
 
-TCID=vxlan01
-TST_TOTAL=5
 TST_OPTS="hi:d:"
 TST_PARSE_ARGS=virt_lib_parse_args
+TST_USAGE=virt_lib_usage
 
 virt_type="vxlan"
 start_id=16700000
 
-. virt_lib.sh
-
-options="l2miss l3miss,norsc nolearning noproxy,\
+TST_TEST_DATA="l2miss l3miss,norsc nolearning noproxy,\
 ttl 0x01 tos 0x01,ttl 0xff tos 0xff,gbp"
+TST_TEST_DATA_IFS=","
+TST_TESTFUNC=virt_test_01
+. virt_lib.sh
 
-virt_test_01 "$options"
-
-tst_exit
+tst_run
diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
index dde1dabc8..04036a0df 100755
--- a/testcases/network/virt/vxlan02.sh
+++ b/testcases/network/virt/vxlan02.sh
@@ -1,24 +1,28 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create and then delete VXLAN
 # interface 5000 times.
 
-TCID=vxlan02
-TST_TOTAL=1
 TST_OPTS="hi:d:"
 TST_PARSE_ARGS=virt_lib_parse_args
+TST_USAGE=virt_lib_usage
 
 virt_type="vxlan"
 start_id=16700000
 
+TST_TESTFUNC=do_test
 . virt_lib.sh
 
-[ "$TST_IPV6" ] && mult_addr="ff02::abc" || mult_addr="239.1.1.1"
-opt="group $mult_addr"
+do_test()
+{
+	local mult_addr="239.1.1.1"
+	[ "$TST_IPV6" ] && mult_addr="ff02::abc"
 
-virt_add_delete_test "id $start_id $opt"
+	virt_add_delete_test "id $start_id group $mult_addr"
+}
 
-tst_exit
+tst_run
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index d8c533cb3..5e6ccd448 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2014-2017 Oracle and/or its affiliates.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
@@ -10,11 +11,10 @@
 # Test-case 2: The same as above but must fail, because VXLAN allows
 #              to communicate only within the same VXLAN segment.
 
-TCID=vxlan03
-TST_TOTAL=4
 TST_NEEDS_TMPDIR=1
 TST_OPTS="hi:d:"
 TST_PARSE_ARGS=virt_lib_parse_args
+TST_USAGE=virt_lib_usage
 
 virt_type="vxlan"
 start_id=16700000
@@ -22,6 +22,11 @@ start_id=16700000
 # Destination address, can be unicast or multicast address
 vxlan_dst_addr="uni"
 
+TST_TEST_DATA=",gbp"
+TST_TEST_DATA_IFS=","
+TST_NEEDS_TMPDIR=1
+TST_TESTFUNC=do_test
+TST_CLEANUP=virt_cleanup
 . virt_lib.sh
 
 # In average cases (with small packets less then 150 bytes) VxLAN slower
@@ -31,30 +36,25 @@ vxlan_dst_addr="uni"
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
 [ "$VIRT_PERF_THRESHOLD" -lt 160 ] && VIRT_PERF_THRESHOLD=160
 
-TST_CLEANUP="virt_cleanup"
-
-if [ -z $ip_local -o -z $ip_remote ]; then
-	tst_brkm TBROK "you must specify IP address"
-fi
-
-opts=" ,gbp"
-
-for n in $(seq 1 2); do
-	p="$(echo $opts | cut -d',' -f$n)"
+do_test()
+{
+	if [ -z $ip_local -o -z $ip_remote ]; then
+		tst_brk TBROK "you must specify IP address"
+	fi
 
-	virt_check_cmd virt_add ltp_v0 id 0 $p || continue
+	virt_check_cmd virt_add ltp_v0 id 0 $2 || continue
 
-	tst_resm TINFO "the same VNI must work"
+	tst_res TINFO "the same VNI must work"
 	# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
-	vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE $p" "id 0xFFFFFE $p"
+	vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE $2" "id 0xFFFFFE $2"
 	virt_netperf_msg_sizes
 	virt_cleanup_rmt
 
-	tst_resm TINFO "different VNI shall not work together"
-	vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE $p" "id 0xFFFFFD $p"
+	tst_res TINFO "different VNI shall not work together"
+	vxlan_setup_subnet_$vxlan_dst_addr "id 0xFFFFFE $2" "id 0xFFFFFD $2"
 	virt_minimize_timeout
 	virt_compare_netperf "fail"
 	virt_cleanup_rmt
-done
+}
 
-tst_exit
+tst_run
-- 
2.17.1

