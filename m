From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 23 Jul 2021 13:19:44 +0800
Subject: [LTP] [PATCH 2/2] syscalls/shmget02: Use TST_NO_HUGEPAGES instead
 of 0
In-Reply-To: <1627017584-30405-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1627017584-30405-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <1627017584-30405-2-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmget/shmget02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 7fcd376f5..66a4b94ee 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -110,5 +110,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcases),
-	.request_hugepages = 0,
+	.request_hugepages = TST_NO_HUGEPAGES,
 };
-- 
2.23.0

