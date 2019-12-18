From: Li Wang <liwang@redhat.com>
Date: Wed, 18 Dec 2019 16:28:26 +0800
Subject: [LTP] [PATCH RFC] sync_file_range02: remove the toplimit of write
 back
Message-ID: <20191218082826.25083-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test tries to sync a range of $BYTES bytes, and then makes sure that
between $BYTES and $BYTES+10% was written to disk. But sometimes, more
than $BYTES+10% hit the disk: "Synced 39843840, expected 33554432" so
it failed as below.

  tst_test.c:1179: INFO: Testing on ext4
  sync_file_range02.c:74: FAIL: Sync equals write: Synced 39843840,
                          expected 33554432
  sync_file_range02.c:74: FAIL: Sync inside of write: Synced 18612224,
                          expected 16777216

From FS dev's view:

" The test's assumptions are fundamentally false; it thinks it can look
at IO counters (tst_dev_bytes_written) for a disk before and after a
system call, and attribute all of the IO seen to the system call that
was made - this isn't necessarily correct. Other processes may generate
IO in the background.

ext4 defers a lot of IO on a freshly made filesystem to the kernel -
for example it will initialize the journal and inode tables after the
mount, and this will cause extra IO.

Creating ext4 filesystems with the options: "-E lazy_itable_init=0,
lazy_journal_init=0" might help.

Another option would be to raise the threshold. Essentially, the report
here is that the test is failing because the filesystem wrote "too much"
as a result of the sync. How much is "too much?" ..."

Let's remove the toplimit of write back, and think as long as we synced
at least the expected amount, the test passes. The +10% limit seems arbitrary.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
---
 testcases/kernel/syscalls/sync_file_range/sync_file_range02.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index eb08143c3..643be14fa 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -66,8 +66,7 @@ static void verify_sync_file_range(struct testcase *tc)
 
 	SAFE_CLOSE(fd);
 
-	if ((written >= tc->exp_sync_size) &&
-	    (written <= (tc->exp_sync_size + tc->exp_sync_size/10)))
+	if ((written >= tc->exp_sync_size))
 		tst_res(TPASS, "%s", tc->desc);
 	else
 		tst_res(TFAIL, "%s: Synced %li, expected %li", tc->desc,
-- 
2.20.1

