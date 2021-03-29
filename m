From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 29 Mar 2021 21:46:47 +0800
Subject: [LTP] [PATCH] syscalls/shmctl04: Add kernel version requestions
Message-ID: <20210329134647.27740-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

SHM_STAT_ANY is imported to linux in v4.17.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index 9e8ec4199..18ac8ba0a 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -168,6 +168,7 @@ static void cleanup(void)
 }

 static struct tst_test test = {
+	.min_kver = "4.17",
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_shminfo,
--
2.17.1

