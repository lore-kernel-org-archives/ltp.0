From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Feb 2017 14:47:47 +0300
Subject: [LTP] [COMMITTED][PATCH 2/2] ipsec_lib: add 'AEAD' algorithm setup
	for ESP protocol
In-Reply-To: <1487159267-1317-1-git-send-email-alexey.kodanev@oracle.com>
References: <1487159267-1317-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1487159267-1317-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add new test-cases in net-stress.ipsec_icmp and move description
of the message sizes used to the top of the file.

New test-cases include AES-GCM, AES-CCM and AES-GMAC cipher modes.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net_stress.ipsec_icmp               |  101 +++++++++++++++++++++-----
 testcases/network/stress/ipsec/ipsec_lib.sh |   55 +++++++++++----
 2 files changed, 123 insertions(+), 33 deletions(-)

diff --git a/runtest/net_stress.ipsec_icmp b/runtest/net_stress.ipsec_icmp
index 2f14fe1..374d44b 100644
--- a/runtest/net_stress.ipsec_icmp
+++ b/runtest/net_stress.ipsec_icmp
@@ -1,40 +1,83 @@
-#
 # Stress test for IPsec with ICMP messages
+# Max ICMP message size descriptsion, MAX_SIZE is 65535
+#
+# IPv4
+# ----
+#   MAX = MAX_SIZE - IP(20) - ICMP(8) = 65507
+#
+#   IPsec [AH]: MAX - AH(24) = 65483
+#   IPsec [AH + Tunnel]: MAX - AH(24) - Tunnel(20) = 65463
+#
+#   ESP Header has pad payload, so the ESP length is variable
+#   IPsec [ESP]: MAX - ESP(37) = 65470
+#   IPsec [ESP + Tunnel]: MAX - ESP(37) - Tunnel(20) = 65450
+#
+# IPv6
+# ----
+#   MAX = MAX_SIZE - ICMP(8) = 65527
 #
+#   IPsec [AH]: MAX - AH(24) = 65503
+#
+#   When receive, we drop the tunnel header first and only leave the inside IPv6
+#   Header and ICMP message. That's why we can have so large message size.
+#   IPsec [AH + Tunnel]: MAX
+#   IPsec [ESP]: MAX - ESP(37) = 65490
+#   IPsec [ESP + Tunnel]: MAX
+#
+# IPsec compression: same message size but different content will result in different data size
+# after compression. So we just use a large enough message size(65000) for testing
 
-# MAX_LENGTH(65535) - IP(20) - ICMP(8) = MAX_SIZE(65507)
 icmp4-uni-basic01 icmp-uni-basic.sh -s "10 100 1000 10000 65507"
-# MAX_LENGTH(65535) - IP(20) - AH(24) - ICMP(8) = MAX_SIZE(65483)
 icmp4-uni-basic02 icmp-uni-basic.sh -p ah -m transport -s "10 100 1000 10000 65483"
-# MAX_LENGTH(65535) - IP(20) - AH(24) - Tunnel(IPv4 20) - ICMP(8) = MAX_SIZE(65463)
 icmp4-uni-basic03 icmp-uni-basic.sh -p ah -m tunnel -s "10 100 1000 10000 65463"
-# MAX_LENGTH(65535) - IP(20) - ESP (37) - ICMP(8) = MAX_SIZE(65470)
-# ESP Header has pad payload, so the ESP length is variable
 icmp4-uni-basic04 icmp-uni-basic.sh -p esp -m transport -s "10 100 1000 10000 65470"
-# MAX_LENGTH(65535) - IP(20) - ESP (37) - Tunnel(20) - ICMP(8) = MAX_SIZE(65450)
 icmp4-uni-basic05 icmp-uni-basic.sh -p esp -m tunnel -s "10 100 1000 10000 65450"
-# Same message size but different content will result in different data size
-# after compression. So we just use a large enough message size(65000) for testing
 icmp4-uni-basic06 icmp-uni-basic.sh -p comp -m transport -s "10 100 1000 10000 65000"
 icmp4-uni-basic07 icmp-uni-basic.sh -p comp -m tunnel -s "10 100 1000 10000 65000"
