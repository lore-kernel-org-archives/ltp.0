From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Jan 2021 17:03:09 +0100
Subject: [LTP] [PATCH 1/1] lib: Fix fs support detection for non-root
In-Reply-To: <YBLRadSFcxAWN57a@yuki.lan>
References: <20210128144649.6012-1-pvorel@suse.cz> <YBLRadSFcxAWN57a@yuki.lan>
Message-ID: <YBLgPafndYT+b2Vr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > grep /proc/filesystems to find kernel support.
> > But consider only 0 (filesystem found) or 1 (not found),
> > ignore other results (e.g. 2: /proc/filesystems not available or
> > no permissions) and fallback to old solution (calling mount()).

> Why is this needed?
generate_lvm_runfile.sh correctly requires TST_NEEDS_ROOT=1, only for this.
zram0{12}.sh (or maybe better zram_lib.sh, which they use) incorrectly don't
require root, they need it for calling modprobe zram and generally for zram use,
but also for this. I'll fix this in my patchset fixing zram and we can ignore
generate_lvm_runfile.sh.

=> It might not be needed. But generally some test in the future (C or shell)
may want to know filesystem support for other reason which does not require
root. Thus we can drop /proc/filesystems, but at least warning would be nice to
have (although that implementation only prints warning and returns 0, thus
warning will be lost for shell).

Also .all_filesystems in C API have .needs_root = 1. Currently copy_file_range01,
preadv03, pwritev03.
They get obvious hint from tst_acquire_loop_device():
tst_device.c:100: TINFO: Not allowed to open /dev/loop-control. Are you root?: EACCES (13)
=> they need to have .needs_root = 1.
And I wonder if we should have check expecting .needs_root for certain flags
(.all_filesystems, .needs_device, .mntpoint at least).

> Also this breaks FUSE detection.
Sorry for this. Agree with all your suggestions and can send v2 if we don't decide wontfix.

Kind regards,
Petr
