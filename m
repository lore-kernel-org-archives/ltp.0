From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 27 Jun 2018 15:38:09 +0000
Subject: [LTP] [PATCH] syscalls/fallocate05: minor fix for
	Werror=format-security
Message-ID: <20180627153809.1196-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

In order to avoid compilation issues in tst_XXX functions:

gcc -g -O0 -fdebug-prefix-map=. -fstack-protector-strong -Wformat
-Werror=format-security-g -O2 -fno-strict-aliasing -pipe -Wall -W
-Wold-style-definition -Wdate-time -I../../../../include
-I../../../../include -I../../../../include/old/ -Wl,-z,relro
-L../../../../lib  fallocate05.c -lltp -o fallocate05
fallocate05.c: In function ‘run’:

fallocate05.c:76:4: error: format not a string literal and
	no format arguments [-Werror=format-security]
    tst_brk(TCONF, tested_flags);
    ^~~~~~~
fallocate05.c:78:3: error: format not a string literal and
	no format arguments [-Werror=format-security]
   tst_brk(TBROK | TERRNO, tested_flags);
   ^~~~~~~
fallocate05.c:80:2: error: format not a string literal and
	no format arguments [-Werror=format-security]
  tst_res(TPASS, tested_flags);

when using format-security, change "const char *" to a
pre-defined string.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 testcases/kernel/syscalls/fallocate/fallocate05.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index d2d84433b..49dc44b04 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -30,6 +30,7 @@
 
 #define MNTPOINT "mntpoint"
 #define FALLOCATE_SIZE 8192
+#define TESTED_FLAGS "fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)"
 
 static int fd;
 
@@ -37,7 +38,6 @@ static void run(void)
 {
 	char buf[FALLOCATE_SIZE];
 	ssize_t ret;
-	const char *tested_flags="fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)";
 
 	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT);
 
@@ -73,11 +73,11 @@ static void run(void)
 	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, FALLOCATE_SIZE);
 	if (ret == -1) {
 		if (errno == EOPNOTSUPP)
-			tst_brk(TCONF, tested_flags);
+			tst_brk(TCONF, TESTED_FLAGS);
 
-		tst_brk(TBROK | TERRNO, tested_flags);
+		tst_brk(TBROK | TERRNO, TESTED_FLAGS);
 	}
-	tst_res(TPASS, tested_flags);
+	tst_res(TPASS, TESTED_FLAGS);
 
 	ret = write(fd, buf, 10);
 	if (ret == -1)
-- 
2.18.0

