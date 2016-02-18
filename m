From: Eryu Guan <eguan@redhat.com>
Date: Thu, 18 Feb 2016 22:12:15 +0800
Subject: [LTP] [PATCH v2] syscalls/renameat202: improve renameat2_verify()
In-Reply-To: <1455713810-21842-1-git-send-email-eguan@redhat.com>
References: <1455713810-21842-1-git-send-email-eguan@redhat.com>
Message-ID: <1455804735-20998-1-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In renameat2_verify(), str is allocated on stack with size 8 (sizeof
content) and filled with random data. Then file content (7 bytes) is
read into str and the last byte in str is left unchanged with garbage,
and test fails if that last byte is not zero.

Another problem is, as Cyril Hrubis pointed out, the str buffer is too
small, so there's chance to overrun the str buffer, as read(2) is
reading strlen(content) + 10 bytes.

Fix them by extending str buffer size and initializing str with zeros.
Also improved the checking logic, do strncmp only if expected number of
bytes is read from file. And improved the failure messages too.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---

v2:
- update commit summary and log
- enlarge str buffer to BUFSIZ
- check return value of read(2) and do other checks only if the value is correct
- return early on failure
- merge two tst_resm into one on failure

 testcases/kernel/syscalls/renameat2/renameat202.c | 28 +++++++++++++++--------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
index 3761391..491a310 100644
--- a/testcases/kernel/syscalls/renameat2/renameat202.c
+++ b/testcases/kernel/syscalls/renameat2/renameat202.c
@@ -118,10 +118,11 @@ static void cleanup(void)
 
 static void renameat2_verify(void)
 {
-	char str[sizeof(content)];
+	char str[BUFSIZ] = { 0 };
 	struct stat st;
 	char *emptyfile;
 	char *contentfile;
+	int readn, data_len;
 
 	if (TEST_ERRNO == EINVAL && TST_BTRFS_MAGIC == fs_type) {
 		tst_brkm(TCONF, cleanup,
@@ -146,17 +147,26 @@ static void renameat2_verify(void)
 
 	SAFE_STAT(cleanup, emptyfile, &st);
 
-	SAFE_READ(cleanup, 0, fd, str, strlen(content) + 10);
+	readn = SAFE_READ(cleanup, 0, fd, str, BUFSIZ);
 
 	if (close(fd) < 0)
 		tst_brkm(TERRNO | TFAIL, cleanup, "close fd failed");
 	fd = 0;
 
-	if (str[strlen(content)] == '\0' && !strcmp(content, str)
-		&& !st.st_size)
-		tst_resm(TPASS,
-			"renameat2() swapped the content of the two files");
-	else
-		tst_resm(TFAIL,
-			"renameat2() didn't swap the content of the two files");
+	data_len = strlen(content);
+	if (readn != data_len) {
+		tst_resm(TFAIL, "Wrong number of bytes read after renameat2(). "
+				"Expect %d, got %d", data_len, readn);
+		return;
+	}
+	if (strncmp(content, str, data_len)) {
+		tst_resm(TFAIL, "File content changed after renameat2(). "
+				"Expect \"%s\", got \"%s\"", content, str);
+		return;
+	}
+	if (st.st_size) {
+		tst_resm(TFAIL, "emptyfile has non-zero file size");
+		return;
+	}
+	tst_resm(TPASS, "renameat2() test passed");
 }
-- 
2.5.0

