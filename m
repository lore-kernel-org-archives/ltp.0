From: Punit Agrawal <punit.agrawal@arm.com>
Date: Tue, 14 Nov 2017 15:59:18 +0000
Subject: [LTP] [PATCH v2 02/13] thp: ensure THP/hugetlbfs is available
In-Reply-To: <20171114155929.24237-1-punit.agrawal@arm.com>
References: <20171114155929.24237-1-punit.agrawal@arm.com>
Message-ID: <20171114155929.24237-3-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Will Deacon <will.deacon@arm.com>

The THP tests can't pass if THP is unavailable or disabled. Add the
missing detection to thp01.c.

Also add tests for the presence of hugetlbfs for tests relying on this
kernel feature.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/mem/thp/thp01.c | 3 +++
 testcases/kernel/mem/thp/thp02.c | 2 ++
 testcases/kernel/mem/thp/thp03.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
index 2f2bb2bdb..939c01b98 100644
--- a/testcases/kernel/mem/thp/thp01.c
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -116,6 +116,9 @@ static void setup(void)
 	int i;
 	long arg_len, arg_count;
 
+	if (access(PATH_THP, F_OK) == -1)
+		tst_brk(TCONF, "THP not enabled in kernel?");
+
 	bst = SAFE_MMAP(NULL, sizeof(*bst),
 			   PROT_READ | PROT_WRITE,
 			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
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
2.14.2

