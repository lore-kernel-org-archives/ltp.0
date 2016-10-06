From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  6 Oct 2016 16:54:55 +0300
Subject: [LTP] [PATCH 4/4] network/ipsec: add vti tunnel test & new options
	for enc algs
In-Reply-To: <1475762095-14612-1-git-send-email-alexey.kodanev@oracle.com>
References: <1475762095-14612-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1475762095-14612-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Add vti with IPsec policies, send ICMP messages through the tunnel.
  New test-cases include ah, esp protocols over vti and vti6 +
  new authentication and encryption algorithms.

* New options in ipsec_lib.sh:
  'e' - Encryption algorithm,
  'a' - Authentication algorithm,
  'c' - Compression algorithm.

* Dynamically generates algorithms random keys based on predefined key
  length for each algorithm type.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net_stress.ipsec_icmp                 |   18 +++-
 testcases/network/stress/icmp/icmp-uni-vti.sh |   71 ++++++++++
 testcases/network/stress/ipsec/ipsec_lib.sh   |  174 +++++++++++++++++++-----
 3 files changed, 225 insertions(+), 38 deletions(-)
 create mode 100755 testcases/network/stress/icmp/icmp-uni-vti.sh

diff --git a/runtest/net_stress.ipsec_icmp b/runtest/net_stress.ipsec_icmp
index 4a841e4..6e5908f 100644
--- a/runtest/net_stress.ipsec_icmp
+++ b/runtest/net_stress.ipsec_icmp
@@ -1,5 +1,5 @@
 #
-# Stress test for TCP/IP protocol stack (ICMP)
+# Stress test for IPsec with ICMP messages
 #
 
 # MAX_LENGTH(65535) - IP(20) - ICMP(8) = MAX_SIZE(65507)
@@ -35,3 +35,19 @@ icmp6-uni-basic05 icmp-uni-basic.sh -6 -p esp -m tunnel -s "10 100 1000 10000 65
 # after compression. So we just use a large enough message size(65000) for testing
 icmp6-uni-basic06 icmp-uni-basic.sh -6 -p comp -m transport -s "10 100 1000 10000 65000"
 icmp6-uni-basic07 icmp-uni-basic.sh -6 -p comp -m tunnel -s "10 100 1000 10000 65000"
