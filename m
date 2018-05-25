From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri, 25 May 2018 15:44:06 +0800
Subject: [LTP] [PATCH ltp] controllers/cpuset/cpuset_regression_test.sh: fix
	shellcheck error
Message-ID: <20180525074406.24422-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

testcases/kernel/controllers/cpuset/cpuset_regression_test.sh:89:10:error:
-n doesn't work with unquoted arguments. Quote or use [[ ]]. [SC2070]

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/controllers/cpuset/cpuset_regression_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index 4a104a3ad..249f16a76 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -86,7 +86,7 @@ cleanup()
 		rmdir ${root_cpuset_dir}/testdir
 	fi
 
-	if [ -n ${cpu_exclusive_value} -a ${cpu_exclusive_value} -ne 1 ]; then
+	if [ -n "${cpu_exclusive_value}" ] && [ ${cpu_exclusive_value} -ne 1 ]; then
 		# Need to flush, or may be output:
 		# "write error: Device or resource busy"
 		sync
-- 
2.14.1

