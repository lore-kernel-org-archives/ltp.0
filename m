From: Xiao Liang <xiliang@redhat.com>
Date: Thu,  4 Apr 2019 13:43:47 +0800
Subject: [LTP] [PATCH v2] hugetlb: dynamically change default hugepages
Message-ID: <20190404054347.6499-1-xiliang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When the system's Hugepagesize is large(eg. 512MiB), the test may
break as cannot set nr_hugepages to default 128.

This patch continue to use 128 as default hugepages, but it checks
the memory available and Hugepagesize registered. If default 128 is
larger than available count, then use the small one.

With this patch:
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
hugemmap01.c:99: INFO: max page available count is 54
mem.c:814: INFO: set nr_hugepages to 54
hugemmap01.c:73: PASS: call succeeded
mem.c:814: INFO: set nr_hugepages to 0

Without this patch:
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
mem.c:814: INFO: set nr_hugepages to 128
mem.c:823: BROK: nr_hugepages = 54, but expect 128
mem.c:814: INFO: set nr_hugepages to 0

Signed-off-by: Xiao Liang <xiliang@redhat.com>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap01.c     |  5 ++++-
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c     |  5 ++++-
 .../kernel/mem/hugetlb/hugemmap/hugemmap04.c     |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c   |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c   |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c   |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c   |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c |  5 ++++-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c |  5 ++++-
 testcases/kernel/mem/hugetlb/lib/hugetlb.c       | 16 ++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h       |  1 +
 16 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 4dc330dc0..11ebe05c9 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -95,8 +95,11 @@ void setup(void)
 		Hopt = tst_get_tmpdir();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 	set_sys_tune("nr_hugepages", hugepages, 1);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 9b0ab4e37..8fc3f0c7e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -142,8 +142,11 @@ static void setup(void)
 		Hopt = tst_get_tmpdir();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 	set_sys_tune("nr_hugepages", hugepages, 1);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 55a3a24f4..d797d73a9 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -113,8 +113,11 @@ void setup(void)
 		Hopt = tst_get_tmpdir();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 	set_sys_tune("nr_hugepages", hugepages, 1);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 942f99e76..80d0738a7 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -168,8 +168,11 @@ static void setup(void)
 	long hpage_size;
 
 	save_nr_hugepages();
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 1cba867e5..77f1e0093 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -93,8 +93,11 @@ void setup(void)
 	long hpage_size;
 
 	save_nr_hugepages();
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 13221b1a8..32331feca 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -88,8 +88,11 @@ static void setup(void)
 	long hpage_size;
 
 	save_nr_hugepages();
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index c639c8e5f..024560529 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -312,8 +312,11 @@ void setup(void)
 	long hpage_size;
 
 	save_nr_hugepages();
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 4009fd804..9bd28f46b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -93,8 +93,11 @@ static void setup(void)
 	long hpage_size;
 
 	save_nr_hugepages();
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 00872e9d6..1584659d0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -118,8 +118,11 @@ void setup(void)
 	long hpage_size;
 
 	save_nr_hugepages();
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index d706d33b9..75be6a914 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -133,8 +133,11 @@ void setup(void)
 	long hpage_size;
 
 	save_nr_hugepages();
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 70fb13185..ebe7f0e9b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -68,8 +68,11 @@ static void setup(void)
 	long hpage_size;
 
 	save_nr_hugepages();
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index d1c0e64b8..2dfc36abc 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -86,8 +86,11 @@ void setup(void)
 	long hpage_size;
 
 	save_nr_hugepages();
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 733a25cdb..1c3b775be 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -65,8 +65,11 @@ static void setup(void)
 	long hpage_size;
 
 	save_nr_hugepages();
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 
 	SAFE_FILE_SCANF(PATH_SHMMNI, "%ld", &orig_shmmni);
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 841f527b7..998bee717 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -79,8 +79,11 @@ void setup(void)
 	long hpage_size;
 
 	save_nr_hugepages();
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages = get_available_hugepages();
+	}
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 1ea47ebb5..dacbe4918 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -56,6 +56,22 @@ void restore_nr_hugepages(void)
 		set_sys_tune("nr_hugepages", orig_hugepages, 0);
 }
 
+long get_available_hugepages(void)
+{
+	long page_sz = 0;
+	long mem_avail = 0;
+	long max_pages = 0;
+	long hugepages = 128;
+
+	page_sz = SAFE_READ_MEMINFO("Hugepagesize:");
+	mem_avail = SAFE_READ_MEMINFO("MemAvailable:");
+	max_pages = mem_avail/page_sz;
+	tst_res(TINFO, "max page available count is %ld", max_pages);
+	hugepages=(page_sz*hugepages>mem_avail)?max_pages:hugepages;
+
+	return hugepages;
+}
+
 /*
  * getipckey() - generates and returns a message key used by the "get"
  *		 calls to create an IPC resource.
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index 2843f0a8e..48a8d08f3 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -58,5 +58,6 @@ char *Hopt;
 void check_hugepage(void);
 long save_nr_hugepages(void);
 void restore_nr_hugepages(void);
+long get_available_hugepages(void);
 
 #endif /* hugetlb.h */
-- 
2.17.2

