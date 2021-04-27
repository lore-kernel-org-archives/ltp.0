From: Wang Xin <wangxin410@huawei.com>
Date: Tue, 27 Apr 2021 10:51:23 +0800
Subject: [LTP] [PATCH] openposix/conformance/interfaces: Correct typos
Message-ID: <1619491883-69694-1-git-send-email-wangxin410@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Types in the name of the temporary files: For example, in aio_cancel/8-1.c file,
pts_aio_cancel_1_1 -> pts_aio_cancel_8_1.
Others like this have been modified.

Signed-off-by: Wang Xin <wangxin410@huawei.com>
---
 v4 -> v3: rebase and resent this patch on the latest main branch.

 testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c  | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c    | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c  | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c   | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c  | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c  | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c       | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c       | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c        | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c      | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c      | 2 +-
 testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c      | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c
index 139e9b5..f11e067 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c
@@ -50,7 +50,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_8_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
index 5b980be..e1ae59e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
@@ -55,7 +55,7 @@ int main(void)
 	    || sysconf(_SC_AIO_MAX) == -1)
 		return PTS_UNSUPPORTED;
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_read_9_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
index f380531..a243b3e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
@@ -50,7 +50,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_return_2_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_return_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
index ed8173e..615b97d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
@@ -53,7 +53,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_2_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
index 5311a4a..277573a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
@@ -55,7 +55,7 @@ int main(void)
 	    || sysconf(_SC_AIO_MAX) == -1)
 		return PTS_UNSUPPORTED;
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_7_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c
index e445773..7eb6448 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c
@@ -55,7 +55,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_5_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c
index 444555e..4e8afb6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c
@@ -73,7 +73,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_7_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c
index 2aea927..d1f8991 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c
@@ -59,7 +59,7 @@ int main(void)
 	/* mmap will create a partial page */
 	len = page_size / 2;
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_5");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_6");
 	child = fork();
 	switch (child) {
 	case 0:
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
index bb3ab74..d58fc8c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
@@ -31,7 +31,7 @@ int main(void)
 	void *pa;
 	int fd;
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_31_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_32_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c
index b38833b..9aef16c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c
@@ -53,7 +53,7 @@ int main(void)
 	int status;
 	int sig_num;
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_3");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c
index 9d0f918..31f2109 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c
@@ -73,7 +73,7 @@ int main(void)
 	len = page_size + 1;
 	/* Create tmp file */
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c
index 53e89de..1879719 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c
@@ -54,7 +54,7 @@ int main(void)
 	len = page_size + 1;
 	/* Create tmp file */
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_munmap_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c
index 0280a0e..371e3b0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c
@@ -49,7 +49,7 @@ int main(void)
 	len = page_size + 1;
 	/* Create tmp file */
-	PTS_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_munmap_9_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
2.6.2

