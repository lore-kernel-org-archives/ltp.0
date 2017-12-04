From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon,  4 Dec 2017 16:36:45 +0000
Subject: [LTP] [PATCH v3 02/12] thp: ensure hugetlbfs is available
In-Reply-To: <20171204163655.8838-1-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
Message-ID: <20171204163655.8838-3-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Will Deacon <will.deacon@arm.com>

The THP tests thp02 and thp03 depend on the presence of hugetlbfs to get
the default hugepage size. If hugetlbfs is not enabled, /proc/meminfo
does not contain "Hugepagesize" and the tests fail with -

safe_file_ops.c:220: BROK: Expected 1 conversions got 0 at thp03.c:85

which is hard to relate to the missing support for hugetlbfs.

Add tests for the presence of hugetlbfs for tests relying on this kernel
feature.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/mem/thp/thp02.c | 2 ++
 testcases/kernel/mem/thp/thp03.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/thp02.c
index acc70e215..6502210e5 100644
--- a/testcases/kernel/mem/thp/thp02.c
+++ b/testcases/kernel/mem/thp/thp02.c
@@ -90,6 +90,8 @@ static void setup(void)
 	if (access(PATH_THP, F_OK) == -1)
 		tst_brk(TCONF, "THP not enabled in kernel?");
 
+	check_hugepage();
+
 	ps = sysconf(_SC_PAGESIZE);
 	hps = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	size = hps * 4;
diff --git a/testcases/kernel/mem/thp/thp03.c b/testcases/kernel/mem/thp/thp03.c
index 19db44944..c6062505f 100644
--- a/testcases/kernel/mem/thp/thp03.c
+++ b/testcases/kernel/mem/thp/thp03.c
@@ -82,6 +82,8 @@ static void setup(void)
 	if (access(PATH_THP, F_OK) == -1)
 		tst_brk(TCONF, "THP not enabled in kernel?");
 
+	check_hugepage();
+
 	hugepage_size = SAFE_READ_MEMINFO("Hugepagesize:") * KB;
 	unaligned_size = hugepage_size * 4 - 1;
 	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
-- 
2.15.0

