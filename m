From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 May 2019 17:36:32 +0200
Subject: [LTP] [PATCH v4 1/2] OVL_MNT: add helpers to setup overlayfs
	mountpoint
In-Reply-To: <20190527133859.mun7h2xlzjdcwlqv@XZHOUW.usersys.redhat.com>
References: <20190524122357.GA28108@dell5510>
 <20190525115112.15399-1-xzhou@redhat.com>
 <20190527120945.GA25513@dell5510>
 <20190527133859.mun7h2xlzjdcwlqv@XZHOUW.usersys.redhat.com>
Message-ID: <20190527153632.GA20053@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir, Murphy,

> > TODO:
> > I'm still not sure about ovl_mounted. There is static int mntpoint_mounted in
> > lib/tst_test.c, which does umount.  tst_test->mntpoint, I guess we should use
> > it. WDYT?

> mntpoint_mounted is tracking mount status of a separated mountpoint which
> is the base for creating overlay dirs and overlay mountpoint. This separated
> mountpoint is setup from scratch, grab dev, mfks etc. It's separated from
> runltp -d DIR. This is why this patch is needed.

> Overlayfs is mounted on this separated mountpoint. Testcases need to umount
> overlayfs in cleanup if setup overlay successfully. That's why ovl_mounted
> is needed.

> How about SAFE_UMOUNT_OVERLAY ignoring EINVAL ?
I don't see much benefits, when we have SAFE_UMOUNT().  More useful looks to me
for simple cases move ovl_mounted and SAFE_UMOUNT(OVL_MNT)  to library (the only
thing needed would be some flag for struct tst_test e.g. .mount_overlay = 1).

> Thanks!
> M


Kind regards,
Petr
