From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 16 Mar 2021 14:00:36 +0100
Subject: [LTP] [PATCH] open_posix: Remove hardcoded /tmp
Message-ID: <20210316130036.1838169-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

This is the first batch, that removes hardcoded paths to /tmp.
They are replaced by getenv(TMPDIR) or fallback to /tmp.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/aio_cancel/1-1.c        |  6 +++---
 .../conformance/interfaces/aio_cancel/2-1.c        |  6 +++---
 .../conformance/interfaces/aio_cancel/2-2.c        |  6 +++---
 .../conformance/interfaces/aio_cancel/3-1.c        |  6 +++---
 .../conformance/interfaces/aio_cancel/4-1.c        |  6 +++---
 .../conformance/interfaces/aio_cancel/5-1.c        |  6 +++---
 .../conformance/interfaces/aio_cancel/6-1.c        |  6 +++---
 .../conformance/interfaces/aio_cancel/7-1.c        |  6 +++---
 .../conformance/interfaces/aio_cancel/8-1.c        |  6 +++---
 .../conformance/interfaces/aio_error/1-1.c         |  6 +++---
 .../conformance/interfaces/aio_error/2-1.c         |  6 +++---
 .../conformance/interfaces/aio_error/3-1.c         |  6 +++---
 .../conformance/interfaces/aio_fsync/14-1.c        |  6 +++---
 .../conformance/interfaces/aio_fsync/2-1.c         |  6 +++---
 .../conformance/interfaces/aio_fsync/3-1.c         |  6 +++---
 .../conformance/interfaces/aio_fsync/4-1.c         |  6 +++---
 .../conformance/interfaces/aio_fsync/5-1.c         |  6 +++---
 .../conformance/interfaces/aio_fsync/8-1.c         |  6 +++---
 .../conformance/interfaces/aio_fsync/8-2.c         |  6 +++---
 .../conformance/interfaces/aio_fsync/8-3.c         |  6 +++---
 .../conformance/interfaces/aio_fsync/8-4.c         |  6 +++---
 .../conformance/interfaces/aio_fsync/9-1.c         |  6 +++---
 .../conformance/interfaces/aio_read/1-1.c          |  6 +++---
 .../conformance/interfaces/aio_read/11-1.c         |  6 +++---
 .../conformance/interfaces/aio_read/11-2.c         |  6 +++---
 .../conformance/interfaces/aio_read/3-1.c          |  6 +++---
 .../conformance/interfaces/aio_read/3-2.c          |  6 +++---
 .../conformance/interfaces/aio_read/4-1.c          |  6 +++---
 .../conformance/interfaces/aio_read/5-1.c          |  6 +++---
 .../conformance/interfaces/aio_read/7-1.c          |  6 +++---
 .../conformance/interfaces/aio_read/9-1.c          |  7 ++++---
 .../conformance/interfaces/aio_return/1-1.c        |  6 +++---
 .../conformance/interfaces/aio_return/2-1.c        |  8 ++++----
 .../conformance/interfaces/aio_return/3-1.c        |  6 +++---
 .../conformance/interfaces/aio_return/3-2.c        |  6 +++---
 .../conformance/interfaces/aio_return/4-1.c        |  6 +++---
 .../conformance/interfaces/aio_suspend/1-1.c       |  6 +++---
 .../conformance/interfaces/aio_suspend/3-1.c       |  6 +++---
 .../conformance/interfaces/aio_suspend/4-1.c       |  6 +++---
 .../conformance/interfaces/aio_suspend/9-1.c       |  6 +++---
 .../conformance/interfaces/aio_write/1-1.c         |  6 +++---
 .../conformance/interfaces/aio_write/1-2.c         |  6 +++---
 .../conformance/interfaces/aio_write/2-1.c         |  6 +++---
 .../conformance/interfaces/aio_write/3-1.c         |  6 +++---
 .../conformance/interfaces/aio_write/5-1.c         |  6 +++---
 .../conformance/interfaces/aio_write/7-1.c         |  7 ++++---
 .../conformance/interfaces/aio_write/8-2.c         |  6 +++---
 .../conformance/interfaces/aio_write/9-1.c         |  6 +++---
 .../conformance/interfaces/aio_write/9-2.c         |  6 +++---
 .../conformance/interfaces/fsync/4-1.c             |  6 ++++--
 .../conformance/interfaces/lio_listio/1-1.c        |  7 ++++---
 .../conformance/interfaces/lio_listio/10-1.c       |  7 ++++---
 .../conformance/interfaces/lio_listio/12-1.c       |  7 ++++---
 .../conformance/interfaces/lio_listio/13-1.c       |  7 ++++---
 .../conformance/interfaces/lio_listio/14-1.c       |  7 ++++---
 .../conformance/interfaces/lio_listio/15-1.c       |  7 ++++---
 .../conformance/interfaces/lio_listio/18-1.c       |  7 ++++---
 .../conformance/interfaces/lio_listio/2-1.c        |  7 ++++---
 .../conformance/interfaces/lio_listio/3-1.c        |  7 ++++---
 .../conformance/interfaces/lio_listio/4-1.c        |  7 ++++---
 .../conformance/interfaces/lio_listio/5-1.c        |  7 ++++---
 .../conformance/interfaces/lio_listio/7-1.c        |  7 ++++---
 .../conformance/interfaces/lio_listio/8-1.c        |  6 +++---
 .../conformance/interfaces/lio_listio/9-1.c        |  7 ++++---
 .../conformance/interfaces/mmap/1-1.c              |  6 ++++--
 .../conformance/interfaces/mmap/10-1.c             |  6 ++++--
 .../conformance/interfaces/mmap/11-1.c             |  6 ++++--
 .../conformance/interfaces/mmap/11-2.c             |  6 ++++--
 .../conformance/interfaces/mmap/11-4.c             |  9 ++++++---
 .../conformance/interfaces/mmap/11-6.c             |  6 ++++--
 .../conformance/interfaces/mmap/12-1.c             |  6 ++++--
 .../conformance/interfaces/mmap/13-1.c             | 10 ++++++----
 .../conformance/interfaces/mmap/14-1.c             |  6 ++++--
 .../conformance/interfaces/mmap/21-1.c             |  6 ++++--
 .../conformance/interfaces/mmap/27-1.c             |  6 ++++--
 .../conformance/interfaces/mmap/3-1.c              | 12 ++++++------
 .../conformance/interfaces/mmap/31-1.c             |  8 +++++---
 .../conformance/interfaces/mmap/32-1.c             |  6 ++++--
 .../conformance/interfaces/mmap/5-1.c              |  6 ++++--
 .../conformance/interfaces/mmap/6-1.c              |  6 ++++--
 .../conformance/interfaces/mmap/6-2.c              |  6 ++++--
 .../conformance/interfaces/mmap/6-3.c              |  6 ++++--
 .../conformance/interfaces/mmap/6-4.c              |  6 ++++--
 .../conformance/interfaces/mmap/6-5.c              |  6 ++++--
 .../conformance/interfaces/mmap/6-6.c              |  6 ++++--
 .../conformance/interfaces/mmap/7-1.c              |  6 ++++--
 .../conformance/interfaces/mmap/7-2.c              |  6 ++++--
 .../conformance/interfaces/mmap/9-1.c              |  6 ++++--
 .../conformance/interfaces/mq_open/16-1.c          |  9 +++++----
 .../conformance/interfaces/munmap/1-1.c            |  7 ++++---
 .../conformance/interfaces/munmap/1-2.c            |  7 ++++---
 .../conformance/interfaces/munmap/3-1.c            |  7 ++++---
 .../conformance/interfaces/munmap/4-1.c            |  7 ++++---
 .../conformance/interfaces/munmap/9-1.c            |  7 ++++---
 testcases/open_posix_testsuite/include/tempfile.h  | 14 ++++++++++++++
 95 files changed, 351 insertions(+), 267 deletions(-)
 create mode 100644 testcases/open_posix_testsuite/include/tempfile.h

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/1-1.c
index 314121fff..c3a54239f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/1-1.c
@@ -31,12 +31,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_cancel/1-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 1024
 	char buf[BUF_SIZE];
 	struct timespec processing_completion_ts = {0, 10000000};
