From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Aug 2018 18:23:46 +0300
Subject: [LTP] [PATCH RFC 4/4] network/ipsec: replace ipsec_try() with
	TST_RTNL_CHK()
In-Reply-To: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1533828226-24753-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/ipsec/ipsec_lib.sh |   21 +++------------------
 1 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index aedba9b..f850166 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -157,21 +157,6 @@ ipsec_set_algoline()
 	esac
 }
 
-ipsec_try()
-{
-	local output="$($@ 2>&1 || echo 'TERR')"
-
-	if echo "$output" | grep -q "TERR"; then
-		echo "$output" | grep -q \
-			'RTNETLINK answers: Function not implemented' && \
-			tst_brk TCONF "'$@': not implemented"
-		echo "$output" | grep -q \
-			'RTNETLINK answers: Operation not supported' && \
-			tst_brk TCONF "'$@': not supported (maybe missing 'ip${TST_IPV6}_vti' kernel module)"
-		tst_brk TBROK "$@ failed: $output"
-	fi
-}
-
 # tst_ipsec target src_addr dst_addr: config ipsec
 #
 # target: target of the configuration host ( lhost / rhost )
@@ -195,7 +180,7 @@ tst_ipsec()
 	if [ $target = lhost ]; then
 		local spi_1="0x$SPI"
 		local spi_2="0x$(( $SPI + 1 ))"
-		ipsec_try ip xfrm state add src $src dst $dst spi $spi_1 \
+		TST_RTNL_CHK xfrm state add src $src dst $dst spi $spi_1 \
 			$p $ALG mode $mode sel src $src dst $dst
 		ROD ip xfrm state add src $dst dst $src spi $spi_2 \
 			$p $ALG mode $mode sel src $dst dst $src
@@ -257,12 +242,12 @@ tst_ipsec_vti()
 	cleanup_vti=$vti
 
 	if [ $target = lhost ]; then
-		ipsec_try ip li add $vti $type local $src remote $dst $key $d
+		TST_RTNL_CHK ip li add $vti $type local $src remote $dst $key $d
 		ROD ip li set $vti up
 
 		local spi_1="spi 0x$SPI"
 		local spi_2="spi 0x$(( $SPI + 1 ))"
-		ipsec_try $ipx st add $o_dir $p $spi_1 $ALG $m
+		TST_RTNL_CHK $ipx st add $o_dir $p $spi_1 $ALG $m
 		ROD $ipx st add $i_dir $p $spi_2 $ALG $m
 		ROD $ipx po add dir out tmpl $o_dir $p $m $mrk
 		ROD $ipx po add dir in tmpl $i_dir $p $m $mrk
-- 
1.7.1

