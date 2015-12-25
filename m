From: Shuang Qiu <shuang.qiu@oracle.com>
Date: Sat, 26 Dec 2015 01:37:20 +0800
Subject: [LTP] mkfs01 testcases issue
Message-ID: <567D7ED0.2060706@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

While running LTP commands testcases,these three 
tests(mkfs01_msdos,mkfs01_vfat,mkswap01) sometimes failed.
It is because that mkfs.vfat/mkswap on the test block device which is 
made as btrfs( in previous mkfs01_btrfs test) does not work.
blkid still show "TYPE="btrfs" after mkfs.vfat/mkswap.
Seems the issue is only reproduced with a very small size of block 
device(less than 20M).
Does anyone hit similar issue,is it a kernel or btrfs bug?

Anyway,how about making the test block device $LTP_DEV to the original 
filesystem in tst_release_device(),so it will avoid such effect between 
different testcases.

--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -253,6 +253,7 @@ tst_acquire_device()
  tst_release_device()
  {
         if [ ${TST_DEVICE_FLAG} -eq 0 ]; then
+               tst_mkfs ${LTP_DEV_FS_TYPE} ${LTP_DEV}
                 return
         fi


Thanks
Shuang
