From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 May 2019 17:27:26 +0200
Subject: [LTP] [PATCH v4 1/2] OVL_MNT: add helpers to setup overlayfs
	mountpoint
In-Reply-To: <CAOQ4uxhwZkpTASn7Vn2sAE3uHcPupe19xwtsxLHixUYFxRiozQ@mail.gmail.com>
References: <20190524122357.GA28108@dell5510>
 <20190525115112.15399-1-xzhou@redhat.com>
 <20190527120945.GA25513@dell5510>
 <CAOQ4uxhwZkpTASn7Vn2sAE3uHcPupe19xwtsxLHixUYFxRiozQ@mail.gmail.com>
Message-ID: <20190527152726.GA17581@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Murphy, Amir,

thanks a lot for your answers.

> > 5) other cleanup

> > TODO:
> > I'm still not sure about ovl_mounted. There is static int mntpoint_mounted in
> > lib/tst_test.c, which does umount.  tst_test->mntpoint, I guess we should use
> > it. WDYT?

> It's not exactly the same as mntpoint_mounted.
> In readahead02 ovl_mounted is used to decide whether to
> run test only on base fs or on base fs and also on overlayfs.
> Or maybe I did not understand what you mean.
> For other tests ovl_moutned is only used for cleanup and could
> probably be replaced with mntpoint_mounted.
Indeed, sorry for confusion. readahead02.c uses .mount_device = 1 flag, which is
then umounted in do_setup() in tst_test.c.
I was still playing with idea having some some other flag for overlay which
would be meant for simple use cases (execveat03.c, inotify0[78].c,
execveat03.c). With this flag library would call SAFE_MOUNT_OVERLAY() in
do_setup() and manage ovl_mounted, doing SAFE_UMOUNT in do_cleanup() (same
approach as .mount_device and mntpoint_mounted). The idea was already mentioned
by Amir. There still would be {SAFE,TST}_MOUNT_OVERLAY() giving a freedom to do
more complicated things (readahead02.c).

Just a suggestion, sorry for complicating things.

> Thanks,
> Amir.

Kind regards,
Petr
