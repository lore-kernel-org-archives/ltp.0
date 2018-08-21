From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Aug 2018 16:05:46 +0200
Subject: [LTP] [RFC PATCH 1/2] tests: Remove tst_safe_macros.c
In-Reply-To: <20180821140547.2509-1-pvorel@suse.cz>
References: <20180821140547.2509-1-pvorel@suse.cz>
Message-ID: <20180821140547.2509-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It's broken and outdated (doesn't really test safe macros features).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tests/tst_safe_macros.c | 40 -------------------------------------
 1 file changed, 40 deletions(-)
 delete mode 100644 lib/tests/tst_safe_macros.c

diff --git a/lib/tests/tst_safe_macros.c b/lib/tests/tst_safe_macros.c
deleted file mode 100644
index b5809f40d..000000000
--- a/lib/tests/tst_safe_macros.c
+++ /dev/null
@@ -1,40 +0,0 @@
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "test_safe_macros";
-int TST_TOTAL = 1;
-
-int fd = -1;
-
-void cleanup(void)
-{
-	SAFE_CLOSE(NULL, fd);
-	SAFE_UNLINK(NULL, __FILE__ "~");
-	tst_resm(TINFO, "got here");
-}
-
-int main(int argc LTP_ATTRIBUTE_UNUSED, char **argv)
-{
-	char buf[10];
-	int fds[2];
-
-	buf[9] = '\0';
-
-	if (system("cp " __FILE__ " " __FILE__ "~")) {
-		fprintf(stderr, "error: could not cp file\n");
-		return 1;
-	}
-	printf("%s\n", SAFE_BASENAME(NULL, *argv));
-	printf("%s\n", SAFE_DIRNAME(NULL, *argv));
-	fd = SAFE_OPEN(cleanup, __FILE__ "~", O_RDWR);
-	SAFE_READ(cleanup, 0, fd, buf, 9);
-	printf("buf: %s\n", buf);
-	SAFE_READ(cleanup, 1, fd, buf, 9);
-	printf("buf: %s\n", buf);
-	SAFE_WRITE(cleanup, 0, -1, buf, 9);
-	SAFE_WRITE(NULL, 0, fd, buf, 9);
-	SAFE_WRITE(NULL, 1, fd, buf, 9);
-	SAFE_PIPE(NULL, fds);
-
-	return 0;
-}
-- 
2.18.0

