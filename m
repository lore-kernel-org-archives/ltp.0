From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 25 Mar 2021 17:01:18 +0800
Subject: [LTP] [PATCH] syscalls/capset: modify incorrect use of TTERRNO for
 capset/capset01.c
Message-ID: <20210325090118.143355-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use TEST() to check the return value of the tst_syscall.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/capset/capset01.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/capset/capset01.c b/testcases/kernel/syscalls/capset/capset01.c
index 6b064517a..a323fc5be 100644
--- a/testcases/kernel/syscalls/capset/capset01.c
+++ b/testcases/kernel/syscalls/capset/capset01.c
@@ -32,10 +32,9 @@ static void verify_capset(unsigned int n)
 	header->version = tc->version;
 	header->pid = pid;

-	if (tst_syscall(__NR_capget, header, data) == -1) {
-		tst_res(TFAIL | TTERRNO, "capget() failed");
-		return;
-	}
+	TEST(tst_syscall(__NR_capget, header, data));
+	if (TST_RET == -1)
+	      tst_brk(TFAIL | TTERRNO, "capget() failed");

 	TST_EXP_PASS(tst_syscall(__NR_capset, header, data),
 	             "capset() with %s", tc->message);
--
2.17.1

