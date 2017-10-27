From: Li Wang <liwang@redhat.com>
Date: Fri, 27 Oct 2017 16:56:32 +0800
Subject: [LTP] [PATCH] hugetlb: fix warnings in cleanup()
Message-ID: <20171027085632.18245-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It'd be better to define the 'orig_hugepages' to '-1' in hugetlb/lib,
then we can make use of it to avoid the warnings on a system without
huge page supporting.

WARNING:
   safe_file_ops.c:283: WARN: Failed to open FILE '/proc/sys/vm/nr_hugepages'
   for writing at mem.c:853: ENOENT

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c     | 3 ++-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c     | 3 ++-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c     | 3 ++-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c     | 2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c     | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c   | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c   | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c   | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c   | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c   | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c   | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c | 3 ++-
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c | 3 ++-
 testcases/kernel/mem/hugetlb/lib/hugetlb.c             | 2 ++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h             | 2 +-
 20 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 212a852..aed21ac 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -108,7 +108,8 @@ void setup(void)
 void cleanup(void)
 {
 	unlink(TEMPFILE);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 
 	umount(Hopt);
 }
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 52db226..1dc9c9b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -154,7 +154,8 @@ static void setup(void)
 static void cleanup(void)
 {
 	unlink(TEMPFILE);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 
 	umount(Hopt);
 }
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 2a368a3..7b423fc 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -125,7 +125,8 @@ void setup(void)
 void cleanup(void)
 {
 	unlink(TEMPFILE);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 
 	umount(Hopt);
 }
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index c73a975..e49c948 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -206,8 +206,8 @@ static void cleanup(void)
 
 static void setup(void)
 {
-	hugepagesize = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	check_hugepage();
+	hugepagesize = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	init_sys_sz_paths();
 
 	if (opt_sysfs) {
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index 40caf81..7bebfc2 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -67,7 +67,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static void *thr(void *arg)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index a0867a8..77242b4 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -190,7 +190,8 @@ static void setup(void)
 static void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index f45151d..1af6bcf 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -116,7 +116,8 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_2);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 83534e5..c7a1a9a 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -111,7 +111,8 @@ static void setup(void)
 static void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 1411af6..6ede95a 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -107,7 +107,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", orig_shmmax);
 }
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index d86d7f9..54c19c9 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
@@ -58,7 +58,8 @@ void setup(void)
 
 void cleanup(void)
 {
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 void shm_test(int size)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index ad7a80d..a465a60 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -376,7 +376,8 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 6079d99..2c2ccda 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -121,7 +121,8 @@ static void cleanup(void)
 {
 	rm_shm(shm_id_1);
 	rm_shm(shm_id_2);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 0474b31..66c261c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -141,7 +141,8 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 796d6df..b7a719d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -163,7 +163,8 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index ac3a1f0..c2234a7 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -89,7 +89,8 @@ static void setup(void)
 static void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 7db8b4e..341ff0a 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -107,7 +107,8 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index f485b0d..04c86cf 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -107,7 +107,8 @@ static void cleanup(void)
 		rm_shm(shm_id_arr[i]);
 
 	FILE_PRINTF(PATH_SHMMNI, "%ld", orig_shmmni);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 790d736..e0341e8 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -102,7 +102,8 @@ void setup(void)
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	if (orig_hugepages != -1)
+		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 7afc7d4..74fb3df 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -40,6 +40,8 @@
 #include <pwd.h>
 #include "hugetlb.h"
 
+long orig_hugepages = -1;
+
 void check_hugepage(void)
 {
 	if (access(PATH_HUGEPAGES, F_OK))
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index c6d2016..074e243 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -57,6 +57,6 @@ void rm_shm(int shm_id);
 
 char *nr_opt;
 char *Hopt;
-long orig_hugepages;
+extern long orig_hugepages;
 
 #endif /* hugetlb.h */
-- 
2.9.3

