From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  8 Jan 2016 08:11:51 +0000
Subject: [LTP] [PATCH 31/31] vma03: fix page size offset as per page size
	alignment
In-Reply-To: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
References: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452240711-51180-31-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

the offset the param of mmap2() doesn't align the page size, but,
this param allow must be a multiple of the page size as returned
by sysconf(_SC_PAGE_SIZE).meanwhile offset * 4096 must be a
multiple of the system page size, so modify the input param of offset
pgoff = (ULONG_MAX - 1)&(~((pgsz-1)>>12));

Signed-off-by: Chuang Dong <Chuang.Dong@windriver.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/mem/vma/vma03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index ad8a7b4..a539233 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -85,7 +85,7 @@ int main(int argc, char *argv[])
 		if (fd == -1)
 			tst_brkm(TBROK | TERRNO, NULL, "open %s", TESTFILE);
 
-		pgoff = ULONG_MAX - 1;
+		pgoff = (ULONG_MAX - 1)&(~((pgsz-1)>>12));
 		map = mmap2(NULL, pgsz, PROT_READ | PROT_WRITE, MAP_PRIVATE,
 			    fd, pgoff);
 		if (map == MAP_FAILED)
-- 
2.7.0

