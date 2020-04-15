From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 13:26:32 +0200
Subject: [LTP] [PATCH v2 6/9] hugepage: Fix linking error with -fno-common
In-Reply-To: <20200415112635.14144-1-pvorel@suse.cz>
References: <20200415112635.14144-1-pvorel@suse.cz>
Message-ID: <20200415112635.14144-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

by moving definitions to tst_hugepage.c and adding extern declarations
to tst_hugepage.h.

Fixes: 156f91396 ("hugetlb: move nr_opt to tst_hugepage.h")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_hugepage.h | 4 ++--
 lib/tst_hugepage.c     | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index 30e00a377..60c03c5c5 100644
--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -9,8 +9,8 @@
 #define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
 #define PATH_NR_HPAGES	"/proc/sys/vm/nr_hugepages"
 
-char *nr_opt; /* -s num   Set the number of the been allocated hugepages */
-char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
+extern char *nr_opt; /* -s num   Set the number of the been allocated hugepages */
+extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
 
 /*
  * Try the best to request a specified number of huge pages from system,
diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index 34fd27ede..52667a14e 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -9,6 +9,8 @@
 #include "tst_hugepage.h"
 
 unsigned long tst_hugepages;
+char *nr_opt;
+char *Hopt;
 
 unsigned long tst_request_hugepages(unsigned long hpages)
 {
-- 
2.26.0

