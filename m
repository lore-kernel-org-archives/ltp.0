From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Nov 2020 14:14:25 +0100
Subject: [LTP] [PATCH 07/10] syscalls/cacheflush: Make use of TEST_MACROS
In-Reply-To: <20201113131428.13199-1-chrubis@suse.cz>
References: <20201113131428.13199-1-chrubis@suse.cz>
Message-ID: <20201113131428.13199-8-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/cacheflush/cacheflush01.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/cacheflush/cacheflush01.c b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
index 6ad8b953a..d53fcdcd0 100644
--- a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
+++ b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
@@ -45,12 +45,8 @@ static void test_cacheflush(unsigned int i)
 {
 	struct test_case_t *tc = &test_cases[i];
 
-	TEST(tst_syscall(__NR_cacheflush, addr, getpagesize(), tc->cache));
-	if (TST_RET == 0) {
-		tst_res(TPASS, "%s passed", tc->desc);
-	} else {
-		tst_res(TFAIL | TTERRNO, "%s failed", tc->desc);
-	}
+	TEST_PASS(tst_syscall(__NR_cacheflush, addr, getpagesize(), tc->cache),
+	          "%s", tc->desc);
 }
 
 static struct tst_test test = {
-- 
2.26.2

