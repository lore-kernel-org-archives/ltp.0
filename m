From: Hridya Valsaraju <hridya@google.com>
Date: Thu,  8 Mar 2018 11:16:39 -0800
Subject: [LTP] [PATCH v2] mtest06: Use temp dir from $TMPDIR if present
Message-ID: <20180308191639.195488-1-hridya@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test was failing in Android devices due to
/tmp not existing. This change uses tst_tmpir()
to create a temporary directory in $TMPDIR if it
is defined.

Signed-off-by: Hridya Valsaraju <hridya@google.com>
---
Changelog since v1:
-Replace mkstemp() with open() since the directory created by
tst_tmpdir() is unique.

 testcases/kernel/mem/mtest06/mmap1.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 8894b0dbf..80889676d 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -62,6 +62,8 @@
 	usage(prog); \
 } while (0)
 
+#define TEST_FILENAME "ashfile"
+
 static int verbose_print = 0;
 static char *volatile map_address;
 static jmp_buf jmpbuf;
@@ -109,13 +111,14 @@ static void sig_handler_mapped(int signal, siginfo_t * info, void *ut)
 
 int mkfile(int size)
 {
-	char template[] = "/tmp/ashfileXXXXXX";
 	int fd, i;
 
-	if ((fd = mkstemp(template)) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "mkstemp() failed");
+	fd = open(TEST_FILENAME,  O_RDWR | O_CREAT, 0600);
+	if (fd < 0)
+		tst_brkm(TBROK | TERRNO, NULL, "open for %s failed",
+			 TEST_FILENAME);
 
-	unlink(template);
+	unlink(TEST_FILENAME);
 
 	for (i = 0; i < size; i++)
 		if (write(fd, "a", 1) == -1)
@@ -375,6 +378,8 @@ int main(int argc, char **argv)
 		}
 	}
 
+	tst_tmpdir();
+
 	for (;;) {
 		if ((fd = mkfile(file_size)) == -1)
 			tst_brkm(TBROK, NULL,
@@ -416,5 +421,7 @@ int main(int argc, char **argv)
 		close(fd);
 	}
 
+	tst_rmdir();
+
 	exit(0);
 }
-- 
2.16.2.395.g2e18187dfd-goog

