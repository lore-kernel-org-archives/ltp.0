From: Zirong Lang <zlang@redhat.com>
Date: Wed, 9 Mar 2016 11:30:05 -0500 (EST)
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <20160309160924.GA28234@rei.lan>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309130709.GA28171@rei.lan>
 <1202691488.27788761.1457537492316.JavaMail.zimbra@redhat.com>
 <20160309155258.GA32248@rei.lan>
 <617741409.27804234.1457539512488.JavaMail.zimbra@redhat.com>
 <20160309160924.GA28234@rei.lan>
Message-ID: <2053304118.27813474.1457541005041.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- 原始邮件 -----
> 发件人: "Cyril Hrubis" <chrubis@suse.cz>
> 收件人: "Zirong Lang" <zlang@redhat.com>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期四, 2016年 3 月 10日 上午 12:09:25
> 主题: Re: [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for create appointed size fs
> 
> Hi!
> > Yes, this likes what I just said to you. add another parameter char
> > *fs_opts[], which
> > store all parameters for mkfs need to behind device name.
> 
> Given that all mkfs programs that I have installed have either one
> (fs-size) or zero paremeters it does not have to be array at all.
> 
> We can just do:
> 
> void safe_mkfs(const int lineno, const char *fname, const char *dev,
>                const char *fs_type, const char *fs_size,
> 	       const char *const fs_opts[]);
> 
> And append fs_size after device if it's non-NULL.
Hi,

Sure, it's OK for me. And I think if we call it *fs_size, maybe make the user
feel confused. The truth is it's the count of blocks, and only used for some
fs. So maybe we can call it *extra_opts, means used after device name?

So I will do this patch:

1. change tst_mkfs to 
void safe_mkfs(const int lineno, const char *fname, const char *dev,
               const char *fs_type, const char *const fs_opts[],
               const char *extra_opts)

2. add tst_mkfs into test.h:
static inline void tst_mkfs(const int lineno, const char *fname, const char *dev,
                             const char *fs_type, const char *const fs_opts[])
{
    safe_mkfs(lineno, fname, dev, fs_type, fs_opts, NULL);
}

Does this you want?

Thanks,
Zorro

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
>
