From: Li Wang <liwang@redhat.com>
Date: Fri,  1 Dec 2017 11:55:59 +0800
Subject: [LTP] [PATCH v2] hugetlb: fix warnings in cleanup()
Message-ID: <20171201035559.11478-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adding two functions [save|restore]_nr_hugepages() to the hugetlb
library, and meanwhile initialize the 'orig_hugepages' to '-1', then
we can make use of that to avoid those warnings on a system without
huge page supporting.

WARNING:
   safe_file_ops.c:283: WARN: Failed to open FILE '/proc/sys/vm/nr_hugepages'
   for writing at mem.c:853: ENOENT

Also, including "mem.h" in hugetlb lib to get rid of compile warnings.

Signed-off-by: Li Wang <liwang@redhat.com>
CC: Punit Agrawal <punit.agrawal@arm.com>
CC: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c     |  7 ++-----
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c     |  7 ++-----
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c     |  7 ++-----
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c     |  3 +--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c     |  6 ++----
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c   |  7 ++-----
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c   |  7 ++-----
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c   |  7 ++-----
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c   |  6 ++----
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c   |  6 ++----
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c |  6 ++----
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c |  6 ++----
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c |  6 ++----
 testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c   |  6 ++----
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c |  6 ++----
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c |  6 ++----
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c |  6 ++----
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c |  6 ++----
 testcases/kernel/mem/hugetlb/lib/Makefile              |  1 +
 testcases/kernel/mem/hugetlb/lib/hugetlb.c             | 14 ++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h             |  8 +++++---
 21 files changed, 55 insertions(+), 79 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 212a852..4dc330d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -37,8 +37,6 @@
 #include <sys/mount.h>
 #include <limits.h>
 #include <sys/param.h>
