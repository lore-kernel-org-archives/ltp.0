From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 29 Apr 2021 22:22:32 +0800
Subject: [LTP] [PATCH] lib/tst_checkpoint.c: Replace SAFE_CLOSE with
 SAFE_UNLINK
Message-ID: <20210429142232.29596-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When we call tst_checkpoint_init and set the cleanup_fn to NULL, the file
checkpoint_futex_base_file might be left over.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 lib/tst_checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 9e9dcf9e6..3360ab07b 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -78,7 +78,7 @@ void tst_checkpoint_init(const char *file, const int lineno,

 	tst_max_futexes = page_size / sizeof(uint32_t);

-	SAFE_CLOSE(cleanup_fn, fd);
+	SAFE_UNLINK(cleanup_fn, "checkpoint_futex_base_file");
 }

 int tst_checkpoint_wait(unsigned int id, unsigned int msec_timeout)
--
2.17.1

