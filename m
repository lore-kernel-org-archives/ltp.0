From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 11 Jan 2019 16:10:17 +0000
Subject: [LTP] [PATCH]  Fix cgroup_lib.sh helper
Message-ID: <20190111161017.52307-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A typo compromised get_cgroup_mountpoint() effectiveness
leading to cgroup_regression test_5 systematic failure.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 testcases/kernel/controllers/cgroup_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
index 8c19c6c3e..45ab51b87 100644
--- a/testcases/kernel/controllers/cgroup_lib.sh
+++ b/testcases/kernel/controllers/cgroup_lib.sh
@@ -16,7 +16,7 @@ get_cgroup_mountpoint()
 	[ $# -eq 0 ] && tst_brk TBROK "get_cgroup_mountpoint: subsystem not defined"
 
 	mntpoint=$(grep cgroup /proc/mounts | grep -w $subsystem | awk '{ print $2 }')
-	[ -z "$mountpoint" ] && return 1
+	[ -z "$mntpoint" ] && return 1
 
 	echo $mntpoint
 	return 0
-- 
2.17.1

