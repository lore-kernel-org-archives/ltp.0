From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 25 Feb 2016 19:51:52 +0300
Subject: [LTP] [PATCH] commands/mkswap01: Update wait_for_file function
In-Reply-To: <20160204131705.GD4615@rei>
References: <1454082985-3549-1-git-send-email-shuang.qiu@oracle.com>
 <20160202143525.GC19199@rei.lan> <56B157DB.3010206@oracle.com>
 <20160204131705.GD4615@rei>
Message-ID: <56CF3128.7030509@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 02/04/2016 04:17 PM, Cyril Hrubis wrote:
> Hi!
>>> Does actually the swapon in the verify function work? Since as far as I
>>> can tell it actually opens the symlink in question in order to get the
>>> swap device.
>>>
>>> Have you tried stracing it in case that the code waiting for the device
>>> timeouted?
>> I tried it with UEK.Sometimes waiting for device timeout but swapon
>> works,i.e.:
>>
>> ...
>> ...
>>
>> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
>> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
>> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
>> mkswap01 6 TWARN : The file /dev/disk/by-label/ltp_testswap haven't appeared
>> mkswap01 6 TPASS : 'mkswap -L ltp_testswap /dev/sda7 ' passed.
>> ...
>
> That looks strange to me. Since if I strace 'swapon -L ltp_testswap' I got:
>
> ...
> stat("/dev/disk/by-label/ltp_testswap", 0x7ffef8293800) = -1 ENOENT (No such file or directory)
> ...
>
> Then it proceeds to exit with error. So I'm geniuely confused.

Hmm, in my case swapon -L test does not fail, if there is no 
/dev/disk/by-label/test:

root@skholman-m7 stas]# rm /dev/disk/by-label/test
rm: remove symbolic link `/dev/disk/by-label/test'? y
[root@skholman-m7 stas]# BLKID_FILE=/tmp/none strace swapon -L test &> 
/tmp/o; echo $?
0
[root@skholman-m7 stas]# grep by-label /tmp/o
stat64("/dev/disk/by-label/test", 0x7feff9b6130) = -1 ENOENT (No such 
file or directory)
[root@skholman-m7 stas]#

(but in the strace output I see that swapon tries to read some sectors 
from all available block devices)

Maybe the version of libblkid plays a role here.

Using 'blkid -t' simply makes wait_for_file/wait_for_device not fail if 
there is no /dev/disk/by-label/ symlink. I suppose 'blkid -t' could be 
substituted with /bin/true in my case.

>
> Hmm but looking at blkid man page, it says that udev symlinks may depend
> on settings in /etc/blkid.conf. That may be the difference after all.
>
> Looking at the manual page doing 'blkid -L ltp_testswap' and 'blkid -U
> $UUID' should be the only correct solution. Does that work for you?
>
