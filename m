From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 12 Jan 2021 10:12:26 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop05.c: skip test on overlay
 filesystem
In-Reply-To: <X/SEt8EfjP+w4EYw@yuki.lan>
References: <20201215155650.6496-1-radoslav.kolev@suse.com>
 <5FD96C97.6020602@cn.fujitsu.com>
 <c6340b4dc96458ddd972beb28059324d44f44a99.camel@suse.com>
 <5FD9C58B.9020807@cn.fujitsu.com> <X/SEt8EfjP+w4EYw@yuki.lan>
Message-ID: <5FFD058A.5050104@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Radoslav
> Hi!
>> diff --git a/lib/tst_device.c b/lib/tst_device.c
>> index c096b418b..de64fd908 100644
>> --- a/lib/tst_device.c
>> +++ b/lib/tst_device.c
>> @@ -534,6 +534,10 @@ void tst_find_backing_dev(const char *path, char *dev)
>>           if (stat(dev,&buf)<  0)
>>                   tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
>>
>> -       if (S_ISBLK(buf.st_mode) != 1)
>> -               tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
>> +       if (S_ISBLK(buf.st_mode) != 1) {
>> +               if (tst_is_mounted(dev))
>> +                       tst_find_backing_dev(dev, dev);
>> +               else
>> +                       tst_brkm(TCONF, NULL, "dev(%s) isn't a block
>> dev", dev);
>> +       }
>>    }
>>
>> My test environment is that
>> /dev/sda10              20G  623M   18G   4% /mnt/xfstests/test
>> /mnt/xfstests/test      20G  623M   18G   4% /mnt/xfstests/test/ovl-mnt
>> /dev/sda11              20G   46M   19G   1% /mnt/xfstests/scratch
>> /mnt/xfstests/scratch   20G   46M   19G   1% /mnt/xfstests/scratch/ovl-mnt
>>
>> and my TMPDIR env is /mnt/xfstests/test/ovl-mnt.
>
> Does this code works for everyone or should we apply patch that disables
> the test on overlay so that it's fixed for next release?
Thanks for this patch, merged.

Best Regards
Yang Xu
>



