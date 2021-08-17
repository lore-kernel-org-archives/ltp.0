From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Aug 2021 18:46:25 +0800
Subject: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
Message-ID: <20210817104625.2559362-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The last write(fd, buf, 10) in the test is used to detect whether
'FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE' deallocating file space
success or not.

But it is not to be a reliable way on returning ENOSPEC if the defallocated
space is too small(only 4 blocks, x86_64). That's because filesystem metadata
might be extending to occupy that space during punch a hole.

Better to increase the size of fallocate/defallocate to reduce interference
from metadata changing.

    33	tst_test.c:1410: TINFO: Testing on ext4
    34	tst_test.c:914: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
    35	mke2fs 1.45.6 (20-Mar-2020)
    36	tst_test.c:1342: TINFO: Timeout per run is 0h 05m 00s
    37	tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
        ...
    46	tst_fill_fs.c:32: TINFO: Creating file mntpoint/file9 size 36207821
    47	tst_fill_fs.c:32: TINFO: Creating file mntpoint/file10 size 81483962
    48	tst_fill_fs.c:59: TINFO: write(): ENOSPC (28)
    49	fallocate05.c:81: TPASS: write() wrote 65536 bytes
    50	fallocate05.c:102: TINFO: fallocate()d 0 extra blocks on full FS
    51	fallocate05.c:114: TPASS: fallocate() on full FS
    52	fallocate05.c:130: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
    53	fallocate05.c:134: TFAIL: write(): ENOSPC (28)

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/fallocate/fallocate05.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index 55ec1aee4..74bfa4861 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -26,8 +26,8 @@
 #include "lapi/fallocate.h"
 
 #define MNTPOINT "mntpoint"
-#define FALLOCATE_BLOCKS 16
-#define DEALLOCATE_BLOCKS 4
+#define FALLOCATE_BLOCKS 256
+#define DEALLOCATE_BLOCKS 64
 #define TESTED_FLAGS "fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)"
 
 static char *buf;
-- 
2.31.1

