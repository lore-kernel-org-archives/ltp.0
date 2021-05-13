From: Konstantin Aladyshev <aladyshev22@gmail.com>
Date: Thu, 13 May 2021 15:23:44 +0300
Subject: [LTP] [PATCH] syscalls/clock_gettime: Fix typo
Message-ID: <20210513122344.1432-1-aladyshev22@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 testcases/kernel/syscalls/clock_gettime/clock_gettime02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
index b0a9e9067..1159dbd13 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
@@ -120,7 +120,7 @@ static void verify_clock_gettime(unsigned int i)
 	TEST(tv->clock_gettime(tc[i].clktype, ts));
 
 	if (TST_RET != -1) {
-		tst_res(TFAIL, "clock_gettime(2): clock %s passed unexcpectedly",
+		tst_res(TFAIL, "clock_gettime(2): clock %s passed unexpectedly",
 			tst_clock_name(tc[i].clktype));
 		return;
 	}
-- 
2.25.1

