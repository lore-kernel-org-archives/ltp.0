From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 29 Sep 2020 15:50:41 +0100
Subject: [LTP] [PATCH] io_submit01: Handle missing AIO support
Message-ID: <20200929145041.29948-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/io_submit/io_submit01.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index afa077c59..bbbbc9101 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -66,11 +66,11 @@ static struct tcase {
 
 static void setup(void)
 {
-	int rval;
-
-	rval = io_setup(1, &ctx);
-	if (rval)
-		tst_brk(TBROK | TERRNO, "io_setup() returned %d", rval);
+	TEST(io_setup(1, &ctx));
+	if (TST_RET == -ENOSYS)
+		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
+	else if (TST_RET)
+		tst_brk(TBROK | TRERRNO, "io_setup() failed");
 
 	io_prep_pread(&inv_fd_iocb, -1, buf, sizeof(buf), 0);
 
-- 
2.28.0

