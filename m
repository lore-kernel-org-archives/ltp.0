From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Jul 2021 15:31:55 +0200
Subject: [LTP] [PATCH] lib: tst_device: Allow more control over the device
 size
Message-ID: <20210730133155.31284-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is actually no reason for lower limit on the device size, and we
can safely allow the tests to request smaller device than the default
hardcoded in the library. The backing file is preallocated without
actually writing to it as long as the underlying filesystem supports it
so the speedup will be minimal if measurable but we will at least spare
some space which needs to be reserved on the filesystem which is still a
good thing.

The test may end up with a device that is bigger than the requsted size
in a case that a real device was passed to the LTP for the testrun.  So
tests should be able to cope with that and that's also the reason why
the turning knob is still called dev_min_size.

Also currently we use the dev_min_size only to increase the device size
for a few tests so this change is safe and cannot break anything.

CC: Joerg Vehlow <lkml@jv-coder.de>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index c91c6cd55..4ef802c41 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -300,7 +300,7 @@ const char *tst_acquire_device__(unsigned int size)
 	unsigned int acq_dev_size;
 	uint64_t ltp_dev_size;
 
-	acq_dev_size = MAX(size, DEV_SIZE_MB);
+	acq_dev_size = size ? size : DEV_SIZE_MB;
 
 	dev = getenv("LTP_DEV");
 
-- 
2.31.1

