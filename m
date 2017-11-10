From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Nov 2017 16:07:21 +0800
Subject: [LTP] [PATCH v2 2/2] mm: raise mmap HIGH_ADDR value for s390 arch
Message-ID: <20171110080721.12355-2-liwang@redhat.com>
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

mmap15  1  TFAIL  :  mmap15.c:77: mmap into high region succeeded unexpectedly

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/mmap/mmap15.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap15.c b/testcases/kernel/syscalls/mmap/mmap15.c
index 7e917bd..a1ed667 100644
--- a/testcases/kernel/syscalls/mmap/mmap15.c
+++ b/testcases/kernel/syscalls/mmap/mmap15.c
@@ -43,10 +43,10 @@ int TST_TOTAL = 1;
 #ifdef __ia64__
 # define HIGH_ADDR (void *)(0xa000000000000000UL)
 #else
-# define HIGH_ADDR (void *)(1L << 53)
+# define HIGH_ADDR (void *)(-page_size)
 #endif
 
-static long map_sz;
+static long page_size;
 
 static void setup(void);
 static void cleanup(void);
@@ -70,7 +70,7 @@ int main(int ac, char **av)
 		fd = SAFE_OPEN(cleanup, "testfile", O_RDWR | O_CREAT, 0666);
 
 		/* Attempt to mmap into highmem addr, should get ENOMEM */
-		addr = mmap(HIGH_ADDR, map_sz, PROT_READ,
+		addr = mmap(HIGH_ADDR, page_size, PROT_READ,
 			    MAP_SHARED | MAP_FIXED, fd, 0);
 		if (addr != MAP_FAILED) {
 			tst_resm(TFAIL, "mmap into high region "
@@ -102,7 +102,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	map_sz = getpagesize();
+	page_size = getpagesize();
 
 	TEST_PAUSE;
 }
-- 
2.9.3

