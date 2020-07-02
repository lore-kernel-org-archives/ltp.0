From: Martin Doucha <mdoucha@suse.cz>
Date: Thu,  2 Jul 2020 12:01:50 +0200
Subject: [LTP] [PATCH v3 1/2] Add tst_get_hugepage_size() to LTP library
Message-ID: <20200702100151.11780-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v2: Code style fixes.

 include/tst_hugepage.h | 5 +++++
 lib/tst_hugepage.c     | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index 60c03c5c5..e08a2daa2 100644
--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -12,6 +12,11 @@
 extern char *nr_opt; /* -s num   Set the number of the been allocated hugepages */
 extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
 
+/*
+ * Get the default hugepage size. Returns 0 if hugepages are not supported.
+ */
+size_t tst_get_hugepage_size(void);
+
 /*
  * Try the best to request a specified number of huge pages from system,
  * it will store the reserved hpage number in tst_hugepages.
diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index f2bf5d20e..1d0e62e5b 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -12,6 +12,14 @@ unsigned long tst_hugepages;
 char *nr_opt;
 char *Hopt;
 
+size_t tst_get_hugepage_size(void)
+{
+	if (access(PATH_HUGEPAGES, F_OK))
+		return 0;
+
+	return SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
+}
+
 unsigned long tst_request_hugepages(unsigned long hpages)
 {
 	unsigned long val, max_hpages;
-- 
2.26.2

