From: Zirong Lang <zlang@redhat.com>
Date: Tue, 8 Mar 2016 00:50:56 -0500 (EST)
Subject: [LTP] [PATCH] mmap16: fix ETIMEDOUT error if test device too
 large
In-Reply-To: <20160307161307.GB6055@rei.lan>
References: <1457097900-12012-1-git-send-email-zlang@redhat.com>
 <20160307161307.GB6055@rei.lan>
Message-ID: <491493160.27201862.1457416256157.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Cyril,

----- 原始邮件 -----
> 发件人: "Cyril Hrubis" <chrubis@suse.cz>
> 收件人: "Zorro Lang" <zlang@redhat.com>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期二, 2016年 3 月 08日 上午 12:13:07
> 主题: Re: [LTP] [PATCH] mmap16: fix ETIMEDOUT error if test device too large
> 
> Hi!
> >  lib/tst_mkfs.c                          | 11 ++++++++---
> >  testcases/kernel/syscalls/mmap/mmap16.c |  2 +-
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> > index 5f959a4..2948e25 100644
> > --- a/lib/tst_mkfs.c
> > +++ b/lib/tst_mkfs.c
> > @@ -27,6 +27,7 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> >  	int i, pos = 3;
> >  	const char *argv[OPTS_MAX] = {"mkfs", "-t", fs_type};
> >  	char fs_opts_str[1024] = "";
> > +	int tailed = 0;
> >  
> >  	if (!fs_type)
> >  		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
> > @@ -54,7 +55,11 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> >  
> >  	if (fs_opts) {
> >  		for (i = 0; fs_opts[i]; i++) {
> > -			argv[pos++] = fs_opts[i];
> > +			if (!strcmp(fs_opts[i], "|")) {
> > +				argv[pos++] = dev;
> > +				tailed = 1;
> > +			} else
> > +				argv[pos++] = fs_opts[i];
> >  
> >  			if (pos + 2 > OPTS_MAX) {
> >  				tst_brkm(TBROK, cleanup_fn,
> > @@ -66,8 +71,8 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> >  			strcat(fs_opts_str, fs_opts[i]);
> >  		}
> >  	}
> > -
> > -	argv[pos++] = dev;
> > +	if (tailed == 0)
> > +		argv[pos++] = dev;
> >  	argv[pos] = NULL;
> >  
> >  	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
> 
> This is ugly. If you want to pass the filesystem size you should add an
> paramter to the mkfs function instead of inventing special syntax for
> what has been simple list of parameters. We may add a second tst_mkfs2()
> function with extra parameter for the fs size.
> 
> Also you should make sure that the device is large enough for the
> requested size. For this use we may call the paramter max_size and
> simply ignore it if the device is smaller than that.

Yeah, I know that's ugly:) I try to find a better way which suit LTP by talk with
you. So I sent a simple patch only for describe what problem I met.

My original idea it's:

1. change tst_mkfs(...) to tst_mkfs_sized(..., const char *fssize, const char *blocksize)
2. add a function cvtnum() which can transform a string about size to a number, e.g. "512M" to 512*1024*1024, "1k" to 1024 ...
3. In tst_mkfs_sized(), if fssize != NULL, check fs type(extX and some others fs need to know blocksize):
   XFS can use "mkfs -t xfs -d size=fssize"
   extX need to use "mkfs -t extX .... dev cvtnum(fssize)/cvtnum(blocksize)"
   ...
   We need to add more different fs support(We can support xfs, ext4 and btrfs at first, add
   more later)
4. #define tst_mkfs(...) tst_mkfs_size(..., NULL, NULL)

I think we don't need to make sure the device is large enough. The cases which use
tst_mkfs_sized() should make sure to use a appropriate size(maybe the smallest it need)
as the parameter. If the test device size not suit the case requested size, we directly
return ERROR which mkfs return to us.

What do you think? If you feel it's OK, I'll write a normal patch as that.

Thanks,
Zorro

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
>
