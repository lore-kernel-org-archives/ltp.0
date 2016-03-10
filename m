From: Zirong Lang <zlang@redhat.com>
Date: Thu, 10 Mar 2016 07:00:39 -0500 (EST)
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <20160310100425.GA18650@rei.lan>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309155258.GA32248@rei.lan>
 <617741409.27804234.1457539512488.JavaMail.zimbra@redhat.com>
 <20160309160924.GA28234@rei.lan>
 <2053304118.27813474.1457541005041.JavaMail.zimbra@redhat.com>
 <20160309174337.GA32758@rei>
 <740680606.28013439.1457574323142.JavaMail.zimbra@redhat.com>
 <20160310100425.GA18650@rei.lan>
Message-ID: <149857450.28159183.1457611239055.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


Hi,

----- 原始邮件 -----
> 发件人: "Cyril Hrubis" <chrubis@suse.cz>
> 收件人: "Zirong Lang" <zlang@redhat.com>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期四, 2016年 3 月 10日 下午 6:04:25
> 主题: Re: [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for create appointed size fs
> 
> Hi!
> > OK...
> > 
> > But actually I want to check all testcases which use tst_mkfs(), and
> > give them a fs_size limit if big device will effect them in my 2nd
> > patch, after the new "fs size" parameter be accepted. I think it looks
> > clearly.
> 
> This begs a question what exactly is your motivation? Why do you pass a
> big device in LTP_DEV in the first place? The testcases that use the
> device just need it to be big enough to be formatted with a filesystem
> which is about 100MB at the moment.

I don't mean give size limit to all cases use tst_mkfs. I mean the limited size
used for cases which will effected by test device size. Actually, I just pass
size limit to mmap16 until now:) I don't know which case need it or will need it too.

I found that mmap16 ETIMEDOUT problem by test on a 1G /dev/loop0. I don't think
it's too big as a general test device.

I think make an appointed size fs can be used for 3 parts:
1) If someone case need a specially appointed fs size, it can do it. e.g. quota test.
2) Generally most QE will prepare some partitions or some special device(FC, SAS...)
in his test machine, and use them for many different test suit(LTP, xfstests ...).
These partitions or devices maybe 15G, 80G, 1T, 2T... they always pass them as test
devices directly. I think we shouldn't say "NO, you can't pass a device more than
1G to LTP, that will cause failures.", I think LTP should deal with big test device
problem, so mkfs_sized is needed.
3) If someone case try to full the whole test fs, and it don't need big size fs, it can use
mkfs_sized to prevent this case run too long time.

I think the reason that LTP don't care make a sized fs is LTP doesn't do many fs test,
if LTP have more and more fs test cases, it will feel mkfs_sized is important.

Thanks,
Zorro

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
>
