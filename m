From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Jan 2017 14:23:39 +0100
Subject: [LTP] [PATCH 4/4] mmapstress03: Fix 32bit test on 64bit kernel
In-Reply-To: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
References: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
Message-ID: <1484227419-16955-4-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The ridiculously large mapping size has to be adjusted based on the
kernel addressing size not on a pointer size otherwise the testcase
segfaults when 32bit binary is executed on 64bit kernel.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/mmapstress/mmapstress03.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress03.c b/testcases/kernel/mem/mmapstress/mmapstress03.c
index 76a77a9..fe25b7a 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress03.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress03.c
@@ -45,6 +45,7 @@
 #include <stdlib.h>
 
 #include "test.h"
+#include "tst_kernel.h"
 
 char *TCID = "mmapstress03";
 FILE *temp;
@@ -61,7 +62,6 @@ void ok_exit();
 #define ERROR(M) (void)fprintf(stderr, "%s: errno = %d: " M "\n", TCID, \
 			errno)
 #define NEG1	(char *)-1
-#define POINTER_SIZE	(sizeof(void *) << 3)
 
 static void do_test(void* brk_max, long pagesize);
 
@@ -69,6 +69,7 @@ int main(void)
 {
 	char *brk_max_addr, *hole_addr, *brk_start, *hole_start;
 	size_t pagesize = (size_t) sysconf(_SC_PAGE_SIZE);
+	int kernel_bits = tst_kernel_bits();
 
 	if ((brk_start = sbrk(0)) == NEG1) {
 		ERROR("initial sbrk failed");
@@ -137,9 +138,10 @@ int main(void)
 		ERROR("failed to fiddle with brk at the end");
 		anyfail();
 	}
+
 	/* Ask for a ridiculously large mmap region@a high address */
-	if (mmap((void*) (1UL << (POINTER_SIZE - 1)) - pagesize,
-		 (size_t) ((1UL << (POINTER_SIZE - 1)) - pagesize),
+	if (mmap((void*) (1UL << (kernel_bits - 1)) - pagesize,
+		 (size_t) ((1ULL << (kernel_bits - 1)) - pagesize),
 		 PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_FIXED | MAP_SHARED,
 		 0, 0)
 	    != (void*) - 1) {
-- 
2.7.3

