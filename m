From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 17 May 2016 15:16:12 +0200
Subject: [LTP] [PATCH] creat05: count opened fds
Message-ID: <04943ef887b09df79204f36b924dcf753a7b3037.1463488840.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This testcase estimates number of opened fds by opening
a new one and assuming there are no gaps. This doesn't always
hold true. There can be gaps if test harness that runs it
opens couple fds with O_CLOEXEC prior to starting creat05.
As result, testcase unexpectedly fails in setup.

This patch counts opened fds by going through /proc/self/fd entries.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/creat/creat05.c | 53 +++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat05.c b/testcases/kernel/syscalls/creat/creat05.c
index 9a51b872590d..048d24329651 100644
--- a/testcases/kernel/syscalls/creat/creat05.c
+++ b/testcases/kernel/syscalls/creat/creat05.c
@@ -21,18 +21,20 @@
  * Testcase to check that creat(2) system call returns EMFILE.
  */
 
+#include <dirent.h>
 #include <stdio.h>
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 #include <fcntl.h>
 #include <linux/limits.h>
 #include <unistd.h>
 #include "tst_test.h"
 
-static int first_fd, last_fd;
+static int *opened_fds, num_opened_fds;
 
 static void verify_creat(void)
 {
@@ -52,37 +54,54 @@ static void verify_creat(void)
 
 static void setup(void)
 {
-	int max_open;
-	int fd;
+	int i, max_open, opened_at_start = 0;
 	char fname[PATH_MAX];
-
-	/* create a file to get the first file descriptor available */
-	first_fd = fd = SAFE_CREAT("fname", 0666);
-	SAFE_CLOSE(fd);
-	SAFE_UNLINK("fname");
-	tst_res(TINFO, "first fd is #%d", first_fd);
+	DIR *dir;
+	struct dirent *dir_ent;
 
 	/* get the maximum number of files that we can open */
 	max_open = getdtablesize();
 	tst_res(TINFO, "getdtablesize() = %d", max_open);
+	opened_fds = SAFE_MALLOC(max_open * sizeof(int));
+
+	/* count already opened fds */
+	dir = SAFE_OPENDIR("/proc/self/fd");
+	for (dir_ent = SAFE_READDIR(dir); dir_ent != NULL;
+		dir_ent = SAFE_READDIR(dir)) {
+		/* Don't count "." or ".." */
+		if (!strcmp(dir_ent->d_name, ".")
+		    || !strcmp(dir_ent->d_name, ".."))
+			continue;
+		opened_at_start++;
+	}
+	SAFE_CLOSEDIR(dir);
+
+	/* subtract one fd for opendir() */
+	opened_at_start--;
+
+	tst_res(TINFO, "Num fds opened at start #%d", opened_at_start);
+	tst_res(TINFO, "Opening additional #%d fds",
+		max_open - opened_at_start);
 
 	/* now open as many files as we can up to max_open */
-	for (fd = first_fd; fd < max_open; fd++) {
-		snprintf(fname, sizeof(fname), "creat05_%d", fd);
-		last_fd = SAFE_CREAT(fname, 0666);
+	for (i = 0; i < max_open - opened_at_start; i++) {
+		snprintf(fname, sizeof(fname), "creat05_%d", i);
+		opened_fds[num_opened_fds++] = SAFE_CREAT(fname, 0666);
 	}
 }
 
 static void cleanup(void)
 {
-	int fd;
+	int i;
 
-	if (last_fd <= 0)
+	if (num_opened_fds == 0)
 		return;
 
-	for (fd = first_fd + 1; fd <= last_fd; fd++) {
-		if (close(fd))
-			tst_res(TWARN | TERRNO, "close(%i) failed", fd);
+	for (i = 0; i < num_opened_fds; i++) {
+		if (close(opened_fds[i])) {
+			tst_res(TWARN | TERRNO, "close(%i) failed",
+				opened_fds[i]);
+		}
 	}
 }
 
-- 
1.8.3.1