+
+icmp4-uni-vti01 icmp-uni-vti.sh -p ah -a sha256 -m tunnel -S fffffffe -k 1 -s "10 100 1000 10000 65463"
+icmp4-uni-vti02 icmp-uni-vti.sh -p esp -a sha512 -e des -m tunnel -S fffffffe -k 0xf0f0f0f0 -s "10 100 1000 10000 65450"
+icmp4-uni-vti03 icmp-uni-vti.sh -p esp -a rmd160 -e cast5 -m tunnel -S fffffffe -k 0xffffffff -s "10 100 1000 10000 65463"
+icmp4-uni-vti04 icmp-uni-vti.sh -p esp -e blowfish -m tunnel -S fffffffe -k 3 -s "10 100 1000 10000 65463"
+icmp4-uni-vti05 icmp-uni-vti.sh -p esp -a sha512 -e twofish -m tunnel -S fffffffe -k 0x7fffffff -s "10 100 1000 10000 65463"
+icmp4-uni-vti06 icmp-uni-vti.sh -p esp -a sha384 -e camellia -m tunnel -S fffffffe -k 0x80000000 -s "10 100 1000 10000 65463"
+icmp4-uni-vti07 icmp-uni-vti.sh -p esp -a sha512 -e serpent -m tunnel -S fffffffe -k 0xffff -s "10 100 1000 10000 65463"
+
+icmp6-uni-vti01 icmp-uni-vti.sh -6 -p ah -m tunnel -S f1f1f1f1 -k 0xffffffff -s "10 100 1000 10000 65527"
+icmp6-uni-vti02 icmp-uni-vti.sh -6 -p esp -a sha256 -e des3_ede -m tunnel -S ffafafaf -k 0xffffffff -s "10 100 1000 10000 65527"
+icmp6-uni-vti03 icmp-uni-vti.sh -6 -p esp -a sha512 -e cast5 -m tunnel -S fffffffe -k 1 -s "10 100 1000 10000 65527"
+icmp6-uni-vti04 icmp-uni-vti.sh -6 -p esp -a rmd160 -e blowfish -m tunnel -S fffffffe -k 0x80000000 -s "10 100 1000 10000 65527"
+icmp6-uni-vti05 icmp-uni-vti.sh -6 -p esp -e twofish -m tunnel -S fffffffe -k 0xffff -s "10 100 1000 10000 65527"
+icmp6-uni-vti06 icmp-uni-vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -S fffffffe -k 0x7fffffff -s "10 100 1000 10000 65527"
+icmp6-uni-vti07 icmp-uni-vti.sh -6 -p esp -a sha384 -e serpent -m tunnel -S ffffffff -k 0x11111111 -s "10 100 1000 10000 65527"
diff --git a/testcases/network/stress/icmp/icmp-uni-vti.sh b/testcases/network/stress/icmp/icmp-uni-vti.sh
new file mode 100755
index 0000000..0f1b8df
--- /dev/null
+++ b/testcases/network/stress/icmp/icmp-uni-vti.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+
+TCID=icmp-uni-vti
+TST_TOTAL=1
+TST_CLEANUP="tst_ipsec_cleanup"
+
+. ipsec_lib.sh
+
+do_setup()
+{
+	ICMP_SIZE_ARRAY=${ICMP_SIZE_ARRAY:-"10 100 1000 10000 65507"}
+
+	if_loc=$(tst_iface)
+	if_rmt=$(tst_iface rhost)
+
+	ip_loc=$(tst_ipaddr)
+	ip_rmt=$(tst_ipaddr rhost)
+
+	tst_vti="ltp_vti0"
+
+	tst_resm TINFO "Test vti$TST_IPV6 + IPsec[$IPSEC_PROTO/$IPSEC_MODE]"
+
+	tst_ipsec_vti lhost $ip_loc $ip_rmt $tst_vti
+	tst_ipsec_vti rhost $ip_rmt $ip_loc $tst_vti
+
+	local mask=
+	if [ "$TST_IPV6" ]; then
+		ip_loc_tun="${IPV6_NET32_UNUSED}::1";
+		ip_rmt_tun="${IPV6_NET32_UNUSED}::2";
+		mask=64
+		ROD ip -6 route add ${IPV6_NET32_UNUSED}::/$mask dev $tst_vti
+	else
+		ip_loc_tun="${IPV4_NET16_UNUSED}.1.1";
+		ip_rmt_tun="${IPV4_NET16_UNUSED}.1.2";
+		mask=30
+		ROD ip route add ${IPV4_NET16_UNUSED}.1.0/$mask dev $tst_vti
+	fi
+
+	tst_resm TINFO "Add IPs to vti tunnel, " \
+		       "loc: $ip_loc_tun/$mask, rmt: $ip_rmt_tun/$mask"
+
+	ROD ip a add $ip_loc_tun/$mask dev $tst_vti
+	tst_rhost_run -s -c "ip a add $ip_rmt_tun/$mask dev $tst_vti"
+}
+
+do_test()
+{
+	tst_resm TINFO "Sending ICMP messages..."
+	EXPECT_PASS tst_ping $tst_vti $ip_rmt_tun $ICMP_SIZE_ARRAY
+}
+
+do_setup
+do_test
+
+tst_exit
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 56422c3..8f3d958 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -21,7 +21,14 @@
 
 . test_net.sh
 
-while getopts "hl:m:p:s:S:6" opt; do
+# Encryption algorithm
+EALGO="des3_ede"
+# Authentication algorithm
+AALGO="sha1"
+# Compression algorithm
+CALGO="deflate"
+
+while getopts "hl:m:p:s:S:k:e:a:c:6" opt; do
 	case "$opt" in
 	h)
 		echo "Usage:"
@@ -31,6 +38,10 @@ while getopts "hl:m:p:s:S:6" opt; do
 		echo "p x      x is ipsec protocol, could be ah / esp / ipcomp"
 		echo "s x      x is icmp messge size array"
 		echo "S n      n is IPsec SPI value"
+		echo "k x      key for vti interface"
+		echo "e x      Encryption algorithm"
+		echo "a x      Authentication algorithm"
+		echo "c x      Compression algorithm"
 		echo "6        run over IPv6"
 		exit 0
 	;;
@@ -39,13 +50,45 @@ while getopts "hl:m:p:s:S:6" opt; do
 	p) IPSEC_PROTO=$OPTARG ;;
 	s) ICMP_SIZE_ARRAY=$OPTARG ;;
 	S) SPI=$OPTARG ;;
