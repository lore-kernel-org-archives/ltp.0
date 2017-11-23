From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 23 Nov 2017 12:50:27 +0100
Subject: [LTP] [PATCH 1/1] network/ipsec: TCONF instead of TFAIL when
	operation not supported
Message-ID: <20171123115027.12966-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This happens when kernel module ip_vti resp. ip6_vti is missing.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/ipsec/ipsec_lib.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 2f10a3bd5..cee755fe0 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -168,6 +168,9 @@ ipsec_try()
 		echo "$output" | grep -q \
 			'RTNETLINK answers: Function not implemented' && \
 			tst_brkm TCONF "'$@': not implemented"
+		echo "$output" | grep -q \
+			'RTNETLINK answers: Operation not supported' && \
+			tst_brkm TCONF "'$@': not supported (maybe missing 'ip${TST_IPV6}_vti' kernel module)"
 		tst_brkm TBROK "$@ failed: $output"
 	fi
 }
@@ -257,7 +260,7 @@ tst_ipsec_vti()
 	cleanup_vti=$vti
 
 	if [ $target = lhost ]; then
-		ROD ip li add $vti $type local $src remote $dst $key $d
+		ipsec_try ip li add $vti $type local $src remote $dst $key $d
 		ROD ip li set $vti up
 
 		local spi_1="spi 0x$SPI"
-- 
2.15.0

