From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 3 Apr 2017 13:01:21 +0200
Subject: [LTP] [PATCH v2 1/1] syscalls/madvise: Handle zero page poisoning
Message-ID: <20170403130121.2bbe7cb2@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Treat failures for an un-populated MAP_PRIVATE mapping as configuration
failures because we are trying to do something which is not necessarily
expected to work. I have included some documentation for what is happening
with the zero page in this instance and what is likely to happen in the
future.

Also add a test case for MAP_PRIVATE with MAP_POPULATE, which is well defined,
and make the test slightly more verbose to help identify which variant is
running when there is an error.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/madvise/madvise07.c | 53 ++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise07.c b/testcases/kernel/syscalls/madvise/madvise07.c
index 2f8c42efc..89472c96c 100644
--- a/testcases/kernel/syscalls/madvise/madvise07.c
+++ b/testcases/kernel/syscalls/madvise/madvise07.c
@@ -23,9 +23,18 @@
  *	      mark memory with MADV_HWPOISON inside child process,
  *	      access memory,
  *	      if SIGBUS is delivered to child the test passes else it fails
+ *
+ * When MAP_PRIVATE is set (without MAP_POPULATE) madvise() may error with
+ * EBUSY on the first attempt and succeed on the second, but without poisoning
+ * any memory. A private mapping is only populated with pages once it is
+ * accessed and poisoning an unmapped VM range is essentially undefined
+ * behaviour. However madvise() itself causes the address to be mapped to the
+ * zero page. If/when the zero page can be poisoned then the test may pass
+ * without any error. For now we just consider it a configuration failure.
  */
 
 #include <stdlib.h>
+#include <stdio.h>
 #include <sys/wait.h>
 #include <fcntl.h>
 #include <unistd.h>
@@ -35,18 +44,32 @@
 #include "tst_test.h"
 #include "lapi/mmap.h"
 
-#define MAPTYPE(m) m == MAP_SHARED ? "MAP_SHARED" : "MAP_PRIVATE"
-
 static int maptypes[] = {
 	MAP_PRIVATE,
+	MAP_PRIVATE | MAP_POPULATE,
 	MAP_SHARED
 };
 
+static char *mapname(int maptype)
+{
+	switch (maptype) {
+	case MAP_PRIVATE: return "MAP_SHARED";
+	case MAP_PRIVATE | MAP_POPULATE: return "MAP_PRIVATE | MAP_POPULATE";
+	case MAP_SHARED: return "MAP_SHARED";
+	default:
+		tst_res(TWARN, "Unknown map type: %d", maptype);
+	}
+	return "Unknown";
+}
+
 static void run_child(int maptype)
 {
-	const size_t msize = 4096;
+	const size_t msize = getpagesize();
 	void *mem = NULL;
+	int first_attempt = 1;
 
+	tst_res(TINFO,
+		"mmap(..., MAP_ANONYMOUS | %s, ...)", mapname(maptype));
 	mem = SAFE_MMAP(NULL,
 			msize,
 			PROT_READ | PROT_WRITE,
@@ -54,22 +77,32 @@ static void run_child(int maptype)
 			-1,
 			0);
 
+do_madvise:
 	tst_res(TINFO, "madvise(%p, %zu, MADV_HWPOISON)", mem, msize);
 	if (madvise(mem, msize, MADV_HWPOISON) == -1) {
-		if (errno == EINVAL)
+		if (errno == EINVAL) {
 			tst_res(TCONF | TERRNO,
 				"CONFIG_MEMORY_FAILURE probably not set in kconfig");
-		else
+		} else if (errno == EBUSY && maptype == MAP_PRIVATE) {
+			tst_res(TCONF,
+				"Madvise failed with EBUSY");
+			if (first_attempt--)
+				goto do_madvise;
+		} else {
 			tst_res(TFAIL | TERRNO, "Could not poison memory");
+		}
 		exit(0);
 	}
 
 	*((char *)mem) = 'd';
 
-	tst_res(TFAIL,
-		"Did not receive SIGBUS after accessing %s memory marked "
-		"with MADV_HWPOISON",
-		MAPTYPE(maptype));
+	if (maptype == MAP_PRIVATE)
+		tst_res(TCONF,
+			"Zero page poisoning is probably not implemented");
+	else
+		tst_res(TFAIL,
+			"Did not receive SIGBUS after accessing %s memory marked with MADV_HWPOISON",
+			mapname(maptype));
 }
 
 static void run(unsigned int n)
@@ -87,7 +120,7 @@ static void run(unsigned int n)
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGBUS)
 		tst_res(TPASS,
 			"madvise(..., MADV_HWPOISON) on %s memory",
-			MAPTYPE(maptypes[n]));
+			mapname(maptypes[n]));
 	else if (WIFEXITED(status) && WEXITSTATUS(status) == TBROK)
 		tst_res(TBROK, "Child exited abnormally");
 }
-- 
2.12.0
