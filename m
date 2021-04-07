From: Wang Xin <wangxin410@huawei.com>
Date: Wed, 7 Apr 2021 15:50:08 +0800
Subject: [LTP] [PATCH] controllers/cpuset: Fix bug for type of variable c in
 checkopt
Message-ID: <1617781808-82555-1-git-send-email-wangxin410@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is the result of running the cpuset_load_balance test case on the ARM64 physical machine:
cpuset_load_balance 1 TFAIL: There is something wrong with test tasks
...
cpuset_load_balance 3 TFAIL: There is something wrong with test tasks
...
cpuset_load_balance 5 TFAIL: There is something wrong with test tasks
...
The analysis shows that on the ARM64-based machine, the getopt performs a while operation.
In addition, the value of char is 0 instead of 1 when it is extended to the left during comparison with the integer type,
resulting in a failure at while ((c = getopt(argc, argv, "p:h")) != -1).
Change the type of variable c to int to fix the problem.

Signed-off-by: Wang Xin <wangxin410@huawei.com>
---
 .../kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
index 8a6ec26..125ebd1 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
@@ -111,7 +111,7 @@ void usage(char *prog_name, int status)
 void checkopt(int argc, char **argv)
 {
-	char c = '\0';
+	int c = '\0';
 	char *endptr = NULL;
 	long nr_cpus = 0;
 	long opt_value = 0;
2.6.2

