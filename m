From: Li Wang <liwang@redhat.com>
Date: Fri, 27 Nov 2015 16:18:48 +0800
Subject: [LTP] [PATCH 2/2] hugetlb: checking if hugepage is supported on
	target system
In-Reply-To: <1448612328-2094-1-git-send-email-liwang@redhat.com>
References: <1448612328-2094-1-git-send-email-liwang@redhat.com>
Message-ID: <1448612328-2094-2-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/Makefile       |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c   |  4 ++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c   |  5 +++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c   |  4 ++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c   | 20 ++++++++++----------
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c |  3 ++-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c |  3 ++-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c |  3 ++-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c |  3 ++-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c     |  4 +++-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c     |  4 +++-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c     |  4 +++-
 testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c |  3 ++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c     |  3 ++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c     |  3 ++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c     |  3 ++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c     |  3 ++-
 testcases/kernel/mem/hugetlb/lib/hugetlb.c           | 13 +++++++------
 testcases/kernel/mem/hugetlb/lib/hugetlb.h           |  4 +++-
 testcases/kernel/syscalls/futex/futex_wake04.c       |  4 ++++
 20 files changed, 59 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 71da630..f51f6b9 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -23,5 +23,5 @@
 top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
+include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 62c3cc8..da8bdb1 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -60,6 +60,7 @@
 #include <unistd.h>
 
 #include "test.h"
+#include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
 
@@ -70,12 +71,10 @@ int TST_TOTAL = 1;
 static long *addr;
 static int fildes;
 static char *Hopt;
-static char *nr_opt;
 static long beforetest;
 static long aftertest;
 static long hugepagesmapped;
 static long hugepages = 128;
-static long orig_hugepages;
 
 static void help(void);
 
@@ -159,6 +158,7 @@ void setup(void)
 {
 	TEST_PAUSE;
 	tst_require_root();
+	check_hugepage();
 	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
 		tst_brkm(TBROK | TERRNO, NULL, "mount failed on %s", Hopt);
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 9fee330..1a44993 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -55,6 +55,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "mem.h"
+#include "hugetlb.h"
 
 #define LOW_ADDR       0x80000000
 #define LOW_ADDR2      0x90000000
@@ -72,9 +73,7 @@ static int i;
 static int fildes;
 static int nfildes;
 static char *Hopt;
-static char *nr_opt;
 static long hugepages = 128;
-static long orig_hugepages;
 
 static void help(void);
 
@@ -93,6 +92,8 @@ int main(int ac, char **av)
 
 	tst_parse_opts(ac, av, options, &help);
 
+	check_hugepage();
+
 	if (!Hflag) {
 		tst_tmpdir();
 		Hopt = tst_get_tmpdir();
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 727b102..e1f2986 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -63,6 +63,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "mem.h"
+#include "hugetlb.h"
 
 static char TEMPFILE[MAXPATHLEN];
 
@@ -76,9 +77,7 @@ static long beforetest;
 static long aftertest;
 static long hugepagesmapped;
 static long hugepages = 128;
-static long orig_hugepages;
 static char *Hopt;
-static char *nr_opt;
 
 static void help(void);
 
@@ -175,6 +174,7 @@ void setup(void)
 {
 	TEST_PAUSE;
 	tst_require_root();
+	check_hugepage();
 	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
 		tst_brkm(TBROK | TERRNO, NULL, "mount failed on %s", Hopt);
 	orig_hugepages = get_sys_tune("nr_hugepages");
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index b68c981..7143e82 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -48,6 +48,7 @@
 #include <string.h>
 #include <ctype.h>
 #include "test.h"
+#include "hugetlb.h"
 
 #define PROTECTION		(PROT_READ | PROT_WRITE)
 #define PATH_MEMINFO		"/proc/meminfo"
@@ -97,8 +98,6 @@ static option_t options[] = {
 	{NULL, NULL, NULL}
 };
 
-static void setup(void);
-static void cleanup(void);
 static void overcommit(void);
 static void write_bytes(void *addr);
 static void read_bytes(void *addr);
@@ -247,7 +246,7 @@ static void overcommit(void)
 	}
 }
 
-static void cleanup(void)
+void cleanup(void)
 {
 	int fd;
 
@@ -255,7 +254,7 @@ static void cleanup(void)
 		fd = open(PATH_SHMMAX, O_WRONLY);
 		if (fd == -1)
 			tst_resm(TWARN | TERRNO, "open");
-		if (write(fd, shmmax, strlen(shmmax)) != strlen(shmmax))
+		if (write(fd, shmmax, strlen(shmmax)) != (ssize_t)strlen(shmmax))
 			tst_resm(TWARN | TERRNO, "write");
 		close(fd);
 	}
@@ -264,7 +263,7 @@ static void cleanup(void)
 		tst_resm(TWARN | TERRNO, "open");
 	tst_resm(TINFO, "restore nr_hugepages to %s.", nr_hugepages);
 	if (write(fd, nr_hugepages,
-		  strlen(nr_hugepages)) != strlen(nr_hugepages))
+		  strlen(nr_hugepages)) != (ssize_t)strlen(nr_hugepages))
 		tst_resm(TWARN | TERRNO, "write");
 	close(fd);
 
