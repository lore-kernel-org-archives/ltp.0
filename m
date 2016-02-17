From: Shuang Qiu <shuang.qiu@oracle.com>
Date: Wed, 17 Feb 2016 16:30:50 +0800
Subject: [LTP] [PATCH] commands/mkswap01: Update wait_for_file function
In-Reply-To: <20160208153415.GB9844@rei>
References: <1454082985-3549-1-git-send-email-shuang.qiu@oracle.com>
 <20160202143525.GC19199@rei.lan> <56B157DB.3010206@oracle.com>
 <20160204131705.GD4615@rei> <56B435EC.3020107@oracle.com>
 <20160208153415.GB9844@rei>
Message-ID: <56C42FBA.5070600@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/08/2016 11:34 PM, Cyril Hrubis wrote:
> Hi!
>>>> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
>>>> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
>>>> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
>>>> mkswap01 6 TWARN : The file /dev/disk/by-label/ltp_testswap haven't appeared
>>>> mkswap01 6 TPASS : 'mkswap -L ltp_testswap /dev/sda7 ' passed.
>>>> ...
>>> That looks strange to me. Since if I strace 'swapon -L ltp_testswap' I got:
>>>
>>> ...
>>> stat("/dev/disk/by-label/ltp_testswap", 0x7ffef8293800) = -1 ENOENT (No such file or directory)
>>> ...
>>>
>>> Then it proceeds to exit with error. So I'm geniuely confused.
>>>
>>> Hmm but looking at blkid man page, it says that udev symlinks may depend
>>> on settings in /etc/blkid.conf. That may be the difference after all.
>>>
>>> Looking at the manual page doing 'blkid -L ltp_testswap' and 'blkid -U
>>> $UUID' should be the only correct solution. Does that work for you?
>> Yes.
>> But it does not support blkid -L/-U with lower version of blkid
>> util(such like in RHEL5.11).
>> So I use "-t" option to search the label and UUID instead in the patch.
> Looking around the backward compatible way should be:
>
> blkid -l -t LABEL=foo
> blkid -l -t UUID=foo
>
> Does that work for you?
According to the man page,-l option will look up only one device which 
matches -t NAME=value if there are multiple devices matched.And it will 
print all devices without -l option.
So I though just -t option is enough in this case.
But blkid -l -t also works.

Thanks
Shuang
>

