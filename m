From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 13 Sep 2018 13:22:03 +0800
Subject: [LTP] [PATCH v2] lib/tst_device.c: Make sure all loop deivces fot
	test are detached
In-Reply-To: <20180912123332.GC463@rei>
References: <20180912123332.GC463@rei>
Message-ID: <1536816123-13986-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Before commit e583eac in LTP, running statx05 by runltp without -b option
every time attached a loop device but didn't detach it, as below:
------------------------------------------------------------------
...
tst_device.c:230: INFO: Using test device LTP_DEV='/dev/loop0'
tst_device.c:268: INFO: Skipping $LTP_DEV size 256MB, requested size 512MB
tst_device.c:83: INFO: Found free device '/dev/loop1'
tst_mkfs.c:83: INFO: Formatting /dev/loop1 with ext4 opts='' extra opts='-O encrypt'
...
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE                                         DIO
/dev/loop1         0      0         0  0 /tmp/ltp-gsrcFAkGpZ/Wka3bp/test_dev.img (deleted)   0
------------------------------------------------------------------

This issue has been fixed for statx since commit e583eac in LTP, but the
test library is still broken.

runltp without -b option creates a block device with default 256M size by
attaching a free loop device and sets LTP_DEV variable, and if some tests
need a 512M(bigger than 256M) block device by specifying .dev_min_size,
tst_acquire_device__() in setup will skip the $LTP_DEV device and create
another block device with 512M size by attaching another free loop device.
Unfortunately, tst_release_device() in cleanup will not detach the 512M
block device due to the defined LTP_DEV.

We should just skip the detach in tst_release_device() when device_acquired
flag is not set.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 4637434431..fd4e277c78 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -313,7 +313,7 @@ int tst_release_device(const char *dev)
 {
 	int ret;
 
-	if (getenv("LTP_DEV"))
+	if (!device_acquired)
 		return 0;
 
 	/*
-- 
2.17.0



