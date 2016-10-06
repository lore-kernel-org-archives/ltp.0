From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  6 Oct 2016 16:54:53 +0300
Subject: [LTP] [PATCH 2/4] network/ipsec: move parsing command-line options
	to ipsec_lib.sh
In-Reply-To: <1475762095-14612-1-git-send-email-alexey.kodanev@oracle.com>
References: <1475762095-14612-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1475762095-14612-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/icmp/icmp-uni-basic.sh |   29 +--------
 testcases/network/stress/ipsec/ipsec_lib.sh     |   76 ++++++++++++++--------
 2 files changed, 50 insertions(+), 55 deletions(-)

diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index 519d870..963f3bc 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -25,31 +25,6 @@ TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
 
-while getopts "hl:m:p:s:S:6" opt; do
-	case "$opt" in
-	h)
-		echo "Usage:"
-		echo "h        help"
-		echo "l n      n is the number of test link when tests run"
-		echo "m x      x is ipsec mode, could be transport / tunnel"
-		echo "p x      x is ipsec protocol, could be ah / esp / ipcomp"
-		echo "s x      x is icmp messge size array"
-		echo "S n      n is IPsec SPI value"
-		echo "6        run over IPv6"
-		exit 0
-	;;
-	l) LINK_NUM=$OPTARG ;;
-	m) IPSEC_MODE=$OPTARG ;;
-	p) IPSEC_PROTO=$OPTARG ;;
-	s) ICMP_SIZE_ARRAY=$OPTARG ;;
-	S) SPI=$OPTARG ;;
-	6) # skip, test_net library already processed it
-	;;
-	*) tst_brkm TBROK "unknown option: $opt" ;;
-	esac
-done
-
-SPI=${SPI:-1000}
 LINK_NUM=${LINK_NUM:-0}
 DO_IPSEC=${DO_IPSEC:-false}
 ICMP_SIZE_ARRAY=${ICMP_SIZE_ARRAY:-"10 100 1000 10000 65507"}
@@ -77,8 +52,8 @@ rhost_addr=$(tst_ipaddr rhost)
 
 # Configure SAD/SPD
 if $DO_IPSEC ; then
-	tst_ipsec lhost $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr
-	tst_ipsec rhost $IPSEC_PROTO $IPSEC_MODE $SPI $rhost_addr $lhost_addr
+	tst_ipsec lhost $lhost_addr $rhost_addr
+	tst_ipsec rhost $rhost_addr $lhost_addr
 fi
 
 tst_ping $lhost_ifname $rhost_addr $ICMP_SIZE_ARRAY
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index b222484..99d0229 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
+# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -20,6 +21,32 @@
 
 . test_net.sh
 
+while getopts "hl:m:p:s:S:6" opt; do
+	case "$opt" in
+	h)
+		echo "Usage:"
+		echo "h        help"
+		echo "l n      n is the number of test link when tests run"
+		echo "m x      x is ipsec mode, could be transport / tunnel"
+		echo "p x      x is ipsec protocol, could be ah / esp / ipcomp"
+		echo "s x      x is icmp messge size array"
+		echo "S n      n is IPsec SPI value"
+		echo "6        run over IPv6"
+		exit 0
+	;;
+	l) LINK_NUM=$OPTARG ;;
+	m) IPSEC_MODE=$OPTARG ;;
+	p) IPSEC_PROTO=$OPTARG ;;
+	s) ICMP_SIZE_ARRAY=$OPTARG ;;
+	S) SPI=$OPTARG ;;
+	6) # skip, test_net library already processed it
+	;;
+	*) tst_brkm TBROK "unknown option: $opt" ;;
+	esac
+done
+
+SPI=${SPI:-1000}
+
 # tst_ipsec_cleanup: flush ipsec state and policy rules
 tst_ipsec_cleanup()
 {
@@ -28,45 +55,36 @@ tst_ipsec_cleanup()
 	tst_rhost_run -c "ip xfrm state flush && ip xfrm policy flush"
 }
 
-# tst_ipsec target protocol mode spi src_addr dst_addr: config ipsec with
-# supplied protocol and mode.
+tst_check_cmds hexdump
+
+# Encryption algorithm
+EALGO="des3_ede"
+EALGO_KEY=0x$(printf _I_want_to_have_chicken_ | hexdump -ve '/1 "%x"')
+
+# Authentication algorithm
+AALGO="sha1"
+AALGO_KEY=0x$(printf beef_fish_pork_salad | hexdump -ve '/1 "%x"')
+
+# tst_ipsec target src_addr dst_addr: config ipsec
 #
 # target: target of the configuration host ( lhost / rhost )
-# protocol: ah / esp / ipcomp
-# mode: transport / tunnel
-# spi: the first spi value
 # src_addr: source IP address
 # dst_addr: destination IP address
 tst_ipsec()
 {
-	if [ $# -ne 6 ]; then
+	if [ $# -ne 3 ]; then
 		tst_brkm TCONF "tst_ipsec parameter mismatch"
 	fi
-	tst_check_cmds hexdump
 
 	local target=$1
-	local protocol=$2
-	local mode=$3
-	local spi=$4
-	local src=$5
-	local dst=$6
-
-	# Encryption algorithm
-	local EALGO="des3_ede"
-	local EALGO_KEY=0x$(printf _I_want_to_have_chicken_ | \
-			    hexdump -ve '/1 "%x"')
-
-	# Authentication algorithm
-	local AALGO="sha1"
-	local AALGO_KEY=0x$(printf beef_fish_pork_salad | \
-			    hexdump -ve '/1 "%x"')
+	local src=$2
+	local dst=$3
 
 	# Compression algorithm
 	local CALGO="deflate"
 	# Algorithm options for each protocol
 	local algo_line=
-	local proto=
-	case $protocol in
+	case $IPSEC_PROTO in
 	ah)
 		algo_line="auth $AALGO $AALGO_KEY"
 		proto="ah"
@@ -84,9 +102,11 @@ tst_ipsec()
 		;;
 	esac
 
+	local mode=$IPSEC_MODE
+
 	if [ $target = lhost ]; then
-		local spi_1="0x$spi"
-		local spi_2="0x$(( $spi + 1 ))"
+		local spi_1="0x$SPI"
+		local spi_2="0x$(( $SPI + 1 ))"
 		ROD ip xfrm state add src $src dst $dst spi $spi_1 \
 			proto $proto $algo_line mode $mode sel src $src dst $dst
 		ROD ip xfrm state add src $dst dst $src spi $spi_2 \
@@ -97,8 +117,8 @@ tst_ipsec()
 		ROD ip xfrm policy add src $dst dst $src dir in tmpl src $dst \
 			dst $src proto $proto mode $mode level use
 	elif [ $target = rhost ]; then
-		local spi_1="0x$(( $spi + 1 ))"
-		local spi_2="0x$spi"
+		local spi_1="0x$(( $SPI + 1 ))"
+		local spi_2="0x$SPI"
 		tst_rhost_run -s -c "ip xfrm state add src $src dst $dst \
 			spi $spi_1 proto $proto $algo_line mode $mode sel \
 			src $src dst $dst"
-- 
1.7.1

