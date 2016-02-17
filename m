From: Eryu Guan <eguan@redhat.com>
Date: Wed, 17 Feb 2016 20:56:50 +0800
Subject: [LTP] [PATCH] syscalls/renameat202: initialize str with zero
Message-ID: <1455713810-21842-1-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In renameat2_verify(), str is allocated on stack with size 8 (sizeof
content) and filled with random data. Then file content (7 bytes) is
read into str and the last byte in str is left unchanged with garbage,
and test fails if that last byte is not zero.

Fix it by initializing the str with zeros, make sure str is null
terminated as long as correct data has been read in.

Also remove the "str[strlen(content)] == '\0'" check, which is not
necessary, because strcmp will catch the failure anyway.

Also improve the failure message to print more useful debug message.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/syscalls/renameat2/renameat202.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
index 3761391..9e2d12e 100644
--- a/testcases/kernel/syscalls/renameat2/renameat202.c
+++ b/testcases/kernel/syscalls/renameat2/renameat202.c
@@ -118,7 +118,7 @@ static void cleanup(void)
 
 static void renameat2_verify(void)
 {
-	char str[sizeof(content)];
+	char str[sizeof(content)] = { 0 };
 	struct stat st;
 	char *emptyfile;
 	char *contentfile;
@@ -152,11 +152,12 @@ static void renameat2_verify(void)
 		tst_brkm(TERRNO | TFAIL, cleanup, "close fd failed");
 	fd = 0;
 
-	if (str[strlen(content)] == '\0' && !strcmp(content, str)
-		&& !st.st_size)
-		tst_resm(TPASS,
-			"renameat2() swapped the content of the two files");
-	else
-		tst_resm(TFAIL,
-			"renameat2() didn't swap the content of the two files");
+	if (strcmp(content, str)) {
+		tst_resm(TFAIL, "file content changed after renameat2()");
+		tst_resm(TFAIL, "expect \"%s\", got \"%s\"", content, str);
+	} else if (st.st_size) {
+		tst_resm(TFAIL, "emptyfile has non-zero file size");
+	} else {
+		tst_resm(TPASS, "renameat2() test passed");
+	}
 }
-- 
2.5.0

