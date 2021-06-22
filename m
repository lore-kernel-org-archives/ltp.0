From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 22 Jun 2021 12:35:10 +0100
Subject: [LTP] [PATCH 4/8] dio: Fix uninitialized var error
In-Reply-To: <20210622113514.22284-1-rpalethorpe@suse.com>
References: <20210622113514.22284-1-rpalethorpe@suse.com>
Message-ID: <20210622113514.22284-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The compiler does not know that we will return if posix_memalign fails
to set bufptr.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/io/ltp-aiodio/dio_append.c   | 2 +-
 testcases/kernel/io/ltp-aiodio/dio_sparse.c   | 2 +-
 testcases/kernel/io/ltp-aiodio/dio_truncate.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 3f0ed29d5..b1b4dc039 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -78,7 +78,7 @@ int read_eof(char *filename)
 void dio_append(char *filename)
 {
 	int fd;
-	void *bufptr;
+	void *bufptr = NULL;
 	int i;
 	int w;
 
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 67b338b3f..3f44e92ea 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -57,7 +57,7 @@ int TST_TOTAL = 1;
  */
 int dio_sparse(int fd, int align, int writesize, int filesize, int offset)
 {
-	void *bufptr;
+	void *bufptr = NULL;
 	int i, w;
 
 	TEST(posix_memalign(&bufptr, align, writesize));
diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 7d466dc20..27cf01525 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -69,7 +69,7 @@ int dio_read(char *filename)
 {
 	int fd;
 	int r;
-	void *bufptr;
+	void *bufptr = NULL;
 
 	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
 	if (TEST_RETURN) {
@@ -105,7 +105,7 @@ int dio_read(char *filename)
 void dio_append(char *filename, int fill)
 {
 	int fd;
-	void *bufptr;
+	void *bufptr = NULL;
 	int i;
 	int w;
 
-- 
2.31.1

