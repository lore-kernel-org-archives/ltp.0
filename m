From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Apr 2019 11:18:59 +0800
Subject: [LTP] [PATCH v4] hugetlb: limit hugepages according to MemAvailable
Message-ID: <20190430031859.28473-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Xiao Liang <xiliang@redhat.com>

When the system's Hugepagesize is large(eg. 512MiB), the test may
break as cannot set nr_hugepages to default 128.

This patch continue to set 128 as default hugepages, but it checks
the memory available and hugepagesize registered. If default 128 is
larger than max available count, then reset the hugepages to 80% of
the max page count.

Without this patch:
  # ./hugemmap01
  tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
  mem.c:814: INFO: set nr_hugepages to 128
  mem.c:823: BROK: nr_hugepages = 54, but expect 128
  mem.c:814: INFO: set nr_hugepages to 0

With this patch:
  # ./hugemmap01  -s 100000000
  tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
  hugetlb.c:67: INFO: The hugepages beyond system available, here reset to 80% of the max page count 14502
  mem.c:814: INFO: set nr_hugepages to 11601
  hugemmap01.c:73: PASS: call succeeded
  mem.c:814: INFO: set nr_hugepages to 0

Signed-off-by: Xiao Liang <xiliang@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap01.c  |  2 ++
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  |  2 ++
 .../kernel/mem/hugetlb/hugemmap/hugemmap04.c  |  2 ++
 .../mem/hugetlb/hugeshmat/hugeshmat01.c       |  1 +
 .../mem/hugetlb/hugeshmat/hugeshmat02.c       |  1 +
 .../mem/hugetlb/hugeshmat/hugeshmat03.c       |  1 +
 .../mem/hugetlb/hugeshmctl/hugeshmctl01.c     |  1 +
 .../mem/hugetlb/hugeshmctl/hugeshmctl02.c     |  1 +
 .../mem/hugetlb/hugeshmctl/hugeshmctl03.c     |  1 +
 .../mem/hugetlb/hugeshmdt/hugeshmdt01.c       |  1 +
 .../mem/hugetlb/hugeshmget/hugeshmget01.c     |  1 +
 .../mem/hugetlb/hugeshmget/hugeshmget02.c     |  1 +
 .../mem/hugetlb/hugeshmget/hugeshmget03.c     |  1 +
 .../mem/hugetlb/hugeshmget/hugeshmget05.c     |  1 +
 testcases/kernel/mem/hugetlb/lib/hugetlb.c    | 24 +++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |  1 +
 16 files changed, 42 insertions(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 4dc330dc0..a6ffab77b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -97,6 +97,8 @@ void setup(void)
 
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 9b0ab4e37..26314d125 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -144,6 +144,8 @@ static void setup(void)
 
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 55a3a24f4..35bae015b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -115,6 +115,8 @@ void setup(void)
 
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 942f99e76..712398e27 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -171,6 +171,7 @@ static void setup(void)
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 1cba867e5..945de584d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -96,6 +96,7 @@ void setup(void)
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 13221b1a8..34fea5cd7 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -91,6 +91,7 @@ static void setup(void)
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index c639c8e5f..9353564e4 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -315,6 +315,7 @@ void setup(void)
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 4009fd804..ab7dc1e6e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -96,6 +96,7 @@ static void setup(void)
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 00872e9d6..480a51e4c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -121,6 +121,7 @@ void setup(void)
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index d706d33b9..171868aeb 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -136,6 +136,7 @@ void setup(void)
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 70fb13185..1636260ce 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -71,6 +71,7 @@ static void setup(void)
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index d1c0e64b8..e8de3251f 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -89,6 +89,7 @@ void setup(void)
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 733a25cdb..d5255228b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -70,6 +70,7 @@ static void setup(void)
 
 	SAFE_FILE_SCANF(PATH_SHMMNI, "%ld", &orig_shmmni);
 
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	SAFE_FILE_PRINTF(PATH_SHMMNI, "%ld", hugepages / 2);
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 841f527b7..824293fb8 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -82,6 +82,7 @@ void setup(void)
 	if (nr_opt)
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
+	limit_hugepages(&hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 1ea47ebb5..66844f3e2 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -56,6 +56,30 @@ void restore_nr_hugepages(void)
 		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
+void limit_hugepages(long *hpages)
+{
+	long mem_avail, max_hpages;
+
+	if (FILE_LINES_SCANF("/proc/meminfo",
+			"MemAvailable: %ld", &mem_avail)) {
+		/*
+		 * Dropping caches and using "MemFree:" on kernel
+		 * that doesn't have "MemAvailable:" in Meminfo
+		 */
+		SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
+		mem_avail = SAFE_READ_MEMINFO("MemFree:");
+	}
+
+	max_hpages = mem_avail / SAFE_READ_MEMINFO("Hugepagesize:");
+
+	if (*hpages > max_hpages) {
+		tst_res(TINFO, "The hugepages beyond system available, here "
+				"reset to 80%% of the max page count %ld",
+				max_hpages);
+		*hpages = max_hpages * 0.8;
+	}
+}
+
 /*
  * getipckey() - generates and returns a message key used by the "get"
  *		 calls to create an IPC resource.
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index 2843f0a8e..baf643d2a 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -58,5 +58,6 @@ char *Hopt;
 void check_hugepage(void);
 long save_nr_hugepages(void);
 void restore_nr_hugepages(void);
+void limit_hugepages(long *hpages);
 
 #endif /* hugetlb.h */
-- 
2.20.1

