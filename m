From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  4 Apr 2019 12:19:51 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/fstat05: Fix failures
Message-ID: <20190404101951.4032-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Quoting Wei Li:

"
On my machine running linux-4.19.23, the fstat05 test case went failed:
[root@localhost ltp_20180926_src]# ./testcases/kernel/syscalls/fstat/fstat05
fstat05     1  TFAIL  :  fstat05.c:168: fstat() returned 0 but we wanted -1

Finally i found that, the end of head was expanded after invoking setup(), more
than 4 * getpagesize(), then ptr_str is not a point outside user's accessible
address space any more.
"

This fixes the test by using the tst_get_bad_addr() instead of sbrk() + delta.

Reported-by: Wei Li <liwei391@huawei.com>
CC: Wei Li <liwei391@huawei.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fstat/fstat05.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fstat/fstat05.c b/testcases/kernel/syscalls/fstat/fstat05.c
index 8de5d070a..200de4130 100644
--- a/testcases/kernel/syscalls/fstat/fstat05.c
+++ b/testcases/kernel/syscalls/fstat/fstat05.c
@@ -129,16 +129,11 @@ int SIG_SEEN = sizeof(siglist) / sizeof(int);
 
 int main(int ac, char **av)
 {
-	struct stat stat_buf;	/* stat structure buffer */
-	struct stat *ptr_str;
+	struct stat *ptr_str = tst_get_bad_addr(NULL);
 	int lc;
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
-	/* Buffer points outside user's accessible address space. */
-	ptr_str = &stat_buf;	/* if it was for conformance testing */
-	ptr_str = (void *)sbrk(0) + (4 * getpagesize());
-
 	/*
 	 * Invoke setup function
 	 */
-- 
2.19.2

