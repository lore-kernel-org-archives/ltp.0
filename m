From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri, 20 Apr 2018 11:18:53 +0800
Subject: [LTP] [PATCH ltp 4/6] network/nfs/fsx-linux/fsx.sh: Fix shellcheck
	issue SC2069
In-Reply-To: <20180420031855.22657-1-yixin.zhang@intel.com>
References: <20180420031855.22657-1-yixin.zhang@intel.com>
Message-ID: <20180420031855.22657-4-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

error: The order of the 2>&1 and the redirect matters. The 2>&1 has to
be last. [SC2069]

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/network/nfs/fsx-linux/fsx.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/nfs/fsx-linux/fsx.sh b/testcases/network/nfs/fsx-linux/fsx.sh
index 473ecb2da..84ad0e204 100755
--- a/testcases/network/nfs/fsx-linux/fsx.sh
+++ b/testcases/network/nfs/fsx-linux/fsx.sh
@@ -33,7 +33,7 @@ do_test()
 {
 	ITERATIONS=${ITERATIONS:=50000}
 	tst_resm TINFO "starting fsx-linux -N $ITERATIONS..."
-	fsx-linux -N $ITERATIONS testfile 2>&1 > fsx-out.log
+	fsx-linux -N $ITERATIONS testfile > fsx-out.log 2>&1
 	if [ "$?" -ne 0 ]; then
 		tst_resm TFAIL "Errors have resulted from this test"
 		cat fsx-out.log
-- 
2.14.1

