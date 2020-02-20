From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Feb 2020 10:59:08 +0100
Subject: [LTP] [PATCH] syscalls/fgetxattr02: Use loop instead of RAM disk
Message-ID: <20200220095908.14980-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are minimal systems that does not ship with RAM disk kernel module
which makes this test fail with ENXIO when we attempt to open the block
device in the test setup.

LTP depends on heavily on loop device driver already so it makes sense
to switch over to a loop device backed block device instead.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fgetxattr/fgetxattr02.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
index 02e81810a..82fb676be 100644
--- a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
+++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
@@ -210,7 +210,8 @@ static void setup(void)
 	size_t i = 0;
 	struct sockaddr_un sun;
 
-	dev_t dev = makedev(1, 3);
+	dev_t chr_dev = makedev(1, 3);
+	dev_t blk_dev = makedev(7, 3);
 
 	SAFE_TOUCH(FILENAME, 0644, NULL);
 	SAFE_TOUCH(SYMLINKF, 0644, NULL);
@@ -219,8 +220,8 @@ static void setup(void)
 
 	/* root: mknod(2) needs it to create something other than a file */
 	SAFE_MKNOD(FIFO, S_IFIFO | 0777, 0);
-	SAFE_MKNOD(CHR, S_IFCHR | 0777, dev);
-	SAFE_MKNOD(BLK, S_IFBLK | 0777, dev);
+	SAFE_MKNOD(CHR, S_IFCHR | 0777, chr_dev);
+	SAFE_MKNOD(BLK, S_IFBLK | 0777, blk_dev);
 
 	for (i = 0; i < ARRAY_SIZE(tc); i++) {
 
-- 
2.23.0

