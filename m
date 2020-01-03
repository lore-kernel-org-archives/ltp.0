From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 3 Jan 2020 16:34:06 +0100
Subject: [LTP] [PATCH v3] syscalls/newmount: new test case for new mount
 API
In-Reply-To: <20191226072338.GH14328@dhcp-12-102.nay.redhat.com>
References: <20191209160227.16125-1-zlang@redhat.com>
 <20191226072338.GH14328@dhcp-12-102.nay.redhat.com>
Message-ID: <20200103153406.GA22990@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zorro,

> > V3 test passed on ext2/3/4 and xfs[1], on upstream mainline kernel. Thanks
> > all your review points:)
> > But I have a question, how to test other filesystems, likes nfs, cifs?

> Ping.

> It's been several weeks passed. Is there more review points?
Sorry for a delay, that's how it works in open source projects (we're also
just contributors).
But you could speed up the review yourself, if you have carefully read reviews
and address suggestions :).

I like you use .all_filesystems = 1 as I suggested in [1], but I warned that it
breaks nfs.
newmount01.c:58: FAIL: fsopen ntfs: ENODEV (19)

Fortunately this does not need any patch for filtering nfs as TST_FS_SKIP_FUSE
is enough for it - add this to struct tst_test:
.dev_fs_flags = TST_FS_SKIP_FUSE

Not sure if just fsopen() is affected, but it probably does not make sense to test
just fsopen() and fsconfig().

There are some issues Xu found in v2 [2], which you didn't address:

> > +AC_DEFUN([LTP_CHECK_NEWMOUNT],[
> > +AC_CHECK_FUNCS(fsopen,,)
> > +AC_CHECK_FUNCS(fsconfig,,)
> > +AC_CHECK_FUNCS(fsmount,,)
> > +AC_CHECK_FUNCS(move_mount,,)
> > +AC_CHECK_HEADER(sys/mount.h,,,)
> > +])
> You use m4 to check them. But it seems that you don't use those macros
> in your cases.
> + I told you in v1 to move AC_CHECK_FUNCS and AC_CHECK_HEADER into configure.ac
> (there is sorted list you add things you need), we use m4/ltp-*.m4 files only
> for complex checks.
> 
> > +#include "tst_safe_macros.h"
> "tst_test.h" has included "tst_safe_macros.h"
=> simply just remove it.

> > +static int sfd, mfd;
> > +static int is_mounted = 0;
> static int sfd, mfd, is_mounted;
(static is always 0).

There are also Cyril's suggestions and objections [3]:

> > +static void setup(void)
> > +{
> > +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
>
> Why aren't we just setting .format_device in the test structure?

> > +static void cleanup(void)
> > +{
> > +	if (mount_flag == 1) {
> > +		TEST(tst_umount(MNTPOINT));
> > +		if (TST_RET != 0)
> > +			tst_brk(TBROK | TTERRNO, "umount failed");
>
> The library already produces TWARN if we fail to umount the device, so I
> would say that there is no need to TBROK here, the TBROK will be
> converted to TWARN anyways since it's in the cleanup...

He also noted, that umount must be done in test:
> > +	SAFE_CLOSE(mfd);
> We have to umount the device here, otherwise it would be mounted for
> each test iteration with -i.

Another reason for tst_umount() in test is for me that it looks a bit strange
for me to perform testing in cleanup function.

+ his objections against else blocks and struct test_cases (I fully agree with it).

[1] https://lists.linux.it/pipermail/ltp/2019-November/014619.html
[2] https://lists.linux.it/pipermail/ltp/2019-December/014702.html
[3] https://lists.linux.it/pipermail/ltp/2019-December/014654.html

Kind regards,
Petr