+icmp4-uni-basic08 icmp-uni-basic.sh -A rfc4106_128 -p esp_aead -m transport -s "10 100 1000 10000 65470"
+icmp4-uni-basic09 icmp-uni-basic.sh -A rfc4106_192 -p esp_aead -m transport -s "10 100 1000 10000 65470"
+icmp4-uni-basic10 icmp-uni-basic.sh -A rfc4106_256 -p esp_aead -m transport -s "10 100 1000 10000 65470"
+icmp4-uni-basic11 icmp-uni-basic.sh -A rfc4309_128 -p esp_aead -m transport -s "10 100 1000 10000 65470"
+icmp4-uni-basic12 icmp-uni-basic.sh -A rfc4309_192 -p esp_aead -m transport -s "10 100 1000 10000 65470"
+icmp4-uni-basic13 icmp-uni-basic.sh -A rfc4309_256 -p esp_aead -m transport -s "10 100 1000 10000 65470"
+icmp4-uni-basic14 icmp-uni-basic.sh -A rfc4543_128 -p esp_aead -m transport -s "10 100 1000 10000 65470"
+icmp4-uni-basic15 icmp-uni-basic.sh -A rfc4543_192 -p esp_aead -m transport -s "10 100 1000 10000 65470"
+icmp4-uni-basic16 icmp-uni-basic.sh -A rfc4543_256 -p esp_aead -m transport -s "10 100 1000 10000 65470"
+icmp4-uni-basic17 icmp-uni-basic.sh -A rfc4106_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
+icmp4-uni-basic18 icmp-uni-basic.sh -A rfc4106_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
+icmp4-uni-basic19 icmp-uni-basic.sh -A rfc4106_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
+icmp4-uni-basic20 icmp-uni-basic.sh -A rfc4309_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
+icmp4-uni-basic21 icmp-uni-basic.sh -A rfc4309_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
+icmp4-uni-basic22 icmp-uni-basic.sh -A rfc4309_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
+icmp4-uni-basic23 icmp-uni-basic.sh -A rfc4543_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
+icmp4-uni-basic24 icmp-uni-basic.sh -A rfc4543_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
+icmp4-uni-basic25 icmp-uni-basic.sh -A rfc4543_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65450"
 
-# MAX_LENGTH(65535) - ICMP(8) = MAX_SIZE(65527)
 icmp6-uni-basic01 icmp-uni-basic.sh -6 -s "10 100 1000 10000 65527"
-# MAX_LENGTH(65535) - AH(24) - ICMP(8) = MAX_SIZE(65503)
 icmp6-uni-basic02 icmp-uni-basic.sh -6 -p ah -m transport -s "10 100 1000 10000 65503"
-# MAX_LENGTH(65535) - ICMP(8) = MAX_SIZE(65527)
-# When receive, we drop the tunnel header first and only leave the inside IPv6
-# Header and icmp message. That's why we can have so large message size.
 icmp6-uni-basic03 icmp-uni-basic.sh -6 -p ah -m tunnel -s "10 100 1000 10000 65527"
-# MAX_LENGTH(65535) - ESP (33) - ICMP(8) = MAX_SIZE(65494)
-# ESP Header has pad payload, so the ESP length is variable
-icmp6-uni-basic04 icmp-uni-basic.sh -6 -p esp -m transport -s "10 100 1000 10000 65494"
-# MAX_LENGTH(65535) - ICMP(8) = MAX_SIZE(65527)
+icmp6-uni-basic04 icmp-uni-basic.sh -6 -p esp -m transport -s "10 100 1000 10000 65490"
 icmp6-uni-basic05 icmp-uni-basic.sh -6 -p esp -m tunnel -s "10 100 1000 10000 65527"
-# Same message size but different content will result in different data size
-# after compression. So we just use a large enough message size(65000) for testing
 icmp6-uni-basic06 icmp-uni-basic.sh -6 -p comp -m transport -s "10 100 1000 10000 65000"
 icmp6-uni-basic07 icmp-uni-basic.sh -6 -p comp -m tunnel -s "10 100 1000 10000 65000"
