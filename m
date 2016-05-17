From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 17 May 2016 16:50:11 +0200
Subject: [LTP] [PATCH v2] creat05: don't assume number of opened fds
Message-ID: <28627e5e1631723fccf734af32372e7fa4655ce7.1463496559.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This testcase estimates number of opened fds by opening
a new one and assuming there are no gaps. This doesn't always
hold true. There can be gaps if test harness that runs it
opens couple/closes fds or opens some with O_CLOEXEC flag.
As result, testcase unexpectedly fails in setup with EMFILE.

This patch keeps opening fds in setup() until it arrives
at fd == max_fd - 1.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/creat/creat05.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat05.c b/testcases/kernel/syscalls/creat/creat05.c
index 9a51b872590d..0da2a21dc75d 100644
--- a/testcases/kernel/syscalls/creat/creat05.c
+++ b/testcases/kernel/syscalls/creat/creat05.c
@@ -32,7 +32,7 @@
 #include <unistd.h>
 #include "tst_test.h"
 
-static int first_fd, last_fd;
+static int *opened_fds, num_opened_fds;
 
 static void verify_creat(void)
 {
@@ -56,33 +56,33 @@ static void setup(void)
 	int fd;
 	char fname[PATH_MAX];
 
-	/* create a file to get the first file descriptor available */
-	first_fd = fd = SAFE_CREAT("fname", 0666);
-	SAFE_CLOSE(fd);
-	SAFE_UNLINK("fname");
-	tst_res(TINFO, "first fd is #%d", first_fd);
-
 	/* get the maximum number of files that we can open */
 	max_open = getdtablesize();
 	tst_res(TINFO, "getdtablesize() = %d", max_open);
+	opened_fds = SAFE_MALLOC(max_open * sizeof(int));
 
 	/* now open as many files as we can up to max_open */
-	for (fd = first_fd; fd < max_open; fd++) {
-		snprintf(fname, sizeof(fname), "creat05_%d", fd);
-		last_fd = SAFE_CREAT(fname, 0666);
-	}
+	do {
+		snprintf(fname, sizeof(fname), "creat05_%d", num_opened_fds);
+		fd = SAFE_CREAT(fname, 0666);
+		opened_fds[num_opened_fds++] = fd;
+	} while (fd < max_open - 1);
+
+	tst_res(TINFO, "Opened additional #%d fds", num_opened_fds);
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

