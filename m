From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Jul 2016 15:37:08 +0200
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
Message-ID: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

madvise_willneed() only schedules I/O and does not
wait for completion, so there is possibility for this
testcase to fail occasionally.

This patch is introducing a small delay and checks the
effect of madvise on more pages.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

Some other obsverations that are not addressed by this patch:
 Testcase assumes that swap is enabled.
 Testcase assumes that there is enough swap.
 Testcase doesn't check buf[0] is swapped before it calls madvise().

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 6b081fddf5eb..1b0f58cb319d 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -77,6 +77,7 @@ static void test_advice_willneed(void)
 	char *dst[100];
 	int page_fault_num_1;
 	int page_fault_num_2;
+	const int pages_to_check = 50;
 
 	/* allocate source memory (1GB only) */
 	src = SAFE_MMAP(NULL, 1 * GB_SZ, PROT_READ | PROT_WRITE,
@@ -97,18 +98,23 @@ static void test_advice_willneed(void)
 	tst_res(TINFO, "PageFault(no madvice): %d", get_page_fault_num());
 
 	/* Do madvice() to dst[0] */
-	TEST(madvise(dst[0], pg_sz, MADV_WILLNEED));
+	TEST(madvise(dst[0], pages_to_check * pg_sz, MADV_WILLNEED));
 	if (TEST_RETURN == -1)
 		tst_brk(TBROK | TERRNO, "madvise failed");
 
-	page_fault_num_1 = get_page_fault_num();
-	tst_res(TINFO, "PageFault(madvice / no mem access): %d",
-			page_fault_num_1);
-
-	*dst[0] = 'a';
-	page_fault_num_2 = get_page_fault_num();
-	tst_res(TINFO, "PageFault(madvice / mem access): %d",
-			page_fault_num_2);
+	i = 0;
+	do {
+		i++;
+		usleep(100000);
+
+		page_fault_num_1 = get_page_fault_num();
+		tst_res(TINFO, "PageFault(madvice / no mem access): %d",
+				page_fault_num_1);
+		dst[0][i * pg_sz] = 'a';
+		page_fault_num_2 = get_page_fault_num();
+		tst_res(TINFO, "PageFault(madvice / mem access): %d",
+				page_fault_num_2);
+	} while (page_fault_num_1 != page_fault_num_2 && i < pages_to_check);
 
 	if (page_fault_num_1 != page_fault_num_2)
 		tst_res(TFAIL, "Bug has been reproduced");
-- 
1.8.3.1