+icmp6-uni-basic08 icmp-uni-basic.sh -6 -A rfc4106_128 -p esp_aead -m transport -s "10 100 1000 10000 65490"
+icmp6-uni-basic09 icmp-uni-basic.sh -6 -A rfc4106_192 -p esp_aead -m transport -s "10 100 1000 10000 65490"
+icmp6-uni-basic10 icmp-uni-basic.sh -6 -A rfc4106_256 -p esp_aead -m transport -s "10 100 1000 10000 65490"
+icmp6-uni-basic11 icmp-uni-basic.sh -6 -A rfc4309_128 -p esp_aead -m transport -s "10 100 1000 10000 65490"
+icmp6-uni-basic12 icmp-uni-basic.sh -6 -A rfc4309_192 -p esp_aead -m transport -s "10 100 1000 10000 65490"
+icmp6-uni-basic13 icmp-uni-basic.sh -6 -A rfc4309_256 -p esp_aead -m transport -s "10 100 1000 10000 65490"
+icmp6-uni-basic14 icmp-uni-basic.sh -6 -A rfc4543_128 -p esp_aead -m transport -s "10 100 1000 10000 65490"
+icmp6-uni-basic15 icmp-uni-basic.sh -6 -A rfc4543_192 -p esp_aead -m transport -s "10 100 1000 10000 65490"
+icmp6-uni-basic16 icmp-uni-basic.sh -6 -A rfc4543_256 -p esp_aead -m transport -s "10 100 1000 10000 65490"
+icmp6-uni-basic17 icmp-uni-basic.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-basic18 icmp-uni-basic.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-basic19 icmp-uni-basic.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-basic20 icmp-uni-basic.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-basic21 icmp-uni-basic.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-basic22 icmp-uni-basic.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-basic23 icmp-uni-basic.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-basic24 icmp-uni-basic.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-basic25 icmp-uni-basic.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
 
 icmp4-uni-vti01 icmp-uni-vti.sh -p ah -a sha256 -m tunnel -S fffffffe -k 1 -s "10 100 1000 10000 65463"
 icmp4-uni-vti02 icmp-uni-vti.sh -p esp -a sha512 -e des -m tunnel -S fffffffe -k 2 -s "10 100 1000 10000 65450"
@@ -43,6 +86,15 @@ icmp4-uni-vti04 icmp-uni-vti.sh -p esp -e blowfish -m tunnel -S fffffffe -k 3 -s
 icmp4-uni-vti05 icmp-uni-vti.sh -p esp -a sha512 -e twofish -m tunnel -S fffffffe -k 0x7fffffff -s "10 100 1000 10000 65463"
 icmp4-uni-vti06 icmp-uni-vti.sh -p esp -a sha384 -e camellia -m tunnel -S fffffffe -k 0x80000000 -s "10 100 1000 10000 65463"
 icmp4-uni-vti07 icmp-uni-vti.sh -p esp -a sha512 -e serpent -m tunnel -S fffffffe -k 0xffff -s "10 100 1000 10000 65463"
+icmp4-uni-vti08 icmp-uni-vti.sh -A rfc4106_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
+icmp4-uni-vti09 icmp-uni-vti.sh -A rfc4106_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
+icmp4-uni-vti10 icmp-uni-vti.sh -A rfc4106_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
+icmp4-uni-vti11 icmp-uni-vti.sh -A rfc4309_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
+icmp4-uni-vti12 icmp-uni-vti.sh -A rfc4309_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
+icmp4-uni-vti13 icmp-uni-vti.sh -A rfc4309_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
+icmp4-uni-vti14 icmp-uni-vti.sh -A rfc4543_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
+icmp4-uni-vti15 icmp-uni-vti.sh -A rfc4543_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
+icmp4-uni-vti16 icmp-uni-vti.sh -A rfc4543_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65463"
 
 icmp6-uni-vti01 icmp-uni-vti.sh -6 -p ah -m tunnel -S fffffffe -k 0xffffffff -s "10 100 1000 10000 65527"
 icmp6-uni-vti02 icmp-uni-vti.sh -6 -p esp -a sha256 -e des3_ede -m tunnel -S fffffffe -k 0xffffffff -s "10 100 1000 10000 65527"
