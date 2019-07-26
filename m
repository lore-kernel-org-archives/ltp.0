From: Steve Muckle <smuckle@google.com>
Date: Thu, 25 Jul 2019 17:07:27 -0700
Subject: [LTP] [PATCH v2] syscalls/statx01: loosen the stx_blocks check
Message-ID: <20190726000727.16842-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Extended attributes may cause an extra block to be allocated for a file.
Loosen the test to accommodate this.

Signed-off-by: Steve Muckle <smuckle@google.com>
---
 testcases/kernel/syscalls/statx/statx01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 23ea99b4a..c3ba94394 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -92,7 +92,7 @@ static void test_normal_file(void)
 			buff.stx_mode, MODE);
 
 
-	if (buff.stx_blocks <= buff.stx_blksize/512)
+	if (buff.stx_blocks <= buff.stx_blksize/512 * 2)
 		tst_res(TPASS, "stx_blocks(%"PRIu64") is valid",
 			buff.stx_blocks);
 	else
-- 
2.22.0.709.g102302147b-goog

