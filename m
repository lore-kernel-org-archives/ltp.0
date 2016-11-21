From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 21 Nov 2016 21:53:00 +0100
Subject: [LTP] [PATCH v2 1/1] testcases: bashisms: s/==/=/
Message-ID: <20161121205300.28375-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixed also for scripts with bash shebang

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
v2: using test -z comparator (portability)
---
 testcases/commands/fileutils/mv/mv_tests.sh                    |  2 +-
 testcases/kernel/controllers/cgroup/cgroup_regression_test.sh  |  2 +-
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh     |  6 +++---
 testcases/kernel/controllers/cpuset/cpuset_regression_test.sh  |  2 +-
 testcases/kernel/fs/acl/tacl_xattr.sh                          | 10 +++++-----
 .../ext4-inode-version/ext4_get_inode_version.sh               |  2 +-
 .../ext4-journal-checksum/ext4_journal_checksum.sh             |  4 ++--
 .../ext4-uninit-groups/ext4_uninit_groups_test.sh              |  2 +-
 testcases/realtime/func/periodic_cpu_load/mixed_load.sh        |  2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/testcases/commands/fileutils/mv/mv_tests.sh b/testcases/commands/fileutils/mv/mv_tests.sh
index 66f4056..7b5ef46 100755
--- a/testcases/commands/fileutils/mv/mv_tests.sh
+++ b/testcases/commands/fileutils/mv/mv_tests.sh
@@ -169,7 +169,7 @@ test02()
 			       "backup file2."
 	fi
 
-	if [ "$MD5_old" == "$MD5_backup" -a -f "tmpfile2~" ]; then
+	if [ "$MD5_old" = "$MD5_backup" -a -f "tmpfile2~" ]; then
 		tst_resm TPASS "Test #2: mv -b success"
 	else
 		tst_resm TFAIL "Test #2: mv -b failed"
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index abd780f..5856726 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -277,7 +277,7 @@ test_5()
 
 	mkdir cgroup/0
 	# Otherwise we can't attach task
-	if [ "$subsys1" == cpuset -o "$subsys2" == cpuset ]; then
+	if [ "$subsys1" = cpuset -o "$subsys2" = cpuset ]; then
 		echo 0 > cgroup/0/cpuset.cpus 2> /dev/null
 		echo 0 > cgroup/0/cpuset.mems 2> /dev/null
 	fi
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index 13e2938..2c8dfd3 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -34,7 +34,7 @@ exist_subsystem()
     local subsystem="$1"
     local exist=`grep -w $subsystem /proc/cgroups | cut -f1`
 
-    if [ "$exist" = "" ]; then
+    if [ -z "$exist" ]; then
         tst_brkm TCONF "Subsystem $subsystem not supported"
     fi
 }
@@ -68,7 +68,7 @@ create_subgroup()
 
     # cpuset.cpus and cpuset.mems must be initialized with suitable value
     # before any pids are attached
-    if [ "$subsystem" == "cpuset" ]; then
+    if [ "$subsystem" = "cpuset" ]; then
         if [ -e "$mount_point/cpus" ]; then
             ROD cat "$mount_point/cpus" \> "$path/cpus"
             ROD cat "$mount_point/mems" \> "$path/mems"
@@ -95,7 +95,7 @@ setup()
 
     mount_point=`grep -w $subsystem /proc/mounts | cut -f 2 | cut -d " " -f2`
 
-    if [ "$mount_point" == "" ]; then
+    if [ -z "$mount_point" ]; then
         try_umount=1
         mount_point="/dev/cgroup"
 	tst_resm TINFO "Subsystem $subsystem is not mounted, mounting it at $mount_point"
diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index 0c7b6cf..5a8083f 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -96,7 +96,7 @@ cleanup()
 		     ${root_cpuset_dir}/${cpu_exclusive}
 	fi
 
