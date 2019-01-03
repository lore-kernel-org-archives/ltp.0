From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 3 Jan 2019 06:06:49 -0500 (EST)
Subject: [LTP] [PATCH] tbio/ltp_tbio.c: Change the order of calling
 blk_cleanup_queue() and del_gendisk()
In-Reply-To: <5BCE876F.4070500@cn.fujitsu.com>
References: <1540193371-5689-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <5BCE876F.4070500@cn.fujitsu.com>
Message-ID: <2118209189.93118010.1546513609600.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On 2018/10/22 15:29, Xiao Yang wrote:
> > Removing ltp_tbio.ko module always reproduced a warning and panic
> > on the old kernels that have backported kernel commit a063057d7c73
> > (e.g. RHEL7.6).
> Hi,
> 
> Sorry, the RHEL version is sensltive, so please remove it when pushing
> the patch.

Not sure what you mean by 'sensitive'. Anyway, pushed with
the note about RHEL7.6 dropped.

Regards,
Jan

> 
> Best Regards,
> Xiao Yang
> > Removing ltp_tbio.ko module calls blk_cleanup_queue() and del_gendisk()
> > in the order so that it triggers races or warnings since commit
> > a063057d7c73
> > in kernel, and some kernel modules have fixed the issue, as below:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57678e5a3d5145e5f08aa1d307ba219b27b1765a
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0fa8ebdd4244b8e652cc5341c3d5b4b06f84a637
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d8115c35bf3ee575cfc9c51ac9853f58a21a43dc
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=392db38058eb47250a9d0cc737af37e78a7e443d
> >
> > We also try to fix the issue in the same way.
> >
> > Note:
> > A lot of structs and functions in ltp_tbio.ko module based on old
> > kernel(e.g. 3.10.0) has been changed on upstream kernel, so ltp_tbio.ko
> > module cannot be built on upstream kernel.  Perhaps ltp_tbio.ko
> > module needs to be updated, but we want to fix the issue first.
> >
> > Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > ---
> >  testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
> > b/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
> > index 48cc588..0a9cd40 100644
> > --- a/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
> > +++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c
> > @@ -562,8 +562,8 @@ module_init(tbio_init);
> >  
> >  static void tbio_exit(void)
> >  {
> > -	blk_cleanup_queue(tbio_dev.q);
> >  	del_gendisk(tbio_dev.gd);
> > +	blk_cleanup_queue(tbio_dev.q);
> >  	put_disk(tbio_dev.gd);
> >  	unregister_blkdev(TBIO_MAJOR, DEVICE_NAME);
> >  	vfree(tbio_dev.data);
> 
> 
> 
> 