@@ -46,8 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_cancel_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-1.c
index cf681755c..738b47479 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-1.c
@@ -36,12 +36,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_cancel/2-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 1024
 	char buf[BUF_SIZE];
 	int fd, err;
@@ -50,8 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_cancel_2_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-2.c
index 9b1df5a0c..5921bc577 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-2.c
@@ -32,19 +32,19 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_cancel/2-2.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_cancel_2_2_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_2_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
index abe09cd83..90d2e8f3a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
@@ -40,6 +40,7 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_cancel/3-1.c"
 
@@ -64,7 +65,7 @@ static void sig_handler(int signum LTP_ATTRIBUTE_UNUSED, siginfo_t *info,
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 	struct aiocb *aiocb_list[BUF_NB];
 	struct aiocb *aiocb;
@@ -77,8 +78,7 @@ int main(void)
 		return PTS_UNSUPPORTED;
 	}
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_cancel_3_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
index 512f8ea6c..daf72b799 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
@@ -37,6 +37,7 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_cancel/4-1.c"
 
@@ -45,7 +46,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 	struct aiocb *aiocb[BUF_NB];
 	int i;
@@ -54,8 +55,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_cancel_4_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
index 03937e5d9..bebe6c7ae 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
@@ -35,6 +35,7 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_cancel/5-1.c"
 
