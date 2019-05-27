From: Murphy Zhou <xzhou@redhat.com>
Date: Mon, 27 May 2019 21:38:59 +0800
Subject: [LTP] [PATCH v4 1/2] OVL_MNT: add helpers to setup overlayfs
	mountpoint
In-Reply-To: <20190527120945.GA25513@dell5510>
References: <20190524122357.GA28108@dell5510>
 <20190525115112.15399-1-xzhou@redhat.com>
 <20190527120945.GA25513@dell5510>
Message-ID: <20190527133859.mun7h2xlzjdcwlqv@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr,

On Mon, May 27, 2019 at 02:09:45PM +0200, Petr Vorel wrote:
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

Yes, it's good to use them in the messages.

> 
> 2) mount_overlay(): return ret from mount (usually -1) instead of 1 (in case
> anybody is interested).

Agree.
> 
> 3) mount_overlay(): earlier return 0 after checking ENODEV saves us one shift
> right (but might look as error, as tst_res() is usually followed by return).

Brilliant!

> 
> 4) create_overlay_dirs(): checks for OVL_LOWER and thus can be called in
> mount_overlay() without any check. This saves us calling it before
> {SAFE,TST}_MOUNT_OVERLAY() in execveat03.c and readahead02.c
> 
> 5) removed unused headers (<stdint.h>, <stdio.h>, <stdlib.h>, <sys/vfs.h>),
> is any of them needed and the need masked by it's include in tst_test.h?
> 
> 5) other cleanup

All agree.
> 
> TODO:
> I'm still not sure about ovl_mounted. There is static int mntpoint_mounted in
> lib/tst_test.c, which does umount.  tst_test->mntpoint, I guess we should use
> it. WDYT?

mntpoint_mounted is tracking mount status of a separated mountpoint which
is the base for creating overlay dirs and overlay mountpoint. This separated
mountpoint is setup from scratch, grab dev, mfks etc. It's separated from
runltp -d DIR. This is why this patch is needed.

Overlayfs is mounted on this separated mountpoint. Testcases need to umount
overlayfs in cleanup if setup overlay successfully. That's why ovl_mounted
is needed.

How about SAFE_UMOUNT_OVERLAY ignoring EINVAL ?

Thanks!
M


> 
> Kind regards,
> Petr
> ---
> * diff to first commit:
> diff --git lib/tst_fs_setup.c lib/tst_fs_setup.c
> index de09c7135..60dedc283 100644
> --- lib/tst_fs_setup.c
> +++ lib/tst_fs_setup.c
> @@ -1,46 +1,46 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * DESCRIPTION
> - *	A place for setup filesystem helpers.
> - */
>  
> -#include <stdint.h>
> +#include <dirent.h>
>  #include <errno.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <sys/vfs.h>
>  #include <sys/mount.h>
>  
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>  #include "tst_fs.h"
>  
> +#define TST_FS_SETUP_OVERLAYFS_MSG "overlayfs is not configured in this kernel"
> +#define TST_FS_SETUP_OVERLAYFS_CONFIG "lowerdir="OVL_LOWER",upperdir="OVL_UPPER",workdir="OVL_WORK
> +
>  void create_overlay_dirs(void)
>  {
> -	SAFE_MKDIR(OVL_LOWER, 0755);
> -	SAFE_MKDIR(OVL_UPPER, 0755);
> -	SAFE_MKDIR(OVL_WORK, 0755);
> -	SAFE_MKDIR(OVL_MNT, 0755);
> +	DIR* dir = opendir(OVL_BASE_MNTPOINT);
> +	if (!dir) {
> +		SAFE_MKDIR(OVL_LOWER, 0755);
> +		SAFE_MKDIR(OVL_UPPER, 0755);
> +		SAFE_MKDIR(OVL_WORK, 0755);
> +		SAFE_MKDIR(OVL_MNT, 0755);
> +	}
>  }
>  
>  int mount_overlay(const char *file, const int lineno, int safe)
>  {
> -	int ret = 0;
> -	char *cfgmsg = "overlayfs is not configured in this kernel.";
> -
> -	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
> -		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
> -	if (ret < 0) {
> -		if (errno == ENODEV) {
> -			if (safe) {
> -				tst_brk(TCONF, cfgmsg);
> -			} else {
> -				tst_res(TINFO, cfgmsg);
> -				return 1;
> -			}
> +	int ret;
> +
> +	create_overlay_dirs();
> +
> +	ret = mount("overlay", OVL_MNT, "overlay", 0, TST_FS_SETUP_OVERLAYFS_CONFIG);
> +
> +	if (!ret)
> +		return 0;
> +
> +	if (errno == ENODEV) {
> +		if (safe) {
> +			tst_brk(TCONF, "%s:%d: " TST_FS_SETUP_OVERLAYFS_MSG, file, lineno);
>  		} else {
> -			tst_brk(TBROK | TERRNO, "overlayfs mount failed");
> +			tst_res(TINFO, "%s:%d: " TST_FS_SETUP_OVERLAYFS_MSG, file, lineno);
>  		}
> +	} else {
> +		tst_brk(TBROK | TERRNO, "overlayfs mount failed");
>  	}
> -	return 0;
> +	return ret;
>  }
> 
> * diff to second commit:
> diff --git testcases/kernel/syscalls/execveat/execveat03.c testcases/kernel/syscalls/execveat/execveat03.c
> index 446ff4f1d..eb088bc4c 100644
> --- testcases/kernel/syscalls/execveat/execveat03.c
> +++ testcases/kernel/syscalls/execveat/execveat03.c
> @@ -88,8 +88,6 @@ static void verify_execveat(void)
>  static void setup(void)
>  {
>  	check_execveat();
> -
> -	create_overlay_dirs();
>  	SAFE_MOUNT_OVERLAY();
>  	ovl_mounted = 1;
>  }
> diff --git testcases/kernel/syscalls/inotify/inotify08.c testcases/kernel/syscalls/inotify/inotify08.c
> index 929ed08f1..9433315e2 100644
> --- testcases/kernel/syscalls/inotify/inotify08.c
> +++ testcases/kernel/syscalls/inotify/inotify08.c
> @@ -165,7 +165,7 @@ static void setup(void)
>  	if (fd_notify < 0) {
>  		if (errno == ENOSYS) {
>  			tst_brk(TCONF,
> -				"inotify is not configured in this kernel.");
> +				"inotify is not configured in this kernel");
>  		} else {
>  			tst_brk(TBROK | TERRNO,
>  				"inotify_init () failed");
> diff --git testcases/kernel/syscalls/readahead/readahead02.c testcases/kernel/syscalls/readahead/readahead02.c
> index db95c2b01..f6e07173d 100644
> --- testcases/kernel/syscalls/readahead/readahead02.c
> +++ testcases/kernel/syscalls/readahead/readahead02.c
> @@ -388,7 +388,6 @@ static void setup(void)
>  	setup_readahead_length();
>  	tst_res(TINFO, "readahead length: %d", readahead_length);
>  
> -	create_overlay_dirs();
>  	ovl_mounted = TST_MOUNT_OVERLAY();
>  }
