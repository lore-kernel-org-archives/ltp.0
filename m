From: Zirong Lang <zlang@redhat.com>
Date: Tue, 8 Mar 2016 22:12:00 -0500 (EST)
Subject: [LTP] [PATCH 2/2] mmap16: fix ETIMEDOUT error if test device is
 too large
In-Reply-To: <20160309022200.GC11419@eguan.usersys.redhat.com>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
 <1457444133-5671-2-git-send-email-zlang@redhat.com>
 <20160309022200.GC11419@eguan.usersys.redhat.com>
Message-ID: <2049039915.27626928.1457493120716.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- 原始邮件 -----
> 发件人: "Eryu Guan" <eguan@redhat.com>
> 收件人: "Zorro Lang" <zlang@redhat.com>
> 抄送: ltp@lists.linux.it
> 发送时间: 星期三, 2016年 3 月 09日 上午 10:22:00
> 主题: Re: [LTP] [PATCH 2/2] mmap16: fix ETIMEDOUT error if test device is too large
> 
> On Tue, Mar 08, 2016 at 09:35:33PM +0800, Zorro Lang wrote:
> > mmap16 will wait DEFAULT_MSEC_TIMEOUT=10000 msec, for parent
> > process full the test device(-b $DEVICE). But if the device
> > size is too large, this case will hit ETIMEDOUT error.
> > 
> > For reproduce the bug of mmap16, it don't need too large device.
> > So I limit the fs size in 100M.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  testcases/kernel/syscalls/mmap/mmap16.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/mmap/mmap16.c
> > b/testcases/kernel/syscalls/mmap/mmap16.c
> > index c5828ea..f8fbd50 100644
> > --- a/testcases/kernel/syscalls/mmap/mmap16.c
> > +++ b/testcases/kernel/syscalls/mmap/mmap16.c
> > @@ -143,8 +143,6 @@ static void do_test(void)
> >  
> >  static void setup(void)
> >  {
> > -	const char *fs_opts[3] = {"-b", "1024", NULL};
> > -
> >  	tst_sig(FORK, DEF_HANDLER, NULL);
> >  	tst_require_root();
> >  
> > @@ -158,7 +156,7 @@ static void setup(void)
> >  	device = tst_acquire_device(cleanup);
> >  	if (!device)
> >  		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> > -	tst_mkfs(cleanup, device, fs_type, fs_opts);
> > +	tst_mkfs(cleanup, device, fs_type, NULL, "100m", "1024");
> 
> Should be calling tst_mkfs_sized() instead?

Wow! Yes, my mistake. Sorry, it's should be:
tst_mkfs_sized(cleanup, device, fs_type, NULL, "100m", "1024");

I will wait for the patch about tst_mkfs_sized() be reviewed, then change this
patch.

My original idea is: after tst_mkfs_sized() be accepted, I should try to find all
cases use tst_mkfs(), then check/fix if large device maybe cause them hit TIMEOUT
error or run too long time.

This patch about mmap16 is only a demo, I want to follow the maintainer's suggestions.
If I do all those works now, but LTP don't want that, that's waste time:)

Thanks,
Zorro

> 
> Thanks,
> Eryu
> >  
> >  	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
> >  	/*
> > --
> > 2.5.0
> > 
> > 
> > --
> > Mailing list info: http://lists.linux.it/listinfo/ltp
>
