From: Li Wang <liwang@redhat.com>
Date: Thu, 30 Jul 2020 11:15:47 +0800
Subject: [LTP] [PATCH COMMITTED] futex: take use of the .request_hugepages
Message-ID: <20200730031547.24630-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To get rid of warnings when hugetlbfs is not supported.

  futex_wake04.c:65: CONF: Huge page is not supported.
  safe_file_ops.c:299: WARN: Failed to close FILE '/proc/sys/vm/nr_hugepages' at futex_wake04.c:76: EOPNOTSUPP (95)

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/syscalls/futex/futex_wake04.c      | 21 ++++---------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index 8fae7ced9..f6f571ac4 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -36,8 +36,6 @@ static futex_t *futex1, *futex2;
 
 static struct tst_ts to;
 
-static long orig_hugepages;
-
 static struct test_variants {
 	enum futex_fn_type fntype;
 	enum tst_ts_type tstype;
@@ -54,26 +52,15 @@ static struct test_variants {
 
 static void setup(void)
 {
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "No enough hugepages for testing.");
+
 	struct test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
 
 	to = tst_ts_from_ns(tv->tstype, 30 * NSEC_PER_SEC);
-
-	if (access(PATH_HUGEPAGES, F_OK))
-		tst_brk(TCONF, "Huge page is not supported.");
-
-	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%ld", &orig_hugepages);
-
-	if (orig_hugepages <= 0)
-		SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%d", 1);
-}
-
-static void cleanup(void)
-{
-	if (orig_hugepages <= 0)
-		SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%ld", orig_hugepages);
 }
 
 static void *wait_thread1(void *arg LTP_ATTRIBUTE_UNUSED)
@@ -147,10 +134,10 @@ static void wakeup_thread2(void)
 
 static struct tst_test test = {
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = wakeup_thread2,
 	.test_variants = ARRAY_SIZE(variants),
 	.needs_root = 1,
 	.min_kver = "2.6.32",
 	.needs_tmpdir = 1,
+	.request_hugepages = 1,
 };
-- 
2.21.1

