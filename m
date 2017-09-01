From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri,  1 Sep 2017 16:13:43 +0200
Subject: [LTP] [PATCH v2] thp01: Find largest arguments size
In-Reply-To: <20170901100319.GA26071@rei>
References: <20170901100319.GA26071@rei>
Message-ID: <20170901141343.27416-1-rpalethorpe@suse.com>
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

V2 - Reduced the argument length, but increased the argument array and
     switched to a binary search

 testcases/kernel/mem/thp/thp01.c | 96 ++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
index 101a9b5c8..cd14bec14 100644
--- a/testcases/kernel/mem/thp/thp01.c
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -30,6 +30,7 @@
  * ....
  */
 
+#include <errno.h>
 #include <sys/types.h>
 #include <sys/resource.h>
 #include <sys/wait.h>
@@ -38,56 +39,92 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "mem.h"
+#include "tst_minmax.h"
+#include "tst_safe_sysv_ipc.h"
 
-#define ARRAY_SZ	256
+#define ARGS_SZ	256 * 32
 
-static int ps;
-static long length;
-static char *array[ARRAY_SZ];
+static char *args[ARGS_SZ];
 static char *arg;
-static struct rlimit rl = {
-	.rlim_cur = RLIM_INFINITY,
-	.rlim_max = RLIM_INFINITY,
-};
+static long *arg_count, *change, *arg_count_next;
 
 static void thp_test(void)
 {
-	int i;
 	pid_t pid;
 
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
+	while (*change > 1) {
+		*arg_count = *arg_count_next;
+		*change /= 2;
+		*arg_count_next = *arg_count + *change;
+
+		pid = SAFE_FORK();
+		if (!pid) {
+			args[*arg_count] = NULL;
+
+			TEST(execvp("true", args));
+			if (TEST_ERRNO != E2BIG)
+				tst_brk(TBROK | TTERRNO, "execvp(\"true\", ...)");
+
+			*arg_count_next = *arg_count - *change;
+			exit(0);
 		}
-	default:
+		  tst_res(TINFO, "count: %ld, change: %ld, next: %ld",
+				*arg_count, *change, *arg_count_next);
 		tst_reap_children();
 	}
 
+	pid = SAFE_FORK();
+	if (!pid) {
+		args[*arg_count] = NULL;
+		do {
+			TEST(execvp("true", args));
+			if (TEST_ERRNO != E2BIG)
+				tst_brk(TBROK | TTERRNO, "execvp(\"true\", ...)");
+			tst_res(TINFO, "Binary search finished on 2BIG value: %ld",
+				*arg_count);
+			args[--(*arg_count)] = NULL;
+		} while (*arg_count > 0);
+		exit(0);
+	}
+
 	tst_res(TPASS, "system didn't crash, pass.");
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
+	long arg_len;
+
+	arg_count = SAFE_MMAP(NULL, sizeof(*arg_count) * 3,
+			      PROT_READ | PROT_WRITE,
+			      MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+	arg_count_next = arg_count + 1;
+	change = arg_count + 2;
+
+	arg_len = sysconf(_SC_PAGESIZE);
+	arg = SAFE_MALLOC(arg_len);
+	memset(arg, 'c', arg_len - 1);
+	arg[arg_len - 1] = '\0';
+
+	args[0] = "true";
+	*change = (ARGS_SZ - 1) / 2;
+	for (i = 1; i < ARGS_SZ - 1; i++)
+		args[i] = arg;
+	*arg_count_next += *change;
+
+	SAFE_SETRLIMIT(RLIMIT_STACK, &rl);
 }
 
 static void cleanup(void)
 {
-	free(arg);
+	if (arg)
+		free(arg);
+	if (arg_count)
+		SAFE_MUNMAP(arg_count, sizeof(*arg_count));
 }
 
 static struct tst_test test = {
@@ -96,4 +133,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = thp_test,
+	.min_kver = "2.4",
 };
-- 
2.14.1

