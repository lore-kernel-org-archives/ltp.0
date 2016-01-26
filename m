From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Jan 2016 14:35:32 +0800
Subject: [LTP] [PATCH] lib/mem.c: exit from test_transparent_hugepage() if
	shortage of memory
Message-ID: <1453790132-2360-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sometime thp05.c fails like:
---
thp05       0  TINFO  :  Stop all children...
thp05       0  TINFO  :  Start to scan all transparent hugepages...
thp05       0  TINFO  :  khugepaged daemon takes 10s to scan all thp pages
thp05       0  TINFO  :  Start to verify transparent hugepage size...
thp05       1  TFAIL  :  mem.c:754: child[27099] got 43008KB thps - expect 40960KB thps
thp05       2  TFAIL  :  mem.c:754: child[27099] got 43008KB thps - expect 40960KB thps
thp05       3  TFAIL  :  mem.c:754: child[27099] got 43008KB thps - expect 40960KB thps
thp05       4  TFAIL  :  mem.c:754: child[27099] got 43008KB thps - expect 40960KB thps
---

Since the system has done much testing work so far as it comes here, it is very easy to
hit the fails if the memory is fragmented, the following tests should better be skiped
while system dose not have enough memory for THP testing.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index cee4e91..6715c35 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -773,7 +773,7 @@ void test_transparent_hugepage(int nr_children, int nr_thps,
 	memfree = read_meminfo("MemFree:");
 	tst_resm(TINFO, "The current MemFree is %luMB", memfree / KB);
 	if (memfree < MB)
-		tst_resm(TCONF, "Not enough memory for testing");
+		tst_brkm(TCONF, NULL, "Not enough memory for testing");
 
 	hugepagesize = read_meminfo("Hugepagesize:");
 	tst_resm(TINFO, "The current Hugepagesize is %luMB", hugepagesize / KB);
-- 
1.8.3.1

