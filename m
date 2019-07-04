From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  4 Jul 2019 09:26:02 +0200
Subject: [LTP] [PATCH] direct_io: diotest4: fix mips MAP_SHARED/MAP_FIXED
 mmap
Message-ID: <47b8b48060353711ff8d3695a7d3702f1aced12a.1562224996.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hongzhi reports that this test is failing on mips64 with 5.1+:
  diotest4 10 TBROK : diotest4.c:368: can't mmap file: Invalid argument
  diotest4 11 TBROK : diotest4.c:368: Remaining cases broken
I could reproduce it on emulated 5kc-malta, running 5.2.0-rc7.

Test is trying to map in area immediately following heap as MAP_SHARED,
but it's using wrong alignment, because MMAP_GRANULARITY is always
defined as single page - lapi/mmap.h is not including config.h.

Usage of MAP_FIXED in test seems unnecessary, so drop that too
and let the kernel pick an address.

Reported-by: Hongzhi.Song <hongzhi.song@windriver.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/lapi/mmap.h                      | 2 ++
 testcases/kernel/io/direct_io/diotest4.c | 8 ++------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index 18547c0d47ed..98b6ade1e2ab 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -19,6 +19,8 @@
 #ifndef LAPI_MMAP_H__
 #define LAPI_MMAP_H__
 
+#include "config.h"
+
 #ifndef MAP_HUGETLB
 # define MAP_HUGETLB 0x40000
 #endif
diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index e4616e400abd..bf200cd41a27 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -352,18 +352,14 @@ int main(int argc, char *argv[])
 	total++;
 
 	/* Test-10: read, write to a mmaped file */
-	shm_base = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz - 1));
-	if (shm_base == NULL) {
-		tst_brkm(TBROK, cleanup, "sbrk failed: %s", strerror(errno));
-	}
 	offset = 4096;
 	count = bufsize;
 	if ((fd = open(filename, O_DIRECT | O_RDWR)) < 0) {
 		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			 filename, strerror(errno));
 	}
-	shm_base = mmap(shm_base, 0x100000, PROT_READ | PROT_WRITE,
-			MAP_SHARED | MAP_FIXED, fd, 0);
+	shm_base = mmap(0, 0x100000, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
 	if (shm_base == (caddr_t) - 1) {
 		tst_brkm(TBROK, cleanup, "can't mmap file: %s",
 			 strerror(errno));
-- 
1.8.3.1

