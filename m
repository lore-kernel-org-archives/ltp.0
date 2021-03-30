From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Tue, 30 Mar 2021 20:20:41 +0800
Subject: [LTP] [PATCH] syscalls/getdtablesize01: Add abnormal handling
Message-ID: <20210330122041.19700-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When /etc/hosts is not exist, test would fail, actually, we chould skip the
the problem to improve maintainability.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/getdtablesize/getdtablesize01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
index d25cac261..25d10d5fb 100644
--- a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
+++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
@@ -100,6 +100,8 @@ int main(void)
 		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
 	else if (fd < 0 && errno == ENFILE)
 		tst_brkm(TCONF, cleanup, "Reached maximum number of open files for the system");
+	else if (fd == 0)
+		tst_brkm(TCONF, cleanup, "Maybe /etc/hosts is not exist");
 	else
 		tst_resm(TFAIL, "%d != %d", count, (max_val_opfiles - 1));

--
2.17.1