+	k) VTI_KEY=$OPTARG ;;
+	e) EALGO=$OPTARG ;;
+	a) AALGO=$OPTARG ;;
+	c) CALGO=$OPTARG ;;
 	6) # skip, test_net library already processed it
 	;;
 	*) tst_brkm TBROK "unknown option: $opt" ;;
 	esac
 done
 
+get_key()
+{
+	local bits=$1
+	local xdg_num=$(( $bits / 4 ))
+	echo "0x$(tr -dc "[:xdigit:]" < /dev/urandom | head -c$xdg_num)"
+}
+
+case $EALGO in
+des) EALGO_KEY=$(get_key 64) ;;
+des3_ede) EALGO_KEY=$(get_key 192) ;;
+cast5) EALGO_KEY=$(get_key 128) ;;
+blowfish) EALGO_KEY=$(get_key 448) ;;
+aes|twofish|camellia|serpent) EALGO_KEY=$(get_key 256) ;;
+*) tst_brkm TBROK "unknown enc alg: $EALGO" ;;
+esac
+
+case $AALGO in
+sha1|rmd160) AALGO_KEY=$(get_key 160) ;;
+sha256) AALGO_KEY=$(get_key 256) ;;
+sha384) AALGO_KEY=$(get_key 384) ;;
+sha512) AALGO_KEY=$(get_key 512) ;;
+*) tst_brkm TBROK "unknown auth alg: $AALGO" ;;
+esac
+
 SPI=${SPI:-1000}
+VTI_KEY=${VTI_KEY:-10}
+cleanup_vti=
+ALG=
+ALGR=
 
 # tst_ipsec_cleanup: flush ipsec state and policy rules
 tst_ipsec_cleanup()
@@ -53,17 +96,33 @@ tst_ipsec_cleanup()
 	ip xfrm state flush
 	ip xfrm policy flush
 	tst_rhost_run -c "ip xfrm state flush && ip xfrm policy flush"
-}
-
-tst_check_cmds hexdump
 
-# Encryption algorithm
-EALGO="des3_ede"
-EALGO_KEY=0x$(printf _I_want_to_have_chicken_ | hexdump -ve '/1 "%x"')
+	if [ -n "$cleanup_vti" ]; then
+		ip li del $cleanup_vti 2>/dev/null
+		tst_rhost_run -c "ip li del $cleanup_vti 2>/dev/null"
+	fi
+}
 
-# Authentication algorithm
-AALGO="sha1"
-AALGO_KEY=0x$(printf beef_fish_pork_salad | hexdump -ve '/1 "%x"')
+ipsec_set_algoline()
+{
+	case $IPSEC_PROTO in
+	ah)
+		ALG='auth hmac('$AALGO') '$AALGO_KEY
+		ALGR='auth hmac\('$AALGO'\) '$AALGO_KEY
+		;;
+	esp)
+		ALG="enc $EALGO $EALGO_KEY auth "'hmac('$AALGO') '$AALGO_KEY
+		ALGR="enc $EALGO $EALGO_KEY auth "'hmac\('$AALGO'\) '$AALGO_KEY
+		;;
+	comp)
+		ALG="comp $CALGO"
+		ALGR=$ALG
+		;;
+	*)
+		tst_brkm TCONF "tst_ipsec protocol mismatch"
+		;;
+	esac
+}
 
 # tst_ipsec target src_addr dst_addr: config ipsec
 #
@@ -79,38 +138,18 @@ tst_ipsec()
 	local target=$1
 	local src=$2
 	local dst=$3
-
-	# Compression algorithm
-	local CALGO="deflate"
-	# Algorithm options for each protocol
-	local algo_line=
-	case $IPSEC_PROTO in
-	ah)
-		algo_line="auth $AALGO $AALGO_KEY"
-		proto="ah"
-		;;
-	esp)
-		algo_line="enc $EALGO $EALGO_KEY auth $AALGO $AALGO_KEY"
-		proto="esp"
-		;;
-	comp)
-		algo_line="comp $CALGO"
-		proto="comp"
-		;;
-	*)
-		tst_brkm TCONF "tst_ipsec protocol mismatch"
-		;;
-	esac
-
 	local mode=$IPSEC_MODE
