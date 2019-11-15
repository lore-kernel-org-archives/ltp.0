From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 15 Nov 2019 11:10:39 +0100
Subject: [LTP] [PATCH] cpuset_regression_test: Fix for already existing
 cpusets
Message-ID: <20191115101039.43386-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

If there are already cpusets defined on the system, that use cpu 0-1,
the test fails, because it tries to exclusively use cpu 0-1 for the
testcase.

The fix sets the cpuset for all cgroups to 0 and disables exclusive
cpu usage for the duration of the test and restores it on cleanup.
For the test only cpu 1 is set as exclusive. This is enough to
trigger the bug this regression test was designed for.
This was tested by reverting the commit mentioned in the testcase.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../cpuset/cpuset_regression_test.sh          | 58 +++++++++++++++++--
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index dccfd91cd..ed5e30f2a 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -26,6 +26,49 @@ TCID=cpuset_regression_test
 TST_TOTAL=1
 . test.sh
 
+# cpuset_backup_and_update <backup_dir> <what> <value>
+# Create backup of the values of a specific file (<what>)
+# in all cpuset groups and set the value to <value>
+# The backup is written to <backup_dir> in the same structure
+# as in the cpuset filesystem
+cpuset_backup_and_update()
+{
+	local backup_dir=$1
+	local what=$2
+	local value=$3
+	local old_dir=$(pwd)
+
+	cd ${root_cpuset_dir}
+	find . -mindepth 2 -name ${what} -print0 |
+	while IFS= read -r -d '' file; do
+		tst_resm TINFO "Backup ${file} ($(cat "${file}"))"
+		mkdir -p "$(dirname "${backup_dir}/${file}")"
+		cat "${file}" > "${backup_dir}/${file}"
+		echo "${value}" > "${file}"
+	done
+
+	cd ${old_dir}
+}
+
+# cpuset_restore <backup_dir> <what>
+# Restores the value of a file (<what>) in all cpuset
+# groups from the backup created by cpuset_backup_and_update
+cpuset_restore()
+{
+	local backup_dir=$1
+	local what=$2
+	local old_dir=$(pwd)
+
+	cd ${backup_dir}
+	find . -mindepth 2 -name ${what} -print0 |
+	while IFS= read -r -d '' file; do
+		tst_resm TINFO "Restore ${file} ($(cat "${file}"))"
+		cat "${file}" > "${root_cpuset_dir}/${file}"
+	done
+
+	cd ${old_dir}
+}
+
 setup()
 {
 	tst_require_root
@@ -69,6 +112,10 @@ setup()
 			       "do not exist."
 	fi
 
+	mkdir cpuset_backup
+	cpuset_backup_and_update "$(pwd)/cpuset_backup" ${cpu_exclusive} 0
+	cpuset_backup_and_update "$(pwd)/cpuset_backup" cpuset.cpus 0
+
 	cpu_exclusive_value=$(cat ${root_cpuset_dir}/${cpu_exclusive})
 	if [ "${cpu_exclusive_value}" != "1" ];then
 		echo 1 > ${root_cpuset_dir}/${cpu_exclusive}
@@ -86,6 +133,9 @@ cleanup()
 		rmdir ${root_cpuset_dir}/testdir
 	fi
 
+	cpuset_restore "$(pwd)/cpuset_backup" cpuset.cpus
+	cpuset_restore "$(pwd)/cpuset_backup" ${cpu_exclusive}
+
 	if [ "$cpu_exclusive_value" != 1 ]; then
 		# Need to flush, or may be output:
 		# "write error: Device or resource busy"
@@ -129,15 +179,15 @@ cpuset_test()
 	fi
 
 	# ${cpus} is empty at the begin, that maybe make the system *crash*.
-	echo 0-1 > ${root_cpuset_dir}/testdir/${cpus}
+	echo 1 > ${root_cpuset_dir}/testdir/${cpus}
 	if [ $? -ne 0 ]; then
-		tst_brkm TFAIL "'echo 0-1 >" \
+		tst_brkm TFAIL "'echo 1 >" \
 			       "${root_cpuset_dir}/testdir/${cpus}' failed"
 	fi
 
 	local cpus_value=$(cat ${root_cpuset_dir}/testdir/${cpus})
-	if [ "${cpus_value}" != "0-1" ]; then
-		tst_brkm TFAIL "${cpus} is '${cpus_value}', expected '0-1'"
+	if [ "${cpus_value}" != "1" ]; then
+		tst_brkm TFAIL "${cpus} is '${cpus_value}', expected '1'"
 	fi
 
 	tst_resm TPASS "Bug is not reproduced"
-- 
2.20.1

