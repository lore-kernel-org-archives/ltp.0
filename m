From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 May 2019 16:17:53 +0300
Subject: [LTP] [PATCH v4 1/2] OVL_MNT: add helpers to setup overlayfs
	mountpoint
In-Reply-To: <20190527120945.GA25513@dell5510>
References: <20190524122357.GA28108@dell5510>
 <20190525115112.15399-1-xzhou@redhat.com>
 <20190527120945.GA25513@dell5510>
Message-ID: <CAOQ4uxhwZkpTASn7Vn2sAE3uHcPupe19xwtsxLHixUYFxRiozQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Mon, May 27, 2019 at 3:09 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Murphy, Amir, Cyril,
>
> just a suggestion to apply diff below:
>
> 1) mount_overlay(): you don't actually use lineno and safe in error messages
> tst_fs_setup.c: In function ‘mount_overlay’:
> tst_fs_setup.c:26:31: warning: unused parameter ‘file’ [-Wunused-parameter]
>  int mount_overlay(const char *file, const int lineno, int safe)
>                    ~~~~~~~~~~~~^~~~
> tst_fs_setup.c:26:47: warning: unused parameter ‘lineno’ [-Wunused-parameter]
>  int mount_overlay(const char *file, const int lineno, int safe)
>
> 2) mount_overlay(): return ret from mount (usually -1) instead of 1 (in case
> anybody is interested).
>
> 3) mount_overlay(): earlier return 0 after checking ENODEV saves us one shift
> right (but might look as error, as tst_res() is usually followed by return).
>
> 4) create_overlay_dirs(): checks for OVL_LOWER and thus can be called in
> mount_overlay() without any check. This saves us calling it before
> {SAFE,TST}_MOUNT_OVERLAY() in execveat03.c and readahead02.c
>
> 5) removed unused headers (<stdint.h>, <stdio.h>, <stdlib.h>, <sys/vfs.h>),
> is any of them needed and the need masked by it's include in tst_test.h?
>

The changes above look fine to me

> 5) other cleanup
>
> TODO:
> I'm still not sure about ovl_mounted. There is static int mntpoint_mounted in
> lib/tst_test.c, which does umount.  tst_test->mntpoint, I guess we should use
> it. WDYT?

It's not exactly the same as mntpoint_mounted.
In readahead02 ovl_mounted is used to decide whether to
run test only on base fs or on base fs and also on overlayfs.
Or maybe I did not understand what you mean.
For other tests ovl_moutned is only used for cleanup and could
probably be replaced with mntpoint_mounted.

Thanks,
Amir.
