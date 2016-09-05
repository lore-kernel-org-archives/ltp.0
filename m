From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  5 Sep 2016 17:24:11 +0200
Subject: [LTP] [PATCH V2 2/6] memcg_lib.sh: Move all the kill -s XXX to
	functions
In-Reply-To: <1473089055-17782-1-git-send-email-chrubis@suse.cz>
References: <1473089055-17782-1-git-send-email-chrubis@suse.cz>
Message-ID: <1473089055-17782-2-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit adds two functions:

* signal_memcg_process
   which asks the memcg_process to allocate/free memory and waits for
   completion

* stop_memcg_process
   which sends SIGINT to the memcg_process and waits for the pid

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../memcg/functional/memcg_function_test.sh        | 10 ++-
 .../controllers/memcg/functional/memcg_lib.sh      | 75 +++++++++++-----------
 2 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index 5ee63a9..1bb75d0 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -211,14 +211,13 @@ testcase_29()
 	pid=$!
 	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
-	kill -s USR1 $pid 2> /dev/null
-	sleep 1
+	signal_memcg_process $pid
 	echo $pid > ../tasks
 
 	# This expects that there is swap configured
 	EXPECT_PASS echo 1 \> memory.force_empty
 
-	kill -s INT $pid 2> /dev/null
+	stop_memcg_process $pid
 }
 
 testcase_30()
@@ -227,12 +226,11 @@ testcase_30()
 	pid=$!
 	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
-	kill -s USR1 $pid 2> /dev/null
-	sleep 1
+	signal_memcg_process $pid
 
 	EXPECT_FAIL echo 1 \> memory.force_empty
 
-	kill -s INT $pid 2> /dev/null
+	stop_memcg_process $pid
 }
 
 testcase_31()
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 352960b..26d2783 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -87,15 +87,27 @@ check_mem_stat()
 	fi
 }
 
+signal_memcg_process()
+{
+	pid=$1
+	kill -s USR1 $pid 2> /dev/null
+	sleep 1
+}
+
+stop_memcg_process()
+{
+	pid=$1
+	kill -s INT $pid 2> /dev/null
+	wait $pid
+}
+
 warmup()
 {
 	pid=$1
 
 	tst_resm TINFO "Warming up pid: $pid"
-	kill -s USR1 $pid 2> /dev/null
-	sleep 1
-	kill -s USR1 $pid 2> /dev/null
-	sleep 1
+	signal_memcg_process $pid
+	signal_memcg_process $pid
 
 	kill -0 $pid
 	if [ $? -ne 0 ]; then
@@ -128,18 +140,16 @@ test_mem_stat()
 	fi
 
 	echo $! > tasks
-	kill -s USR1 $! 2> /dev/null
-	sleep 1
+	signal_memcg_process $!
 
 	check_mem_stat $3 $4
 
-	kill -s USR1 $! 2> /dev/null
-	sleep 1
+	signal_memcg_process $!
 	if [ $5 -eq 1 ]; then
 		check_mem_stat $3 0
 	fi
 
-	kill -s INT $! 2> /dev/null
+	stop_memcg_process $!
 }
 
 # Run test cases which checks memory.max_usage_in_bytes after make
@@ -161,11 +171,8 @@ test_max_usage_in_bytes()
 	fi
 
 	echo $! > tasks
-	kill -s USR1 $! 2> /dev/null
-	sleep 1
-
-	kill -s USR1 $! 2> /dev/null
-	sleep 1
+	signal_memcg_process $!
+	signal_memcg_process $!
 
 	check_mem_stat $3 $4
 
@@ -174,7 +181,7 @@ test_max_usage_in_bytes()
 		check_mem_stat $3 0
 	fi
 
-	kill -s INT $! 2> /dev/null
+	stop_memcg_process $!
 }
 
 # make some memory allocation
@@ -187,13 +194,10 @@ malloc_free_memory()
 	TST_CHECKPOINT_WAIT 0
 
 	echo $! > tasks
-	kill -s USR1 $! 2> /dev/null
-	sleep 1
-
-	kill -s USR1 $! 2> /dev/null
-	sleep 1
+	signal_memcg_process $!
+	signal_memcg_process $!
 
-	kill -s INT $! 2> /dev/null
+	stop_memcg_process $!
 }
 
 # Test if failcnt > 0, which means page reclamation occured
@@ -230,7 +234,7 @@ test_proc_kill()
 	TST_CHECKPOINT_WAIT 0
 	echo $pid > tasks
 
-	kill -s USR1 $pid 2> /dev/null
+	signal_memcg_process $pid
 
 	tpk_pid_exists=1
 	for tpk_iter in $(seq 20); do
@@ -254,7 +258,7 @@ test_proc_kill()
 			tst_resm TPASS "process $pid is killed"
 		fi
 	else
-		kill -s INT $pid 2> /dev/null
+		stop_memcg_process $!
 		tst_resm TFAIL "process $pid is not killed"
 	fi
 }
@@ -307,8 +311,7 @@ test_hugepage()
 	memcg_process $2 --hugepage -s $3 > $TMP_FILE 2>&1 &
 	TST_CHECKPOINT_WAIT 0
 
-	kill -s USR1 $! 2> /dev/null
-	sleep 1
+	signal_memcg_process $!
 
 	check_mem_stat "rss" 0
 
@@ -320,15 +323,15 @@ test_hugepage()
 		if [ $? -eq 0 ]; then
 			tst_resm TPASS "allocate hugepage failed as expected"
 		else
-			kill -s USR1 $! 2> /dev/null
-			kill -s INT $! 2> /dev/null
+			signal_memcg_process $!
+			stop_memcg_process $!
 			tst_resm TFAIL "allocate hugepage should fail"
 		fi
 	else
 		test ! -s $TMP_FILE
 		if [ $? -eq 0 ]; then
-			kill -s USR1 $! 2> /dev/null
-			kill -s INT $! 2> /dev/null
+			signal_memcg_process $!
+			stop_memcg_process $!
 			tst_resm TPASS "allocate hugepage succeeded"
 		else
 			tst_resm TFAIL "allocate hugepage failed"
@@ -361,8 +364,7 @@ test_subgroup()
 	fi
 
 	echo $! > tasks
-	kill -s USR1 $! 2> /dev/null
-	sleep 1
+	signal_memcg_process $!
 	check_mem_stat "rss" $PAGESIZE
 
 	cd subgroup
@@ -372,8 +374,7 @@ test_subgroup()
 	# cleanup
 	cd ..
 	echo $! > tasks
-	kill -s INT $! 2> /dev/null
-	sleep 1
+	stop_memcg_process $!
 	rmdir subgroup
 }
 
@@ -397,8 +398,7 @@ test_move_charge()
 	fi
 
 	echo $! > subgroup_a/tasks
-	kill -s USR1 $!
-	sleep 1
+	signal_memcg_process $!
 
 	mkdir subgroup_b
 	echo $3 > subgroup_b/memory.move_charge_at_immigrate
@@ -413,9 +413,8 @@ test_move_charge()
 
 	cd ..
 	echo $! > tasks
-	kill -s USR1 $!
-	kill -s INT $!
-	sleep 1
+	signal_memcg_process $!
+	stop_memcg_process $!
 	rmdir subgroup_a subgroup_b
 }
 
-- 
2.7.3