@@ -43,7 +44,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 	struct aiocb *aiocb[BUF_NB];
 	char *buf[BUF_NB];
@@ -54,8 +55,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_cancel_5_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_5_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
index 6cc23f2d6..a474d2410 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
@@ -38,6 +38,7 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_cancel/6-1.c"
 
@@ -46,7 +47,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 	struct aiocb *aiocb[BUF_NB];
 	int i;
@@ -56,8 +57,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_cancel_6_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_6_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
index 0a19ff99f..8c418d583 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
@@ -36,6 +36,7 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_cancel/7-1.c"
 
@@ -44,7 +45,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 	struct aiocb *aiocb[BUF_NB];
 	int i;
@@ -54,8 +55,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_cancel_7_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_7_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c
index c64520f55..da5a9347b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c
@@ -33,12 +33,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_cancel/8-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 1024
 	char buf[BUF_SIZE];
 	int fd;
@@ -49,8 +50,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_cancel_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/1-1.c
index a212c4ff7..add59bf50 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/1-1.c
@@ -31,12 +31,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_error/1-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd, ret;
@@ -46,8 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_error_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
index 3c8e30299..31d527a7a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
@@ -31,6 +31,7 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_error/2-1.c"
 
@@ -39,7 +40,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 	struct aiocb *aiocb[BUF_NB];
 	int i;
@@ -48,8 +49,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_2_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_error_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
index 9ccda055e..82b30f993 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
@@ -30,13 +30,14 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_error/3-1.c"
 
 int main(void)
 {
 
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 512
 	char buf[BUF_SIZE];
 	int fd;
@@ -46,8 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_3_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_error_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
index dce60c2a0..d912af981 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
@@ -18,12 +18,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_fsync/14-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
@@ -35,8 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_14_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_14_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
index 3ca9c75b8..78d3c810b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
@@ -18,6 +18,7 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_fsync/2-1.c"
 
@@ -25,7 +26,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	char buf[BUF_SIZE];
 	int fd, ret;
 	struct aiocb aiocb_write;
@@ -35,8 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_2_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
index 678045e71..ebc666174 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
@@ -18,6 +18,7 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_fsync/3-1.c"
 
@@ -25,7 +26,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	char buf[BUF_SIZE];
 	int fd, ret;
 	struct aiocb aiocb_write;
@@ -35,8 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_3_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
index 31fa74b29..881cf3a42 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
@@ -19,12 +19,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_fsync/4-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
@@ -35,8 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_4_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c
index 83c765d9c..2a4e4d42d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c
@@ -18,6 +18,7 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_fsync/5-1.c"
 
@@ -25,7 +26,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	char buf[BUF_SIZE];
 	int fd;
 	struct aiocb aiocb_write;
@@ -36,8 +37,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_5_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_5_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
index 0d44b1830..813e11b11 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
@@ -18,12 +18,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_fsync/8-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
@@ -35,8 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_8_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
index 57347a30d..17508ca2d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
@@ -18,12 +18,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_fsync/8-2.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
@@ -35,8 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_8_2_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
index ed85d268d..daf09e584 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
@@ -18,12 +18,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_fsync/8-3.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
@@ -35,8 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_8_3_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_3");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
index 8bbb080d6..d4d317d4d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
@@ -18,12 +18,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_fsync/8-4.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
@@ -35,8 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_8_4_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_4");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
index 725eb7f36..da44f99ad 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
@@ -18,12 +18,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_fsync/9-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
@@ -35,8 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_fsync_9_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_9_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/1-1.c
index 43d33887f..4c3f5e03e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/1-1.c
@@ -29,12 +29,13 @@
 #include <unistd.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_read/1-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define WBUF_SIZE 1024
 	char buf[WBUF_SIZE];
 #define RBUF_SIZE 256
@@ -50,8 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_read_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-1.c
index 01834e4e5..b8e47795d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-1.c
@@ -33,12 +33,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_read/11-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
@@ -47,8 +48,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_read_11_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_11_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-2.c
index ff43ca153..d4f75bf5a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-2.c
@@ -32,12 +32,13 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_read/11-2.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
@@ -46,8 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_read_11_2%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_11_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-1.c
index d5af0dbdf..57d162bd4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-1.c
@@ -30,12 +30,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_read/3-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
@@ -46,8 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_read_3_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-2.c
index 67716971a..63efc0d56 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-2.c
@@ -30,12 +30,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_read/3-2.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 1024
 	char buf[BUF_SIZE];
 	int fd;
@@ -46,8 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_read_3_2_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_3_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/4-1.c
index 55c3e48b1..8f937e0f7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/4-1.c
@@ -30,12 +30,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_read/4-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 512
 	unsigned char buf[BUF_SIZE * 2];
 	unsigned char check[BUF_SIZE];
@@ -47,8 +48,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_read_4_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/5-1.c
index 7d553225e..514e066ce 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/5-1.c
@@ -31,12 +31,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_read/5-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	unsigned char buf[BUF_SIZE];
 	unsigned char check[BUF_SIZE];
@@ -48,8 +49,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_read_5_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_5_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c
index 67abafe73..7051b04c7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c
@@ -31,12 +31,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_read/7-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	unsigned char check[BUF_SIZE];
 	int fd;
@@ -47,8 +48,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_read_7_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_7_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
index a1b7de2b1..1e8836730 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
@@ -31,7 +31,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_read/9-1.c"
 
@@ -39,7 +41,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 512
 	char buf[BUF_SIZE];
 	int fd;
@@ -53,8 +55,7 @@ int main(void)
 	    || sysconf(_SC_AIO_MAX) == -1)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_write_4_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
