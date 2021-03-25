From: Li Wang <liwang@redhat.com>
Date: Thu, 25 Mar 2021 17:43:27 +0800
Subject: [LTP] [COMMITTED PATCH] brk02: to print errno if test fail
Message-ID: <20210325094327.332904-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/brk/brk02.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/brk/brk02.c b/testcases/kernel/syscalls/brk/brk02.c
index cd4cfd1be..4a272bac3 100644
--- a/testcases/kernel/syscalls/brk/brk02.c
+++ b/testcases/kernel/syscalls/brk/brk02.c
@@ -26,30 +26,30 @@ void brk_down_vmas(void)
 	void *addr = brk_addr + page_size;
 
 	if (brk(addr)) {
-		tst_res(TFAIL, "Cannot expand brk() by page size");
+		tst_res(TFAIL | TERRNO, "Cannot expand brk() by page size");
 		return;
 	}
 
 	addr += page_size;
 	if (brk(addr)) {
-		tst_res(TFAIL, "Cannot expand brk() by 2x page size");
+		tst_res(TFAIL | TERRNO, "Cannot expand brk() by 2x page size");
 		return;
 	}
 
 	if (mprotect(addr - page_size, page_size,
 		     PROT_READ|PROT_WRITE|PROT_EXEC)) {
-		tst_res(TFAIL, "Cannot mprotect new VMA");
+		tst_res(TFAIL | TERRNO, "Cannot mprotect new VMA");
 		return;
 	}
 
 	addr += page_size;
 	if (brk(addr)) {
-		tst_res(TFAIL, "Cannot expand brk() after mprotect");
+		tst_res(TFAIL | TERRNO, "Cannot expand brk() after mprotect");
 		return;
 	}
 
 	if (brk(brk_addr)) {
-		tst_res(TFAIL, "Cannot restore brk() to start address");
+		tst_res(TFAIL | TERRNO, "Cannot restore brk() to start address");
 		return;
 	}
 
-- 
2.30.2

