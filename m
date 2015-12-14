From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 14 Dec 2015 15:57:45 +0800
Subject: [LTP] [PATCH] cgroup_fj/cgroup_fj_stress.sh: Fix failures on cgroup
	unmounted case
Message-ID: <1450079865-4596-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test fails when cgroup subsystem is not mounted beforehand because of
the misused "mounted" in setup(), which doesn't represent the current
mount status exactly but the mount status before the test, so fix this.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh  | 3 ---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh | 7 +++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index 88cf735..3b53b63 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -194,9 +194,6 @@ if [ $mount_times -ne 1 ]; then
 		setup;
 		$TESTROOT/cgroup_fj_proc &
 		pid=$!
-		if [ $mounted -ne 1 ]; then
-			mount_cgroup;
-		fi
 		mkdir_subgroup;
 		if [ "$subsystem" == "cpuset" ]; then
 			if [ "$exist_cpuset" != "" ]; then
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
index c035498..8daf8d6 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
@@ -430,15 +430,18 @@ setup()
 
 	if [ "$mount_point" == "" ]; then
 		mounted=0
+		mounted_now=0
 		mount_point=/dev/cgroup
+	else
+		mounted_now=1
 	fi
 
-	if [ -e $mount_point ] && [ $mounted -ne 1 ]; then
+	if [ -e $mount_point ] && [ $mounted_now -ne 1 ]; then
 		rm -rf $mount_point
 		cleanup
 	fi
 
-	if [ $mounted -ne 1 ]; then
+	if [ $mounted_now -ne 1 ]; then
 		do_mkdir 1 1 $mount_point
 		mount_cgroup
 	fi
-- 
1.8.4.2



