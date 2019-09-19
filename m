From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Sep 2019 10:58:56 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/fstat03: Fix bad fd
 initialization
Message-ID: <20190919085856.18758-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

passing unused pid as bad fd is wrong and slipped in during a review.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fstat/fstat03.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fstat/fstat03.c b/testcases/kernel/syscalls/fstat/fstat03.c
index acefa2529..68fae43df 100644
--- a/testcases/kernel/syscalls/fstat/fstat03.c
+++ b/testcases/kernel/syscalls/fstat/fstat03.c
@@ -25,7 +25,7 @@
 #define TESTFILE	"test_file"
 
 static int fd_ok;
-static int fd_ebadf;
+static int fd_ebadf = -1;
 static struct stat stat_buf;
 
 static struct tcase {
@@ -83,7 +83,6 @@ static void run(unsigned int tc_num)
 
 static void setup(void)
 {
-	fd_ebadf = tst_get_unused_pid();
 	fd_ok = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
 }
 
-- 
2.21.0

