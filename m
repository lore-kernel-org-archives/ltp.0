From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Nov 2015 10:57:09 +0800
Subject: [LTP] [PATCH v2] hugetlb: checking if hugepage is supported on
	target system
Message-ID: <1448506629-12150-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |  1 +
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |  2 ++
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |  1 +
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | 26 +++++++++++-----------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |  1 +
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |  1 +
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |  1 +
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat04.c     |  1 +
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |  1 +
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |  1 +
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   |  1 +
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     |  1 +
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |  1 +
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |  1 +
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |  1 +
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   |  1 +
 testcases/kernel/mem/include/mem.h                 |  2 ++
 testcases/kernel/mem/lib/mem.c                     |  6 +++++
 testcases/kernel/syscalls/futex/futex_wake04.c     |  4 ++++
 19 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 62c3cc8..d137135 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -159,6 +159,7 @@ void setup(void)
 {
 	TEST_PAUSE;
 	tst_require_root();
+	check_hugepage();
 	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
 		tst_brkm(TBROK | TERRNO, NULL, "mount failed on %s", Hopt);
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 9fee330..0cbb62b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -93,6 +93,8 @@ int main(int ac, char **av)
 
 	tst_parse_opts(ac, av, options, &help);
 
+	check_hugepage();
+
 	if (!Hflag) {
 		tst_tmpdir();
 		Hopt = tst_get_tmpdir();
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 727b102..0332d3b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -175,6 +175,7 @@ void setup(void)
 {
 	TEST_PAUSE;
 	tst_require_root();
+	check_hugepage();
 	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
 		tst_brkm(TBROK | TERRNO, NULL, "mount failed on %s", Hopt);
 	orig_hugepages = get_sys_tune("nr_hugepages");
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 8dac97a..bef5a4a 100644
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
@@ -467,6 +466,7 @@ static void init_hugepagesize(void)
 {
 	FILE *fp;
 
+	check_hugepage();
 	memset(buf, -1, BUFSIZ);
 	fp = fopen(PATH_MEMINFO, "r");
 	if (fp == NULL)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 851d4cf..fe0f376 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -209,6 +209,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 52348f1..2b8e923 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -125,6 +125,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 723c8b5..28f85b6 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -131,6 +131,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index f631a0a..88217e5 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -126,6 +126,7 @@ void setup(void)
 	long mem_total, hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 
 	mem_total = read_meminfo("MemTotal:");
 	SAFE_FILE_SCANF(NULL, PATH_SHMMAX, "%ld", &orig_shmmax);
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 66ad1b5..f4d4f19 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -392,6 +392,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(FORK, sighandler, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 4aeb638..d5b8109 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -130,6 +130,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 9f5c2c9..66df7f9 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -156,6 +156,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 9770e87..305d2b4 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -165,6 +165,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, sighandler, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index ee82de3..d1897b5 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -143,6 +143,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index b995ef8..953000f 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -138,6 +138,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 9284669..d1f3205 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -113,6 +113,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 7b8f6b4..ae39b33 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -135,6 +135,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 4a18799..4cf34d1 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -62,7 +62,9 @@ void thp_usage(void);
 /* HUGETLB */
 
 #define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
+#define PATH_HUGEPAGES		"/sys/kernel/mm/hugepages/"
 
+void check_hugepage(void);
 void write_memcg(void);
 void create_same_memory(int size, int num, int unit);
 int  opt_num, opt_size, opt_unit;
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 215c052..84af3ce 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -314,6 +314,12 @@ static void verify(char **memory, char value, int proc,
 	free(s);
 }
 
+void check_hugepage(void)
+{
+	if (access(PATH_HUGEPAGES, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+}
+
 void write_memcg(void)
 {
 	SAFE_FILE_PRINTF(NULL, MEMCG_LIMIT, "%ld", TESTMEM);
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

