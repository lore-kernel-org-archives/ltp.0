From: Zirong Lang <zlang@redhat.com>
Date: Thu, 10 Mar 2016 11:24:27 -0500 (EST)
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <20160310140653.GA19672@rei.lan>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309174337.GA32758@rei>
 <740680606.28013439.1457574323142.JavaMail.zimbra@redhat.com>
 <20160310100425.GA18650@rei.lan>
 <149857450.28159183.1457611239055.JavaMail.zimbra@redhat.com>
 <20160310121914.GA18922@rei.lan>
 <762780060.28180858.1457616611675.JavaMail.zimbra@redhat.com>
 <20160310140653.GA19672@rei.lan>
Message-ID: <1050034192.28240408.1457627067176.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- 原始邮件 -----
> 发件人: "Cyril Hrubis" <chrubis@suse.cz>
> 收件人: "Zirong Lang" <zlang@redhat.com>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期四, 2016年 3 月 10日 下午 10:06:53
> 主题: Re: [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for create appointed size fs
> 
> Hi!
> > > > 2) Generally most QE will prepare some partitions or some special
> > > > device(FC, SAS...)
> > > > in his test machine, and use them for many different test suit(LTP,
> > > > xfstests ...).
> > > > These partitions or devices maybe 15G, 80G, 1T, 2T... they always pass
> > > > them
> > > > as test
> > > > devices directly. I think we shouldn't say "NO, you can't pass a device
> > > > more than
> > > > 1G to LTP, that will cause failures.", I think LTP should deal with big
> > > > test device
> > > > problem, so mkfs_sized is needed.
> > > 
> > > I do not agree. Since if you do not pass any device to LTP, it will
> > > simply create small enough loopback device. So in this case the solution
> > > is simply not passing any device to LTP at all.
> > 
> > Oh, sorry I don't know LTP will create small loop device by itself. So do
> > you
> > still want to fix this ETIMEDOUT problem? Or we just say "please don't give
> > outside device to LTP?" or "please give a small enough device to LTP -b
> > device"
> 
> I still do, since it's reasonably easy to fix and 1GB block device is
> not that big to begin with.
> 
> > BTW, if LTP will create small loop device by itself, I can't make mmap16 to
> > create
> > a 100M ext4. I think it maybe too big for LTP small loop device. I will
> > test and
> > change my recent patch
> 
> Ah looks like there is a bug. Since the default LTP device size was
> changed to 100MB in lib/tst_device.c and in testcases/lib/test.sh but
> not in the runltp (which is because new enough btrfs needs at least
> 100MB for filesystem).

Oh, if you want to mkfs.btrfs on a device less than 100MB, you can use --mixed
option. I know it can support small device less than 100MB, but I haven't try
the smallest size.

> 
> But the mmap16 test should work with as small device as possible, which
> would be 20MB.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
