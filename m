From: Julio Cruz <jcsistemas2001@gmail.com>
Date: Thu,  7 Apr 2016 18:01:41 +0800
Subject: [LTP] [PATCH-v2] getrusage03: check available memory and move
	initial allocation out test loop
Message-ID: <1460023301-25626-1-git-send-email-jcsistemas2001@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Julio Cruz <julio.cruz@smartmatic.com>

This patch check the available memory before to perform the 
different test cases. If the memory is not enough (according with
each test case), the test finish as TCONF.
This could be usefull when you are testing on embedded devices
with RAM memory limitation (i.e. 512MB)
This patch no changed the test case procedure and is still valid 
for non-embedded devices. It just verify the available memory.
The patch also solve an issue with the initial allocation moving 
the call 'consume' before the test loop.

The patch was tested with different board configurations (512MB and 1GB)
including various DEFAULT_ALLOC_MB constants

checkpatch.pl return total: 0 errors, 0 warnings, 129 lines checked

Signed-off-by: Julio Cruz <jcsistemas2001@gmail.com>

---
 testcases/kernel/syscalls/getrusage/getrusage03.c | 56 +++++++++++++++++------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 54cdc83..f3d048f 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -45,7 +45,8 @@
 char *TCID = "getrusage03";
 int TST_TOTAL = 1;
 
-#define DELTA_MAX	10240
+#define DELTA_MAX	        10240
+#define DEFAULT_ALLOC_MB	100
 
 static struct rusage ru;
 static long maxrss_init;
@@ -65,6 +66,14 @@ static void consume(int mega);
 static void setup(void);
 static void cleanup(void);
 
+unsigned long get_available_memory_mb(void)
+{
+	unsigned long long ps, pn;
+	ps = sysconf(_SC_PAGESIZE);
+	pn = sysconf(_SC_AVPHYS_PAGES);
+	return (ps / 1024) * pn / 1024;
+}
+
 int main(int argc, char *argv[])
 {
 	int lc;
@@ -73,12 +82,16 @@ int main(int argc, char *argv[])
 
 	setup();
 
+	tst_resm(TINFO, "Available memory: %ldMB\n", get_available_memory_mb());
+	if (get_available_memory_mb() < DEFAULT_ALLOC_MB)
+		tst_brkm(TCONF, cleanup, "Not enough memory\n");
+
+	tst_resm(TINFO, "allocate %dMB", DEFAULT_ALLOC_MB);
+	consume(DEFAULT_ALLOC_MB);
+
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		tst_resm(TINFO, "allocate 100MB");
-		consume(100);
-
 		inherit_fork();
 		inherit_fork2();
 		fork_malloc();
@@ -95,11 +108,13 @@ int main(int argc, char *argv[])
  * expect: initial.self ~= child.self */
 static void inherit_fork(void)
 {
-	tst_resm(TINFO, "Testcase #01: fork inherit");
-
 	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
 	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
 
+	tst_resm(TINFO, "Testcase #01: fork inherit");
+	if (get_available_memory_mb() < DEFAULT_ALLOC_MB)
+		tst_brkm(TCONF, cleanup, "Not enough memory\n");
+
 	switch (pid = fork()) {
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "fork #1");
@@ -119,17 +134,19 @@ static void inherit_fork(void)
 }
 
 /* Testcase #02: fork inherit (cont.)
- * expect: initial.children ~= 100MB, child.children = 0 */
+ * expect: initial.children ~= DEFAULT_ALLOC_MB, child.children = 0 */
 static void inherit_fork2(void)
 {
-	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
+	tst_resm(TINFO, "Testcase #02: fork inherit cont.");
+	if (get_available_memory_mb() < DEFAULT_ALLOC_MB)
+		tst_brkm(TCONF, cleanup, "Not enough memory\n");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
 	if (is_in_delta(ru.ru_maxrss - 102400))
-		tst_resm(TPASS, "initial.children ~= 100MB");
+		tst_resm(TPASS, "initial.children ~= %dMB", DEFAULT_ALLOC_MB);
 	else
-		tst_resm(TFAIL, "initial.children !~= 100MB");
+		tst_resm(TFAIL, "initial.children !~= %dMB", DEFAULT_ALLOC_MB);
 
 	switch (pid = fork()) {
 	case -1:
@@ -152,7 +169,9 @@ static void inherit_fork2(void)
  * expect: initial.self + 50MB ~= child.self */
 static void fork_malloc(void)
 {
-	tst_resm(TINFO, "Testcase #03: fork + malloc");
+	tst_resm(TINFO, "Testcase #03: fork + malloc");
+	if (get_available_memory_mb() < (DEFAULT_ALLOC_MB+50))
+		tst_brkm(TCONF, cleanup, "Not enough memory\n");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
 	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
@@ -181,7 +200,10 @@ static void fork_malloc(void)
  * expect: post_wait.children ~= 300MB */
 static void grandchild_maxrss(void)
 {
-	tst_resm(TINFO, "Testcase #04: grandchild maxrss");
+	tst_resm(TINFO, "Testcase #04: grandchild maxrss");
+	if (get_available_memory_mb() <= (DEFAULT_ALLOC_MB+300))
+		tst_brkm(TCONF, cleanup, "Not enough memory\n");
+
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
@@ -215,7 +237,9 @@ static void grandchild_maxrss(void)
  * expect: initial ~= pre_wait, post_wait ~= 400MB */
 static void zombie(void)
 {
-	tst_resm(TINFO, "Testcase #05: zombie");
+	tst_resm(TINFO, "Testcase #05: zombie");
+	if (get_available_memory_mb() <= (DEFAULT_ALLOC_MB+400))
+		tst_brkm(TCONF, cleanup, "Not enough memory\n");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
@@ -258,7 +282,9 @@ static void zombie(void)
  * expect: initial ~= after_zombie */
 static void sig_ign(void)
 {
-	tst_resm(TINFO, "Testcase #06: SIG_IGN");
+	tst_resm(TINFO, "Testcase #06: SIG_IGN");
+	if (get_available_memory_mb() <= (DEFAULT_ALLOC_MB+500))
+		tst_brkm(TCONF, cleanup, "Not enough memory to run test case");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
@@ -294,7 +320,7 @@ static void exec_without_fork(void)
 	char str_maxrss_self[BUFSIZ], str_maxrss_child[BUFSIZ];
 	long maxrss_self, maxrss_child;
 
-	tst_resm(TINFO, "Testcase #07: exec without fork");
+	tst_resm(TINFO, "Testcase #07: exec without fork");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
 	maxrss_self = ru.ru_maxrss;
-- 
1.9.1

