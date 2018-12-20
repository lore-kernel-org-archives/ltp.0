From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Dec 2018 17:08:11 +0800
Subject: [LTP] [PATCH 2/2] readdir02: use invalid DIR stream descriptor
In-Reply-To: <20181220090811.21514-1-liwang@redhat.com>
References: <20181220090811.21514-1-liwang@redhat.com>
Message-ID: <20181220090811.21514-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Issue:
  On ppc64le and aarch64, when testing in NFS mountpoint, test
  process receives SIGSEGV when calling readdir on a DIR which
  has just been closed by closedir().

  Unfortunately, ltp/readdir02.c handles SIGSEGV. This makes it
  hits SIGSEGV again in its cleanup function. So readdir02 hangs
  there hitting SEGV endlessly.

That's because a DIR * is NOT a file descriptor. It's memory
allocated by opendir() that contains libc internal information
about the directory. closedir(test_dir) frees any memory associated
with the open directory pointer test_dir.

To then pass the freed dir pointer to readdir() is a use-after-free.
It probably won't return EBADF, it will dereference freed memory
and whatever happens after that is undefined.

In this patch, I simply modify the test to use an exist FILE *
stream to simulate the invalid directory stream descriptor. Then
it won't hit the use-after-free issue any more.

Also, the sighandler function has been dropped.

Reported-by: Xiong Zhou <xzhou@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>
---
 testcases/kernel/syscalls/readdir/readdir02.c | 64 +++++++++++----------------
 1 file changed, 25 insertions(+), 39 deletions(-)

diff --git a/testcases/kernel/syscalls/readdir/readdir02.c b/testcases/kernel/syscalls/readdir/readdir02.c
index 441c4b431..21d00cb0a 100644
--- a/testcases/kernel/syscalls/readdir/readdir02.c
+++ b/testcases/kernel/syscalls/readdir/readdir02.c
@@ -36,59 +36,45 @@
 #include <signal.h>
 
 #include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+#define TEST_FILE "readdir_file.txt"
 
 static void verify_readdir(void)
 {
+	FILE *fp;
 	DIR *test_dir;
 	struct dirent *dptr;
 
-	if ((test_dir = opendir(".")) == NULL) {
-		tst_res(TFAIL, "opendir(\".\") Failed, errno=%d : %s",
-			 errno, strerror(errno));
-	} else {
-		if (closedir(test_dir) < 0) {
+	fp = SAFE_FOPEN(TEST_FILE, "ab+");
+	/* regard FILE * as an invalid directory stream descriptor */
+	test_dir = (DIR *)fp;
+
+	dptr = readdir(test_dir);
+	switch (errno) {
+	case EBADF:
+		tst_res(TPASS,
+			"expected failure - errno = %d : %s",
+			errno, strerror(errno));
+		break;
+	default:
+		if (dptr != NULL) {
 			tst_res(TFAIL,
-				 "closedir(\".\") Failed, errno=%d : %s",
-				 errno, strerror(errno));
+				"call failed with an "
+				"unexpected error - %d : %s",
+				errno,
+				strerror(errno));
 		} else {
-			dptr = readdir(test_dir);
-			switch (errno) {
-			case EBADF:
-				tst_res(TPASS,
-					 "expected failure - errno = %d : %s",
-					 errno, strerror(errno));
-				break;
-			default:
-				if (dptr != NULL) {
-					tst_brk(TFAIL,
-						 "call failed with an "
-						 "unexpected error - %d : %s",
-						 errno,
-						 strerror(errno));
-				} else {
-					tst_res(TINFO,
-						 "readdir() is not _required_ to fail, "
-						 "errno = %d  ", errno);
-				}
-			}
+			tst_res(TINFO,
+				"readdir() is not _required_ to fail, "
+				"errno = %d ", errno);
 		}
 	}
-}
 
-static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
-{
-	tst_res(TCONF,
-		 "This system's implementation of closedir() "
-		 "will not allow this test to execute properly.");
-}
-
-static void setup(void)
-{
-	SAFE_SIGNAL(SIGSEGV, sighandler);
+	SAFE_FCLOSE(fp);
 }
 
 static struct tst_test test = {
 	.needs_tmpdir = 1,
-	.setup = setup,
 	.test_all = verify_readdir,
 };
-- 
2.14.5

