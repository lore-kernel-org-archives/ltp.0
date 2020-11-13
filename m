From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Nov 2020 14:14:24 +0100
Subject: [LTP] [PATCH 06/10] syscalls/brk01: Make use of TEST_MACROS
In-Reply-To: <20201113131428.13199-1-chrubis@suse.cz>
References: <20201113131428.13199-1-chrubis@suse.cz>
Message-ID: <20201113131428.13199-7-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/brk/brk01.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
index c50791d40..9e38c9abd 100644
--- a/testcases/kernel/syscalls/brk/brk01.c
+++ b/testcases/kernel/syscalls/brk/brk01.c
@@ -31,12 +31,7 @@ void verify_brk(void)
 		break;
 		}
 
-		TEST(brk((void *)new_brk));
-
-		if (TST_RET == -1) {
-			tst_res(TFAIL | TERRNO, "brk() failed");
-			return;
-		}
+		TEST_PASS(brk((void *)new_brk), "brk()");
 
 		cur_brk = (uintptr_t)sbrk(0);
 
@@ -51,8 +46,6 @@ void verify_brk(void)
 		if (i % 3 == 0)
 			*((char *)cur_brk) = 0;
 	}
-
-	tst_res(TPASS, "brk() works fine");
 }
 
 static struct tst_test test = {
-- 
2.26.2

