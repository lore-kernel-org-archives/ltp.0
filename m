From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 16 Dec 2020 16:30:03 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop05.c: skip test on overlay
 filesystem
In-Reply-To: <c6340b4dc96458ddd972beb28059324d44f44a99.camel@suse.com>
References: <20201215155650.6496-1-radoslav.kolev@suse.com>	
 <5FD96C97.6020602@cn.fujitsu.com>
 <c6340b4dc96458ddd972beb28059324d44f44a99.camel@suse.com>
Message-ID: <5FD9C58B.9020807@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Radoslav
> On Wed, 2020-12-16 at 10:10 +0800, Yang Xu wrote:
>> Hi Radoslav
>>> The undelrying device can't be properly detected and causes failure
>>> when running in an overlay filesystem.
>>
>> I guess the best way is to change tst_find_backing_dev api, so it
>> can
>> detect the correct underlying device.
>
> Yes, that would be the best solution. If you have and idea of how to do
> it that's not too complicated please give me some pointers.
>
> I looked into it briefly, but didn't see a straighforward way.
>
The code maybe below(just check whether the device is a mountpotint, if 
it is, call tst_find_backing_dev api again)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index c096b418b..de64fd908 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -534,6 +534,10 @@ void tst_find_backing_dev(const char *path, char *dev)
         if (stat(dev, &buf) < 0)
                 tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);

-       if (S_ISBLK(buf.st_mode) != 1)
-               tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
+       if (S_ISBLK(buf.st_mode) != 1) {
+               if (tst_is_mounted(dev))
+                       tst_find_backing_dev(dev, dev);
+               else
+                       tst_brkm(TCONF, NULL, "dev(%s) isn't a block 
dev", dev);
+       }
  }

My test environment is that
/dev/sda10              20G  623M   18G   4% /mnt/xfstests/test
/mnt/xfstests/test      20G  623M   18G   4% /mnt/xfstests/test/ovl-mnt
/dev/sda11              20G   46M   19G   1% /mnt/xfstests/scratch
/mnt/xfstests/scratch   20G   46M   19G   1% /mnt/xfstests/scratch/ovl-mnt

and my TMPDIR env is /mnt/xfstests/test/ovl-mnt.

>
>
> .
>