@@ -51,3 +103,12 @@ icmp6-uni-vti04 icmp-uni-vti.sh -6 -p esp -a rmd160 -e blowfish -m tunnel -S fff
 icmp6-uni-vti05 icmp-uni-vti.sh -6 -p esp -e twofish -m tunnel -S fffffffe -k 0xffff -s "10 100 1000 10000 65527"
 icmp6-uni-vti06 icmp-uni-vti.sh -6 -p esp -a sha512 -e camellia -m tunnel -S fffffffe -k 0x7fffffff -s "10 100 1000 10000 65527"
 icmp6-uni-vti07 icmp-uni-vti.sh -6 -p esp -a sha384 -e serpent -m tunnel -S ffffffff -k 0x11111111 -s "10 100 1000 10000 65527"
+icmp6-uni-vti08 icmp-uni-vti.sh -6 -A rfc4106_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-vti09 icmp-uni-vti.sh -6 -A rfc4106_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-vti10 icmp-uni-vti.sh -6 -A rfc4106_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-vti11 icmp-uni-vti.sh -6 -A rfc4309_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-vti12 icmp-uni-vti.sh -6 -A rfc4309_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-vti13 icmp-uni-vti.sh -6 -A rfc4309_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-vti14 icmp-uni-vti.sh -6 -A rfc4543_128 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-vti15 icmp-uni-vti.sh -6 -A rfc4543_192 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
+icmp6-uni-vti16 icmp-uni-vti.sh -6 -A rfc4543_256 -p esp_aead -m tunnel -s "10 100 1000 10000 65527"
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 3fada90..e5494bd 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -21,6 +21,8 @@
 
 . test_net.sh
 
+# Authenticated encryption with associated data
+AEALGO="rfc4106_128"
 # Encryption algorithm
 EALGO="des3_ede"
 # Authentication algorithm
@@ -28,7 +30,7 @@ AALGO="sha1"
 # Compression algorithm
 CALGO="deflate"
 
-while getopts "hl:m:p:s:S:k:e:a:c:6" opt; do
+while getopts "hl:m:p:s:S:k:A:e:a:c:6" opt; do
 	case "$opt" in
 	h)
 		echo "Usage:"
@@ -39,6 +41,7 @@ while getopts "hl:m:p:s:S:k:e:a:c:6" opt; do
 		echo "s x      x is icmp messge size array"
 		echo "S n      n is IPsec SPI value"
 		echo "k x      key for vti interface"
+		echo "A x      Authenticated encryption with associated data algorithm"
 		echo "e x      Encryption algorithm"
 		echo "a x      Authentication algorithm"
 		echo "c x      Compression algorithm"
@@ -51,6 +54,7 @@ while getopts "hl:m:p:s:S:k:e:a:c:6" opt; do
 	s) ICMP_SIZE_ARRAY=$OPTARG ;;
 	S) SPI=$OPTARG ;;
 	k) VTI_KEY=$OPTARG ;;
+	A) AEALGO=$OPTARG ;;
 	e) EALGO=$OPTARG ;;
 	a) AALGO=$OPTARG ;;
 	c) CALGO=$OPTARG ;;
@@ -67,6 +71,15 @@ get_key()
 	echo "0x$(tr -dc "[:xdigit:]" < /dev/urandom | head -c$xdg_num)"
 }
 
+case $AEALGO in
+rfc4106_128|rfc4543_128) AEALGO_KEY=$(get_key 160) ;;
+rfc4106_192|rfc4543_192) AEALGO_KEY=$(get_key 224) ;;
+rfc4106_256|rfc4543_256) AEALGO_KEY=$(get_key 288) ;;
+rfc4309_128) AEALGO_KEY=$(get_key 152) ;;
+rfc4309_192) AEALGO_KEY=$(get_key 216) ;;
+rfc4309_256) AEALGO_KEY=$(get_key 280) ;;
+esac
+
 case $EALGO in
 des) EALGO_KEY=$(get_key 64) ;;
 des3_ede) EALGO_KEY=$(get_key 192) ;;
