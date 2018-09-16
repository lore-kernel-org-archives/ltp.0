From: Rafael Tinoco <rafael.tinoco@linaro.org>
Date: Sun, 16 Sep 2018 16:46:19 -0300
Subject: [LTP] LTP master: arm64 : fsetxattr02.c:214:
 open(mntpoint/fsetxattr02blk, 0, 00) failed: ENXIO
In-Reply-To: <CA+G9fYtAuGixa5x6kgmBOa7bDkhkz6rQMY5AdBgXLjp8uZKHzg@mail.gmail.com>
References: <CA+G9fYtAuGixa5x6kgmBOa7bDkhkz6rQMY5AdBgXLjp8uZKHzg@mail.gmail.com>
Message-ID: <CADtBP2DrGG8743zKzi0_SJQLSJrG27NgiOeHHvWga=RzcYPjTQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Naresh,

LKFT hikey builds are missing:

inaddy@hikey:/mountpoint$ zcat /proc/config.gz | grep -i BLK_DEV_RAM
# CONFIG_BLK_DEV_RAM is not set

if comparing to my debian arm64 lab:

inaddy@statx04bug:/mountpoint$ cat /boot/config-4.18.0 | grep -i BLK_DEV_RAM
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384

So, when the test tries to mkdev(1,3), the device "ramdisk" does not exist.
As you can see in:

inaddy@statx04bug:/mountpoint$ sudo cat /proc/devices
Character devices:
...
Block devices:
  1 ramdisk
...

ramdisk block devices are showed in a working environment.

Without the ramdisk module, the test creates a block device node (major 1,
minor 3) pointing to non existing device types (ramdisk for this particular
test). I guess ramdisk module is mandatory for this test to succeed.

Not sure if there is a way, using LTP API, to enforce a module
existing/being loaded, but BROK is definitely the correct error in this
condition.

On Sat, Sep 15, 2018 at 7:09 AM Naresh Kamboju <naresh.kamboju@linaro.org>
wrote:

> LTP master testing on Hikey (arm64) device reported new test case
> fsetxattr02 and fgetxattr02 failed with error ENXIO (No such device or
> address)
>
> We have very limited failure information on the console.
> Is this test case in any special TMP DIR ?
>
> # cd /opt/ltp
> # mkdir -m 777 -p /ltp-tmp # on the top level ltp-tmp created which is
> ext4 fs.
> # ./runltp -f syscalls -d /ltp-tmp
>
> Test output log,
> safe_macros.c:225: BROK: fsetxattr02.c:214:
> open(mntpoint/fsetxattr02blk,0,00) failed: ENXIO
> safe_macros.c:225: BROK: fgetxattr02.c:244: open(fgetxattr02blk,0,00)
> failed: ENXIO
>
> Yangx fixed  error "EACCES" this error is ENXIO (No such device or address)
>
> Full log link,
> https://lkft.validation.linaro.org/scheduler/job/420924#L3182
>
> FYI,
> LTP Version: 20180515-270-ge7bab6188
>
> Best regards
> Naresh Kamboju
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180916/7cf30a7c/attachment.html>
