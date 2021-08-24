From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Aug 2021 16:18:20 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/sync_file_range02: Rewrite the
 decription
Message-ID: <20210824141820.8685-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Into a docparse format.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../syscalls/sync_file_range/sync_file_range02.c       | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index f9693089b..5da751c70 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -4,12 +4,12 @@
  * Author: Sumit Garg <sumit.garg@linaro.org>
  */
 
-/*
- * sync_file_range02
+/*\
+ * [Description]
  *
- * It basically tests sync_file_range() to sync test file range having large
- * dirty file pages to block device. Also, it tests all supported filesystems
- * on a test block device.
+ * Tests if sync_file_range() does sync a test file range with a many dirty pages
+ * to a block device. Also, it tests all supported filesystems on a test block
+ * device.
  */
 
 #define _GNU_SOURCE
-- 
2.31.1

