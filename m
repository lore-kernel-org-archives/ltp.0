From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 8 Feb 2016 16:34:16 +0100
Subject: [LTP] [PATCH] commands/mkswap01: Update wait_for_file function
In-Reply-To: <56B435EC.3020107@oracle.com>
References: <1454082985-3549-1-git-send-email-shuang.qiu@oracle.com>
 <20160202143525.GC19199@rei.lan> <56B157DB.3010206@oracle.com>
 <20160204131705.GD4615@rei> <56B435EC.3020107@oracle.com>
Message-ID: <20160208153415.GB9844@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
> >> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
> >> mkswap01 6 TINFO : Waiting for /dev/disk/by-label/ltp_testswap to appear
> >> mkswap01 6 TWARN : The file /dev/disk/by-label/ltp_testswap haven't appeared
> >> mkswap01 6 TPASS : 'mkswap -L ltp_testswap /dev/sda7 ' passed.
> >> ...
> > That looks strange to me. Since if I strace 'swapon -L ltp_testswap' I got:
> >
> > ...
> > stat("/dev/disk/by-label/ltp_testswap", 0x7ffef8293800) = -1 ENOENT (No such file or directory)
> > ...
> >
> > Then it proceeds to exit with error. So I'm geniuely confused.
> >
> > Hmm but looking at blkid man page, it says that udev symlinks may depend
> > on settings in /etc/blkid.conf. That may be the difference after all.
> >
> > Looking at the manual page doing 'blkid -L ltp_testswap' and 'blkid -U
> > $UUID' should be the only correct solution. Does that work for you?
> Yes.
> But it does not support blkid -L/-U with lower version of blkid 
> util(such like in RHEL5.11).
> So I use "-t" option to search the label and UUID instead in the patch.

Looking around the backward compatible way should be:

blkid -l -t LABEL=foo
blkid -l -t UUID=foo

Does that work for you?

-- 
Cyril Hrubis
chrubis@suse.cz
