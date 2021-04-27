From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Apr 2021 15:27:53 +0200
Subject: [LTP] [PATCH] Ignore ntfs file system
In-Reply-To: <726f49eb-a185-6637-44e3-232d5e9b6fab@uniontech.com>
References: <20210425030440.12762-1-zhanglianjie@uniontech.com>
 <YIcTuE34yq8KISC5@pevik>
 <726f49eb-a185-6637-44e3-232d5e9b6fab@uniontech.com>
Message-ID: <YIgRWZFymSmCKFyS@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > If the fuse file system is ignored and the kernel enable CONFIG_NTFS_FS,
> > > then the mount.ntfs of fuse is used when mounting ntfs,
> > > which is equivalent to not ignoring the fuse file system.

> > ...
> > > +++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> > > @@ -123,6 +123,7 @@ static struct tst_test test = {
> > >   	.all_filesystems = 1,
> > >   	.skip_filesystems = (const char *const []){
> > >   		"fuse",
> > > +		"ntfs",

> > Shouldn't "ntfs" *replace* "fuse"?
> Can't replace fuse.
Not sure if we understand each other: I mean add "ntfs" and *remove* "fuse",
as "fuse" is now redundant when we whitelist ntfs (see
tst_get_supported_fs_types()), unless there is problem with other fuse
filesystems. I tested with CONFIG_FUSE_FS=m CONFIG_EXFAT_FS=m.

But maybe removing "fuse" should be a separate step.

> > Testing on SLES kernel 5.3 (heavily patched) which is without CONFIG_NTFS_FS:
> > ...
> > tst_supported_fs_types.c:51: TINFO: mkfs.vfat does exist
> > ...
> > Summary:
> > passed   21
> > failed   0
> > broken   0
> > skipped  0
> > warnings 0
> If there is no CONFIG_NTFS_FS, the test of the ntfs file system will be
> ignored. Because there is fuse in skip_filesystems, the test can pass.

See above.

> > Testing Debian kernel 4.9.0-11-amd64 which is with CONFIG_NTFS_FS:
> > tst_supported_fs_types.c:148: TINFO: Skipping ntfs as requested by the test
> > ...
> > Summary:
> > passed   15
> > failed   0
> > broken   0
> > skipped  0
> > warnings 0

> CONFIG_NTFS_FS is configured, are you sure there is no ntfs
> in skip_filesystems? Why does it output "Skipping ntfs as requested by
> the test"?
> There should be no mount.ntfs command provided by ntfs-3g in your
> system.
See above.

Kind regards,
Petr