@@ -114,6 +127,22 @@ ipsec_set_algoline()
 		ALG="enc $EALGO $EALGO_KEY auth "'hmac('$AALGO') '$AALGO_KEY
 		ALGR="enc $EALGO $EALGO_KEY auth "'hmac\('$AALGO'\) '$AALGO_KEY
 		;;
+	esp_aead)
+		case $AEALGO in
+		rfc4106_128|rfc4106_192|rfc4106_256)
+			ALG="aead "'rfc4106(gcm(aes))'" $AEALGO_KEY 128"
+			ALGR="aead "'rfc4106\(gcm\(aes\)\)'" $AEALGO_KEY 128"
+			;;
+		rfc4309_128|rfc4309_192|rfc4309_256)
+			ALG="aead "'rfc4309(ccm(aes))'" $AEALGO_KEY 128"
+			ALGR="aead "'rfc4309\(ccm\(aes\)\)'" $AEALGO_KEY 128"
+			;;
+		rfc4543_128|rfc4543_192|rfc4543_256)
+			ALG="aead "'rfc4543(gcm(aes))'" $AEALGO_KEY 128"
+			ALGR="aead "'rfc4543\(gcm\(aes\)\)'" $AEALGO_KEY 128"
+			;;
+		esac
+		;;
 	comp)
 		ALG="comp $CALGO"
 		ALGR=$ALG
@@ -139,7 +168,8 @@ tst_ipsec()
 	local src=$2
 	local dst=$3
 	local mode=$IPSEC_MODE
-	local proto=$IPSEC_PROTO
+	local p="proto $IPSEC_PROTO"
+	[ "$IPSEC_PROTO" = "esp_aead" ] && p="proto esp"
 
 	ipsec_set_algoline
 
@@ -147,29 +177,26 @@ tst_ipsec()
 		local spi_1="0x$SPI"
 		local spi_2="0x$(( $SPI + 1 ))"
 		ROD ip xfrm state add src $src dst $dst spi $spi_1 \
-			proto $proto $ALG mode $mode sel src $src dst $dst
+			$p $ALG mode $mode sel src $src dst $dst
 		ROD ip xfrm state add src $dst dst $src spi $spi_2 \
-			proto $proto $ALG mode $mode sel src $dst dst $src
+			$p $ALG mode $mode sel src $dst dst $src
 
 		ROD ip xfrm policy add src $src dst $dst dir out tmpl src $src \
-			dst $dst proto $proto mode $mode
+			dst $dst $p mode $mode
 		ROD ip xfrm policy add src $dst dst $src dir in tmpl src $dst \
-			dst $src proto $proto mode $mode level use
+			dst $src $p mode $mode level use
 	elif [ $target = rhost ]; then
 		local spi_1="0x$(( $SPI + 1 ))"
 		local spi_2="0x$SPI"
 		tst_rhost_run -s -c "ip xfrm state add src $src dst $dst \
-			spi $spi_1 proto $proto $ALGR mode $mode sel \
-			src $src dst $dst"
+			spi $spi_1 $p $ALGR mode $mode sel src $src dst $dst"
 		tst_rhost_run -s -c "ip xfrm state add src $dst dst $src \
-			spi $spi_2 proto $proto $ALGR mode $mode sel \
-			src $dst dst $src"
+			spi $spi_2 $p $ALGR mode $mode sel src $dst dst $src"
 
 		tst_rhost_run -s -c "ip xfrm policy add src $src dst $dst \
-			dir out tmpl src $src dst $dst proto $proto mode $mode"
+			dir out tmpl src $src dst $dst $p mode $mode"
 		tst_rhost_run -s -c "ip xfrm policy add src $dst dst $src dir \
-			in tmpl src $dst dst $src proto $proto \
-			mode $mode level use"
+			in tmpl src $dst dst $src $p mode $mode level use"
 	fi
 }
 
@@ -191,6 +218,8 @@ tst_ipsec_vti()
 	local vti=$4
 	local m="mode $IPSEC_MODE"
 	local p="proto $IPSEC_PROTO"
+	[ "$IPSEC_PROTO" = "esp_aead" ] && p="proto esp"
+
 	local key="key $VTI_KEY"
 	local mrk="mark $VTI_KEY"
 	local type="type vti$TST_IPV6"
-- 
1.7.1

