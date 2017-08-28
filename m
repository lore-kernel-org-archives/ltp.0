From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 28 Aug 2017 15:48:27 +0200
Subject: [LTP] [PATCH] madvise07: Increase probability of testing a
	supported page type
Message-ID: <20170828134827.5871-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We were attempting to poison page types which do not support it (e.g. the zero
page) due to our usage of mmap. Now we map some anonymous memory and write to
it. Hopefully ensuring the underlying page is of a supported type.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/madvise/madvise07.c | 76 ++++++++-------------------
 1 file changed, 23 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise07.c b/testcases/kernel/syscalls/madvise/madvise07.c
index 76adb2e06..ef9aa4a26 100644
--- a/testcases/kernel/syscalls/madvise/madvise07.c
+++ b/testcases/kernel/syscalls/madvise/madvise07.c
@@ -16,21 +16,23 @@
  */
 
 /*
- * Check that accessing memory marked with MADV_HWPOISON results in SIGBUS.
+ * Check that accessing a page marked with MADV_HWPOISON results in SIGBUS.
  *
  * Test flow: create child process,
- *	      map memory,
- *	      mark memory with MADV_HWPOISON inside child process,
+ *	      map and write to memory,
+ *	      mark memory with MADV_HWPOISON,
  *	      access memory,
  *	      if SIGBUS is delivered to child the test passes else it fails
  *
- * When MAP_PRIVATE is set (without MAP_POPULATE) madvise() may error with
- * EBUSY on the first attempt and succeed on the second, but without poisoning
- * any memory. A private mapping is only populated with pages once it is
- * accessed and poisoning an unmapped VM range is essentially undefined
- * behaviour. However madvise() itself causes the address to be mapped to the
- * zero page. If/when the zero page can be poisoned then the test may pass
- * without any error. For now we just consider it a configuration failure.
+ * If the underlying page type of the memory we have mapped does not support
+ * poisoning then the test will fail. We try to map and write to the memory in
+ * such a way that by the time madvise is called the virtual memory address
+ * points to a supported page. However there may be some rare circumstances
+ * where the test produces the wrong result because we have somehow obtained
+ * an unsupported page. In such cases madvise will probably return success,
+ * but no SIGBUS will be produced.
+ *
+ * For more information see <linux source>/Documentation/vm/hwpoison.txt.
  */
 
 #include <stdlib.h>
@@ -40,54 +42,32 @@
 #include <unistd.h>
 #include <signal.h>
 #include <errno.h>
+#include <string.h>
 
 #include "tst_test.h"
 #include "lapi/mmap.h"
 
-static int maptypes[] = {
-	MAP_PRIVATE,
-	MAP_PRIVATE | MAP_POPULATE,
-	MAP_SHARED
-};
-
-static char *mapname(int maptype)
-{
-	switch (maptype) {
-	case MAP_PRIVATE: return "MAP_PRIVATE";
-	case MAP_PRIVATE | MAP_POPULATE: return "MAP_PRIVATE | MAP_POPULATE";
-	case MAP_SHARED: return "MAP_SHARED";
-	default:
-		tst_res(TWARN, "Unknown map type: %d", maptype);
-	}
-	return "Unknown";
-}
-
-static void run_child(int maptype)
+static void run_child(void)
 {
 	const size_t msize = getpagesize();
 	void *mem = NULL;
-	int first_attempt = 1;
 
 	tst_res(TINFO,
-		"mmap(..., MAP_ANONYMOUS | %s, ...)", mapname(maptype));
+		"mmap(0, %zu, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0)",
+		msize);
 	mem = SAFE_MMAP(NULL,
 			msize,
 			PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | maptype,
+			MAP_ANONYMOUS | MAP_PRIVATE,
 			-1,
 			0);
+	memset(mem, 'L', msize);
 
-do_madvise:
 	tst_res(TINFO, "madvise(%p, %zu, MADV_HWPOISON)", mem, msize);
 	if (madvise(mem, msize, MADV_HWPOISON) == -1) {
 		if (errno == EINVAL) {
 			tst_res(TCONF | TERRNO,
 				"CONFIG_MEMORY_FAILURE probably not set in kconfig");
-		} else if (errno == EBUSY && maptype == MAP_PRIVATE) {
-			tst_res(TCONF,
-				"Madvise failed with EBUSY");
-			if (first_attempt--)
-				goto do_madvise;
 		} else {
 			tst_res(TFAIL | TERRNO, "Could not poison memory");
 		}
@@ -96,39 +76,29 @@ do_madvise:
 
 	*((char *)mem) = 'd';
 
-	if (maptype == MAP_PRIVATE) {
-		tst_res(TCONF,
-			"Zero page poisoning is probably not implemented");
-	} else {
-		tst_res(TFAIL,
-			"Did not receive SIGBUS after accessing %s memory marked with MADV_HWPOISON",
-			mapname(maptype));
-	}
+	tst_res(TFAIL, "Did not receive SIGBUS on accessing poisoned page");
 }
 
-static void run(unsigned int n)
+static void run(void)
 {
 	int status;
 	pid_t pid;
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
-		run_child(maptypes[n]);
+		run_child();
 		exit(0);
 	}
 
 	SAFE_WAITPID(pid, &status, 0);
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGBUS)
-		tst_res(TPASS,
-			"madvise(..., MADV_HWPOISON) on %s memory",
-			mapname(maptypes[n]));
+		tst_res(TPASS, "Received SIGBUS after accessing poisoned page");
 	else if (WIFEXITED(status) && WEXITSTATUS(status) == TBROK)
 		tst_res(TBROK, "Child exited abnormally");
 }
 
 static struct tst_test test = {
-	.test = run,
-	.tcnt = ARRAY_SIZE(maptypes),
+	.test_all = run,
 	.min_kver = "2.6.31",
 	.needs_root = 1,
 	.forks_child = 1
-- 
2.14.1

