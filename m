From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 11 Jul 2018 13:29:22 +0100
Subject: [LTP] [PATCH 1/4] controllers/cgroup_fj_common.sh: Check for
	dependencies during setup
In-Reply-To: <20180711122925.24278-1-punit.agrawal@arm.com>
References: <20180711122925.24278-1-punit.agrawal@arm.com>
Message-ID: <20180711122925.24278-2-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

cgroup_fj_common.sh uses 'killall' in cleanup but doesn't check for it
during setup. Add killall as an explicit dependency to bail out on
systems where it's not available.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index 907881ca8..e163e5394 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -83,6 +83,7 @@ create_subgroup()
 setup()
 {
     tst_require_root
+    tst_check_cmds killall
 
     if [ ! -f /proc/cgroups ]; then
         tst_brkm TCONF "Kernel does not support for control groups"
-- 
2.17.1

