From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Sep 2020 09:35:01 +0200
Subject: [LTP] [PATCH 1/1] io_destroy01: TCONF when unsupported
Message-ID: <20200929073501.4598-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to fix test on kernel built without CONFIG_AIO=y.

Cleanup: use return instead of else, join string.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

simple patch, but can wait after release.
I can move cleanup into separate commit.

Kind regards,
Petr

 testcases/kernel/syscalls/io_destroy/io_destroy01.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/io_destroy/io_destroy01.c b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
index 560d7b3fb..5c5c59335 100644
--- a/testcases/kernel/syscalls/io_destroy/io_destroy01.c
+++ b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
@@ -32,14 +32,19 @@ static void verify_io_destroy(void)
 		return;
 	}
 
+	if (TST_RET == -ENOSYS) {
+		tst_res(TCONF, "io_destroy() not supported");
+		return;
+	}
+
 	if (TST_RET == -EINVAL) {
 		tst_res(TPASS,
 			"io_destroy() failed as expected, returned -EINVAL");
-	} else {
-		tst_res(TFAIL, "io_destroy() failed unexpectedly, "
-			"returned -%s expected -EINVAL",
-			tst_strerrno(-TST_RET));
+		return;
 	}
+
+	tst_res(TFAIL, "io_destroy() failed unexpectedly, returned -%s expected -EINVAL",
+		tst_strerrno(-TST_RET));
 }
 
 static struct tst_test test = {
-- 
2.28.0

