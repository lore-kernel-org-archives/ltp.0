From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Sat, 27 Mar 2021 18:23:44 +0800
Subject: [LTP] [PATCH] syscalls/shmctl: Using TERRNO to macth errno
Message-ID: <20210327102344.1620-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When "shmid == -1", we need print the errno with TERRNO. It must have no error in
TEST, otherwise it has return early.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index c70a76fb2..9e8ec4199 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -130,7 +130,7 @@ static void verify_shminfo(unsigned int n)
 	shmid = shmctl(TST_RET, SHM_STAT_ANY, &ds);

 	if (shmid == -1) {
-		tst_res(TFAIL | TTERRNO, "SHM_INFO haven't returned a valid index");
+		tst_res(TFAIL | TERRNO, "SHM_INFO haven't returned a valid index");
 	} else {
 		tst_res(TPASS,
 			"SHM_INFO returned valid index %li maps to shmid %i",
--
2.17.1

