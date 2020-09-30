From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 30 Sep 2020 21:38:46 +0800
Subject: [LTP] [PATCH v2] controllers/cpuset_base_ops_testset.sh: Only
 verify '0-' subtest on kernel v4.3 or newer
Message-ID: <20200930133846.10034-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) According to the previous kernel check, '0-' is an invalid
   value on very old kernel(i.e. v3.0 or older).
2) '0-' becomes a valid '0' on old kernel(e.g. between v3.1 and v4.2).
3) '0-' becomes an invalid value again by commit d9282cb66353b
   on new kernel(e.g. v4.3 kernel or newer).
For example:
-------------------------------------------
On v5.8.0:
 # echo 0- > cpuset.cpus
 -bash: echo: write error: Invalid argument
 # echo 0- > cpuset.mems
 -bash: echo: write error: Invalid argument

On v4.0.0:
 # echo '0-' >cpuset.cpus
 # cat cpuset.cpus
 0
 # echo '0-' >cpuset.mems
 # cat cpuset.cpus
 0
-------------------------------------------

In this case, only verify(focus on) '0-' subtest on kernel v4.3
or newer due to two reasons:
1) It may catch a bug on mainline kernel in future.
2) It doesn't trigger any bug on old kernel currently.

Fixes: #695
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../cpuset_base_ops_test/cpuset_base_ops_testset.sh       | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index 67f3611d7..367c95d2b 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -128,10 +128,8 @@ test_cpus()
 		base_op_test "$CPUSET/1/cpuset.cpus" "0,1-$((nr_cpus-2))," "0-$((nr_cpus-2))"
 	fi
 
-	if tst_kvcmp -lt "3.0 RHEL6:2.6.32"; then
+	if tst_kvcmp -ge "4.3"; then
 		base_op_test "$CPUSET/1/cpuset.cpus" "0-" "WRITE_ERROR"
-	else
-		base_op_test "$CPUSET/1/cpuset.cpus" "0-" "0"
 	fi
 }
 
@@ -163,10 +161,8 @@ test_mems()
 		base_op_test "$CPUSET/1/cpuset.mems" "0,1-$((nr_mems-2))," "0-$((nr_mems-2))"
 	fi
 
-	if tst_kvcmp -lt "3.0 RHEL6:2.6.32"; then
+	if tst_kvcmp -ge "4.3"; then
 		base_op_test "$CPUSET/1/cpuset.mems" "0-" "WRITE_ERROR"
-	else
-		base_op_test "$CPUSET/1/cpuset.mems" "0-" "0"
 	fi
 }
 
-- 
2.25.1



