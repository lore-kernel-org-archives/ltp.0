From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Mon, 12 Jul 2021 11:03:22 +0300
Subject: [LTP] [PATCH] mmap18: fix when PTHREAD_STACK_MIN < PAGE_SIZE
Message-ID: <20210712080322.11512-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

PTHREAD_STACK_MIN can be less than the page size, to be more
precise 2048 on musl. This value is used in the test as an
offset for a new stack address with mmap() + MAP_FIXED flag.
Though it might not be aligned to the page size.

This breaks the test with musl:

  tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s
  mmap18.c:98: TBROK: mmap(0x7fe67e2ee800,2048,3,306,-1,0) failed: EINVAL (22)
  mmap18.c:169: TFAIL: Child: exited with 2
  [...]

The fix is to align mapped_size arg to the page size.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/kernel/syscalls/mmap/mmap18.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap18.c b/testcases/kernel/syscalls/mmap/mmap18.c
index dc2926454..b37b29890 100644
--- a/testcases/kernel/syscalls/mmap/mmap18.c
+++ b/testcases/kernel/syscalls/mmap/mmap18.c
@@ -200,11 +200,12 @@ static void grow_stack_fail(size_t stack_size, size_t mapped_size)
 
 static void run_test(void)
 {
-	size_t stack_size = 8 * PTHREAD_STACK_MIN;
+	size_t pthread_stack = LTP_ALIGN(PTHREAD_STACK_MIN, getpagesize());
+	size_t stack_size = 8 * pthread_stack;
 
-	grow_stack_success(stack_size, PTHREAD_STACK_MIN);
+	grow_stack_success(stack_size, pthread_stack);
 	grow_stack_success(stack_size, stack_size/2);
-	grow_stack_fail(stack_size, PTHREAD_STACK_MIN);
+	grow_stack_fail(stack_size, pthread_stack);
 	grow_stack_fail(stack_size, stack_size/2);
 }
 
-- 
2.25.1

