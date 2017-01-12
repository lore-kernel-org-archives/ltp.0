From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Jan 2017 14:23:38 +0100
Subject: [LTP] [PATCH 3/4] mmapstress03: Small cleanup
In-Reply-To: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
References: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
Message-ID: <1484227419-16955-3-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

No fucntional changes done.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/mmapstress/mmapstress03.c | 47 ++++++++------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress03.c b/testcases/kernel/mem/mmapstress/mmapstress03.c
index 066587a..76a77a9 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress03.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress03.c
@@ -42,11 +42,9 @@
 #include <errno.h>
 #include <unistd.h>
 #include <limits.h>
+#include <stdlib.h>
 
-/*****  LTP Port        *****/
 #include "test.h"
-#define FAILED 0
-#define PASSED 1
 
 char *TCID = "mmapstress03";
 FILE *temp;
@@ -54,36 +52,24 @@ int TST_TOTAL = 1;
 
 int anyfail();
 void ok_exit();
-/*****  **      **      *****/
 
 #define AS_SVSM_VSEG_MAX	48UL
 #define AS_SVSM_MMAP_MAX	16UL
 
 #define EXTRA_VSEGS	2L
 #define NUM_SEGS	(AS_SVSM_VSEG_MAX + EXTRA_VSEGS)
-#define ERROR(M) (void)fprintf(stderr, "%s: errno = %d: " M "\n", progname, \
+#define ERROR(M) (void)fprintf(stderr, "%s: errno = %d: " M "\n", TCID, \
 			errno)
 #define NEG1	(char *)-1
 #define POINTER_SIZE	(sizeof(void *) << 3)
 
-extern long sysconf(int name);
-extern void exit(int);
-extern time_t time(time_t *);
-extern char *ctime(const time_t *);
-static void do_test(caddr_t brk_max, long pagesize);
+static void do_test(void* brk_max, long pagesize);
 
-static char *progname;
-
- /*ARGSUSED*/ int main(int argc, char *argv[])
+int main(void)
 {
 	char *brk_max_addr, *hole_addr, *brk_start, *hole_start;
 	size_t pagesize = (size_t) sysconf(_SC_PAGE_SIZE);
-	time_t t;
-
-	progname = argv[0];
 
-	(void)time(&t);
-//      (void)printf("%s: Started %s", argv[0], ctime(&t));
 	if ((brk_start = sbrk(0)) == NEG1) {
 		ERROR("initial sbrk failed");
 		anyfail();
@@ -105,7 +91,7 @@ static char *progname;
 		ERROR("couldn't find top of brk");
 		anyfail();
 	}
-	do_test((caddr_t) brk_max_addr, pagesize);
+	do_test((void*) brk_max_addr, pagesize);
 
 	/* now make holes and repeat test */
 	while (hole_addr + pagesize < brk_max_addr) {
@@ -120,7 +106,7 @@ static char *progname;
 		ERROR("do_test should leave the top of brk where it began");
 		anyfail();
 	}
-	do_test((caddr_t) brk_max_addr, pagesize);
+	do_test((void*) brk_max_addr, pagesize);
 
 	/* Shrink brk */
 	if (sbrk(-NUM_SEGS * pagesize) == NEG1) {
@@ -152,11 +138,11 @@ static char *progname;
 		anyfail();
 	}
 	/* Ask for a ridiculously large mmap region@a high address */
-	if (mmap((caddr_t) (1UL << (POINTER_SIZE - 1)) - pagesize,
+	if (mmap((void*) (1UL << (POINTER_SIZE - 1)) - pagesize,
 		 (size_t) ((1UL << (POINTER_SIZE - 1)) - pagesize),
 		 PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_FIXED | MAP_SHARED,
 		 0, 0)
-	    != (caddr_t) - 1) {
+	    != (void*) - 1) {
 		ERROR("really large mmap didn't fail");
 		anyfail();
 	}
@@ -164,8 +150,7 @@ static char *progname;
 		ERROR("really large mmap didn't set errno = ENOMEM nor EINVAL");
 		anyfail();
 	}
-	(void)time(&t);
-//      (void)printf("%s: Finished %s", argv[0], ctime(&t));
+
 	ok_exit();
 	tst_exit();
 }
@@ -174,21 +159,20 @@ static char *progname;
  * do_test assumes that brk_max is a multiple of pagesize
  */
 
-static
-void do_test(caddr_t brk_max, long pagesize)
+static void do_test(void* brk_max, long pagesize)
 {
-	if (mmap((caddr_t) ((long)brk_max - 3 * pagesize), (2 * pagesize),
+	if (mmap((void*) ((long)brk_max - 3 * pagesize), (2 * pagesize),
 		 PROT_READ | PROT_WRITE,
 		 MAP_ANONYMOUS | MAP_FIXED | MAP_PRIVATE, 0, 0)
-	    == (caddr_t) - 1) {
+	    == (void*) - 1) {
 		ERROR("mmap failed");
 		anyfail();
 	}
 	/* extend mmap */
-	if (mmap((caddr_t) ((long)brk_max - 2 * pagesize), (2 * pagesize),
+	if (mmap((void*) ((long)brk_max - 2 * pagesize), (2 * pagesize),
 		 PROT_READ | PROT_WRITE,
 		 MAP_ANONYMOUS | MAP_FIXED | MAP_PRIVATE, 0, 0)
-	    == (caddr_t) - 1) {
+	    == (void*) - 1) {
 		ERROR("mmap failed");
 		anyfail();
 	}
@@ -214,7 +198,6 @@ void do_test(caddr_t brk_max, long pagesize)
 	}
 }
 
-/*****  LTP Port        *****/
 void ok_exit(void)
 {
 	tst_resm(TPASS, "Test passed");
@@ -225,5 +208,3 @@ int anyfail(void)
 {
 	tst_brkm(TFAIL, NULL, "Test failed");
 }
-
-/*****  **      **      *****/
-- 
2.7.3

