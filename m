From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 30 Sep 2020 15:50:07 +0100
Subject: [LTP] [PATCH 1/3] io_setup01: Handle no AIO support in kernel
Message-ID: <20200930145009.16260-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

Here are 3 more tests modified to check for ENOSYS. There are other
tests which still don't check, but they appear to be only listed under
the AIO runtest files.

 testcases/kernel/syscalls/io_setup/io_setup01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/io_setup/io_setup01.c b/testcases/kernel/syscalls/io_setup/io_setup01.c
index 4693f8fbb..28aee7831 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup01.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup01.c
@@ -53,6 +53,8 @@ static void verify_success(unsigned int nr, io_context_t *ctx, int init_val)
 	memset(ctx, init_val, sizeof(*ctx));
 
 	TEST(io_setup(nr, ctx));
+	if (TST_RET == -ENOSYS)
+		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
 	if (TST_RET != 0) {
 		tst_res(TFAIL, "io_setup() failed unexpectedly with %li (%s)",
 			TST_RET, tst_strerrno(-TST_RET));
-- 
2.28.0

