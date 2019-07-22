From: Steve Muckle <smuckle@google.com>
Date: Mon, 22 Jul 2019 12:44:39 -0700
Subject: [LTP] [PATCH] syscalls/statx01: loosen the stx_blocks check
Message-ID: <20190722194439.161904-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A filesystem may preallocate blocks (ext4 does this), so even though the
contents of the file may fit into a single block, statx may report more
than one block. Loosen the test to accommodate this.

Signed-off-by: Steve Muckle <smuckle@google.com>
---
 testcases/kernel/syscalls/statx/statx01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 23ea99b4a..5e705dc7d 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -92,7 +92,7 @@ static void test_normal_file(void)
 			buff.stx_mode, MODE);
 
 
-	if (buff.stx_blocks <= buff.stx_blksize/512)
+	if (buff.stx_blocks <= 128)
 		tst_res(TPASS, "stx_blocks(%"PRIu64") is valid",
 			buff.stx_blocks);
 	else
-- 
2.22.0.657.g960e92d24f-goog

