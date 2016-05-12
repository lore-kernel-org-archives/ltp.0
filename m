From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 12 May 2016 16:14:26 +0300
Subject: [LTP] [PATCH V2 4/4] memcg_stress_test.sh: allocate less than
	CommitLimit bytes
In-Reply-To: <1463058866-17188-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1463058866-17188-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1463058866-17188-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1463058866-17188-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1463058866-17188-4-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we run this test case on a system, where the amount of
physical RAM is significantly more than the amount of swap
space (for example, 128G vs 1G), one of the memcg_process_stress
processes will invoke the OOM-killer, and the test will fail
(in the least bad case).

The key here is to find out a more generic formula instead of

mem=$(( $mem_free + $swap_free / 2 ))

Per my understanding, this test case does not require all the
memory of the system.

Given that, (CommitLimit - Committed_AS) with overcommit_memory == 1,
looks to be a suitable formula, since the kernel lets allocate this
amount of memory and there will be some memory for other tasks.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
No changes since V1.

 .../controllers/memcg/stress/memcg_stress_test.sh  |   28 ++++++++++++++++---
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index ad2fb03..2cd6ac1 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -39,6 +39,8 @@ children=""
 nr_children=0
 memcg_path=/dev/memcg
 memcg_created=0
+overcommit_path=/proc/sys/vm/overcommit_memory
+overcommit=""
 
 cleanup()
 {
@@ -54,6 +56,10 @@ cleanup()
 		umount "$memcg_path"
 		rmdir "$memcg_path"
 	fi
+
+	if is_int "$overcommit"; then
+		echo "$overcommit" > "$overcommit_path"
+	fi
 }
 TST_CLEANUP=cleanup
 
@@ -139,20 +145,32 @@ testcase_2()
 ROD echo 3 \> /proc/sys/vm/drop_caches
 sleep 2
 
-mem_free=$(awk '/MemFree/ {print $2}' /proc/meminfo)
-is_int "$mem_free" || tst_brkm TBROK "Unable to determine mem_free"
+# We enable the "always overcommit" memory policy and allocate
+# less than CommitLimit bytes. Given that no other memory-consuming
+# process should be running, this gives us a more-or-less strong
+# guarantee that our allocations will not result in an OOM situation.
+
+overcommit=$(cat "$overcommit_path")
+is_int "$overcommit" || tst_brkm TBROK "Unable to determine overcommit"
 
-swap_free=$(awk '/SwapFree/ {print $2}' /proc/meminfo)
-is_int "$swap_free" || tst_brkm TBROK "Unable to determine swap_free"
+commit_limit=$(awk '/CommitLimit/ {print $2}' /proc/meminfo)
+is_int "$commit_limit" || tst_brkm TBROK "Unable to determine commit_limit"
 
-mem=$(( $mem_free + $swap_free / 2 ))
+committed_as=$(awk '/Committed_AS/ {print $2}' /proc/meminfo)
+is_int "$committed_as" || tst_brkm TBROK "Unable to determine committed_as"
+
+mem=$(( $commit_limit - $committed_as ))
 mem=$(( $mem / 1024 ))
 [ "$mem" -gt 0 ] || tst_brkm TBROK "mem is not positive: $mem"
 
+ROD echo 1 \> "$overcommit_path"
+
 date
 testcase_1
 date
 testcase_2
 date
 
+ROD echo "$overcommit" \> "$overcommit_path"
+
 tst_exit
-- 
1.7.1

