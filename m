From: dongshijiang <dongshijiang@inspur.com>
Date: Tue, 8 Jun 2021 05:17:14 -0400
Subject: [LTP] [PATCH] io/ltp-aiodio: fix function return value
Message-ID: <20210608091714.62930-1-dongshijiang@inspur.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: liubo03 <liubo03@inspur.com>

Function return value is determined using tst_resm (TFAIL,) and tst_exit function

Signed-off-by: liubo03 <liubo03@inspur.com>
---
 testcases/kernel/io/ltp-aiodio/aiodio_append.c | 9 ++++-----
 testcases/kernel/io/ltp-aiodio/dio_append.c    | 7 ++++---
 testcases/kernel/io/ltp-aiodio/dio_truncate.c  | 6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index 5d97ed9..5490bd5 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -93,7 +93,7 @@ void aiodio_append(char *filename)
 
 	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
 	if (fd < 0) {
-		perror("cannot create file");
+		tst_resm(TFAIL, "cannot create file %s", filename);
 		return;
 	}
 
@@ -116,7 +116,7 @@ void aiodio_append(char *filename)
 	 * Start the 1st NUM_AIO requests
 	 */
 	if ((w = io_submit(myctx, NUM_AIO, iocbs)) < 0) {
-		fprintf(stderr, "io_submit write returned %d\n", w);
+		tst_resm(TFAIL, "io_submit write returned %d", w);
 	}
 
 	/*
@@ -135,8 +135,7 @@ void aiodio_append(char *filename)
 					       AIO_SIZE, offset);
 				offset += AIO_SIZE;
 				if ((w = io_submit(myctx, 1, &iocbp)) < 0) {
-					fprintf(stderr,
-						"write %d returned %d\n", i, w);
+					tst_resm(TFAIL, "write %d returned %d", i, w);
 				}
 			}
 		}
@@ -176,7 +175,7 @@ int main(int argc, char **argv)
 		kill(pid[i], SIGTERM);
 	}
 
-	return 0;
+	tst_exit();
 }
 #else
 int main(void)
diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 3f0ed29..585847f 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -85,7 +85,7 @@ void dio_append(char *filename)
 	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
 
 	if (fd < 0) {
-		perror("cannot create file");
+		tst_resm(TFAIL, "cannot create file %s", filename);
 		return;
 	}
 
@@ -99,7 +99,7 @@ void dio_append(char *filename)
 	memset(bufptr, 0, 64 * 1024);
 	for (i = 0; i < 1000; i++) {
 		if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
-			fprintf(stderr, "write %d returned %d\n", i, w);
+			tst_resm(TFAIL, "write %d returned %d", i, w);
 		}
 	}
 }
@@ -139,5 +139,6 @@ int main(void)
 	for (i = 0; i < num_children; i++) {
 		kill(pid[i], SIGTERM);
 	}
-	return 0;
+
+	tst_exit();
 }
diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 7d466dc..0b67f7b 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -112,7 +112,7 @@ void dio_append(char *filename, int fill)
 	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
 
 	if (fd < 0) {
-		perror("cannot create file");
+		tst_resm(TFAIL, "cannot create file %s", filename);
 		return;
 	}
 
@@ -127,7 +127,7 @@ void dio_append(char *filename, int fill)
 
 	for (i = 0; i < 1000; i++) {
 		if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
-			fprintf(stderr, "write %d returned %d\n", i, w);
+			tst_resm(TFAIL, "write %d returned %d", i, w);
 		}
 	}
 	close(fd);
@@ -173,5 +173,5 @@ int main(void)
 		kill(pid[i], SIGTERM);
 	}
 
-	return 0;
+	tst_exit();
 }
-- 
1.8.3.1

