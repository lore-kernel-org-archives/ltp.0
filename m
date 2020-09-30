From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Sep 2020 12:28:54 +0200
Subject: [LTP] [PATCH v2 1/2] vxlan0{3,4}.sh: Fix exit on error
Message-ID: <20200930102855.5967-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

we need return, continue was for original loop (in vxlan03.sh regression
from f275363d7, then copy pasted to vxlan04.sh).

Fixes: f275363d7 ("net/{stress,virt}: Migrate virt_lib.sh, ipsec_lib.sh + tests using them")
Fixes: 503b1cb1e ("network: add new gre02, geneve02, macsec03 and vxlan04 tests")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/virt/vxlan03.sh | 2 +-
 testcases/network/virt/vxlan04.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 9ca303930..ef66a57fe 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -40,7 +40,7 @@ do_test()
 		tst_brk TBROK "you must specify IP address"
 	fi
 
-	virt_check_cmd virt_add ltp_v0 id 0 $2 || continue
+	virt_check_cmd virt_add ltp_v0 id 0 $2 || return
 
 	tst_res TINFO "the same VNI must work"
 	# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
diff --git a/testcases/network/virt/vxlan04.sh b/testcases/network/virt/vxlan04.sh
index 0351ea80f..a59b1183f 100755
--- a/testcases/network/virt/vxlan04.sh
+++ b/testcases/network/virt/vxlan04.sh
@@ -24,7 +24,7 @@ do_test()
 		tst_brk TBROK "you must specify IP address"
 	fi
 
-	virt_check_cmd virt_add ltp_v0 id 0 $2 || continue
+	virt_check_cmd virt_add ltp_v0 id 0 $2 || return
 
 	tst_res TINFO "the same VNI must work"
 	# VNI is 24 bits long, so max value, which is not reserved, is 0xFFFFFE
-- 
2.28.0

