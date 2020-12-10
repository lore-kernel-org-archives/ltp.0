From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Dec 2020 15:15:41 +0100
Subject: [LTP] [PATCH v2 03/10] syscalls/accept: Make use of TST_EXP_MACROS
In-Reply-To: <20201210141548.10982-1-chrubis@suse.cz>
References: <20201210141548.10982-1-chrubis@suse.cz>
Message-ID: <20201210141548.10982-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/accept/accept01.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index 01d6db84c..8722f2c7f 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -97,21 +97,8 @@ void verify_accept(unsigned int nr)
 {
 	struct test_case *tcase = &tcases[nr];
 
-	TEST(accept(*tcase->fd, tcase->sockaddr, &tcase->salen));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "%s: returned %li, expected -1",
-				tcase->desc, TST_RET);
-		return;
-	}
-
-	if (TST_ERR != tcase->experrno) {
-		tst_res(TFAIL | TTERRNO, "%s: expected errno %s, got ",
-				tcase->desc, tst_strerrno(tcase->experrno));
-		return;
-	}
-
-	tst_res(TPASS | TTERRNO, "%s successful", tcase->desc);
+	TST_EXP_FAIL(accept(*tcase->fd, tcase->sockaddr, &tcase->salen),
+	             tcase->experrno, "%s", tcase->desc);
 }
 
 static struct tst_test test = {
-- 
2.26.2