index 2bc7c32b4..764c653ef 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
@@ -32,13 +32,14 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_return/1-1.c"
 #define BUF_SIZE 111
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	char buf[BUF_SIZE];
 	struct aiocb aiocb;
 	int fd, retval;
@@ -47,8 +48,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_return_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_return_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/2-1.c
index ac9873200..2216256e3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/2-1.c
@@ -28,15 +28,16 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include "posixtest.h"
 #include <time.h>
 
+#include "posixtest.h"
+#include "tempfile.h"
 #define TNAME "aio_return/2-1.c"
 #define BUF_SIZE 111
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	char buf[BUF_SIZE];
 	struct aiocb aiocb;
 	int fd, retval;
@@ -45,8 +46,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_return_2_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_return_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-1.c
index 218d9ddf7..d80c58edf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-1.c
@@ -35,13 +35,14 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_return/3-1.c"
 #define BUF_SIZE 4096
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	char buf[BUF_SIZE];
 	struct aiocb aiocb;
 	int fd, retval;
@@ -50,8 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_return_3_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_return_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-2.c
index 883823bac..18a965ca9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-2.c
@@ -33,13 +33,14 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_return/3-2.c"
 #define BUF_SIZE 4096
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	char buf[BUF_SIZE];
 	struct aiocb aiocb;
 	int fd, retval;
@@ -48,8 +49,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_return_3_2_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_return_3_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
index 7a039b13f..8f25f4e2d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
@@ -33,13 +33,14 @@
 #include <unistd.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_return/4-1.c"
 #define BUF_SIZE 111
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	char buf[BUF_SIZE];
 	struct aiocb aiocb;
 	struct aiocb aiocb2;
@@ -49,8 +50,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_return_2_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_return_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
index 623a2a0d0..8d411acfe 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
@@ -43,6 +43,7 @@
 #include <unistd.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_suspend/1-1.c"
 
