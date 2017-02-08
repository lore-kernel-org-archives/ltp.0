From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  8 Feb 2017 15:44:57 +0100
Subject: [LTP] [PATCH v2 1/4] network: Add 'net.' prefix to TI-RPC and
	TS-RPC tests files
Message-ID: <20170208144500.27340-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/{rpc_tests => net.rpc_tests}     | 0
 runtest/{tirpc_tests => net.tirpc_tests} | 0
 testcases/network/rpc/rpc-tirpc/README   | 4 ++--
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename runtest/{rpc_tests => net.rpc_tests} (100%)
 rename runtest/{tirpc_tests => net.tirpc_tests} (100%)

diff --git a/runtest/rpc_tests b/runtest/net.rpc_tests
similarity index 100%
rename from runtest/rpc_tests
rename to runtest/net.rpc_tests
diff --git a/runtest/tirpc_tests b/runtest/net.tirpc_tests
similarity index 100%
rename from runtest/tirpc_tests
rename to runtest/net.tirpc_tests
diff --git a/testcases/network/rpc/rpc-tirpc/README b/testcases/network/rpc/rpc-tirpc/README
index d87024c41..139162751 100644
--- a/testcases/network/rpc/rpc-tirpc/README
+++ b/testcases/network/rpc/rpc-tirpc/README
@@ -44,8 +44,8 @@ The sources here are modified a bit to use the LTP wrapper - rpc_test.sh -
 instead of a bunch of scripts from the above web page.
 
 The basic group of test cases can be executed from
- * runtest/rpc_tests - for TS-RPC testing
- * runtest/tirpc_tests - for TI-RPC testing
+ * runtest/net.rpc_tests - for TS-RPC testing
+ * runtest/net.tirpc_tests - for TI-RPC testing
 using the LTP framework (ltp-pan, runltp and etc).
 
 Additional test cases (like stress, complex and etc) are to be integrated.
-- 
2.11.0

