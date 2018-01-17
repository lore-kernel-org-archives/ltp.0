From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Jan 2018 15:56:40 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/2] fcntl36: Do not pass char* pointer to
	tst_res() fmt
Message-ID: <20180117145641.21103-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The format string has to be constant, passing pointers directly is a bad
practice that may result in security exploit and some build systems even
do not produce packages if such warning is found in the compiler logs.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fcntl/fcntl36.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
index 6f2eb6b34..3246d1389 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl36.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -300,7 +300,7 @@ static void test_fn(void *f0(void *), void *f1(void *),
 	struct param p2[thread_cnt];
 	unsigned char buf[write_size];
 
-	tst_res(TINFO, msg);
+	tst_res(TINFO, "%s", msg);
 
 	if (tst_fill_file(fname, 1, write_size, thread_cnt + 1))
 		tst_brk(TBROK, "Failed to create tst file");
-- 
2.13.6

