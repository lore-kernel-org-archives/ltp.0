From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Aug 2017 16:33:10 +0200
Subject: [LTP] [PATCH 2/2] [RFC] syscalls/mmap12: Do not fail on non-present
	pages
In-Reply-To: <20170817143310.11634-1-chrubis@suse.cz>
References: <20170817143310.11634-1-chrubis@suse.cz>
Message-ID: <20170817143310.11634-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are two problems with the testcase:

1. MAP_POPULATE is best effort operation.

   To quote Michal Hocko:

   "The semantic of MAP_POPULATE is rather vague and allows for nuances
   in future."

2. There is no guarantee that the pages will be present even if
   MAP_POPULATE caused read-ahead.

   To quote Michal again:

   "Ptes can be made !present, reclaimed or who knows what else in
   future yet that won't qualify as a regression. I find such a test
   questionable at best."

I still think that calling mmap() with MAP_POPULATE and checking that
the mapping is OK is a valid testcase itself, so instead of passing the
test on present pages we simply check that the mapping is zero-filled
(since we mapped empty file). I kept the page-present check still there
but it now produces only INFO messages, it could be removed though if
everyone agrees that it has no real value.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Michal Hocko <mhocko@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap12.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap12.c b/testcases/kernel/syscalls/mmap/mmap12.c
index 32cbe4431..05ace6a0c 100644
--- a/testcases/kernel/syscalls/mmap/mmap12.c
+++ b/testcases/kernel/syscalls/mmap/mmap12.c
@@ -49,7 +49,7 @@
 static int fildes;
 static char *addr;
 
-static int page_check(void)
+static void page_check(void)
 {
 	int i = 1;
 	int flag = 0;
@@ -70,8 +70,9 @@ static int page_check(void)
 	pm = open("/proc/self/pagemap", O_RDONLY);
 	if (pm == -1) {
 		if ((errno == EPERM) && (geteuid() != 0)) {
-			tst_brk(TCONF | TERRNO,
+			tst_res(TCONF | TERRNO,
 				"don't have permission to open dev pagemap");
+			return;
 		} else {
 			tst_brk(TFAIL | TERRNO, "pen dev pagemap failed");
 		}
@@ -98,14 +99,14 @@ static int page_check(void)
 
 	close(pm);
 
-	if (flag)
-		return 1;
-
-	return 0;
+	if (!flag)
+		tst_res(TINFO, "All pages are present");
 }
 
 void verify_mmap(void)
 {
+	unsigned int i;
+
 	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
 		    MAP_PRIVATE | MAP_POPULATE, fildes, 0);
 
@@ -114,11 +115,18 @@ void verify_mmap(void)
 		return;
 	}
 
-	if (page_check())
-		tst_res(TFAIL, "Not all pages are present");
-	else
-		tst_res(TPASS, "Functionality of mmap() successful");
+	page_check();
+
+	for (i = 0; i < MMAPSIZE; i++) {
+		if (addr[i]) {
+			tst_res(TFAIL, "Non-zero byte@offset %i", i);
+			goto unmap;
+		}
+	}
+
+	tst_res(TPASS, "File mapped properly");
 
+unmap:
 	SAFE_MUNMAP(addr, MMAPSIZE);
 }
 
-- 
2.13.0

