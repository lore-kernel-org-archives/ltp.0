From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 26 Oct 2020 13:48:35 +0800
Subject: [LTP] [PATCH 3/4] syscalls/sync03: Remove useless judgement
In-Reply-To: <1603691317-22811-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1603691317-22811-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1603691317-22811-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The TEST_VOID was defined as below in include/tst_test.h
define TEST_VOID(SCALL) \
        do { \
                errno = 0; \
                SCALL; \
                TST_ERR = errno; \
        } while (0)

It doesn't assign the value fot TST_RET like TEST macro. So
remove the useless judgement and use sync instead because
sync() is always successful.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
1.I plan to remove TEST_VOID macro because only sync cases use it.
Also, I don't see any syscall doesn't have return value and still has
error describe(If having, please let me know).
 testcases/kernel/syscalls/sync/sync03.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/sync/sync03.c b/testcases/kernel/syscalls/sync/sync03.c
index c5c02f877..dc093d863 100644
--- a/testcases/kernel/syscalls/sync/sync03.c
+++ b/testcases/kernel/syscalls/sync/sync03.c
@@ -37,10 +37,7 @@ static void verify_sync(void)
 
 	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
 
-	TEST_VOID(sync());
-
-	if (TST_RET)
-		tst_brk(TFAIL | TTERRNO, "sync() failed");
+	sync();
 
 	written = tst_dev_bytes_written(tst_device->dev);
 
-- 
2.23.0



