From: Shuang Qiu <shuang.qiu@oracle.com>
Date: Wed, 03 Feb 2016 09:28:59 +0800
Subject: [LTP] [PATCH] commands/mkswap01: Update wait_for_file function
In-Reply-To: <20160202143525.GC19199@rei.lan>
References: <1454082985-3549-1-git-send-email-shuang.qiu@oracle.com>
 <20160202143525.GC19199@rei.lan>
Message-ID: <56B157DB.3010206@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
Thanks for review.
On 02/02/2016 10:35 PM, Cyril Hrubis wrote:
> Hi!
>> In commit a76b72ad31fa7bb22a09f323dadd5db7c00c7f56,it depends on the files
>> under /dev/disk/by-* in wait_for_file function.But sometimes udev does not
>> refresh automatically during runtime and the symbolic links will not appear.
> Isn't that udev bug?
It does not look like a bug,restart udev(or run udevtrigger) or 
partprobe will create the symbolic link.
>
>> Update the function to use blkid instead.
> Does actually the swapon in the verify function work? Since as far as I
> can tell it actually opens the symlink in question in order to get the
> swap device.
>
> Have you tried stracing it in case that the code waiting for the device
> timeouted?
I tried it with UEK.Sometimes waiting for device timeout but swapon 
works,i.e.:

...
...

mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
mkswap01 6 TWARN : The file /dev/disk/by-label/ltp_testswap haven't appeared
mkswap01 6 TPASS : 'mkswap -L ltp_testswap /dev/sda7 ' passed.
...

But we can find the label or UUID for device in blkid.
Per my testing with blkid,swapon will not fail after checking blkid.

Thanks
Shuang
>

