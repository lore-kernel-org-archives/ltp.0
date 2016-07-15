From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Fri, 15 Jul 2016 18:35:53 +0300
Subject: [LTP]  [PATCH 2/2] syscalls/perf_event_open{01,
	02}: Add -n arg for size of idle loop
In-Reply-To: <1468596953-3407-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1468596953-3407-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <1468596953-3407-2-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The value of this option is used in do_word() idle loop. By default
do_work() iterates 1000000000 times. However such loop may take a
long time to finish for all available performance counters on some
boards. It would be useful to have an ability to choose the size of
idle loop.

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 .../syscalls/perf_event_open/perf_event_open01.c   | 32 +++++++++++++++++++---
 .../syscalls/perf_event_open/perf_event_open02.c   | 18 ++++++++++--
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
index 9c87e65..3823e5e 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
@@ -49,8 +49,20 @@
 char *TCID = "perf_event_open01";
 
 #if HAVE_PERF_EVENT_ATTR
+
+#define DEFAULT_LOOPS	1000000000
+
 static void setup(void);
 static void cleanup(void);
+static void help(void);
+
+static int loops;
+static int loops_flag;
+static char *loops_arg;
+static option_t options[] = {
+	{"n:", &loops_flag, &loops_arg},
+	{NULL, NULL, NULL},
+};
 
 static struct test_case_t {
 	uint32_t type;
@@ -82,7 +94,15 @@ int main(int ac, char **av)
 {
 	int i, lc;
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	tst_parse_opts(ac, av, options, help);
+
+	loops = DEFAULT_LOOPS;
+	if (loops_flag) {
+		if (sscanf(loops_arg, "%i", &loops) != 1)
+			tst_brkm(TBROK, NULL, "-n option arg is not a number");
+		if (loops <= 0)
+			tst_brkm(TBROK, NULL, "-n option arg is less than 1");
+	}
 
 	setup();
 
@@ -129,13 +149,11 @@ static int perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
 }
 
 /* do_work() is copied form performance_counter02.c */
-#define LOOPS	1000000000
-
 static void do_work(void)
 {
 	int i;
 
-	for (i = 0; i < LOOPS; ++i)
+	for (i = 0; i < loops; ++i)
 		asm volatile ("" : : "g" (i));
 }
 
@@ -197,6 +215,12 @@ static void cleanup(void)
 {
 }
 
+static void help(void)
+{
+	printf("  -n x    Number of iterations in idle loop, default is %d\n",
+		DEFAULT_LOOPS);
+}
+
 #else
 
 int main(void)
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index ba840f5..dc7c85e 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -79,7 +79,7 @@ int TST_TOTAL = 1;
 #if HAVE_PERF_EVENT_ATTR
 
 #define MAX_CTRS	1000
-#define LOOPS		1000000000
+#define DEFAULT_LOOPS	1000000000
 
 static int count_hardware_counters(void);
 static void setup(void);
@@ -89,7 +89,11 @@ static void help(void);
 
 static int n, nhw;
 static int verbose;
+static int loops;
+static int loops_flag;
+static char *loops_arg;
 static option_t options[] = {
+	{"n:", &loops_flag, &loops_arg},
 	{"v", &verbose, NULL},
 	{NULL, NULL, NULL},
 };
@@ -103,6 +107,14 @@ int main(int ac, char **av)
 
 	tst_parse_opts(ac, av, options, help);
 
+	loops = DEFAULT_LOOPS;
+	if (loops_flag) {
+		if (sscanf(loops_arg, "%i", &loops) != 1)
+			tst_brkm(TBROK, NULL, "-n option arg is not a number");
+		if (loops <= 0)
+			tst_brkm(TBROK, NULL, "-n option arg is less than 1");
+	}
+
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -129,7 +141,7 @@ static void do_work(void)
 {
 	int i;
 
-	for (i = 0; i < LOOPS; ++i)
+	for (i = 0; i < loops; ++i)
 		asm volatile (""::"g" (i));
 }
 
@@ -338,6 +350,8 @@ static void verify(void)
 
 static void help(void)
 {
+	printf("  -n x    Number of iterations in idle loop, default is %d\n",
+		DEFAULT_LOOPS);
 	printf("  -v      Print verbose information\n");
 }
 
-- 
2.2.0

