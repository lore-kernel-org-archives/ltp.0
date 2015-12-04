From: Li Wang <liwang@redhat.com>
Date: Fri,  4 Dec 2015 14:29:37 +0800
Subject: [LTP] [PATCH v2 2/2] hugetlb: checking if hugepage is supported on
	target system
Message-ID: <1449210577-14950-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
     v1 ---> v2
     a. Remove the cleanup() and setup() from lib/hugetlb.h
     b. Change the getipckey() and getuserid() to have the cleanup_fn callback

 testcases/kernel/mem/hugetlb/hugemmap/Makefile     |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |  4 ++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |  5 +++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |  4 ++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | 14 +++++++------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |  5 +++--
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |  5 +++--
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |  7 ++++---
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat04.c     |  3 ++-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |  6 ++++--
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |  6 ++++--
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   |  8 +++++---
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     |  5 +++--
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |  5 +++--
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |  5 +++--
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |  3 ++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   |  7 ++++---
 testcases/kernel/mem/hugetlb/lib/hugetlb.c         | 23 +++++++++++-----------
 testcases/kernel/mem/hugetlb/lib/hugetlb.h         | 11 +++++------
 testcases/kernel/syscalls/futex/futex_wake04.c     |  4 ++++
 20 files changed, 77 insertions(+), 55 deletions(-)

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
index b68c981..b127566 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -48,6 +48,7 @@
 #include <string.h>
 #include <ctype.h>
 #include "test.h"
+#include "hugetlb.h"
 
 #define PROTECTION		(PROT_READ | PROT_WRITE)
 #define PATH_MEMINFO		"/proc/meminfo"
@@ -255,7 +256,7 @@ static void cleanup(void)
 		fd = open(PATH_SHMMAX, O_WRONLY);
 		if (fd == -1)
 			tst_resm(TWARN | TERRNO, "open");
-		if (write(fd, shmmax, strlen(shmmax)) != strlen(shmmax))
+		if (write(fd, shmmax, strlen(shmmax)) != (ssize_t)strlen(shmmax))
 			tst_resm(TWARN | TERRNO, "write");
 		close(fd);
 	}
@@ -264,7 +265,7 @@ static void cleanup(void)
 		tst_resm(TWARN | TERRNO, "open");
 	tst_resm(TINFO, "restore nr_hugepages to %s.", nr_hugepages);
 	if (write(fd, nr_hugepages,
-		  strlen(nr_hugepages)) != strlen(nr_hugepages))
+		  strlen(nr_hugepages)) != (ssize_t)strlen(nr_hugepages))
 		tst_resm(TWARN | TERRNO, "write");
 	close(fd);
 
@@ -274,7 +275,7 @@ static void cleanup(void)
 	tst_resm(TINFO, "restore nr_overcommit_hugepages to %s.",
 		 nr_overcommit_hugepages);
 	if (write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
-	    != strlen(nr_overcommit_hugepages))
+	    != (ssize_t)strlen(nr_overcommit_hugepages))
 		tst_resm(TWARN | TERRNO, "write");
 	close(fd);
 
@@ -323,7 +324,7 @@ static void setup(void)
 				tst_brkm(TBROK | TERRNO, cleanup, "open");
 			snprintf(buf, BUFSIZ, "%ld",
 				 (long)(length / 2 * hugepagesize));
-			if (write(fd, buf, strlen(buf)) != strlen(buf))
+			if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
 				tst_brkm(TBROK | TERRNO, cleanup,
 					 "failed to change shmmax.");
 		}
@@ -347,7 +348,7 @@ static void setup(void)
 	if (lseek(fd, 0, SEEK_SET) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "lseek");
 	snprintf(buf, BUFSIZ, "%zd", size);
-	if (write(fd, buf, strlen(buf)) != strlen(buf))
+	if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "failed to change nr_hugepages.");
 	close(fd);
@@ -371,7 +372,7 @@ static void setup(void)
 	if (lseek(fd, 0, SEEK_SET) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "lseek");
 	snprintf(buf, BUFSIZ, "%zd", size);
-	if (write(fd, buf, strlen(buf)) != strlen(buf))
+	if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "failed to change nr_hugepages.");
 	close(fd);
