From: Yuan Sun <sunyuan3@huawei.com>
Date: Mon, 9 Nov 2015 16:05:34 +0800
Subject: [LTP] [PATCH 2/2] Simplify grep actions in cpuset_syscall_test.
In-Reply-To: <1447056334-28420-1-git-send-email-sunyuan3@huawei.com>
References: <1447056334-28420-1-git-send-email-sunyuan3@huawei.com>
Message-ID: <1447056334-28420-2-git-send-email-sunyuan3@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 .../cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh       | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index 771b642..94b8824 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -188,7 +188,7 @@ test7()
 	do_syscall_test 0 0 --mbind=1 0 || return $?
 	memory_addr="$(cat $TEST_OUTPUT)"
 	memory_addr=${memory_addr##*0x}
-	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
+	allowed_list=$(grep "$memory_addr" $TEST_PROCNUMA | \
 			awk '{print $2}')
 	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
 	test "$allowed_list" = "0" || return 1
@@ -204,7 +204,7 @@ test8()
 	do_syscall_test 0 0-1 --mbind=1 0 || return $?
 	memory_addr="$(cat $TEST_OUTPUT)"
 	memory_addr=${memory_addr##*0x}
-	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
+	allowed_list=$(grep "$memory_addr" $TEST_PROCNUMA | \
 			awk '{print $2}')
 	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
 	test "$allowed_list" = "0"
@@ -220,7 +220,7 @@ test9()
 	do_syscall_test 0 0-1 --mbind=6 0 || return $?
 	memory_addr="$(cat $TEST_OUTPUT)"
 	memory_addr=${memory_addr##*0x}
-	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
+	allowed_list=$(grep "$memory_addr" $TEST_PROCNUMA | \
 			awk '{print $2}')
 	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
 	test "$allowed_list" = "1"
@@ -236,11 +236,11 @@ test10()
 	do_syscall_test 0 0 --mbind=6 1 || return $?
 	memory_addr="$(cat $TEST_OUTPUT)"
 	memory_addr=${memory_addr##*0x}
-	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
+	allowed_list=$(grep "$memory_addr" $TEST_PROCNUMA | \
 			awk '{print $2}')
 	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
 
-	task_policy=$(cat $TEST_PROCNUMA | grep -e "  *stack  *anon" | \
+	task_policy=$(grep -e "  *stack  *anon" $TEST_PROCNUMA | \
 			awk '{print $2}')
 
 	test "$allowed_list" = "$task_policy"
-- 
1.9.1

