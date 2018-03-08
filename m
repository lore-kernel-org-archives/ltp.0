From: Hridya Valsaraju <hridya@google.com>
Date: Wed,  7 Mar 2018 16:52:50 -0800
Subject: [LTP] [PATCH] mtest06: Use temp dir from $TMPDIR if present
Message-ID: <20180308005250.210404-1-hridya@google.com>
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
 testcases/kernel/mem/mtest06/mmap1.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 8894b0dbf..8f757d4c9 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -47,6 +47,7 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <sys/time.h>
+#include <sys/param.h>
 #include <sys/wait.h>
 #include <setjmp.h>
 #include <pthread.h>
@@ -109,8 +110,13 @@ static void sig_handler_mapped(int signal, siginfo_t * info, void *ut)
 
 int mkfile(int size)
 {
-	char template[] = "/tmp/ashfileXXXXXX";
 	int fd, i;
+	char template[MAXPATHLEN];
+	char *tmpdir;
+
+	tmpdir = tst_get_tmpdir();
+	snprintf(template, sizeof(template), "%s/ashfileXXXXXX", tmpdir);
+	free(tmpdir);
 
 	if ((fd = mkstemp(template)) == -1)
 		tst_brkm(TBROK | TERRNO, NULL, "mkstemp() failed");
@@ -375,6 +381,8 @@ int main(int argc, char **argv)
 		}
 	}
 
+	tst_tmpdir();
+
 	for (;;) {
 		if ((fd = mkfile(file_size)) == -1)
 			tst_brkm(TBROK, NULL,
@@ -416,5 +424,7 @@ int main(int argc, char **argv)
 		close(fd);
 	}
 
+	tst_rmdir();
+
 	exit(0);
 }
-- 
2.16.2.395.g2e18187dfd-goog

