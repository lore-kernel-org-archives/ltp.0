From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 1 Aug 2018 13:50:20 +0800
Subject: [LTP] [PATCH] open_posix_testsuite/mmap_11-4: Skip this test on
	tmpfs
Message-ID: <1533102620-30244-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According to mmap(2) manpage, when you write data to such partial
page after the end of the object, the data stays in the page cache
even after the file is closed and unmapped, subsequent mappings
always see the modified content on tmpfs.  We just skip this test
when running it on tmpfs.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../conformance/interfaces/mmap/11-4.c                    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
index 2b44815..a52b288 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
@@ -40,8 +40,11 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/vfs.h>
 #include "posixtest.h"
 
+#define TYPE_TMPFS_MAGIC	0x01021994
+
 int main(void)
 {
 	char tmpfname[256];
@@ -54,11 +57,23 @@ int main(void)
 	pid_t child;
 	int i, exit_val;
 
+	struct statfs buf;
+
 	page_size = sysconf(_SC_PAGE_SIZE);
 
 	/* mmap will create a partial page */
 	len = page_size / 2;
 
+	if (statfs("/tmp", &buf)) {
+		printf("Error at statfs(): %s\n", strerror(errno));
+		return PTS_UNRESOLVED;
+	}
+
+	if (buf.f_type == TYPE_TMPFS_MAGIC) {
+		printf("From mmap(2) manpage, skip known bug on tmpfs\n");
+		return PTS_UNTESTED;
+	}
+
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_11_5_%d", getpid());
 	child = fork();
 	switch (child) {
-- 
1.8.3.1