@@ -60,7 +61,7 @@ static void sigrt1_handler(int signum LTP_ATTRIBUTE_UNUSED,
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb **aiocbs;
@@ -76,8 +77,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_suspend_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_1_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
index 46046f3ca..c275f57dd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
@@ -31,6 +31,7 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_suspend/2-1.c"
 
@@ -39,7 +40,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 1024
 	char buf[BUF_SIZE];
 	int fd;
@@ -52,8 +53,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_suspend_2_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
index 6e312b6fa..c3d599e0d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
@@ -33,6 +33,7 @@
 #include <unistd.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_suspend/4-1.c"
 
@@ -60,7 +61,7 @@ static void sigrt2_handler(int signum)
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	struct aiocb aiocbs[NUM_AIOCBS];
 	struct aiocb *aiolist[NUM_AIOCBS];
 	struct aiocb *plist[2];
@@ -74,8 +75,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_suspend_4_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_4_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_SYNC | O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/9-1.c
index ba776a5a2..f0c825e48 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/9-1.c
@@ -36,6 +36,7 @@
 #include <unistd.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define WAIT_FOR_AIOCB	6
 
@@ -49,7 +50,7 @@ static void sigrt1_handler()
 static int do_test(int num_aiocbs, size_t buf_size)
 {
 	struct timespec processing_completion_ts = {0, 10000000};
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 	struct aiocb *aiocbs[num_aiocbs];
 	struct aiocb *plist[2];
@@ -61,8 +62,7 @@ static int do_test(int num_aiocbs, size_t buf_size)
 	int err = PTS_UNRESOLVED;
 	int i;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_suspend_9_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_9_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-1.c
index c885fa4e2..9dfa0b2fd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-1.c
@@ -33,12 +33,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_write/1-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 512
 	char buf[BUF_SIZE];
 	char check[BUF_SIZE + 1];
@@ -51,8 +52,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_write_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-2.c
index f7424fbfc..35c3bf422 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-2.c
@@ -34,12 +34,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_write/1-2.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 1024
 	char buf[BUF_SIZE];
 	char check[BUF_SIZE * 2];
@@ -52,8 +53,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_write_1_2_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_1_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/2-1.c
index 86c9f714f..bc66ce0f9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/2-1.c
@@ -33,12 +33,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_write/2-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE0 512
 	char buf0[BUF_SIZE0];
 #define BUF_SIZE1 1024
@@ -59,8 +60,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_write_2_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_APPEND | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/3-1.c
index 8481af357..14fc69573 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/3-1.c
@@ -33,12 +33,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_write/3-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 512
 	char buf[BUF_SIZE];
 	char check[BUF_SIZE];
@@ -51,8 +52,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_write_3_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/5-1.c
index b41edcba5..1cf91688c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/5-1.c
@@ -32,12 +32,13 @@
 #include <time.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_write/5-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 512
 	char buf[BUF_SIZE];
 	int fd;
@@ -49,8 +50,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_write_5_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_5_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
index 016e2e06b..8184e1c11 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
@@ -31,7 +31,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_write/7-1.c"
 
@@ -39,7 +41,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 512
 	char buf[BUF_SIZE];
 	int fd;
@@ -53,8 +55,7 @@ int main(void)
 	    || sysconf(_SC_AIO_MAX) == -1)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_write_4_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
index a2e96fd7e..8b9f8e49c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
@@ -32,12 +32,13 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_write/8-2.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 512
 	char buf[BUF_SIZE];
 	int fd;
@@ -48,8 +49,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_write_8_2_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_8_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDONLY | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-1.c
index 402c5c952..ed49754b0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-1.c
@@ -35,12 +35,13 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_write/9-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 111
 	char buf[BUF_SIZE];
 	int fd;
@@ -50,8 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_write_9_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_9_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-2.c
index c0ed1f9ae..b620eb8a4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-2.c
@@ -35,12 +35,13 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "aio_write/9-2.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 512
 	char buf[BUF_SIZE];
 	int fd;
@@ -50,8 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_write_9_2_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_9_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fsync/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fsync/4-1.c
index 8e27c98ab..ebfe9902b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fsync/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fsync/4-1.c
@@ -22,18 +22,20 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "fsync/4-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	char *data;
 	int total_size = 1024;
 	int fd;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_fsync_4_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_fsync_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c
index d5069b40e..bd50e3d58 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c
@@ -30,7 +30,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/1-1.c"
 
@@ -48,7 +50,7 @@ static void sigrt1_handler(int signum LTP_ATTRIBUTE_UNUSED,
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb **aiocbs;
@@ -63,8 +65,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_1_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/10-1.c
index d95b5e8e9..2087b3a93 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/10-1.c
@@ -29,7 +29,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/10-1.c"
 
@@ -54,7 +56,7 @@ static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb *aiocbs[NUM_AIOCBS];
@@ -69,8 +71,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_10_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_10_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/12-1.c
index db73cb50e..af393f8ad 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/12-1.c
@@ -28,7 +28,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/12-1.c"
 
@@ -37,7 +39,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb *aiocbs[NUM_AIOCBS];
@@ -50,8 +52,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_12_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_12_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/13-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/13-1.c
index 240f343f5..6e511aadf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/13-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/13-1.c
@@ -28,7 +28,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/13-1.c"
 
@@ -37,7 +39,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb *aiocbs[NUM_AIOCBS];
@@ -50,8 +52,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_13_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_13_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/14-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/14-1.c
index 3944b3c13..477e66b7d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/14-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/14-1.c
@@ -29,7 +29,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/14-1.c"
 
@@ -55,7 +57,7 @@ static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb *aiocbs[NUM_AIOCBS];
@@ -70,8 +72,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_14_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_14_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/15-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/15-1.c
index ff90d1f49..6e03cb1f7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/15-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/15-1.c
@@ -29,7 +29,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/15-1.c"
 
@@ -55,7 +57,7 @@ static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb *aiocbs[NUM_AIOCBS];
@@ -70,8 +72,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_15_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_15_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/18-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/18-1.c
index 130f7dfbe..3cd26f230 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/18-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/18-1.c
@@ -29,7 +29,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/18-1.c"
 
@@ -38,7 +40,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb *aiocbs[NUM_AIOCBS];
@@ -48,8 +50,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_18_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_18_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
index 193948300..3cdd106fe 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
@@ -28,7 +28,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/2-1.c"
 
@@ -54,7 +56,7 @@ static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb *aiocbs[NUM_AIOCBS];
@@ -69,8 +71,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_2_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_2_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/3-1.c
index a33a215ad..0b8becf80 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/3-1.c
@@ -29,7 +29,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/3-1.c"
 
@@ -54,7 +56,7 @@ static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb *aiocbs[NUM_AIOCBS];
@@ -69,8 +71,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_3_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_3_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/4-1.c
index 8383ca072..ae1b749ea 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/4-1.c
@@ -29,7 +29,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/4-1.c"
 
@@ -55,7 +57,7 @@ static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb *aiocbs[NUM_AIOCBS];
@@ -70,8 +72,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_4_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_4_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c
index e0d58ad79..5a2c140e0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c
@@ -31,7 +31,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define NUM_AIOCBS	3
 #define BUF_SIZE	1024
@@ -40,7 +42,7 @@
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb *aiocbs[NUM_AIOCBS];
@@ -53,8 +55,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_4_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_4_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c
index 7594b82b0..af953123f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c
@@ -30,7 +30,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/7-1.c"
 
@@ -56,7 +58,7 @@ static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int fd;
 
 	struct aiocb *aiocbs[NUM_AIOCBS];
@@ -71,8 +73,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_4_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_4_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/8-1.c
index c2cff0c1d..aeec017ad 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/8-1.c
@@ -31,12 +31,13 @@
 #include <aio.h>
 
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/8-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 512
 	unsigned char buf[BUF_SIZE];
 	unsigned char check[BUF_SIZE];
@@ -50,8 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_8_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_8_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/9-1.c
index 13585a120..0324a7505 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/9-1.c
@@ -30,13 +30,15 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "lio_listio/9-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 #define BUF_SIZE 512
 	unsigned char buf[BUF_SIZE];
 	unsigned char check[BUF_SIZE];
@@ -50,8 +52,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_lio_listio_9_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_9_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c
index 4b9b47d40..420c83b5b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c
@@ -24,17 +24,19 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	ssize_t len = 1024;
 	char data[len];
 	void *pa;
 	int fd;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_1_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/10-1.c
index 4248b43b4..3b9525ba6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/10-1.c
@@ -26,7 +26,9 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define LOOP_NUM 100000
 
@@ -35,7 +37,7 @@ int main(void)
 	int rc;
 	unsigned long cnt;
 
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	long total_size;
 
 	void *pa;
@@ -45,7 +47,7 @@ int main(void)
 	total_size = 1024;
 	size = total_size;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_10_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_10_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-1.c
index ef982bb48..bfc83911c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-1.c
@@ -31,11 +31,13 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	long page_size;
 	long total_size;
 
@@ -48,7 +50,7 @@ int main(void)
 	total_size = 3 * page_size;
 	size = page_size;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_11_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
index f2555e261..ebf4e47d4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
@@ -29,7 +29,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
 
@@ -48,7 +50,7 @@ int main(void)
 	printf("_POSIX_MEMORY_PROTECTION is not defined\n");
 	return PTS_UNTESTED;
 #endif
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	long page_size;
 	long total_size;
 
@@ -72,7 +74,7 @@ int main(void)
 	sigaction(SIGBUS, &sa, NULL);
 
 	/* Create tmp file */
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_11_2_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
index 565e1cf0c..e7fef3359 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
@@ -39,16 +39,19 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+#include <limits.h>
 #ifdef	__linux__
 #include <sys/vfs.h>
 #endif
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TYPE_TMPFS_MAGIC	0x01021994
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	long page_size;
 
 	char *pa;
@@ -63,10 +66,11 @@ int main(void)
 	/* mmap will create a partial page */
 	len = page_size / 2;
 
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_5");
 #ifdef	__linux__
 	struct statfs buf;
 
-	if (statfs("/tmp", &buf)) {
+	if (statfs(ltp_get_tmpdir(), &buf)) {
 		printf("Error at statfs(): %s\n", strerror(errno));
 		return PTS_UNRESOLVED;
 	}
@@ -77,7 +81,6 @@ int main(void)
 	}
 #endif
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_11_5_%d", getpid());
 	child = fork();
 	switch (child) {
 	case 0:
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c
index 9c1383498..17edf80bd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c
@@ -38,11 +38,13 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	long page_size;
 
 	char *pa, ch;
@@ -57,7 +59,7 @@ int main(void)
 	/* mmap will create a partial page */
 	len = page_size / 2;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_11_5_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_5");
 	child = fork();
 	switch (child) {
 	case 0:
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/12-1.c
index 9c4023c57..21a119e6d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/12-1.c
@@ -30,16 +30,18 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	void *pa;
 	ssize_t size = 1024;
 	int fd, i;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_12_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_12_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c
index d04060cae..e6faca765 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c
@@ -30,12 +30,14 @@
 #include <string.h>
 #include <errno.h>
 #include <time.h>
+
 #include "noatime.h"
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	ssize_t size = 1024;
 	char data[size];
 	void *pa;
@@ -46,12 +48,12 @@ int main(void)
 
 	char *ch;
 
-	if (mounted_noatime("/tmp") == 1) {
-		printf("UNTESTED: The /tmp is mounted noatime\n");
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_13_1");
+	if (mounted_noatime(ltp_get_tmpdir()) == 1) {
+		printf("UNTESTED: The tmpdir is mounted noatime\n");
 		return PTS_UNTESTED;
 	}
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_13_1_%d", getpid());
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c
index bcbb4e67c..b262f6ecb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c
@@ -29,11 +29,13 @@
 #include <string.h>
 #include <errno.h>
 #include <time.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	ssize_t size = 1024;
 	char data[size];
 	void *pa;
@@ -44,7 +46,7 @@ int main(void)
 
 	char *ch;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_14_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_14_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
index ce0e5ef8f..b8df231d7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
@@ -24,18 +24,20 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 
 	void *pa;
 	size_t size = 1024;
 	int flag = ~0;
 	int fd;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_21_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_21_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/27-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/27-1.c
index b69274364..c06f48783 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/27-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/27-1.c
@@ -27,18 +27,20 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	int total_size = 1024;
 
 	void *pa;
 	size_t len = total_size;
 	int fd, err = 0;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_27_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_27_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/3-1.c
index 18867d95b..f0deecb3c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/3-1.c
@@ -29,13 +29,15 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #ifdef MAP_FIXED
 int main(void)
 {
-	char tmpfname[256];
-	char tmpfname2[256];
+	char tmpfname[PATH_MAX];
+	char tmpfname2[PATH_MAX];
 	char *data;
 	long total_size;
 	long page_size;
@@ -57,10 +59,8 @@ int main(void)
 	/* Size of the file */
 	total_size = 2 * page_size;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_3_1_%d_1",
-		 getpid());
-	snprintf(tmpfname2, sizeof(tmpfname2), "/tmp/pts_mmap_3_1_%d_2",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_3_1_1");
+	LTP_GET_TMP_FILENAME(tmpfname2, "pts_mmap_3_1_2");
 
 	unlink(tmpfname);
 	unlink(tmpfname2);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c
index 4c594da7b..56bdc2357 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c
@@ -34,11 +34,13 @@
 #include <string.h>
 #include <errno.h>
 #include <sys/utsname.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 
 	void *pa;
 	size_t len;
@@ -47,7 +49,7 @@ int main(void)
 
 	/* check for 64 bit arch */
 	if (sizeof(void *) == 8) {
-		printf("USUPPORTED: Cannot be tested on 64 bit architecture\n");
+		printf("UNSUPPORTED: Cannot be tested on 64 bit architecture\n");
 		return PTS_UNSUPPORTED;
 	}
 
@@ -65,7 +67,7 @@ int main(void)
 
 	long page_size = sysconf(_SC_PAGE_SIZE);
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_31_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_31_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
index 7ab526066..187799f33 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
@@ -20,16 +20,18 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 
 	void *pa;
 	int fd;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_31_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_31_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c
index d9d476bd5..860d3ee0b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c
@@ -30,7 +30,9 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 static struct testcase {
 	int prot;
@@ -87,13 +89,13 @@ static void print_error(struct testcase *t, int saved_errno)
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	void *pa;
 	size_t size = 1024;
 	int fd, fail = 0;
 	unsigned int i;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_5_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_5_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-1.c
index ebded92be..5edf66d19 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-1.c
@@ -36,12 +36,14 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
 #ifdef _POSIX_MEMORY_PROTECTION
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	void *pa;
 	size_t size = 1024;
 	int fd;
@@ -50,7 +52,7 @@ int main(void)
 	int status;
 	int sig_num;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_6_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c
index 0ffa82052..18beb009e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c
@@ -37,12 +37,14 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
 #ifdef _POSIX_MEMORY_PROTECTION
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	ssize_t size = 1024;
 	char data[size];
 	void *pa;
@@ -52,7 +54,7 @@ int main(void)
 	int status;
 	int sig_num;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_6_2_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c
index fd413b35b..361c26177 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c
@@ -37,12 +37,14 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
 #ifdef _POSIX_MEMORY_PROTECTION
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	void *pa;
 	size_t size = 1024;
 	int fd;
@@ -51,7 +53,7 @@ int main(void)
 	int status;
 	int sig_num;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_6_2_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-4.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-4.c
index 27f3cbd65..b5777493d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-4.c
@@ -29,16 +29,18 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	void *pa;
 	size_t size = 1024;
 	int fd;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_6_4_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_4");
 
 	/* Create a tmp file */
 	unlink(tmpfname);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-5.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-5.c
index a21432fd6..ba0a0c899 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-5.c
@@ -29,17 +29,19 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	void *pa;
 	size_t size = 1024;
 	int fd;
 
 	/* Create the file */
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_6_5_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_5");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-6.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-6.c
index 6672c96c3..5e5d82b57 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-6.c
@@ -28,17 +28,19 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	void *pa;
 	size_t size = 1024;
 	int fd;
 
 	/* Create the tmp file */
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_6_6_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_6");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c
index d7cfdde67..719ca189c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c
@@ -35,17 +35,19 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	ssize_t size = 1024;
 	char data[size];
 	void *pa;
 	int fd;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_7_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_7_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c
index e90f812f8..e2b21f578 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c
@@ -35,17 +35,19 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	ssize_t size = 1024;
 	char data[size];
 	void *pa;
 	int fd;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_7_2_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_7_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/9-1.c
index 8130ce768..73cb19c80 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/9-1.c
@@ -29,11 +29,13 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	long page_size;
 	long total_size;
 
@@ -47,7 +49,7 @@ int main(void)
 	size = total_size;
 
 	/* Create tmp file */
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_9_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_9_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
index b7d064b06..b41cd52cd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
@@ -31,15 +31,16 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
-#define NAMESIZE 50
 #define TNAME "mq_open/16-1.c"
 
 int main(void)
 {
-	char qname[NAMESIZE];
-	char fname[NAMESIZE];
+	char qname[NAME_MAX];
+	char fname[PATH_MAX];
 	int pid, succeeded = 0;
 	int fd;
 	void *pa = NULL;
@@ -53,7 +54,7 @@ int main(void)
 
 	sprintf(qname, "/mq_open_16-1_%d", getpid());
 
-	sprintf(fname, "/tmp/pts_mq_open_16_1_%d", getpid());
+	LTP_GET_TMP_FILENAME(fname, "pts_mq_open_16_1");
 	unlink(fname);
 	fd = open(fname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-1.c
index 8c79a7516..13a6ae025 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-1.c
@@ -30,7 +30,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "munmap/1-1.c"
 
@@ -43,7 +45,7 @@ static void sigsegv_handler(int signum LTP_ATTRIBUTE_UNUSED)
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	long file_size;
 
 	void *pa = NULL;
@@ -71,8 +73,7 @@ int main(void)
 	len = page_size + 1;
 
 	/* Create tmp file */
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_munmap_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c
index 92e4917a5..9cfa3df88 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c
@@ -30,7 +30,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "munmap/1-2.c"
 
@@ -43,7 +45,7 @@ static void sigsegv_handler(int signum LTP_ATTRIBUTE_UNUSED)
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	long file_size;
 
 	void *pa = NULL;
@@ -71,8 +73,7 @@ int main(void)
 	len = page_size + 1;
 
 	/* Create tmp file */
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_munmap_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c
index cca9028c8..06672f0c5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c
@@ -24,13 +24,15 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "munmap/3-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	long file_size;
 
 	void *pa = NULL;
@@ -52,8 +54,7 @@ int main(void)
 	len = page_size + 1;
 
 	/* Create tmp file */
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_munmap_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/4-1.c
index 7e90a97a4..72e9e671e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/4-1.c
@@ -30,7 +30,9 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "munmap/4-1.c"
 
@@ -38,7 +40,7 @@ int main(void)
 {
 	int rc;
 
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	char *data;
 	int total_size = 1024;
 
@@ -52,8 +54,7 @@ int main(void)
 
 	char *ch;
 
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_munmap_4_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_munmap_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c
index ce0b06f35..3d24e503b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c
@@ -21,13 +21,15 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+
 #include "posixtest.h"
+#include "tempfile.h"
 
 #define TNAME "munmap/9-1.c"
 
 int main(void)
 {
-	char tmpfname[256];
+	char tmpfname[PATH_MAX];
 	long file_size;
 
 	void *pa = NULL;
@@ -47,8 +49,7 @@ int main(void)
 	len = page_size + 1;
 
 	/* Create tmp file */
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_munmap_1_1_%d",
-		 getpid());
+	LTP_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/include/tempfile.h b/testcases/open_posix_testsuite/include/tempfile.h
new file mode 100644
index 000000000..cc67cf832
--- /dev/null
+++ b/testcases/open_posix_testsuite/include/tempfile.h
@@ -0,0 +1,14 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <limits.h>
+
+#define LTP_GET_TMP_FILENAME(target, prefix) \
+    snprintf(target, sizeof(target), \
+    "%s/" prefix "%d", ltp_get_tmpdir(), getpid());
+
+static inline const char *ltp_get_tmpdir(void)
+{
+    const char *tmpdir_env;
+    tmpdir_env = getenv("TMPDIR");
+    return tmpdir_env ? tmpdir_env : "/tmp";
+}
\ No newline at end of file
-- 
2.25.1

