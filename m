From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  6 Dec 2017 15:42:13 +0100
Subject: [LTP] [RFC PATCH 1/2] network/ipsec: Add trap to INT and require
	root
Message-ID: <20171206144214.27317-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/ipsec/ipsec_lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index cee755fe0..5cc2c9a45 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -21,6 +21,9 @@
 
 . test_net.sh
 
+tst_require_root
+trap "tst_brkm TBROK 'test interrupted'" INT
+
 # Authenticated encryption with associated data
 AEALGO="rfc4106_128"
 # Encryption algorithm
-- 
2.15.0

