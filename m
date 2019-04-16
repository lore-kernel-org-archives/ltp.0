From: Balamuruhan S <bala24@linux.vnet.ibm.com>
Date: Tue, 16 Apr 2019 13:46:55 +0530
Subject: [LTP] [PATCH] mem02: calculate the order of pagesize instead to
	hardcode
Message-ID: <20190416081655.23749-1-bala24@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

default pagesize in x86 it is 4K and in powerpc it is 64K so calculate
the order of pagesize instead of hardcoding it. Few other fixes to
remove unused variable and call `tst_resm()` for valloc() scenario.

Signed-off-by: Harish <harish@linux.vnet.ibm.com>
Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
---
 testcases/kernel/mem/mem/mem02.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/mem/mem02.c b/testcases/kernel/mem/mem/mem02.c
index 8c35ff64c..e85b2e011 100644
--- a/testcases/kernel/mem/mem/mem02.c
+++ b/testcases/kernel/mem/mem/mem02.c
@@ -48,7 +48,7 @@
 #include <sys/types.h>
 #include <sys/user.h>
 
-#define MEMSIZE	8192*8192
+#define MEMSIZE	8192 * 8192
 
 void on_mem_fault(int sig);
 
@@ -62,16 +62,25 @@ static void usage(char *progname)
 	exit(1);
 }
 
+static int get_pagesize_order()
+{
+	int i, pagesize, size = 0;
+	pagesize = sysconf(_SC_PAGESIZE);
+	for (i = 0; size != pagesize; i++)
+		size = 1 << i;
+	return (i - 1);
+}
+
 int main(int argc, char **argv)
 {
 	int i;
 	char *pm1, *pm2, *pm3, *pm4;
-	long pm6;
 	void *memptr;
 	long laddr;
 	int iteration_count;
 	int size;		/* Size to memory to be valloced */
-	int pagesize = 12;	/* 2^12 = 4096, PAGESIZE      */
+	/* calculate the order of pagesize */
+	int pagesize_order = get_pagesize_order();
 	int memsize = MEMSIZE;	/* Size of memory to allocate */
 	extern char *optarg;	/* getopt() function global variables */
 	extern int optopt;	/* stores bad option passed to the program */
@@ -154,7 +163,6 @@ int main(int argc, char **argv)
 
 	/* realloc with reduced size */
 	pm4 = realloc(pm3, 5);
-	pm6 = (long)pm4;
 	pm3 = pm4;
 	/* verify contents did not change */
 	for (i = 0; i < 5; i++) {
@@ -168,7 +176,6 @@ int main(int argc, char **argv)
 
 	/* realloc with increased size after fragmenting memory */
 	pm4 = realloc(pm3, 15);
-	pm6 = (long)pm3;
 	pm3 = pm4;
 	/* verify contents did not change */
 	for (i = 0; i < 5; i++) {
@@ -208,16 +215,18 @@ int main(int argc, char **argv)
 		 * Check to see if valloc returns unaligned data.
 		 * This can be done by copying the memory address into
 		 * a variable and the by diving and multipying the address
-		 * by the pagesize and checking.
+		 * by the pagesize order and checking.
 		 */
 		laddr = (long)memptr;
-		if (((laddr >> pagesize) << pagesize) != laddr) {
+		if (((laddr >> pagesize_order) << pagesize_order) != laddr) {
 			tst_brkm(TFAIL, NULL,
 				 "Valloc returned unaligned data");
 		}
 
 		free(memptr);
 	}
+	tst_resm(TPASS, "valloc - valloc of rand() size of memory succeeded "
+		 "for 15000 iteration");
 
 	tst_exit();
 }
-- 
2.14.5

