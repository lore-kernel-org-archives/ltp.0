From: Julio Cruz <jcsistemas2001@gmail.com>
Date: Thu, 28 Apr 2016 12:31:03 +0800
Subject: [LTP]  [PATCH-v4] getrusage03: check available memory
Message-ID: <1461817863-6962-1-git-send-email-jcsistemas2001@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Julio Cruz <julio.cruz@smartmatic.com>

This patch check the available memory before to perform the different test cases. If the memory is not enough (according with each test case), the test finish as TCONF.
This could be usefull when you are testing on embedded devices with RAM memory limitation (i.e. 512MB) This patch no changed the test case procedure and is still valid for non-embedded devices. It just verify the available memory.
The patch also solve an issue with the initial allocation moving the call 'consume' before the test loop.
During testing to obtain available memory, _SC_AVPHYS_PAGES and MemAvailable get different results. sysconf(_SC_AVPHYS_PAGES) was replaced by MemAvailable (if present) or MemFree+Cached from /proc/meminfo.

The patch was tested with different board configurations (512MB and 1GB) including various DEFAULT_ALLOC_MB constants

checkpatch.pl return total: 0 errors, 0 warnings, 168 lines checked

Signed-off-by: Julio Cruz <jcsistemas2001@gmail.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>; 
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

---
 testcases/kernel/syscalls/getrusage/getrusage03.c | 95 ++++++++++++++++++++---
 1 file changed, 85 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 54cdc83..7176321 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -37,6 +37,7 @@
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <string.h>
 
 #include "test.h"
@@ -45,7 +46,8 @@
 char *TCID = "getrusage03";
 int TST_TOTAL = 1;
 
-#define DELTA_MAX	10240
+#define DELTA_MAX	        10240
+#define DEFAULT_ALLOC_MB	100
 
 static struct rusage ru;
 static long maxrss_init;
@@ -65,6 +67,62 @@ static void consume(int mega);
 static void setup(void);
 static void cleanup(void);
 
+#define PATH_MEMINFO		"/proc/meminfo"
+#define KB			(1UL<<10)
+
+/* Based on read_meminfo() from kernel/mem/lib/mem.c */
+long read_meminfo(char *item, bool check)
+{
+	FILE *fp;
+	char line[BUFSIZ], buf[BUFSIZ];
+	long val;
+
+	fp = fopen(PATH_MEMINFO, "r");
+	if (fp == NULL && !check)
+		tst_brkm(TBROK | TERRNO, cleanup, "fopen %s", PATH_MEMINFO);
+
+	while (fgets(line, BUFSIZ, fp) != NULL) {
+		if (sscanf(line, "%64s %ld", buf, &val) == 2)
+			if (strcmp(buf, item) == 0) {
+				fclose(fp);
+				return val;
+			}
+		continue;
+	}
+	fclose(fp);
+
+	if (!check)
+		tst_brkm(TBROK, cleanup, "cannot find \"%s\" in %s",
+			 item, PATH_MEMINFO);
+
+	return -1;
+}
+
+unsigned long get_available_memory_mb(void)
+{
+	unsigned long available_mem = 0;
+	long mem_free, mem_cached, mem_available;
+
+	/* If MemAvailable is present, used it */
+	mem_available = read_meminfo("MemAvailable:", false);
+	if (mem_available >= 0) {
+		tst_resm(TINFO, "Using MemAvailable (%luMB)",
+			mem_available / KB);
+		return mem_available / KB;
+	}
+
+	/* Otherwise use MemFree+Cached */
+	mem_free = read_meminfo("MemFree:", false);
+	if (mem_free >= 0)
+		available_mem += mem_free / KB;
+	mem_cached = read_meminfo("Cached:", false);
+	if (mem_cached >= 0)
+		available_mem += mem_cached / KB;
+	tst_resm(TINFO, "The current MemFree+Cached (%lu+%luMB)",
+		mem_free / KB, mem_cached / KB);
+	return available_mem;
+}
+
 int main(int argc, char *argv[])
 {
 	int lc;
@@ -73,12 +131,16 @@ int main(int argc, char *argv[])
 
 	setup();
 
+	tst_resm(TINFO, "Available memory: %luMB", get_available_memory_mb());
+	if (get_available_memory_mb() < DEFAULT_ALLOC_MB)
+		tst_brkm(TCONF, cleanup, "Not enough memory");
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
@@ -95,11 +157,13 @@ int main(int argc, char *argv[])
  * expect: initial.self ~= child.self */
 static void inherit_fork(void)
 {
-	tst_resm(TINFO, "Testcase #01: fork inherit");
-
 	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
 	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
 
+	tst_resm(TINFO, "Testcase #01: fork inherit");
+	if (get_available_memory_mb() < DEFAULT_ALLOC_MB)
+		tst_brkm(TCONF, cleanup, "Not enough memory");
+
 	switch (pid = fork()) {
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "fork #1");
@@ -119,17 +183,19 @@ static void inherit_fork(void)
 }
 
 /* Testcase #02: fork inherit (cont.)
- * expect: initial.children ~= 100MB, child.children = 0 */
+ * expect: initial.children ~= DEFAULT_ALLOC_MB, child.children = 0 */
 static void inherit_fork2(void)
 {
-	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
+	tst_resm(TINFO, "Testcase #02: fork inherit cont.");
+	if (get_available_memory_mb() < DEFAULT_ALLOC_MB)
+		tst_brkm(TCONF, cleanup, "Not enough memory");
 
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
@@ -153,6 +219,8 @@ static void inherit_fork2(void)
 static void fork_malloc(void)
 {
 	tst_resm(TINFO, "Testcase #03: fork + malloc");
+	if (get_available_memory_mb() < (DEFAULT_ALLOC_MB+50))
+		tst_brkm(TCONF, cleanup, "Not enough memory");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
 	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
@@ -182,6 +250,9 @@ static void fork_malloc(void)
 static void grandchild_maxrss(void)
 {
 	tst_resm(TINFO, "Testcase #04: grandchild maxrss");
+	if (get_available_memory_mb() <= (DEFAULT_ALLOC_MB+300))
+		tst_brkm(TCONF, cleanup, "Not enough memory");
+
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
@@ -216,6 +287,8 @@ static void grandchild_maxrss(void)
 static void zombie(void)
 {
 	tst_resm(TINFO, "Testcase #05: zombie");
+	if (get_available_memory_mb() <= (DEFAULT_ALLOC_MB+400))
+		tst_brkm(TCONF, cleanup, "Not enough memory");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
@@ -259,6 +332,8 @@ static void zombie(void)
 static void sig_ign(void)
 {
 	tst_resm(TINFO, "Testcase #06: SIG_IGN");
+	if (get_available_memory_mb() <= (DEFAULT_ALLOC_MB+500))
+		tst_brkm(TCONF, cleanup, "Not enough memory to run test case");
 
 	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
 	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
-- 
1.9.1

