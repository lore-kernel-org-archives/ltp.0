From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 30 Nov 2020 10:06:06 +0800
Subject: [LTP] [PATCH] cpuset_inherit: Use the original mem value instead of
 N_NODES
Message-ID: <1606701966-1596-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since ltp commit cf33086a1ca, we add cgroup.clone_children switch for
cpuset.cpus and mems, we used the original memory value to set in cpuset_inherit case.

After ltp commit 6872ad15a, we improve the node number calculation for N_NODES,
so it can calculate for N_NODES obtained from the file contains only "0,8".

But it doesn't think about this patch will affect mem_string value, so this
cpuset_inherit case will fail on 4 numa nodes pc, as below:

cpuset_inherit 1 TPASS: cpus: Inherited information is right!
cpuset_inherit 3 TPASS: cpus: Inherited information is right!
cpuset_inherit 5 TPASS: cpus: Inherited information is right!
cpuset_inherit 7 TPASS: cpus: Inherited information is right!
cpuset_inherit 9 TPASS: cpus: Inherited information is right!
cpuset_inherit 11 TPASS: cpus: Inherited information is right!
cpuset_inherit 13 TPASS: mems: Inherited information is right!
cpuset_inherit 15 TPASS: mems: Inherited information is right!
cpuset_inherit 17 TPASS: mems: Inherited information is right!
cpuset_inherit 19 TPASS: mems: Inherited information is right!
cpuset_inherit 21 TPASS: mems: Inherited information is right!
cpuset_inherit 23 TFAIL: mems: Test result - 0-3 Expected string - "4"

Fix this by using original mem value.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/controllers/cpuset/cpuset_funcs.sh        | 7 +++----
 .../cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh   | 6 ++----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index f4365af2c..b469140ca 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -28,10 +28,11 @@
 
 NR_CPUS=`tst_ncpus`
 if [ -f "/sys/devices/system/node/has_high_memory" ]; then
-	N_NODES="`cat /sys/devices/system/node/has_high_memory | tr ',' ' '`"
+	mem_string="`cat /sys/devices/system/node/has_high_memory`"
 else
-	N_NODES="`cat /sys/devices/system/node/has_normal_memory | tr ',' ' '`"
+	mem_string="`cat /sys/devices/system/node/has_normal_memory`"
 fi
+N_NODES="`echo $mem_string | tr ',' ' '`"
 count=0
 for item in $N_NODES; do
 	delta=1
@@ -42,8 +43,6 @@ for item in $N_NODES; do
 done
 N_NODES=$count
 
-mem_string="$N_NODES"
-
 CPUSET="/dev/cpuset"
 CPUSET_TMP="/tmp/cpuset_tmp"
 CLONE_CHILDREN="/dev/cpuset/cgroup.clone_children"
diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
index 73eed2cb9..27ff19532 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
@@ -31,10 +31,8 @@ export TST_COUNT=1
 check 1 1
 
 nr_cpus=$NR_CPUS
-nr_mems=$N_NODES
 
 cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
-mems_all="$(seq -s, 0 $((nr_mems-1)))"
 
 exit_status=0
 
@@ -134,10 +132,10 @@ test_mems()
 	done <<- EOF
 		0	NULL					EMPTY
 		0	0					EMPTY
-		0	$mems_all				EMPTY
+		0	$mem_string				EMPTY
 		1	NULL					EMPTY
 		1	0					0
-		1	$mems_all				$mem_string
+		1	$mems_string				$mem_string
 	EOF
 	# while read mems result
 }
-- 
2.23.0



