From: Li Wang <liwang@redhat.com>
Date: Thu, 27 Apr 2017 18:12:41 +0800
Subject: [LTP] [PATCH] ioctl06: fix BLKRASET failures in small sectors
Message-ID: <20170427101241.15640-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ioctl() failed to set readahead area in smaller sectors on ppc/aarch64
(PAGESIZE == 65536kB) arch, that's because the minimal readahead pages
aligned by '(arg * 512) / PAGE_SIZE'. See:

 block/ioctl.c:
         case BLKRASET:
         case BLKFRASET:
                 if(!capable(CAP_SYS_ADMIN))
                         return -EACCES;
                 bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
                 return 0;

In this patch, shift the test value with increase by 512 bytes
(base on: blockdev(8) --setra).

Error log:
tst_device.c:82: INFO: Found free device '/dev/loop1'
tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
ioctl06.c:37: INFO: BLKRAGET original value 256
ioctl06.c:44: PASS: BLKRASET 0 read back correctly
ioctl06.c:46: FAIL: BLKRASET 64 read back 0
ioctl06.c:44: PASS: BLKRASET 128 read back correctly
ioctl06.c:46: FAIL: BLKRASET 192 read back 128
ioctl06.c:44: PASS: BLKRASET 256 read back correctly
ioctl06.c:46: FAIL: BLKRASET 320 read back 256
ioctl06.c:44: PASS: BLKRASET 384 read back correctly
ioctl06.c:46: FAIL: BLKRASET 448 read back 384
ioctl06.c:44: PASS: BLKRASET 512 read back correctly
ioctl06.c:49: INFO: BLKRASET restoring original value 256

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl06.c b/testcases/kernel/syscalls/ioctl/ioctl06.c
index 082d097..30ca088 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl06.c
@@ -36,7 +36,7 @@ static void verify_ioctl(void)
 
 	tst_res(TINFO, "BLKRAGET original value %lu", rao);
 
-	for (ra = 0; ra <= 512; ra += 64) {
+	for (ra = 0; ra <= 4096; ra += 512) {
 		SAFE_IOCTL(fd, BLKRASET, ra);
 		SAFE_IOCTL(fd, BLKRAGET, &rab);
 
-- 
2.9.3

