From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Oct 2017 11:30:06 +0800
Subject: [LTP] [PATCH 2/2] mm: enlarge mmap HIGH_ADDR value for s390 arch
In-Reply-To: <20171025033006.32463-1-liwang@redhat.com>
References: <20171025033006.32463-1-liwang@redhat.com>
Message-ID: <20171025033006.32463-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The kernel commit 1aea9b3f92 (s390/mm: implement 5 level pages tables)
enlarge the maximum address in the tasks address space from (1UL << 53)
to (-PAGE_SIZE) on s390 platform.

We have to increase the HIGH_ADDR in ltp testcases accordingly otherwise
that would be failed with succeeded mmap into high region:

mmap15.c:
mmap15  1  TFAIL  :  mmap15.c:77: mmap into high region succeeded unexpectedly

mmapstress03.c:
mmapstress03: errno = 25: really large mmap didn't fail
mmapstress03    0  TINFO  :  uname.machine=s390x kernel is 32bit
mmapstress03    1  TFAIL  :  mmapstress03.c:212: Test failed

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/mmapstress/mmapstress03.c | 3 +--
 testcases/kernel/syscalls/mmap/mmap15.c        | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress03.c b/testcases/kernel/mem/mmapstress/mmapstress03.c
index 0012eeb..f8541e1 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress03.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress03.c
@@ -141,8 +141,7 @@ int main(void)
 	}
 
 	/* Ask for a ridiculously large mmap region at a high address */
-	if (mmap((void*) (((uintptr_t)1) << ((sizeof(void*)<<3) - 1)) - pagesize,
-		 (size_t) ((1ULL << (kernel_bits - 1)) - pagesize),
+	if (mmap((void*) (-pagesize), (size_t) ((1ULL << (kernel_bits - 1)) - pagesize),
 		 PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_FIXED | MAP_SHARED,
 		 0, 0)
 	    != (void*) - 1) {
diff --git a/testcases/kernel/syscalls/mmap/mmap15.c b/testcases/kernel/syscalls/mmap/mmap15.c
index 7e917bd..e1dbca2 100644
--- a/testcases/kernel/syscalls/mmap/mmap15.c
+++ b/testcases/kernel/syscalls/mmap/mmap15.c
@@ -43,7 +43,7 @@ int TST_TOTAL = 1;
 #ifdef __ia64__
 # define HIGH_ADDR (void *)(0xa000000000000000UL)
 #else
-# define HIGH_ADDR (void *)(1L << 53)
+# define HIGH_ADDR (void *)(0xfffffffffffff000UL)
 #endif
 
 static long map_sz;
-- 
2.9.3

