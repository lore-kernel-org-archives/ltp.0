From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Apr 2018 21:55:03 +0200
Subject: [LTP] [RFC PATCH v3 10/10] ima/ima_mmap: Rewrite to new library
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Message-ID: <20180419195503.7194-11-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Filename passed as getopt parameter.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/src/ima_mmap.c   | 75 +++++++++++-----------
 .../security/integrity/ima/tests/ima_violations.sh |  2 +-
 2 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
index 9045e79a0..5bc688bd4 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
@@ -14,48 +14,49 @@
  * Open and mmap a file and sleep. Another process will open the
  * mmapped file in read mode, resulting in a open_writer violation.
  */
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <fcntl.h>
-#include "test.h"
 
-char *TCID = "ima_mmap";
-int TST_TOTAL = 1;
+#include "tst_test.h"
 
 #define SLEEP_AFTER_CLOSE 3
+#define MMAPSIZE 1024
 
-int main(int argc, char *argv[])
+static char *filename;
+static void *file;
+static int fd;
+
+static struct tst_option options[] = {
+	{"f:", &filename,
+	 "-f file  File to mmap"},
+	{NULL, NULL, NULL}
+};
+
+static void cleanup(void)
+{
+	if (file)
+		SAFE_MUNMAP(file, MMAPSIZE);
+
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static void run(void)
 {
-	int fd;
-	void *file;
-	char *filename;
-
-	if (argc != 2)
-		printf("%s: filename\n", argv[1]);
-	filename = argv[1];
-
-	fd = open(filename, O_CREAT | O_RDWR, S_IRWXU);
-	if (fd < 0) {
-		perror("open");
-		return (-1);
-	}
-
-	file = mmap(NULL, 1024, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	if (file == (void *)-1) {
-		perror("mmap");
-		return (-1);
-	}
-	close(fd);
-
-	tst_resm(TINFO, "sleep %ds", SLEEP_AFTER_CLOSE);
+	if (!filename)
+		tst_brk(TBROK, "Usage: %s -f filename", TCID);
+
+	fd = SAFE_OPEN(filename, O_CREAT | O_RDWR, S_IRWXU);
+
+	file = SAFE_MMAP(NULL, MMAPSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	SAFE_CLOSE(fd);
+
+	tst_res(TINFO, "sleep %ds", SLEEP_AFTER_CLOSE);
 	sleep(SLEEP_AFTER_CLOSE);
 
-	if (munmap(file, 1024) < 0) {
-		perror("unmap");
-		return (-1);
-	}
-	tst_exit();
+	tst_res(TPASS, "test completed");
 }
+
+static struct tst_test test = {
+	.options = options,
+	.test_all = run,
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 8742f4593..f3f40d455 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -142,7 +142,7 @@ test3()
 
 	echo 'testing testing' > $FILE
 
-	ima_mmap $FILE &
+	ima_mmap -f $FILE &
 	# wait for violations appear in logs
 	tst_sleep 1s
 
-- 
2.16.3

