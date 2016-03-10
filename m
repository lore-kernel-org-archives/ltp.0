From: Zirong Lang <zlang@redhat.com>
Date: Wed, 9 Mar 2016 20:45:23 -0500 (EST)
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <20160309174337.GA32758@rei>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309130709.GA28171@rei.lan>
 <1202691488.27788761.1457537492316.JavaMail.zimbra@redhat.com>
 <20160309155258.GA32248@rei.lan>
 <617741409.27804234.1457539512488.JavaMail.zimbra@redhat.com>
 <20160309160924.GA28234@rei.lan>
 <2053304118.27813474.1457541005041.JavaMail.zimbra@redhat.com>
 <20160309174337.GA32758@rei>
Message-ID: <740680606.28013439.1457574323142.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- 原始邮件 -----
> 发件人: "Cyril Hrubis" <chrubis@suse.cz>
> 收件人: "Zirong Lang" <zlang@redhat.com>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期四, 2016年 3 月 10日 上午 1:43:37
> 主题: Re: [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for create appointed size fs
> 
> Hi!
> > Sure, it's OK for me. And I think if we call it *fs_size, maybe make the
> > user
> > feel confused. The truth is it's the count of blocks, and only used for
> > some
> > fs. So maybe we can call it *extra_opts, means used after device name?
> 
> That is true, well the 'man mkfs' is confusing as well since it looks
> like the size argument is supported generally by mkfs binaries...
> 
> And we should call it extra_opt, since it's just one option.
> 
> > So I will do this patch:
> > 
> > 1. change tst_mkfs to
> > void safe_mkfs(const int lineno, const char *fname, const char *dev,
> >                const char *fs_type, const char *const fs_opts[],
> >                const char *extra_opts)
> > 
> > 2. add tst_mkfs into test.h:
> > static inline void tst_mkfs(const int lineno, const char *fname, const char
> > *dev,
> >                              const char *fs_type, const char *const
> >                              fs_opts[])
> > {
> >     safe_mkfs(lineno, fname, dev, fs_type, fs_opts, NULL);
> > }
> > 
> > Does this you want?
> 
> Having two nearly identical *_mkfs() functions would be confusing as
> well. I would have just changed the function prototype and fixed all the
> testcases that use it (36 testcases if I'm counting right).

OK...

But actually I want to check all testcases which use tst_mkfs(), and give them a
fs_size limit if big device will effect them in my 2nd patch, after
the new "fs size" parameter be accepted. I think it looks clearly.

Anyway, if you think it's OK, I can do them in one patch:)

Thanks,
Zorro

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
