From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 24 Sep 2020 16:42:46 +0200
Subject: [LTP] [PATCH 2/2] mmap18: Increase minimal stack mapping to 8KB
In-Reply-To: <20200924144246.12750-1-mdoucha@suse.cz>
References: <20200924144246.12750-1-mdoucha@suse.cz>
Message-ID: <20200924144246.12750-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The first testcase keeps segfaulting on older kernels with only 4KB initial
stack mapping

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Note: Increasing initial stack size to 8KB fixes the segfaults but I'm not
entirely sure whether we shouldn't use PTHREAD_STACK_MIN as the minimal size
instead. Pthread man page isn't entirely clear whether PTHREAD_STACK_MIN is
the minimal value for stack size after it grows to the limit, or the minimal
size of the initial stack mapping (before it starts growing).

On x86_64, PTHREAD_STACK_MIN is 4 pages (16KB). On PPC64, it's 2 pages
(128KB).

 testcases/kernel/syscalls/mmap/mmap18.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap18.c b/testcases/kernel/syscalls/mmap/mmap18.c
index 966bf673e..8b149fb93 100644
--- a/testcases/kernel/syscalls/mmap/mmap18.c
+++ b/testcases/kernel/syscalls/mmap/mmap18.c
@@ -201,10 +201,11 @@ static void grow_stack_fail(size_t stack_size, size_t mapped_size)
 static void run_test(void)
 {
 	size_t stack_size = 8 * PTHREAD_STACK_MIN;
+	size_t minsize = MAX(page_size, 8192);
 
-	grow_stack_success(stack_size, page_size);
+	grow_stack_success(stack_size, minsize);
 	grow_stack_success(stack_size, stack_size/2);
-	grow_stack_fail(stack_size, page_size);
+	grow_stack_fail(stack_size, minsize);
 	grow_stack_fail(stack_size, stack_size/2);
 }
 
-- 
2.28.0

