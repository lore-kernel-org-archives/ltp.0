From: Zirong Lang <zlang@redhat.com>
Date: Thu, 10 Mar 2016 08:30:11 -0500 (EST)
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <20160310121914.GA18922@rei.lan>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309160924.GA28234@rei.lan>
 <2053304118.27813474.1457541005041.JavaMail.zimbra@redhat.com>
 <20160309174337.GA32758@rei>
 <740680606.28013439.1457574323142.JavaMail.zimbra@redhat.com>
 <20160310100425.GA18650@rei.lan>
 <149857450.28159183.1457611239055.JavaMail.zimbra@redhat.com>
 <20160310121914.GA18922@rei.lan>
Message-ID: <762780060.28180858.1457616611675.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- 原始邮件 -----
> 发件人: "Cyril Hrubis" <chrubis@suse.cz>
> 收件人: "Zirong Lang" <zlang@redhat.com>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期四, 2016年 3 月 10日 下午 8:19:14
> 主题: Re: [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for create appointed size fs
> 
> Hi!
> > I don't mean give size limit to all cases use tst_mkfs. I mean the limited
> > size
> > used for cases which will effected by test device size. Actually, I just
> > pass
> > size limit to mmap16 until now:) I don't know which case need it or will
> > need it too.
> > 
> > I found that mmap16 ETIMEDOUT problem by test on a 1G /dev/loop0. I don't
> > think
> > it's too big as a general test device.
> 
> Well that could be fixed easily by the extra blocksize parameter.
> 
> And I guess that the testcase can also run faster if we limit the fs
> size to minimal ext4 size. So this looks like a good idea.
> 
> Are there any other testcases that fail with a device of size 1GB or
> less?

I just run some LTP cases about FS, not all LTP cases. Until now I haven't
found any others similar fail.

> 
> > I think make an appointed size fs can be used for 3 parts:
> > 1) If someone case need a specially appointed fs size, it can do it. e.g.
> > quota test.
> 
> We do not have this need at the moment.
> 
> Are you about the write such testcase?

Sorry, no this plan until now.

> 
> > 2) Generally most QE will prepare some partitions or some special
> > device(FC, SAS...)
> > in his test machine, and use them for many different test suit(LTP,
> > xfstests ...).
> > These partitions or devices maybe 15G, 80G, 1T, 2T... they always pass them
> > as test
> > devices directly. I think we shouldn't say "NO, you can't pass a device
> > more than
> > 1G to LTP, that will cause failures.", I think LTP should deal with big
> > test device
> > problem, so mkfs_sized is needed.
> 
> I do not agree. Since if you do not pass any device to LTP, it will
> simply create small enough loopback device. So in this case the solution
> is simply not passing any device to LTP at all.

Oh, sorry I don't know LTP will create small loop device by itself. So do you
still want to fix this ETIMEDOUT problem? Or we just say "please don't give
outside device to LTP?" or "please give a small enough device to LTP -b device"

BTW, if LTP will create small loop device by itself, I can't make mmap16 to create
a 100M ext4. I think it maybe too big for LTP small loop device. I will test and
change my recent patch


Thanks,
Zorro

