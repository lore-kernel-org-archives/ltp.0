From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Jun 2018 14:46:27 +0200
Subject: [LTP] [PATCH 2/2] net/icmp-uni-basic.sh: Remove LINK_NUM setup
In-Reply-To: <20180614124627.14344-1-pvorel@suse.cz>
References: <20180614124627.14344-1-pvorel@suse.cz>
Message-ID: <20180614124627.14344-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LINK_NUM should not be setup in the test.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/icmp/icmp-uni-basic.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index 5fe6b9b13..7cdf0309a 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -25,8 +25,6 @@ TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
 
-LINK_NUM=${LINK_NUM:-0}
-
 # Test description
 tst_resm TINFO "Sending ICMP messages with the following conditions"
 tst_resm TINFO "- Version of IP is IPv${TST_IPV6:-4}"
-- 
2.17.1