-
-#include "mem.h"
 #include "hugetlb.h"
 
 static struct tst_option options[] = {
@@ -91,8 +89,7 @@ static void test_hugemmap(void)
 
 void setup(void)
 {
-	check_hugepage();
-	orig_hugepages = get_sys_tune("nr_hugepages");
+	save_nr_hugepages();
 
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
@@ -108,7 +105,7 @@ void setup(void)
 void cleanup(void)
 {
 	unlink(TEMPFILE);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 
 	umount(Hopt);
 }
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 52db226..0be753e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -39,8 +39,6 @@
 #include <sys/mount.h>
 #include <limits.h>
 #include <sys/param.h>
-
-#include "mem.h"
 #include "hugetlb.h"
 
 #define LOW_ADDR       0x80000000
@@ -137,8 +135,7 @@ static void test_hugemmap(void)
 
 static void setup(void)
 {
-	check_hugepage();
-	orig_hugepages = get_sys_tune("nr_hugepages");
+	save_nr_hugepages();
 
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
@@ -154,7 +151,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	unlink(TEMPFILE);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 
 	umount(Hopt);
 }
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 2a368a3..674d367 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -38,8 +38,6 @@
 #include <stdio.h>
 #include <limits.h>
 #include <sys/param.h>
-
-#include "mem.h"
 #include "hugetlb.h"
 
 static struct tst_option options[] = {
@@ -108,8 +106,7 @@ static void test_hugemmap(void)
 
 void setup(void)
 {
-	check_hugepage();
-	orig_hugepages = get_sys_tune("nr_hugepages");
+	save_nr_hugepages();
 
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
@@ -125,7 +122,7 @@ void setup(void)
 void cleanup(void)
 {
 	unlink(TEMPFILE);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 
 	umount(Hopt);
 }
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index c73a975..445b05f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -29,7 +29,6 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
-#include "mem.h"
 #include "hugetlb.h"
 #include "tst_safe_sysv_ipc.h"
 #include "tst_test.h"
@@ -206,8 +205,8 @@ static void cleanup(void)
 
 static void setup(void)
 {
-	hugepagesize = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	check_hugepage();
+	hugepagesize = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	init_sys_sz_paths();
 
 	if (opt_sysfs) {
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index 40caf81..550a91e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -35,7 +35,6 @@
 #define _GNU_SOURCE
 #include <pthread.h>
 #include <stdio.h>
-#include "mem.h"
 #include "hugetlb.h"
 #include "lapi/mmap.h"
 
@@ -52,10 +51,9 @@ struct mp {
 
 static void setup(void)
 {
-	check_hugepage();
+	save_nr_hugepages();
 
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
-	orig_hugepages = get_sys_tune("nr_hugepages");
 
 	hugepages = (ARSZ + 1) * LOOP;
 
@@ -67,7 +65,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static void *thr(void *arg)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index a0867a8..942f99e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -39,8 +39,6 @@
 
 #include <limits.h>
 #include "hugetlb.h"
-#include "mem.h"
-#include "hugetlb.h"
 
 #define CASE0 10 /* values to write into the shared */
 #define CASE1 20 /* memory location.                */
@@ -169,11 +167,10 @@ static void setup(void)
 {
 	long hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -190,7 +187,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index f45151d..1c2c978 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -37,8 +37,6 @@
 #include <pwd.h>
 #include <limits.h>
 #include "hugetlb.h"
-#include "mem.h"
-#include "hugetlb.h"
 
 #if __WORDSIZE == 64
 #define NADDR	0x10000000eef	/* a 64bit non alligned address value */
@@ -93,11 +91,10 @@ void setup(void)
 {
 	long hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -116,7 +113,7 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_2);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 83534e5..13221b1 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -43,8 +43,6 @@
 
 #include <limits.h>
 #include "hugetlb.h"
-#include "mem.h"
-#include "hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
@@ -89,11 +87,10 @@ static void setup(void)
 {
 	long hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -111,7 +108,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 1411af6..99d0386 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -30,7 +30,6 @@
  * 	test must be run at root
  */
 
-#include "mem.h"
 #include "hugetlb.h"
 
 #define SIZE	(1024 * 1024 * 1024)
@@ -86,7 +85,7 @@ static void setup(void)
 {
 	long mem_total, hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	mem_total = SAFE_READ_MEMINFO("MemTotal:");
 	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &orig_shmmax);
 	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", (long)SIZE);
@@ -98,7 +97,6 @@ static void setup(void)
 	if (new_shmmax < SIZE)
 		tst_brk(TCONF,	"shmmax too low, have: %ld", new_shmmax);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
 	hugepages = (orig_hugepages * hpage_size + SIZE) / hpage_size;
@@ -107,7 +105,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", orig_shmmax);
 }
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index d86d7f9..a587391 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
@@ -36,7 +36,6 @@
  *
  */
 
-#include "mem.h"
 #include "hugetlb.h"
 
 static long page_size;
@@ -47,8 +46,7 @@ static long hugepages;
 
 void setup(void)
 {
-	check_hugepage();
-	orig_hugepages = get_sys_tune("nr_hugepages");
+	save_nr_hugepages();
 	page_size = getpagesize();
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -58,7 +56,7 @@ void setup(void)
 
 void cleanup(void)
 {
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 void shm_test(int size)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index ad7a80d..248065d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -42,7 +42,6 @@
  */
 
 #include <limits.h>
-#include "mem.h"
 #include "hugetlb.h"
 
 #define FIRST		0
@@ -360,11 +359,10 @@ void setup(void)
 {
 	long hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -376,7 +374,7 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 6079d99..8a3eee4 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -35,7 +35,6 @@
 
 #include <pwd.h>
 #include <limits.h>
-#include "mem.h"
 #include "hugetlb.h"
 
 static size_t shm_size;
@@ -93,11 +92,10 @@ static void setup(void)
 {
 	long hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -121,7 +119,7 @@ static void cleanup(void)
 {
 	rm_shm(shm_id_1);
 	rm_shm(shm_id_2);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 0474b31..63dc4ce 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -45,7 +45,6 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <limits.h>
-#include "mem.h"
 #include "hugetlb.h"
 
 static size_t shm_size;
@@ -118,11 +117,10 @@ void setup(void)
 {
 	long hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -141,7 +139,7 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 796d6df..d706d33 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -42,7 +42,6 @@
 #include <setjmp.h>
 #include <limits.h>
 #include "hugetlb.h"
-#include "mem.h"
 #include "hugetlb.h"
 
 static size_t shm_size;
@@ -133,11 +132,10 @@ void setup(void)
 {
 	long hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -163,7 +161,7 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index ac3a1f0..70fb131 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -25,7 +25,6 @@
 
 #include <limits.h>
 #include "hugetlb.h"
-#include "mem.h"
 #include "hugetlb.h"
 
 static size_t shm_size;
@@ -68,11 +67,10 @@ static void setup(void)
 {
 	long hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -89,7 +87,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 7db8b4e..657b66e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -24,7 +24,6 @@
 #include <limits.h>
 #include "hugetlb.h"
 
-#include "mem.h"
 #include "hugetlb.h"
 
 static size_t shm_size;
@@ -86,11 +85,10 @@ void setup(void)
 {
 	long hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -107,7 +105,7 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index f485b0d..2ea3df9 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -24,7 +24,6 @@
 
 #include <limits.h>
 #include "hugetlb.h"
-#include "mem.h"
 #include "hugetlb.h"
 
 /*
@@ -65,11 +64,10 @@ static void setup(void)
 {
 	long hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	SAFE_FILE_SCANF(PATH_SHMMNI, "%ld", &orig_shmmni);
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
@@ -107,7 +105,7 @@ static void cleanup(void)
 		rm_shm(shm_id_arr[i]);
 
 	FILE_PRINTF(PATH_SHMMNI, "%ld", orig_shmmni);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 790d736..ae28bb3 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -26,7 +26,6 @@
 #include <sys/wait.h>
 #include <limits.h>
 #include "hugetlb.h"
-#include "mem.h"
 #include "hugetlb.h"
 
 static size_t shm_size;
@@ -79,11 +78,10 @@ void setup(void)
 {
 	long hpage_size;
 
-	check_hugepage();
+	save_nr_hugepages();
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
-	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
@@ -102,7 +100,7 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	restore_nr_hugepages();
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/lib/Makefile b/testcases/kernel/mem/hugetlb/lib/Makefile
index 96e8e37..c5c5564 100644
--- a/testcases/kernel/mem/hugetlb/lib/Makefile
+++ b/testcases/kernel/mem/hugetlb/lib/Makefile
@@ -19,6 +19,7 @@
 top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 
 LIB			:= libhugetlb.a
 
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 7afc7d4..c9a2b2c 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -40,12 +40,26 @@
 #include <pwd.h>
 #include "hugetlb.h"
 
+long orig_hugepages = -1;
+
 void check_hugepage(void)
 {
 	if (access(PATH_HUGEPAGES, F_OK))
 		tst_brk(TCONF, "Huge page is not supported.");
 }
 
+void save_nr_hugepages(void)
+{
+	check_hugepage();
+	orig_hugepages = get_sys_tune("nr_hugepages");
+}
+
+void restore_nr_hugepages(void)
+{
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
+}
+
 /*
  * getipckey() - generates and returns a message key used by the "get"
  *		 calls to create an IPC resource.
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index c6d2016..492b570 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -31,6 +31,7 @@
 #include <sys/wait.h>
 #include "tst_test.h"
 #include "old_tmpdir.h"
+#include "mem.h"
 
 #define SHM_RD	0400
 #define SHM_WR	0200
@@ -49,14 +50,15 @@
 
 key_t shmkey;			/* an IPC key generated by ftok() */
 
-void check_hugepage(void);
-
 int getipckey(void);
 int getuserid(char *user);
 void rm_shm(int shm_id);
 
 char *nr_opt;
 char *Hopt;
-long orig_hugepages;
+extern long orig_hugepages;
+void check_hugepage(void);
+void save_nr_hugepages(void);
+void restore_nr_hugepages(void);
 
 #endif /* hugetlb.h */
-- 
2.9.3

