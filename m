From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 29 Sep 2020 10:56:06 +0800
Subject: [LTP] [PATCH] controllers/cpuset_base_ops_testset.sh: Accept either
 0 or -EINVAL when passing '0-'
Message-ID: <20200929025606.322543-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When we write '0-' to cpuset.cpus/cpuset.mems, new bitmap_parselist()
in kernel(e.g. newer than v4.2) treats it as an invalid value and old
one treats it as a valid '0':
-------------------------------------------
on v5.8.0:
 # echo 0- > cpuset.cpus
 -bash: echo: write error: Invalid argument
 # echo 0- > cpuset.mems
 -bash: echo: write error: Invalid argument

on v4.0.0:
 # echo '0-' >cpuset.cpus
 # cat cpuset.cpus
 0
 # echo '0-' >cpuset.mems
 # cat cpuset.cpus
 0
-------------------------------------------
Note: commit d9282cb66353b changes the behavior.

Drop the check of kernel version and accept either 0 or -EINVAL
because the change of behavior can be backported into old kernel.

Fixes: #695
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---

Hi Cyril, Petr, Jan, Li

Do you think it is better to remove '0-' subtest directly?

 .../cpuset_base_ops_testset.sh                | 47 ++++++++-----------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index 67f3611d7..1fa40d2d9 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -45,7 +45,7 @@ base_op_write_and_test()
 {
 	local write_file="$1"
 	local write_string="$2"
-	local expect_string="$3"
+	local expect_strings="$3"
 	local write_result=
 	local ret=0
 
@@ -59,24 +59,27 @@ base_op_write_and_test()
 	ret=$?
 	write_result="$(cat "$write_file")"
 
-	case "$expect_string" in
-	EMPTY)
-		test -z "$write_result" -a $ret = 0
-		ret=$?
-		;;
-	WRITE_ERROR)
-		ret=$((!$ret))
-		;;
-	*)
-		test "$expect_string" = "$write_result" -a $ret = 0
-		ret=$?
-		;;
-	esac
+	for expect_string in $(echo $expect_strings | sed 's/|/ /'); do
+		case "$expect_string" in
+		EMPTY)
+			test -z "$write_result" -a $ret = 0
+			ret=$?
+			;;
+		WRITE_ERROR)
+			ret=$((!$ret))
+			;;
+		*)
+			test "$expect_string" = "$write_result" -a $ret = 0
+			ret=$?
+			;;
+		esac
+		[ $ret -eq 0 ] && break
+	done
 
 	if [ $ret -eq 0 ]; then
 		tst_resm TPASS "$cfile_name: Get the expected string"
 	else
-		tst_resm TFAIL "$cfile_name: Test result - $write_result Expected string - \"$expect_string\""
+		tst_resm TFAIL "$cfile_name: Test result - $write_result Expected string - \"$expect_strings\""
 	fi
 	return $ret
 }
@@ -114,6 +117,7 @@ test_cpus()
 		${cpus_all}$nr_cpus			WRITE_ERROR
 		0,0					0
 		0-0					0
+		0-					0|WRITE_ERROR
 		0-$((nr_cpus-1))			0-$((nr_cpus-1))
 		-1					WRITE_ERROR
 		0-$nr_cpus				WRITE_ERROR
@@ -127,12 +131,6 @@ test_cpus()
 		base_op_test "$CPUSET/1/cpuset.cpus" "0,1-$((nr_cpus-2)),$((nr_cpus-1))" "0-$((nr_cpus-1))"
 		base_op_test "$CPUSET/1/cpuset.cpus" "0,1-$((nr_cpus-2))," "0-$((nr_cpus-2))"
 	fi
-
-	if tst_kvcmp -lt "3.0 RHEL6:2.6.32"; then
-		base_op_test "$CPUSET/1/cpuset.cpus" "0-" "WRITE_ERROR"
-	else
-		base_op_test "$CPUSET/1/cpuset.cpus" "0-" "0"
-	fi
 }
 
 test_mems()
@@ -149,6 +147,7 @@ test_mems()
 		${mems_all}$nr_mems			WRITE_ERROR
 		0,0					0
 		0-0					0
+		0-					0|WRITE_ERROR
 		0-$((nr_mems-1))			0-$((nr_mems-1))
 		-1					WRITE_ERROR
 		0-$nr_mems				WRITE_ERROR
@@ -162,12 +161,6 @@ test_mems()
 		base_op_test "$CPUSET/1/cpuset.mems" "0,1-$((nr_mems-2)),$((nr_mems-1))" "0-$((nr_mems-1))"
 		base_op_test "$CPUSET/1/cpuset.mems" "0,1-$((nr_mems-2))," "0-$((nr_mems-2))"
 	fi
-
-	if tst_kvcmp -lt "3.0 RHEL6:2.6.32"; then
-		base_op_test "$CPUSET/1/cpuset.mems" "0-" "WRITE_ERROR"
-	else
-		base_op_test "$CPUSET/1/cpuset.mems" "0-" "0"
-	fi
 }
 
 test_flags()
-- 
2.25.1



