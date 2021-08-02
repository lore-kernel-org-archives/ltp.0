From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  2 Aug 2021 14:17:02 +0200
Subject: [LTP] [PATCH v2] lib: tst_device: Allow more control over the
 device size
Message-ID: <20210802121702.3905-1-chrubis@suse.cz>
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

v2: Updated both places where we compute the device size as pointed out
    by Joerg

 lib/tst_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index c91c6cd55..73e70d26e 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -278,7 +278,7 @@ int tst_dev_sync(int fd)
 
 const char *tst_acquire_loop_device(unsigned int size, const char *filename)
 {
-	unsigned int acq_dev_size = MAX(size, DEV_SIZE_MB);
+	unsigned int acq_dev_size = size ? size : DEV_SIZE_MB;
 
 	if (tst_prealloc_file(filename, 1024 * 1024, acq_dev_size)) {
 		tst_resm(TWARN | TERRNO, "Failed to create %s", filename);
@@ -300,7 +300,7 @@ const char *tst_acquire_device__(unsigned int size)
 	unsigned int acq_dev_size;
 	uint64_t ltp_dev_size;
 
-	acq_dev_size = MAX(size, DEV_SIZE_MB);
+	acq_dev_size = size ? size : DEV_SIZE_MB;
 
 	dev = getenv("LTP_DEV");
 
-- 
2.31.1

