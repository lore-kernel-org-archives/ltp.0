From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 17 May 2021 17:30:28 +0100
Subject: [LTP] [RFC PATCH 5/6] API: Add tst_ to hugepage opt vars
In-Reply-To: <20210517163029.22974-1-rpalethorpe@suse.com>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
Message-ID: <20210517163029.22974-6-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_hugepage.h                             |  4 ++--
 lib/tst_hugepage.c                                 |  8 ++++----
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c | 14 +++++++-------
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c | 14 +++++++-------
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c | 14 +++++++-------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   |  2 +-
 16 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index e08a2daa2..67104de14 100644
--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -9,8 +9,8 @@
 #define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
 #define PATH_NR_HPAGES	"/proc/sys/vm/nr_hugepages"
 
-extern char *nr_opt; /* -s num   Set the number of the been allocated hugepages */
-extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
+extern char *tst_hugepage_nr_opt; /* -s num   Set the number of the been allocated hugepages */
+extern char *tst_hugepage_Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
 
 /*
  * Get the default hugepage size. Returns 0 if hugepages are not supported.
diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index 1d0e62e5b..1180beb87 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -9,8 +9,8 @@
 #include "tst_hugepage.h"
 
 unsigned long tst_hugepages;
-char *nr_opt;
-char *Hopt;
+char *tst_hugepage_nr_opt;
+char *tst_hugepage_Hopt;
 
 size_t tst_get_hugepage_size(void)
 {
@@ -29,8 +29,8 @@ unsigned long tst_request_hugepages(unsigned long hpages)
 		goto out;
 	}
 
-	if (nr_opt)
-		tst_hugepages = SAFE_STRTOL(nr_opt, 1, LONG_MAX);
+	if (tst_hugepage_nr_opt)
+		tst_hugepages = SAFE_STRTOL(tst_hugepage_nr_opt, 1, LONG_MAX);
 	else
 		tst_hugepages = hpages;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 1783bfb12..564f6aaf3 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -74,25 +74,25 @@ void setup(void)
 	if (tst_hugepages == 0)
 		tst_brk(TCONF, "Not enough hugepages for testing.");
 
-	if (!Hopt)
-		Hopt = tst_get_tmpdir();
-	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+	if (!tst_hugepage_Hopt)
+		tst_hugepage_Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", tst_hugepage_Hopt, "hugetlbfs", 0, NULL);
 
-	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
+	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", tst_hugepage_Hopt, getpid());
 }
 
 void cleanup(void)
 {
 	unlink(TEMPFILE);
-	umount(Hopt);
+	umount(tst_hugepage_Hopt);
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"H:", &Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"H:", &tst_hugepage_Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 0b27154af..df1f27419 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -121,25 +121,25 @@ static void setup(void)
 	if (tst_hugepages == 0)
 		tst_brk(TCONF, "Not enough hugepages for testing.");
 
-	if (!Hopt)
-		Hopt = tst_get_tmpdir();
-	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+	if (!tst_hugepage_Hopt)
+		tst_hugepage_Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", tst_hugepage_Hopt, "hugetlbfs", 0, NULL);
 
-	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
+	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", tst_hugepage_Hopt, getpid());
 }
 
 static void cleanup(void)
 {
 	unlink(TEMPFILE);
-	umount(Hopt);
+	umount(tst_hugepage_Hopt);
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"H:", &Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"H:", &tst_hugepage_Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index f63b41f28..12d7705fd 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -92,25 +92,25 @@ void setup(void)
 	if (tst_hugepages == 0)
 		tst_brk(TCONF, "Not enough hugepages for testing!");
 
-	if (!Hopt)
-		Hopt = tst_get_tmpdir();
-	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+	if (!tst_hugepage_Hopt)
+		tst_hugepage_Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", tst_hugepage_Hopt, "hugetlbfs", 0, NULL);
 
-	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
+	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", tst_hugepage_Hopt, getpid());
 }
 
 void cleanup(void)
 {
 	unlink(TEMPFILE);
-	umount(Hopt);
+	umount(tst_hugepage_Hopt);
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"H:", &Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"H:", &tst_hugepage_Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index f206522c0..f6235f8eb 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -173,7 +173,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index fcad8f5d9..739b29c43 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -100,7 +100,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 1f1d2613a..4e20434f1 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -95,7 +95,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.test_all = verify_hugeshmat,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index b5b5496fd..45157fc6f 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -303,7 +303,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index e014edd94..ed819e949 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -105,7 +105,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 8c485810d..3c35efc4b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -128,7 +128,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 571a4cf10..c6641d041 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -146,7 +146,7 @@ void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 470563653..a161a1da0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -72,7 +72,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 323b5d6d1..d102b8f40 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -91,7 +91,7 @@ void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index f18c1a124..0b1e2fcd0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -90,7 +90,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 60c86455c..4452f97e3 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -86,7 +86,7 @@ void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &tst_hugepage_nr_opt, "-s num   Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
-- 
2.31.1