@@ -469,6 +470,7 @@ static void init_hugepagesize(void)
 {
 	FILE *fp;
 
+	check_hugepage();
 	memset(buf, -1, BUFSIZ);
 	fp = fopen(PATH_MEMINFO, "r");
 	if (fp == NULL)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 35e7216..cfb4d72 100644
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
 
@@ -218,7 +219,7 @@ void setup(void)
 
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
-	shmkey = getipckey();
+	shmkey = getipckey(cleanup);
 	shm_id_1 = shmget(shmkey++, shm_size,
 			  SHM_HUGETLB | SHM_RW | IPC_CREAT | IPC_EXCL);
 	if (shm_id_1 == -1)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 2bac9c2..e644178 100644
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
 
@@ -134,7 +135,7 @@ void setup(void)
 
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
-	shmkey = getipckey();
+	shmkey = getipckey(cleanup);
 
 	/* create a shared memory resource with read and write permissions */
 	/* also post increment the shmkey for the next shmget call */
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index fe74810..a0cea9a 100644
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
 
@@ -140,13 +141,13 @@ void setup(void)
 
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
-	shmkey = getipckey();
+	shmkey = getipckey(cleanup);
 	shm_id_1 = shmget(shmkey, shm_size,
 			  SHM_HUGETLB | SHM_RW | IPC_CREAT | IPC_EXCL);
 	if (shm_id_1 == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
 
-	ltp_uid = getuserid(ltp_user);
+	ltp_uid = getuserid(cleanup, ltp_user);
 
 	TEST_PAUSE;
 }
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
index d7990c7..2c23332 100644
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
 
@@ -401,7 +403,7 @@ void setup(void)
 
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
-	shmkey = getipckey();
+	shmkey = getipckey(cleanup);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index f79ee83..af98e67 100644
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
 
@@ -139,7 +141,7 @@ void setup(void)
 
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
-	shmkey = getipckey();
+	shmkey = getipckey(cleanup);
 
 	/* create a shared memory segment without read or write permissions */
 	shm_id_1 = shmget(shmkey, shm_size, SHM_HUGETLB | IPC_CREAT | IPC_EXCL);
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index e553a2a..a9f6efa 100644
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
 
@@ -165,14 +167,14 @@ void setup(void)
 
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
-	shmkey = getipckey();
+	shmkey = getipckey(cleanup);
 	shm_id_1 = shmget(shmkey, shm_size,
 			  SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
 	if (shm_id_1 == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
 
 	/* get the userid for a non root user */
-	ltp_uid = getuserid(ltp_user);
+	ltp_uid = getuserid(cleanup, ltp_user);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index c8592b3..0ebcca6 100644
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
 
@@ -174,7 +175,7 @@ void setup(void)
 
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
-	shmkey = getipckey();
+	shmkey = getipckey(cleanup);
 
 	/* create a shared memory resource with read and write permissions */
 	shm_id_1 = shmget(shmkey, shm_size,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 5d45aaa..2367c4d 100644
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
 
@@ -152,7 +153,7 @@ void setup(void)
 
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
-	shmkey = getipckey();
+	shmkey = getipckey(cleanup);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 0ac4a29..5f2cb31 100644
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
 
@@ -148,7 +149,7 @@ void setup(void)
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
 
-	shmkey = getipckey();
+	shmkey = getipckey(cleanup);
 	shmkey2 = shmkey + 1;
 	shm_id_1 = shmget(shmkey, shm_size, IPC_CREAT | IPC_EXCL | SHM_RW);
 	if (shm_id_1 == -1)
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
index 567b02d..1a96c3c 100644
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
 
@@ -144,14 +145,14 @@ void setup(void)
 
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
-	shmkey = getipckey();
+	shmkey = getipckey(cleanup);
 	shm_id_1 = shmget(shmkey, shm_size,
 			  SHM_HUGETLB | SHM_RW | IPC_CREAT | IPC_EXCL);
 	if (shm_id_1 == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "shmget #setup");
 
 	/* get the userid for a non-root user */
-	ltp_uid = getuserid(ltp_user);
+	ltp_uid = getuserid(cleanup, ltp_user);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 4b2a3d2..4a9d489 100644
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
@@ -39,11 +39,17 @@
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
  */
-int getipckey(void)
+int getipckey(void (*cleanup_fn) (void))
 {
 	const char a = 'a';
 	int ascii_a = (int)a;
@@ -54,7 +60,7 @@ int getipckey(void)
 
 	curdir = getcwd(curdir, size);
 	if (curdir == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "getcwd(curdir)");
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "getcwd(curdir)");
 
 	/*
 	 * Get a Sys V IPC key
@@ -73,7 +79,7 @@ int getipckey(void)
 
 	ipc_key = ftok(curdir, ascii_a + random() % 26);
 	if (ipc_key == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "ftok");
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "ftok");
 
 	return ipc_key;
 }
@@ -81,13 +87,13 @@ int getipckey(void)
 /*
  * getuserid() - return the integer value for the "user" id
  */
-int getuserid(char *user)
+int getuserid(void (*cleanup_fn) (void), char *user)
 {
 	struct passwd *ent;
 
 	ent = getpwnam(user);
 	if (ent == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "getpwnam");
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "getpwnam");
 
 	return ent->pw_uid;
 }
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
index 6d73e9c..bf2e1ed 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -43,19 +43,18 @@
  * from shmid_ds.ipc_perm.mode
  */
 #define MODE_MASK	0x01FF
+#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
 
 key_t shmkey;			/* an IPC key generated by ftok() */
 
-int getipckey(void);
-int getuserid(char *user);
-void rm_shm(int shm_id);
+void check_hugepage(void);
 
-void cleanup(void);
-void setup(void);
+int getipckey(void (*cleanup_fn) (void));
+int getuserid(void (*cleanup_fn) (void), char *user);
+void rm_shm(int shm_id);
 
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

