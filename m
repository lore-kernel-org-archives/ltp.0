From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Apr 2021 21:25:44 +0200
Subject: [LTP] [PATCH] Ignore ntfs file system
In-Reply-To: <20210425030440.12762-1-zhanglianjie@uniontech.com>
References: <20210425030440.12762-1-zhanglianjie@uniontech.com>
Message-ID: <YIcTuE34yq8KISC5@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> If the fuse file system is ignored and the kernel enable CONFIG_NTFS_FS,
> then the mount.ntfs of fuse is used when mounting ntfs,
> which is equivalent to not ignoring the fuse file system.

...
> +++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> @@ -123,6 +123,7 @@ static struct tst_test test = {
>  	.all_filesystems = 1,
>  	.skip_filesystems = (const char *const []){
>  		"fuse",
> +		"ntfs",

Shouldn't "ntfs" *replace* "fuse"?

Testing on SLES kernel 5.3 (heavily patched) which is without CONFIG_NTFS_FS:
...
tst_supported_fs_types.c:51: TINFO: mkfs.vfat does exist
...
Summary:
passed   21
failed   0
broken   0
skipped  0
warnings 0

Testing Debian kernel 4.9.0-11-amd64 which is with CONFIG_NTFS_FS:
tst_supported_fs_types.c:148: TINFO: Skipping ntfs as requested by the test
...
Summary:
passed   15
failed   0
broken   0
skipped  0
warnings 0


Kind regards,
Petr
