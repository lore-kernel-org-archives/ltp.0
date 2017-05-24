From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 24 May 2017 18:02:49 +0800
Subject: [LTP] [PATCH] controllers/cgroup_fj_common.sh: Fix mountpoint
	mismatch
Message-ID: <1495620169-25851-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Only grepping subsystem name in /proc/cgroups may lead to mismatch, e.g.
grep -w debug /proc/mounts will wrongly return debugfs /sys/kernel/debug
debugfs as well, so fix this by adding a grep for "cgroup".

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index 2c8dfd3..907881c 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -93,7 +93,8 @@ setup()
     tst_tmpdir
     TST_CLEANUP=cleanup
 
-    mount_point=`grep -w $subsystem /proc/mounts | cut -f 2 | cut -d " " -f2`
+    mount_point=`grep -w $subsystem /proc/mounts | grep -w "cgroup" | \
+	cut -f 2 | cut -d " " -f2`
 
     if [ -z "$mount_point" ]; then
         try_umount=1
-- 
1.8.4.2



