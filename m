From: charishma <charishm@linux.vnet.ibm.com>
Date: Fri, 31 Mar 2017 15:59:54 +0530
Subject: [LTP] [PATCH] Fix hugemmap05 failure on ppc32 architecture
Message-ID: <ac20b5ca-62e5-1b26-d5f1-1bee214d8923@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hugemmap05 failed due to data type exceed to limit in 32 bit architectures.

In hugemmap.c,

addr = mmap(ADDR, (long)(length / 2 * hugepagesize), PROTECTION,FLAGS, 
fd, 0);

In the above expression, mmap size data type is long, which execeeds the 
limit in 32 bit while runing hugemmap05 tests, due to which 
hugemap05,hugemmap05_1,hugemmap05_2,hugemmap05_3 is failing.

Signed-off-by: Basavaraju< basava@linux.vnet.ibm.com >
---
  testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c 
b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index b127566..6ea397e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -161,7 +161,7 @@ static void overcommit(void)
          fd = open(s, O_CREAT | O_RDWR, 0755);
          if (fd == -1)
              tst_brkm(TBROK | TERRNO, cleanup, "open");
-        addr = mmap(ADDR, (long)(length / 2 * hugepagesize), PROTECTION,
+        addr = mmap(ADDR, (unsigned long)(length / 2 * hugepagesize), 
PROTECTION,
                  FLAGS, fd, 0);
          if (addr == MAP_FAILED) {
              close(fd);
@@ -387,18 +387,18 @@ static void setup(void)

  static void write_bytes(void *addr)
  {
-    long i;
+    unsigned long i;

-    for (i = 0; i < (long)(length / 2 * hugepagesize); i++)
+    for (i = 0; i < (unsigned long)(length / 2 * hugepagesize); i++)
          ((char *)addr)[i] = '\a';
  }

  static void read_bytes(void *addr)
  {
-    long i;
+    unsigned long i;

      tst_resm(TINFO, "First hex is %x", *((unsigned int *)addr));
-    for (i = 0; i < (long)(length / 2 * hugepagesize); i++) {
+    for (i = 0; i < (unsigned long)(length / 2 * hugepagesize); i++) {
          if (((char *)addr)[i] != '\a') {
              tst_resm(TFAIL, "mismatch@%ld", i);
              break;
-- 
2.5.5

