From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Feb 2016 14:17:05 +0100
Subject: [LTP] [PATCH] commands/mkswap01: Update wait_for_file function
In-Reply-To: <56B157DB.3010206@oracle.com>
References: <1454082985-3549-1-git-send-email-shuang.qiu@oracle.com>
 <20160202143525.GC19199@rei.lan> <56B157DB.3010206@oracle.com>
Message-ID: <20160204131705.GD4615@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Does actually the swapon in the verify function work? Since as far as I
> > can tell it actually opens the symlink in question in order to get the
> > swap device.
> >
> > Have you tried stracing it in case that the code waiting for the device
> > timeouted?
> I tried it with UEK.Sometimes waiting for device timeout but swapon 
> works,i.e.:
> 
> ...
> ...
> 
> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
> mkswap01 6 TWARN : The file /dev/disk/by-label/ltp_testswap haven't appeared
> mkswap01 6 TPASS : 'mkswap -L ltp_testswap /dev/sda7 ' passed.
> ...

That looks strange to me. Since if I strace 'swapon -L ltp_testswap' I got:

...
stat("/dev/disk/by-label/ltp_testswap", 0x7ffef8293800) = -1 ENOENT (No such file or directory)
...

Then it proceeds to exit with error. So I'm geniuely confused.

Hmm but looking at blkid man page, it says that udev symlinks may depend
on settings in /etc/blkid.conf. That may be the difference after all.

Looking at the manual page doing 'blkid -L ltp_testswap' and 'blkid -U
$UUID' should be the only correct solution. Does that work for you?

-- 
Cyril Hrubis
chrubis@suse.cz
