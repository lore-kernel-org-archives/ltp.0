From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Nov 2015 16:22:06 +0800
Subject: [LTP] [PATCH] hugetlb: checking if hugepage is supported on target
	system
Message-ID: <1448439726-6832-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all, how about changging these codes in testcases to check if
system support hugepage?

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |  4 ++++
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |  4 ++++
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |  4 ++++
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | 28 ++++++++++++----------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |  3 +++
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |  3 +++
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |  3 +++
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat04.c     |  3 +++
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |  3 +++
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |  3 +++
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   |  3 +++
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     |  3 +++
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |  3 +++
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |  3 +++
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |  3 +++
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   |  4 ++++
 testcases/kernel/mem/include/mem.h                 |  1 +
 testcases/kernel/syscalls/futex/futex_wake04.c     |  4 ++++
 18 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 62c3cc8..cae0b78 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -159,6 +159,10 @@ void setup(void)
 {
 	TEST_PAUSE;
 	tst_require_root();
+
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
 		tst_brkm(TBROK | TERRNO, NULL, "mount failed on %s", Hopt);
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 9fee330..1187b38 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -93,6 +93,9 @@ int main(int ac, char **av)
 
 	tst_parse_opts(ac, av, options, &help);
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	if (!Hflag) {
 		tst_tmpdir();
 		Hopt = tst_get_tmpdir();
@@ -200,6 +203,7 @@ void setup(void)
 {
 	TEST_PAUSE;
 	tst_require_root();
+
 	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
 		tst_brkm(TBROK | TERRNO, NULL, "mount failed on %s", Hopt);
 	orig_hugepages = get_sys_tune("nr_hugepages");
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 727b102..0b7bc86 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -175,6 +175,10 @@ void setup(void)
 {
 	TEST_PAUSE;
 	tst_require_root();
+
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
 		tst_brkm(TBROK | TERRNO, NULL, "mount failed on %s", Hopt);
 	orig_hugepages = get_sys_tune("nr_hugepages");
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 8dac97a..7dcf87a 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -48,6 +48,7 @@
 #include <string.h>
 #include <ctype.h>
 #include "test.h"
+#include "mem.h"
 
 #define PROTECTION		(PROT_READ | PROT_WRITE)
 #define PATH_MEMINFO		"/proc/meminfo"
@@ -97,9 +98,7 @@ static option_t options[] = {
 	{NULL, NULL, NULL}
 };
 
-static void setup(void);
-static void cleanup(void);
-static void overcommit(void);
+static void overcommit1(void);
 static void write_bytes(void *addr);
 static void read_bytes(void *addr);
 static int lookup(char *line, char *pattern);
@@ -132,13 +131,13 @@ int main(int argc, char *argv[])
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
-		overcommit();
+		overcommit1();
 	}
 	cleanup();
 	tst_exit();
 }
 
-static void overcommit(void)
+static void overcommit1(void)
 {
 	void *addr = NULL, *shmaddr = NULL;
 	int fd = -1, key = -1;
@@ -245,7 +244,7 @@ static void overcommit(void)
 	}
 }
 
-static void cleanup(void)
+void cleanup(void)
 {
 	int fd;
 
@@ -253,7 +252,7 @@ static void cleanup(void)
 		fd = open(PATH_SHMMAX, O_WRONLY);
 		if (fd == -1)
 			tst_resm(TWARN | TERRNO, "open");
-		if (write(fd, shmmax, strlen(shmmax)) != strlen(shmmax))
+		if ((unsigned int)write(fd, shmmax, strlen(shmmax)) != strlen(shmmax))
 			tst_resm(TWARN | TERRNO, "write");
 		close(fd);
 	}
@@ -261,7 +260,7 @@ static void cleanup(void)
 	if (fd == -1)
 		tst_resm(TWARN | TERRNO, "open");
 	tst_resm(TINFO, "restore nr_hugepages to %s.", nr_hugepages);
-	if (write(fd, nr_hugepages,
+	if ((unsigned int)write(fd, nr_hugepages,
 		  strlen(nr_hugepages)) != strlen(nr_hugepages))
 		tst_resm(TWARN | TERRNO, "write");
 	close(fd);
@@ -271,7 +270,7 @@ static void cleanup(void)
 		tst_resm(TWARN | TERRNO, "open");
 	tst_resm(TINFO, "restore nr_overcommit_hugepages to %s.",
 		 nr_overcommit_hugepages);
-	if (write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
+	if ((unsigned int)write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
 	    != strlen(nr_overcommit_hugepages))
 		tst_resm(TWARN | TERRNO, "write");
 	close(fd);
@@ -287,7 +286,7 @@ static void cleanup(void)
 	tst_rmdir();
 }
 
-static void setup(void)
+void setup(void)
 {
 	FILE *fp;
 	int fd;
@@ -321,7 +320,7 @@ static void setup(void)
 				tst_brkm(TBROK | TERRNO, cleanup, "open");
 			snprintf(buf, BUFSIZ, "%ld",
 				 (long)(length / 2 * hugepagesize));
-			if (write(fd, buf, strlen(buf)) != strlen(buf))
+			if ((unsigned int)write(fd, buf, strlen(buf)) != strlen(buf))
 				tst_brkm(TBROK | TERRNO, cleanup,
 					 "failed to change shmmax.");
 		}
@@ -345,7 +344,7 @@ static void setup(void)
 	if (lseek(fd, 0, SEEK_SET) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "lseek");
 	snprintf(buf, BUFSIZ, "%zd", size);
-	if (write(fd, buf, strlen(buf)) != strlen(buf))
+	if ((unsigned int)write(fd, buf, strlen(buf)) != strlen(buf))
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "failed to change nr_hugepages.");
 	close(fd);
@@ -369,7 +368,7 @@ static void setup(void)
 	if (lseek(fd, 0, SEEK_SET) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "lseek");
 	snprintf(buf, BUFSIZ, "%zd", size);
-	if (write(fd, buf, strlen(buf)) != strlen(buf))
+	if ((unsigned int)write(fd, buf, strlen(buf)) != strlen(buf))
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "failed to change nr_hugepages.");
 	close(fd);
@@ -467,6 +466,9 @@ static void init_hugepagesize(void)
 {
 	FILE *fp;
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	memset(buf, -1, BUFSIZ);
 	fp = fopen(PATH_MEMINFO, "r");
 	if (fp == NULL)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 851d4cf..31192c5 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -212,6 +212,9 @@ void setup(void)
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 52348f1..0c809ea 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -128,6 +128,9 @@ void setup(void)
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 723c8b5..ba73ded 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -134,6 +134,9 @@ void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index f631a0a..8a7f88e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -127,6 +127,9 @@ void setup(void)
 
 	tst_require_root();
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	mem_total = read_meminfo("MemTotal:");
 	SAFE_FILE_SCANF(NULL, PATH_SHMMAX, "%ld", &orig_shmmax);
 	SAFE_FILE_PRINTF(NULL, PATH_SHMMAX, "%ld", (long)SIZE);
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 66ad1b5..ff04ca5 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -395,6 +395,9 @@ void setup(void)
 	tst_sig(FORK, sighandler, cleanup);
 	tst_tmpdir();
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 4aeb638..c085c09 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -133,6 +133,9 @@ void setup(void)
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 9f5c2c9..7f99acb 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -159,6 +159,9 @@ void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 9770e87..7f775a4 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -168,6 +168,9 @@ void setup(void)
 	tst_sig(NOFORK, sighandler, cleanup);
 	tst_tmpdir();
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index ee82de3..46e6949 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -146,6 +146,9 @@ void setup(void)
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index b995ef8..55bd860 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -141,6 +141,9 @@ void setup(void)
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 9284669..8a69258 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -116,6 +116,9 @@ void setup(void)
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 7b8f6b4..ff410e9 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -138,6 +138,10 @@ void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 4a18799..b8a3d6f 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -62,6 +62,7 @@ void thp_usage(void);
 /* HUGETLB */
 
 #define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
+#define PATH_HUGEPAGES		"/sys/kernel/mm/hugepages/"
 
 void write_memcg(void);
 void create_same_memory(int size, int num, int unit);
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index dcefde8..d044ba5 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -50,6 +50,7 @@
 
 #define PATH_MEMINFO "/proc/meminfo"
 #define PATH_NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
+#define PATH_HUGEPAGES "/sys/kernel/mm/hugepages/"
 
 const char *TCID = "futex_wake04";
 const int TST_TOTAL = 1;
@@ -69,6 +70,9 @@ static void setup(void)
 			"that are 2.6.32 or higher");
 	}
 
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	tst_tmpdir();
 
 	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
-- 
1.8.3.1

