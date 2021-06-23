From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 23 Jun 2021 09:15:41 +0200
Subject: [LTP] [PATCH 2/3] cpuset_regression_test: Drop min cpu requirement
In-Reply-To: <20210623071543.171021-1-lkml@jv-coder.de>
References: <20210623071543.171021-1-lkml@jv-coder.de>
Message-ID: <20210623071543.171021-3-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The bug can also be reproduced with only one cpu.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../controllers/cpuset/cpuset_regression_test.sh  | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index 1dda19704..369fbedae 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -27,13 +27,6 @@ old_cpu_exclusive_value=1
 
 setup()
 {
-	local cpu_num
-
-	cpu_num=$(tst_getconf _NPROCESSORS_ONLN)
-	if [ $cpu_num -lt 2 ]; then
-		tst_brk TCONF "We need 2 cpus at least to have test"
-	fi
-
 	if ! is_cgroup_subsystem_available_and_enabled "cpuset"; then
 		tst_brk TCONF "Either kernel does not support cpuset controller or feature not enabled"
 	fi
@@ -101,12 +94,12 @@ test()
 	fi
 
 	# This may trigger the kernel crash
-	echo 0-1 > ${root_cpuset_dir}/testdir/${cpus}
-	[ $? -ne 0 ] && tst_brk TFAIL "'echo 0-1 > ${root_cpuset_dir}/testdir/${cpus}' failed"
+	echo 0 > ${root_cpuset_dir}/testdir/${cpus}
+	[ $? -ne 0 ] && tst_brk TFAIL "'echo 0 > ${root_cpuset_dir}/testdir/${cpus}' failed"
 
 	cpus_value=$(cat ${root_cpuset_dir}/testdir/${cpus})
-	if [ "${cpus_value}" != "0-1" ]; then
-		tst_brk TFAIL "${cpus} is '${cpus_value}', expected '0-1'"
+	if [ "${cpus_value}" != "0" ]; then
+		tst_brk TFAIL "${cpus} is '${cpus_value}', expected '0'"
 	fi
 
 	tst_res TPASS "Bug is not reproducible"
-- 
2.25.1