-	if [ "${mount_flag}" == "1" ]; then
+	if [ "${mount_flag}" = "1" ]; then
 		umount ${root_cpuset_dir}
 		if [ $? -ne 0 ]; then
 			tst_resm TWARN "'umount ${root_cpuset_dir}' failed"
diff --git a/testcases/kernel/fs/acl/tacl_xattr.sh b/testcases/kernel/fs/acl/tacl_xattr.sh
index b42b665..039bd17 100755
--- a/testcases/kernel/fs/acl/tacl_xattr.sh
+++ b/testcases/kernel/fs/acl/tacl_xattr.sh
@@ -667,11 +667,11 @@ USER_PERMISSION=`echo $CONTENT | awk '{print \$10}'`
 GROUP_PERMISSION=`echo $CONTENT | awk '{print \$12}'`
 OTHER_PERMISSION=`echo $CONTENT | awk '{print \$15}'`
 
-if [ $USER_PERMISSION == "user::rwx" ]
+if [ $USER_PERMISSION = "user::rwx" ]
 then
-	if [ $GROUP_PERMISSION == "group::rwx" ]
+	if [ $GROUP_PERMISSION = "group::rwx" ]
 	then
-		if [ $OTHER_PERMISSION == "other::rwx" ]
+		if [ $OTHER_PERMISSION = "other::rwx" ]
 		then
 			echo ""
 			echo "SUCCESS: Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are correct"
@@ -702,9 +702,9 @@ CONTENT=`getfacl tacl/mount-ext2/shared/team1/newfile2`
 ITEM_OWNER=`echo $CONTENT | awk '{print \$6}'`
 ITEM_GROUP=`echo $CONTENT | awk '{print \$9}'`
 
-if [ $ITEM_OWNER == "tacluser2" ]
+if [ $ITEM_OWNER = "tacluser2" ]
 then
-	if [ $ITEM_GROUP == "tacluser2" ]
+	if [ $ITEM_GROUP = "tacluser2" ]
 	then
 		echo ""
 		echo "SUCCESS: Chown correct"
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh
index d45d6d3..5c89b23 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_get_inode_version.sh
@@ -33,7 +33,7 @@ inode_version=`echo $inode_version | sed 's/://'`
 
 inode_version=$(( $inode_version ))
 
-if [ "$2" == "1" ]; then
+if [ "$2" = "1" ]; then
 	exit $inode_version
 else
 	echo $inode_version
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
index c776fc9..87eb90b 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
@@ -40,12 +40,12 @@ ext4_test_journal_checksum()
 	local checksum=
 	local async_commit=
 
-	if [ "$3" == "" ]; then
+	if [ -z "$3" ]; then
 		checksum="No use"
 	else
 		checksum="Used"
 	fi
-	if [ "$4" == "" ]; then
+	if [ -z "$4" ]; then
 		async_commit="No use"
 	else
 		async_commit="Used"
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
index c8de206..4db846a 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
@@ -72,7 +72,7 @@ ext4_test_uninit_groups()
 		return
 	fi
 
-	if [ $3 == "no_flex_bg" ]; then
+	if [ "$3" = "no_flex_bg" ]; then
 		flag=""
 	else
 		flag=$3
diff --git a/testcases/realtime/func/periodic_cpu_load/mixed_load.sh b/testcases/realtime/func/periodic_cpu_load/mixed_load.sh
index 931d18f..3623427 100644
--- a/testcases/realtime/func/periodic_cpu_load/mixed_load.sh
+++ b/testcases/realtime/func/periodic_cpu_load/mixed_load.sh
@@ -124,7 +124,7 @@ function pass_criteria() {
 # Parse args
 JVM_ARG=""
 JVM_STATUS="Disabled"
-if [ "$1" == "-j" ]; then
+if [ "$1" = "-j" ]; then
     JVM_ARG="-j"
     JVM_STATUS="Enabled"
 fi
-- 
2.10.2

