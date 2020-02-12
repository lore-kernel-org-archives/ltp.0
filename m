From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 12 Feb 2020 18:07:31 +0800
Subject: [LTP] [PATCH v3] aio02: Drop O_DIRECT flag for tmpfs
In-Reply-To: <5E43C9A1.8090807@cn.fujitsu.com>
References: <5E43C9A1.8090807@cn.fujitsu.com>
Message-ID: <1581502051-17240-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tmpfs doesn't support O_DIRECT flag, drop it. So user still can run aio02
with different filesystem by mounting specified filesystem on $TMPDIR.

Also remove unused static value initialization.

Reviewed-by: Xiao Yang <ice_yangxiao@163.com>
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/io/aio/aio02.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/io/aio/aio02.c b/testcases/kernel/io/aio/aio02.c
index e283afba9..6dec073a2 100644
--- a/testcases/kernel/io/aio/aio02.c
+++ b/testcases/kernel/io/aio/aio02.c
@@ -18,7 +18,7 @@
 #define AIO_MAXIO 32
 #define AIO_BLKSIZE (64*1024)
 
-static int wait_count = 0;
+static int wait_count;
 
 #define DESC_FLAGS_OPR(x, y) .desc = (x == IO_CMD_PWRITE ? "WRITE: " #y: "READ : " #y), \
 	.flags = y, .operation = x
@@ -206,6 +206,11 @@ static void test_io(unsigned int n)
 	int status;
 	struct testcase *tc = testcases + n;
 
+	if ((tst_fs_type(".") == TST_TMPFS_MAGIC) && (tc->flags & O_DIRECT)) {
+		tst_res(TINFO, "Drop O_DIRECT flag for tmpfs");
+		tc->flags &= ~O_DIRECT;
+	}
+
 	status = io_tio("file", tc->flags, tc->operation);
 	if (status)
 		tst_res(TFAIL, "%s, status = %d", tc->desc, status);
-- 
2.18.0