@@ -274,7 +273,7 @@ static void cleanup(void)
 	tst_resm(TINFO, "restore nr_overcommit_hugepages to %s.",
 		 nr_overcommit_hugepages);
 	if (write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
-	    != strlen(nr_overcommit_hugepages))
+	    != (ssize_t)strlen(nr_overcommit_hugepages))
 		tst_resm(TWARN | TERRNO, "write");
 	close(fd);
 
@@ -289,7 +288,7 @@ static void cleanup(void)
 	tst_rmdir();
 }
 
-static void setup(void)
+void setup(void)
 {
 	FILE *fp;
 	int fd;
@@ -323,7 +322,7 @@ static void setup(void)
 				tst_brkm(TBROK | TERRNO, cleanup, "open");
 			snprintf(buf, BUFSIZ, "%ld",
 				 (long)(length / 2 * hugepagesize));
-			if (write(fd, buf, strlen(buf)) != strlen(buf))
+			if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
 				tst_brkm(TBROK | TERRNO, cleanup,
 					 "failed to change shmmax.");
 		}
@@ -347,7 +346,7 @@ static void setup(void)
 	if (lseek(fd, 0, SEEK_SET) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "lseek");
 	snprintf(buf, BUFSIZ, "%zd", size);
-	if (write(fd, buf, strlen(buf)) != strlen(buf))
+	if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "failed to change nr_hugepages.");
 	close(fd);
@@ -371,7 +370,7 @@ static void setup(void)
 	if (lseek(fd, 0, SEEK_SET) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "lseek");
 	snprintf(buf, BUFSIZ, "%zd", size);
-	if (write(fd, buf, strlen(buf)) != strlen(buf))
+	if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "failed to change nr_hugepages.");
 	close(fd);
