From: Yixin Zhang <yixin.zhang@intel.com>
Date: Sat, 12 May 2018 04:16:38 +0800
Subject: [LTP] [PATCH ltp] connectors/connector_test.sh: Return 32 for TCONF
Message-ID: <20180511201638.20872-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/connectors/connector_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/connectors/connector_test.sh b/testcases/kernel/connectors/connector_test.sh
index 0742a1b78..f92e10b85 100644
--- a/testcases/kernel/connectors/connector_test.sh
+++ b/testcases/kernel/connectors/connector_test.sh
@@ -2,7 +2,7 @@
 
 if [ ! -f /proc/net/connector ];then
 	echo "Connectors 0 CONF : system doesn't support execution of the test"
-	exit 0
+	exit 32
 fi
 
 $LTPROOT/testcases/bin/run_pec_test
-- 
2.14.1

