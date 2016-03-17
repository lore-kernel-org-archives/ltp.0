From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 17 Mar 2016 18:35:54 +0300
Subject: [LTP] [PATCH] lib/tst_rmdir.c: close TESTDIR files before rmobj()
Message-ID: <1458228954-28372-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

NFS creates special .nfs* files when test file was removed and
left open. In that case, tst_rmdir() fails to remove test dirs:

fstatat01 TWARN  :  tst_tmpdir.c:260: tst_rmdir:
  rmobj(/tmp/netpan-10380/mnt/fst9dM6nA) failed:
  remove(/tmp/netpan-10380/mnt/fst9dM6nA/fstatattestdir) failed;
  errno=39: Directory not empty

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 lib/tst_tmpdir.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 3ea1a8b..02584da 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -67,6 +67,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <dirent.h>
 
 #include "test.h"
 #include "rmobj.h"
@@ -188,6 +189,35 @@ void tst_tmpdir(void)
 	}
 }
 
+static void tmpdir_close_fds(void)
+{
+	int fd;
+	char buf[PATH_MAX], fd_path[64];
+	struct dirent *entry;
+
+	DIR *dir = opendir("/proc/self/fd/");
+
+	while ((entry = readdir(dir)) != NULL) {
+		const char *file = entry->d_name;
+
+		if (!strcmp(file, "..") || !strcmp(file, "."))
+			continue;
+
+		fd = atoi(file);
+
+		if (sprintf(fd_path, "/proc/self/fd/%d", fd) <= 0)
+			continue;
+
+		if (readlink(fd_path, buf, PATH_MAX) < 0)
+			continue;
+
+		if (!strncmp(buf, TESTDIR, strlen(TESTDIR)))
+			close(fd);
+	}
+
+	closedir(dir);
+}
+
 void tst_rmdir(void)
 {
 	char *errmsg;
@@ -212,6 +242,13 @@ void tst_rmdir(void)
 	}
 
 	/*
+	 * Close open files in TESTDIR before rmobj().
+	 * When running on NFS, directories might have .nfs* files, which appear
+	 * if a file was removed but left open.
+	 */
+	tmpdir_close_fds();
+
+	/*
 	 * Attempt to remove the "TESTDIR" directory, using rmobj().
 	 */
 	if (rmobj(TESTDIR, &errmsg) == -1) {
-- 
1.7.1

