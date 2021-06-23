From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 23 Jun 2021 09:15:42 +0200
Subject: [LTP] [PATCH 3/3] cpuset_regression_test: Allow running,
 if groups exist
In-Reply-To: <20210623071543.171021-1-lkml@jv-coder.de>
References: <20210623071543.171021-1-lkml@jv-coder.de>
Message-ID: <20210623071543.171021-4-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Even if groups with a set cpuset.cpus exist, the original bug can still be
in the kernel. It was possible to create a group, set cpuset.cpus and only
then set cpuset.cpu_exclusive to 1. This did not trigger the bug.

This patche sets cpuset.cpus for all groups to an empty value, before
running the test and resets them to their original value after the test.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../cpuset/cpuset_regression_test.sh          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index 369fbedae..de1d6e649 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -19,12 +19,54 @@ TST_MIN_KVER="3.18"
 . cgroup_lib.sh
 
 LOCAL_MOUNTPOINT="cpuset_test"
+BACKUP_DIRECTORY="cpuset_backup"
 
 root_cpuset_dir=
 cpu_exclusive="cpuset.cpu_exclusive"
 cpus="cpuset.cpus"
 old_cpu_exclusive_value=1
 
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
+	local old_dir=$PWD
+
+	cd ${root_cpuset_dir}
+	find . -mindepth 2 -name ${what} -print0 |
+	while IFS= read -r -d '' file; do
+		mkdir -p "$(dirname "${backup_dir}/${file}")"
+		cat "${file}" > "${backup_dir}/${file}"
+		echo "${value}" > "${file}"
+	done
+
+	cd $old_dir
+}
+
+# cpuset_restore <backup_dir> <what>
+# Restores the value of a file (<what>) in all cpuset
+# groups from the backup created by cpuset_backup_and_update
+cpuset_restore()
+{
+	local backup_dir=$1
+	local what=$2
+	local old_dir=$PWD
+
+	cd ${backup_dir}
+	find . -mindepth 2 -name ${what} -print0 |
+	while IFS= read -r -d '' file; do
+		cat "${file}" > "${root_cpuset_dir}/${file}"
+	done
+
+	cd $old_dir
+}
+
 setup()
 {
 	if ! is_cgroup_subsystem_available_and_enabled "cpuset"; then
@@ -49,6 +91,11 @@ setup()
 		tst_brk TBROK "Both cpuset.cpu_exclusive and cpu_exclusive do not exist"
 	fi
 
+	# Ensure that no group explicitely uses a cpu,
+	# otherwise setting cpuset.cpus for the testgroup will fail
+	mkdir ${BACKUP_DIRECTORY}
+	cpuset_backup_and_update "${PWD}/${BACKUP_DIRECTORY}" ${cpus} ""
+
 	old_cpu_exclusive_value=$(cat ${root_cpuset_dir}/${cpu_exclusive})
 	if [ "${old_cpu_exclusive_value}" != "1" ];then
 		echo 1 > ${root_cpuset_dir}/${cpu_exclusive}
@@ -62,6 +109,10 @@ cleanup()
 		rmdir ${root_cpuset_dir}/testdir
 	fi
 
+	if [ -d "${BACKUP_DIRECTORY}" ]; then
+		cpuset_restore "${PWD}/${BACKUP_DIRECTORY}" ${cpus}
+	fi
+
 	if [ "$old_cpu_exclusive_value" != 1 ]; then
 		# Need to flush, or write may fail with: "Device or resource busy"
 		sync
-- 
2.25.1

