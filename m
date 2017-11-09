From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  9 Nov 2017 21:48:19 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] network/ipsec: Fix parameter in help
Message-ID: <20171109204819.30533-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ipcomp is used in old network stress tests, which don't use
ipsec_lib.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/ipsec/ipsec_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index c9ef1f637..2f10a3bd5 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -40,7 +40,7 @@ while getopts "hl:m:p:s:S:k:A:e:a:c:r:6" opt; do
 		echo "h        help"
 		echo "l n      n is the number of test link when tests run"
 		echo "m x      x is ipsec mode, could be transport / tunnel"
-		echo "p x      x is ipsec protocol, could be ah / esp / ipcomp"
+		echo "p x      x is ipsec protocol, could be ah / esp / comp"
 		echo "s x      x is icmp messge size array"
 		echo "S n      n is IPsec SPI value"
 		echo "k x      key for vti interface"
-- 
2.15.0

