From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Aug 2016 18:53:54 +0200
Subject: [LTP] [PATCH] syscalls/fallocate04: Fix on Btrfs
Message-ID: <20160825165354.GA13281@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The size of a file can double on Btrfs temporarily even when we write
into a preallocated space because of internal Btrfs caches, at least
that is what I've been told by Btrfs devs. The internal caches are then
freed after some time, or can be force freed by syncing the file, which
is what this patch does.

Technically we are not guaranteed that the file size will not change after
writing to preallocated space. We are only guaranteed that subsequent writes to
the region will not fail with ENOSPC. So this behavior, while uncommon, is not
really a bug.

Before the patch the test fails with:

fallocate04    0  TINFO  :  allocate '12288' bytes
fallocate04    1  TPASS  :  test-case succeeded
fallocate04    0  TINFO  :  read allocated file size '24576'
fallocate04    0  TINFO  :  make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04    0  TINFO  :  check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04    0  TINFO  :  found a hole at '4096' offset
fallocate04    0  TINFO  :  allocated file size before '24576' and after '12288'
fallocate04    2  TFAIL  :  fallocate04.c:184: not expected allocated size

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fallocate/fallocate04.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 2b904e4..f204188 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -75,6 +75,8 @@ static size_t get_allocsize(void)
 {
 	struct stat file_stat;
 
+	fsync(fd);
+
 	SAFE_FSTAT(cleanup, fd, &file_stat);
 
 	return file_stat.st_blocks * 512;
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