+	local proto=$IPSEC_PROTO
+
+	ipsec_set_algoline
 
 	if [ $target = lhost ]; then
 		local spi_1="0x$SPI"
 		local spi_2="0x$(( $SPI + 1 ))"
 		ROD ip xfrm state add src $src dst $dst spi $spi_1 \
-			proto $proto $algo_line mode $mode sel src $src dst $dst
+			proto $proto $ALG mode $mode sel src $src dst $dst
 		ROD ip xfrm state add src $dst dst $src spi $spi_2 \
-			proto $proto $algo_line mode $mode sel src $dst dst $src
+			proto $proto $ALG mode $mode sel src $dst dst $src
 
 		ROD ip xfrm policy add src $src dst $dst dir out tmpl src $src \
 			dst $dst proto $proto mode $mode
@@ -120,10 +159,10 @@ tst_ipsec()
 		local spi_1="0x$(( $SPI + 1 ))"
 		local spi_2="0x$SPI"
 		tst_rhost_run -s -c "ip xfrm state add src $src dst $dst \
-			spi $spi_1 proto $proto $algo_line mode $mode sel \
+			spi $spi_1 proto $proto $ALGR mode $mode sel \
 			src $src dst $dst"
 		tst_rhost_run -s -c "ip xfrm state add src $dst dst $src \
-			spi $spi_2 proto $proto $algo_line mode $mode sel \
+			spi $spi_2 proto $proto $ALGR mode $mode sel \
 			src $dst dst $src"
 
 		tst_rhost_run -s -c "ip xfrm policy add src $src dst $dst \
@@ -133,3 +172,64 @@ tst_ipsec()
 			mode $mode level use"
 	fi
 }
+
+# tst_ipsec_vti target src_addr dst_addr vti_name
+#
+# target: target of the configuration host ( lhost / rhost )
+# src_addr: source IP address
+# dst_addr: destination IP address
+# vti_name: name of vti interface
+tst_ipsec_vti()
+{
+	if [ $# -ne 4 ]; then
+		tst_brkm TCONF "tst_ipsec_vti parameter mismatch"
+	fi
+
+	local target=$1
+	local src=$2
+	local dst=$3
+	local vti=$4
+	local mode="mode $IPSEC_MODE"
+	local proto="proto $IPSEC_PROTO"
+	local key="key $VTI_KEY"
+	local mark="mark $VTI_KEY"
+	local type="type vti$TST_IPV6"
+
+	ipsec_set_algoline
+
+	ip li add type vti help 2>&1 | grep -q vti || \
+		tst_brkm TCONF "iproute doesn't support 'vti'"
+
+	local o_dir="src $src dst $dst"
+	local i_dir="src $dst dst $src"
+
+	local sel='src 0.0.0.0/0 dst 0.0.0.0/0'
+	if [ "$TST_IPV6" ]; then
+		sel='src ::/0 dst ::/0'
+	fi
+
+	cleanup_vti=$vti
+
+	if [ $target = lhost ]; then
+		ROD ip li add $vti $type local $src remote $dst $key
+		ROD ip li set $vti up
+
+		local spi_1="spi 0x$SPI"
+		local spi_2="spi 0x$(( $SPI + 1 ))"
+		ROD ip xf st add $o_dir $proto $spi_1 $ALG $mode
+		ROD ip xf st add $i_dir $proto $spi_2 $ALG $mode
+		ROD ip xf po add $sel dir out tmpl $o_dir $proto $mode $mark
+		ROD ip xf po add $sel dir in tmpl $i_dir $proto $mode $mark
+	elif [ $target = rhost ]; then
+		tst_rhost_run -s -c \
+			"ip li add $vti $type local $src remote $dst $key"
+		tst_rhost_run -s -c "ip li set $vti up"
+
+		local spi_1="spi 0x$(( $SPI + 1 ))"
+		local spi_2="spi 0x$SPI"
+		tst_rhost_run -s -c "ip xf st add $o_dir $proto $spi_1 $ALGR $mode"
+		tst_rhost_run -s -c "ip xf st add $i_dir $proto $spi_2 $ALGR $mode"
+		tst_rhost_run -s -c "ip xf po add $sel dir out tmpl $o_dir $proto $mode $mark"
+		tst_rhost_run -s -c "ip xf po add $sel dir in tmpl $i_dir $proto $mode $mark"
+	fi
+}
-- 
1.7.1

