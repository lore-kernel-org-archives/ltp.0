From: Eryu Guan <eguan@redhat.com>
Date: Fri, 27 May 2016 20:15:03 +0800
Subject: [LTP] [PATCH 2/3] ltp-aiodio/dio_sparse: add offset support
In-Reply-To: <1464351304-31405-1-git-send-email-eguan@redhat.com>
References: <1464351304-31405-1-git-send-email-eguan@redhat.com>
Message-ID: <1464351304-31405-2-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Introduce a new option "-o" to specify the write offset.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/io/ltp-aiodio/dio_sparse.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 12e478e..33fda94 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -53,11 +53,11 @@ int TST_TOTAL = 1;
 /*
  * Write zeroes using O_DIRECT into sparse file.
  */
-int dio_sparse(char *filename, int align, int writesize, int filesize)
+int dio_sparse(char *filename, int align, int writesize, int filesize, int offset)
 {
 	int fd, ret;
 	void *bufptr;
-	int i, w;
+	int w;
 
 	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT | O_EXCL, 0600);
 
@@ -76,7 +76,8 @@ int dio_sparse(char *filename, int align, int writesize, int filesize)
 	}
 
 	memset(bufptr, 0, writesize);
-	for (i = 0; i < filesize;) {
+	lseek(fd, offset, SEEK_SET);
+	for (i = offset; i < filesize;) {
 		if ((w = write(fd, bufptr, writesize)) != writesize) {
 			tst_resm(TBROK | TERRNO, "write() returned %d", w);
 			close(fd);
@@ -95,7 +96,7 @@ int dio_sparse(char *filename, int align, int writesize, int filesize)
 void usage(void)
 {
 	fprintf(stderr, "usage: dio_sparse [-d] [-n children] [-s filesize]"
-		" [-w writesize]\n");
+		" [-w writesize] [-o offset]]\n");
 	exit(1);
 }
 
@@ -108,11 +109,12 @@ int main(int argc, char **argv)
 	long alignment = 512;
 	int writesize = 65536;
 	int filesize = 100 * 1024 * 1024;
+	int offset = 0;
 	int c;
 	int children_errors = 0;
 	int ret;
 
-	while ((c = getopt(argc, argv, "dw:n:a:s:")) != -1) {
+	while ((c = getopt(argc, argv, "dw:n:a:s:o:")) != -1) {
 		char *endp;
 		switch (c) {
 		case 'd':
@@ -130,6 +132,10 @@ int main(int argc, char **argv)
 			filesize = strtol(optarg, &endp, 0);
 			filesize = scale_by_kmg(filesize, *endp);
 			break;
+		case 'o':
+			offset = strtol(optarg, &endp, 0);
+			offset = scale_by_kmg(offset, *endp);
+			break;
 		case 'n':
 			num_children = atoi(optarg);
 			if (num_children > NUM_CHILDREN) {
@@ -167,7 +173,7 @@ int main(int argc, char **argv)
 	}
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	ret = dio_sparse(filename, alignment, writesize, filesize);
+	ret = dio_sparse(filename, alignment, writesize, filesize, offset);
 
 	tst_resm(TINFO, "Killing childrens(s)");
 
-- 
2.5.5

