From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 10 Feb 2017 14:38:11 +0100
Subject: [LTP] [PATCH] mmap16: extend checkpoint wait time during fs fill
Message-ID: <793ef4af0e7bb8827b5d2bd04321267ad530ed55.1486733825.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I'm seeing this test rarely failing on slower systems:
mmap16      0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
mmap16      0  TINFO  :  Formatting /dev/loop0 with ext4 opts='-b 1024' extra opts='10240'
mmap16      1  TBROK  :  tst_checkpoint.c:136: mmap16.c:223: tst_checkpoint_wait(0, 10000): errno=ETIMEDOUT(110): Connection timed out
mmap16      2  TBROK  :  tst_checkpoint.c:136: Remaining cases broken
mmap16      1  TBROK  :  tst_checkpoint.c:149: mmap16.c:125: tst_checkpoint_wake(0, 1, 10000): errno=ETIMEDOUT(110): Connection timed out
mmap16      2  TBROK  :  tst_checkpoint.c:149: Remaining cases broken

duration=52 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=132

What appears to be happening is that filling entire fs with 1024 chunks
takes longer than 10 seconds, so child hits TBROK while waiting for
parent. Parent eventually finishes, but then is unable to wake
child, which already finished.

Based on output above it looks like it took ~30 seconds to fill the fs
and then we hit 2 timeouts, making total of ~50 seconds. This patch
extends this particular checkpoint wait to 60 seconds.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/mmap/mmap16.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index 3f2676bdc2d2..b3f51fd18c92 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -220,7 +220,11 @@ static void do_child(void)
 	 * kernel writepage is called, that means data corruption.
 	 */
 	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+
+	/* Give parent enough time to consume FS free blocks */
+	if (tst_checkpoint_wait(0, 60*1000))
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"wait for parent to fill entire space");
 
 	for (offset = FS_BLOCKSIZE; offset < page_size; offset += FS_BLOCKSIZE)
 		addr[offset] = 'a';
-- 
1.8.3.1