@@ -469,6 +468,7 @@ static void init_hugepagesize(void)
 {
 	FILE *fp;
 
+	check_hugepage();
 	memset(buf, -1, BUFSIZ);
 	fp = fopen(PATH_MEMINFO, "r");
 	if (fp == NULL)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 35e7216..8f994f6 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -101,7 +101,7 @@ int main(int ac, char **av)
 {
 	int lc, i;
 
-	tst_parse_opts(ac, av, options, &help);
+	tst_parse_opts(ac, av, options, NULL);
 
 	if (sflag)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
@@ -209,6 +209,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 2bac9c2..b1c5812 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -91,7 +91,7 @@ int main(int ac, char **av)
 {
 	int lc, i;
 
-	tst_parse_opts(ac, av, options, &help);
+	tst_parse_opts(ac, av, options, NULL);
 
 	if (sflag)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
@@ -125,6 +125,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index fe74810..12c9549 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -83,7 +83,7 @@ int main(int ac, char **av)
 	int status;
 	pid_t pid;
 
-	tst_parse_opts(ac, av, options, &help);
+	tst_parse_opts(ac, av, options, NULL);
 
 	if (sflag)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
@@ -131,6 +131,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index f631a0a..7a71747 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -47,6 +47,7 @@
 
 #include "test.h"
 #include "mem.h"
+#include "hugetlb.h"
 
 #define SIZE	(1024 * 1024 * 1024)
 #define BOUNDARY (1024 * 1024 * 1024)
@@ -57,7 +58,6 @@ int TST_TOTAL = 3;
 static long huge_free;
 static long huge_free2;
 static long hugepages;
-static long orig_hugepages;
 static long orig_shmmax, new_shmmax;
 
 static void shared_hugepage(void);
@@ -126,6 +126,7 @@ void setup(void)
 	long mem_total, hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 
 	mem_total = read_meminfo("MemTotal:");
 	SAFE_FILE_SCANF(NULL, PATH_SHMMAX, "%ld", &orig_shmmax);
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index d7990c7..a0d0c55 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -64,6 +64,7 @@
 #include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
+#include "hugetlb.h"
 
 char *TCID = "hugeshmctl01";
 int TST_TOTAL = 4;
@@ -112,7 +113,7 @@ int main(int ac, char **av)
 {
 	int lc, i;
 
-	tst_parse_opts(ac, av, options, &help);
+	tst_parse_opts(ac, av, options, NULL);
 
 	if (sflag)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
@@ -392,6 +393,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(FORK, sighandler, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index f79ee83..1ba6159 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -56,6 +56,7 @@
 #include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
+#include "hugetlb.h"
 
 char *TCID = "hugeshmctl02";
 int TST_TOTAL = 4;
@@ -95,7 +96,7 @@ int main(int ac, char **av)
 {
 	int lc, i;
 
-	tst_parse_opts(ac, av, options, &help);
+	tst_parse_opts(ac, av, options, NULL);
 
 	if (sflag)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
@@ -130,6 +131,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index e553a2a..f3a0d22 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -63,6 +63,7 @@
 #include "hugetlb.h"
 #include "safe_macros.h"
 #include "mem.h"
+#include "hugetlb.h"
 
 char *TCID = "hugeshmctl03";
 int TST_TOTAL = 3;
@@ -102,7 +103,7 @@ int main(int ac, char **av)
 	pid_t pid;
 	int status;
 
-	tst_parse_opts(ac, av, options, &help);
+	tst_parse_opts(ac, av, options, NULL);
 
 	if (sflag)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
@@ -156,6 +157,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index c8592b3..02c7a3d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -85,7 +85,7 @@ int main(int ac, char **av)
 {
 	int lc;
 
-	tst_parse_opts(ac, av, options, &help);
+	tst_parse_opts(ac, av, options, NULL);
 
 	if (sflag)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
@@ -165,6 +165,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, sighandler, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 5d45aaa..4c51599 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -79,7 +79,7 @@ int main(int ac, char **av)
 	int lc;
 	struct shmid_ds buf;
 
-	tst_parse_opts(ac, av, options, &help);
+	tst_parse_opts(ac, av, options, NULL);
 
 	if (sflag)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
@@ -143,6 +143,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 0ac4a29..73fab60 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -95,7 +95,7 @@ int main(int ac, char **av)
 	int lc, i;
 	int shm_id_2 = -1;
 
-	tst_parse_opts(ac, av, options, &help);
+	tst_parse_opts(ac, av, options, NULL);
 
 	if (sflag)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
@@ -138,6 +138,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 9a2a0b2..e38d3aa 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -82,7 +82,7 @@ int main(int ac, char **av)
 {
 	int lc;
 
-	tst_parse_opts(ac, av, options, &help);
+	tst_parse_opts(ac, av, options, NULL);
 
 	if (sflag)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
@@ -113,6 +113,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 567b02d..2a0d468 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -85,7 +85,7 @@ int main(int ac, char **av)
 	pid_t pid;
 	int status;
 
-	tst_parse_opts(ac, av, options, &help);
+	tst_parse_opts(ac, av, options, NULL);
 
 	if (sflag)
 		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
@@ -135,6 +135,7 @@ void setup(void)
 	long hpage_size;
 
 	tst_require_root();
+	check_hugepage();
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 4b2a3d2..dae7da3 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -26,10 +26,10 @@
  *
  *	The library contains the following routines:
  *
+ *	check_hugepage()
  *	getipckey()
  *	getuserid()
  *	rm_shm()
- *	help()
  */
 
 #include <sys/types.h>
@@ -39,6 +39,12 @@
 #include <pwd.h>
 #include "hugetlb.h"
 
+void check_hugepage(void)
+{
+	if (access(PATH_HUGEPAGES, F_OK))
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+}
+
 /*
  * getipckey() - generates and returns a message key used by the "get"
  *		 calls to create an IPC resource.
@@ -109,8 +115,3 @@ void rm_shm(int shm_id)
 		tst_resm(TINFO, "id = %d", shm_id);
 	}
 }
-
-void help(void)
-{
-	printf("    -s NUM  Set the number of hugepages to be allocated\n");
-}
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index 6d73e9c..9b76abe 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -43,9 +43,12 @@
  * from shmid_ds.ipc_perm.mode
  */
 #define MODE_MASK	0x01FF
+#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
 
 key_t shmkey;			/* an IPC key generated by ftok() */
 
+void check_hugepage(void);
+
 int getipckey(void);
 int getuserid(char *user);
 void rm_shm(int shm_id);
@@ -56,6 +59,5 @@ void setup(void);
 char *nr_opt;
 int sflag;
 long orig_hugepages;
-void help(void);
 
 #endif /* hugetlb.h */
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index dcefde8..3c70383 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -50,6 +50,7 @@
 
 #define PATH_MEMINFO "/proc/meminfo"
 #define PATH_NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
+#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
 
 const char *TCID = "futex_wake04";
 const int TST_TOTAL = 1;
@@ -69,6 +70,9 @@ static void setup(void)
 			"that are 2.6.32 or higher");
 	}
 
+	if (access(PATH_HUGEPAGES, F_OK))
+		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+
 	tst_tmpdir();
 
 	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
-- 
1.8.3.1

