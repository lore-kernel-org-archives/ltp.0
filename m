From: Zirong Lang <zlang@redhat.com>
Date: Wed, 9 Mar 2016 11:01:32 -0500 (EST)
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <1202691488.27788761.1457537492316.JavaMail.zimbra@redhat.com>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <20160309130709.GA28171@rei.lan>
 <1202691488.27788761.1457537492316.JavaMail.zimbra@redhat.com>
Message-ID: <1806320002.27803455.1457539292136.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- 原始邮件 -----
> 发件人: "Zirong Lang" <zlang@redhat.com>
> 收件人: "Cyril Hrubis" <chrubis@suse.cz>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期三, 2016年 3 月 09日 下午 11:31:32
> 主题: Re: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for create appointed size fs
> 
> 
> 
> ----- 原始邮件 -----
> > 发件人: "Cyril Hrubis" <chrubis@suse.cz>
> > 收件人: "Zorro Lang" <zlang@redhat.com>
> > 抄送: ltp@lists.linux.it
> > 发送时间: 星期三, 2016年 3 月 09日 下午 9:07:10
> > 主题: Re: [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for create
> > appointed size fs
> > 
> > Hi!
> > >  #include "test.h"
> > >  #include "ltp_priv.h"
> > >  
> > >  #define OPTS_MAX 32
> > >  
> > > -void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> > > -	      const char *fs_type, const char *const fs_opts[])
> > > +long long cvtnum(const char *s)
> > > +{
> > > +	long long i;
> > > +	char *sp = NULL;
> > > +
> > > +	i = strtoll(s, &sp, 0);
> > > +	if (i == 0 && sp == s)
> > > +		return -1LL;
> > > +	if (*sp == '\0')
> > > +		return i;
> > > +
> > > +	if (*sp == 'k' && sp[1] == '\0')
> > > +		return 1024LL * i;
> > > +	if (*sp == 'm' && sp[1] == '\0')
> > > +		return 1024LL * 1024LL * i;
> > > +	if (*sp == 'g' && sp[1] == '\0')
> > > +		return 1024LL * 1024LL * 1024LL * i;
> > > +	if (*sp == 't' && sp[1] == '\0')
> > > +		return 1024LL * 1024LL * 1024LL * 1024LL * i;
> > > +	if (*sp == 'p' && sp[1] == '\0')
> > > +		return 1024LL * 1024LL * 1024LL * 1024LL * 1024LL * i;
> > > +	if (*sp == 'e' && sp[1] == '\0')
> > > +		return 1024LL * 1024LL * 1024LL * 1024LL * 1024LL * 1024LL * i;
> > > +	return -1LL;
> > > +}
> > 
> > We allready have bytes_by_prefix() in LTP library.
> 
> Oh, I just noticed that function. The difference is bytes_by_prefix() run an
> int value, so it can't bigger than 2^31. But some FS, likes XFS can support
> very huge size, even in RHEL-7, XFS support 500T. it's bigger than 2^31.
> 
> But generally we won't run LTP on a 500T device:) So if you don't want to
> change
> that, we should say mkfs size can't bigger than 2^31 bytes, or the result
> will
> be unexpected.
> 
> > 
> > > +void tst_mkfs_sized(void (cleanup_fn)(void), const char *dev,
> > > +                    const char *fs_type, const char *const fs_opts[],
> > > +                    const char *fssize, const char *blocksize)
> > 
> > What about passing the size parameter as we do in tst_fs_has_free()?
> > 
> > I.e. with two paramters where one is size and the second is units?
> 
> Oh, I don't know why we need two parameters to describe one size. I use
> "char *fssize" due to tst_mkfs() use string paramters directly, it don't
> need an int value(but int value is OK too).
> 
> > 
> > Also why have you added the blocksize parameter as well? The block size
> > is needed only for the mmap16 test while limiting filesystem size seems
> > like good addition to the library?
> 
> Block size is needed because some fs need to know the block count, if you
> want to create a sized fs. For example if we want to make 512m ext4 and xfs:
> 
> xfs can directly use mkfs -t xfs -d size=512m device
> 
> but mkfs.ext4 need to do like: mkfs -t ext4 -b $block_size device
> 512*1024*1024/$block_size
> 
> So we need to know block size for some fs, as I know udf fs need to know
> block count too.
> 

And even if not for extX fs, I don't need tst_mkfs_sized() function. If for
XFS, the fs_opts parameter of tst_mkfs() already can do that by:
const char *fs_opts[5] = {"-b", "size=1024", "-d", "size=100m" NULL};


But make a sized extX fs, need to know how many block counts (fs_size/block_size),
and this block counts need to behind the device name, e.g.
mkfs -t ext4 -b 1024 device 100*1024*1024/1024

I can't just write likes above:
const char *fs_opts[4] = {"-b", "1024", "102400" NULL};

So at first demo patch, I add a "|" to separate the parameters which need to before
device name or behind device name.

Or I said another method, add a new parameter for tst_mkfs(), named "fs_opts2", which
store all paramters for mkfs and need to behind the device name.

Thanks,
Zorro

