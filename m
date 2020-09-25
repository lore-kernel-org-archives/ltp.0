From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 25 Sep 2020 15:21:25 +0200
Subject: [LTP] [PATCH v2] mmap18: Increase minimal stack mapping to
 PTHREAD_STACK_MIN
Message-ID: <20200925132125.22955-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The first testcase keeps segfaulting on older kernels with only 4KB initial
stack mapping. Pthread man pages say that stack must be at least
PTHREAD_STACK_MIN bytes in size but they're not clear how that relates
to growing stacks. Let's be on the safe side.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Use PTHREAD_STACK_MIN as the minimum instead of 8KB

 testcases/kernel/syscalls/mmap/mmap18.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap18.c b/testcases/kernel/syscalls/mmap/mmap18.c
index 966bf673e..dc2926454 100644
--- a/testcases/kernel/syscalls/mmap/mmap18.c
+++ b/testcases/kernel/syscalls/mmap/mmap18.c
@@ -202,9 +202,9 @@ static void run_test(void)
 {
 	size_t stack_size = 8 * PTHREAD_STACK_MIN;
 
-	grow_stack_success(stack_size, page_size);
+	grow_stack_success(stack_size, PTHREAD_STACK_MIN);
 	grow_stack_success(stack_size, stack_size/2);
-	grow_stack_fail(stack_size, page_size);
+	grow_stack_fail(stack_size, PTHREAD_STACK_MIN);
 	grow_stack_fail(stack_size, stack_size/2);
 }
 
-- 
2.28.0

