From: Martin Doucha <mdoucha@suse.cz>
Date: Thu,  1 Apr 2021 12:56:17 +0200
Subject: [LTP] [PATCH] fallocat06: Add git tag for Btrfs noCoW ENOSPC bug
Message-ID: <20210401105617.9320-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/fallocate/fallocate06.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
index 409fd1321..ea21bd090 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate06.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
@@ -19,6 +19,8 @@
  *
  * This is also regression test for:
  * e093c4be760e ("xfs: Fix tail rounding in xfs_alloc_file_space()")
+ * 6d4572a9d71d ("Allow btrfs_truncate_block() to fallback to nocow for data
+ *              space reservation")
  */
 
 #define _GNU_SOURCE
@@ -259,6 +261,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "e093c4be760e"},
+		{"linux-git", "6d4572a9d71d"},
 		{}
 	}
 };
-- 
2.30.2

