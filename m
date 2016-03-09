From: Zirong Lang <zlang@redhat.com>
Date: Wed, 9 Mar 2016 10:09:49 -0500 (EST)
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <20160309130921.GB28171@rei.lan>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309130921.GB28171@rei.lan>
Message-ID: <1949942365.27778261.1457536189138.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- 原始邮件 -----
> 发件人: "Cyril Hrubis" <chrubis@suse.cz>
> 收件人: "Zorro Lang" <zlang@redhat.com>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期三, 2016年 3 月 09日 下午 9:09:21
> 主题: Re: [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for create appointed size fs
> 
> Hi!
> > +void tst_mkfs_sized(void (cleanup_fn)(void), const char *dev,
> > +                    const char *fs_type, const char *const fs_opts[],
> > +                    const char *fssize, const char *blocksize);
> > +
> > +#define tst_mkfs(cleanup_fn, dev, fs_type, fs_opts) \
> > +	tst_mkfs_sized(cleanup_fn, dev, fs_type, fs_opts, NULL, NULL)
> 
> Also make this static inline function instead. We only use such macros
> for SAFE_MACROS() where we have to pass correct __FILE__ and __LINE__,
> which is very special occasion.

OK, I will change it to inline function.

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
