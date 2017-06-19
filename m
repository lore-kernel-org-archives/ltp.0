From: naresh.kamboju@linaro.org <naresh.kamboju@linaro.org>
Date: Mon, 19 Jun 2017 19:01:21 +0530
Subject: [LTP] [PATCH] faccessat and fchmodat: Fix build warnings
Message-ID: <1497879081-10456-1-git-send-email-naresh.kamboju@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

From: Naresh Kamboju <naresh.kamboju@linaro.org>

Fixing below build warnings.

ltp-full-20170516/testcases/kernel/syscalls/faccessat$ make
In file included from ../../../../include/old/test.h:51:0,
                 from faccessat01.c:44:
faccessat01.c: In function ‘setup’:
../../../../include/old/old_safe_file_ops.h:55:27:
warning: format not a string literal and no format arguments [-Wformat-security]
                   (path), (fmt), ## __VA_ARGS__)
                           ^
faccessat01.c:132:2: note: in expansion of macro ‘SAFE_FILE_PRINTF’
  SAFE_FILE_PRINTF(cleanup, testfile, testfile);
  ^
../../../../include/old/old_safe_file_ops.h:55:27:
warning: format not a string literal and no format arguments [-Wformat-security]
                   (path), (fmt), ## __VA_ARGS__)
                           ^
faccessat01.c:133:2: note: in expansion of macro ‘SAFE_FILE_PRINTF’
  SAFE_FILE_PRINTF(cleanup, testfile2, testfile2);

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 testcases/kernel/syscalls/faccessat/faccessat01.c | 4 ++--
 testcases/kernel/syscalls/fchmodat/fchmodat01.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
index 622dfd3..def7fa7 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat01.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
@@ -129,8 +129,8 @@ void setup(void)
 	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
 	fds[1] = fds[4] = fds[0];
 
-	SAFE_FILE_PRINTF(cleanup, testfile, testfile);
-	SAFE_FILE_PRINTF(cleanup, testfile2, testfile2);
+	SAFE_FILE_PRINTF(cleanup, testfile, "%s", testfile);
+	SAFE_FILE_PRINTF(cleanup, testfile2, "%s", testfile2);
 
 	fds[2] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
 
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 6bf66d8..7856ed3 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -127,8 +127,8 @@ void setup(void)
 	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
 	fds[1] = fds[4] = fds[0];
 
-	SAFE_FILE_PRINTF(cleanup, testfile, testfile);
-	SAFE_FILE_PRINTF(cleanup, testfile2, testfile2);
+	SAFE_FILE_PRINTF(cleanup, testfile, "%s", testfile);
+	SAFE_FILE_PRINTF(cleanup, testfile2, "%s", testfile2);
 
 	fds[2] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
 	fds[3] = 100;
-- 
2.7.4

