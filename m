From: Murphy Zhou <xzhou@redhat.com>
Date: Wed, 29 May 2019 15:49:00 +0800
Subject: [LTP] [PATCH v4 1/2] OVL_MNT: add helpers to setup overlayfs
	mountpoint
In-Reply-To: <20190527153632.GA20053@dell5510>
References: <20190524122357.GA28108@dell5510>
 <20190525115112.15399-1-xzhou@redhat.com>
 <20190527120945.GA25513@dell5510>
 <20190527133859.mun7h2xlzjdcwlqv@XZHOUW.usersys.redhat.com>
 <20190527153632.GA20053@dell5510>
Message-ID: <20190529074900.c656afgiwcb7bhta@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 27, 2019 at 05:36:32PM +0200, Petr Vorel wrote:
> Hi Amir, Murphy,
> 
> > > TODO:
> > > I'm still not sure about ovl_mounted. There is static int mntpoint_mounted in
> > > lib/tst_test.c, which does umount.  tst_test->mntpoint, I guess we should use
> > > it. WDYT?
> 
> > mntpoint_mounted is tracking mount status of a separated mountpoint which
> > is the base for creating overlay dirs and overlay mountpoint. This separated
> > mountpoint is setup from scratch, grab dev, mfks etc. It's separated from
> > runltp -d DIR. This is why this patch is needed.
> 
> > Overlayfs is mounted on this separated mountpoint. Testcases need to umount
> > overlayfs in cleanup if setup overlay successfully. That's why ovl_mounted
> > is needed.
> 
> > How about SAFE_UMOUNT_OVERLAY ignoring EINVAL ?
> I don't see much benefits, when we have SAFE_UMOUNT().  More useful looks to me
> for simple cases move ovl_mounted and SAFE_UMOUNT(OVL_MNT)  to library (the only
> thing needed would be some flag for struct tst_test e.g. .mount_overlay = 1).

After some digging, I think putting ovl_mounted and UMOUNT to library is
good but creating dirs and MOUNT in library benefits less. Because splitting
creating dirs and MOUNT was intended to be more flexible on this. Also,
inotify07/8 needs to create extra dirs before mounting. So execveat03 is
the only one case to benefit from creating dirs and MOUNT in the library.

Thanks!

> 
> > Thanks!
> > M
> 
> 
> Kind regards,
> Petr
