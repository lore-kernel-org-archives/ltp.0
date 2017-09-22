From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 22 Sep 2017 11:28:02 +0200
Subject: [LTP] [PATCH v4] thp01: Find largest arguments size
Message-ID: <20170922092802.10602-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Because of kernel commit da029c11e6b1 the arguments size for exec has been
reduced considerably. This causes exec to fail with E2BIG, so we call it
repeatedly with a decreasing number of arguments until it is successful.

As far as I know, there is no other reliable and easy way to determine the
maximum argument length.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V4 - Change the binary search implementation and add some comments.

 testcases/kernel/mem/thp/thp01.c | 116 ++++++++++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
index 101a9b5c8..be114e0bf 100644
--- a/testcases/kernel/mem/thp/thp01.c
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -28,8 +28,15 @@
  * invalid opcode: 0000 [#1] SMP
  * last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cpu_map
  * ....
+ *
+ * Due to commit da029c11e6b1 which reduced the stack size considerably, we
+ * now perform a binary search to find the largest possible argument we can
+ * use. Only the first iteration of the test performs the search; subsequent
+ * iterations use the result of the search which is stored in some shared
+ * memory.
  */
 
+#include <errno.h>
 #include <sys/types.h>
 #include <sys/resource.h>
 #include <sys/wait.h>
@@ -37,57 +44,102 @@
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include "tst_test.h"
 #include "mem.h"
+#include "tst_minmax.h"
+
+#define ARGS_SZ	(256 * 32)
 
-#define ARRAY_SZ	256
+static struct bisection {
+	long left;
+	long right;
+	long mid;
+} *bst;
 
-static int ps;
-static long length;
-static char *array[ARRAY_SZ];
+static char *args[ARGS_SZ];
 static char *arg;
-static struct rlimit rl = {
-	.rlim_cur = RLIM_INFINITY,
-	.rlim_max = RLIM_INFINITY,
-};
 
 static void thp_test(void)
 {
-	int i;
-	pid_t pid;
-
-	switch (pid = SAFE_FORK()) {
-	case 0:
-		memset(arg, 'c', length - 1);
-		arg[length - 1] = '\0';
-		array[0] = "true";
-		for (i = 1; i < ARRAY_SZ - 1; i++)
-			array[i] = arg;
-		array[ARRAY_SZ - 1] = NULL;
-		if (setrlimit(RLIMIT_STACK, &rl) == -1) {
-			perror("setrlimit");
-			exit(1);
-		}
-		if (execvp("true", array) == -1) {
-			perror("execvp");
-			exit(1);
+	long prev_left;
+	int pid;
+
+	while (bst->right - bst->left > 1) {
+		pid_t pid = SAFE_FORK();
+
+		if (!pid) {
+			/* We set mid to left assuming exec will succeed. If
+			 * exec fails with E2BIG (and thus returns) then we
+			 * restore left and set right to mid instead.
+			 */
+			prev_left = bst->left;
+			bst->mid = (bst->left + bst->right) / 2;
+			bst->left = bst->mid;
+			args[bst->mid] = NULL;
+
+			TEST(execvp("true", args));
+			if (TEST_ERRNO != E2BIG)
+				tst_brk(TBROK | TTERRNO, "execvp(\"true\", ...)");
+			bst->left = prev_left;
+			bst->right = bst->mid;
+			exit(0);
 		}
-	default:
+
 		tst_reap_children();
+		tst_res(TINFO, "left: %ld, right: %ld, mid: %ld",
+			bst->left, bst->right, bst->mid);
+	}
+
+	/* We end with mid == right or mid == left where right - left =
+	 * 1. Regardless we must use left because right is only set to values
+	 * which are too large.
+	 */
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		args[bst->left] = NULL;
+		TEST(execvp("true", args));
+		if (TEST_ERRNO != E2BIG)
+			tst_brk(TBROK | TTERRNO, "execvp(\"true\", ...)");
+		exit(0);
 	}
+	tst_reap_children();
 
-	tst_res(TPASS, "system didn't crash, pass.");
+	tst_res(TPASS, "system didn't crash.");
 }
 
 static void setup(void)
 {
-	ps = sysconf(_SC_PAGESIZE);
-	length = 32 * ps;
-	arg = SAFE_MALLOC(length);
+	struct rlimit rl = {
+		.rlim_cur = RLIM_INFINITY,
+		.rlim_max = RLIM_INFINITY,
+	};
+	int i;
+	long arg_len, arg_count;
+
+	bst = SAFE_MMAP(NULL, sizeof(*bst),
+			   PROT_READ | PROT_WRITE,
+			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	bst->left = 0;
+	bst->right = ARGS_SZ;
+
+	arg_len = sysconf(_SC_PAGESIZE);
+	arg = SAFE_MALLOC(arg_len);
+	memset(arg, 'c', arg_len - 1);
+	arg[arg_len - 1] = '\0';
+
+	args[0] = "true";
+	arg_count = ARGS_SZ;
+	tst_res(TINFO, "Using %ld args of size %ld", arg_count, arg_len);
+	for (i = 1; i < arg_count; i++)
+		args[i] = arg;
+
+	SAFE_SETRLIMIT(RLIMIT_STACK, &rl);
 }
 
 static void cleanup(void)
 {
-	free(arg);
+	if (arg)
+		free(arg);
 }
 
 static struct tst_test test = {
-- 
2.14.1

