From: Li Wang <liwang@redhat.com>
Date: Tue, 26 May 2020 15:09:01 +0800
Subject: [LTP] [PATCH] lib: use TCONF if hpage reserve failed in retry
Message-ID: <20200526070901.12957-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test still easy to get fail in?hpages?reserving (only 80% of
max_hpages) because of memory fragmentation.
 ?
  tst_hugepage.c:46: BROK: nr_hugepages = 171, but expect 255
? ?
But it seems unkind and useless to exit with TBROK when failed
in hpage reserve retrying. This patch proposes to use TCONF for
better log review.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_hugepage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index 52667a14e..f2bf5d20e 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -43,7 +43,9 @@ unsigned long tst_request_hugepages(unsigned long hpages)
 	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", tst_hugepages);
 	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
 	if (val != tst_hugepages)
-		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, tst_hugepages);
+		tst_brk(TCONF, "nr_hugepages = %lu, but expect %lu. "
+				"Not enough hugepages for testing.",
+				val, tst_hugepages);
 
 	tst_res(TINFO, "%lu hugepage(s) reserved", tst_hugepages);
 out:
-- 
2.21.1

