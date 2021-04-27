From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Tue, 27 Apr 2021 20:25:09 +0800
Subject: [LTP] [PATCH] Ignore ntfs file system
In-Reply-To: <YIcTuE34yq8KISC5@pevik>
References: <20210425030440.12762-1-zhanglianjie@uniontech.com>
 <YIcTuE34yq8KISC5@pevik>
Message-ID: <726f49eb-a185-6637-44e3-232d5e9b6fab@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
> 
>> If the fuse file system is ignored and the kernel enable CONFIG_NTFS_FS,
>> then the mount.ntfs of fuse is used when mounting ntfs,
>> which is equivalent to not ignoring the fuse file system.
> 
> ...
>> +++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
>> @@ -123,6 +123,7 @@ static struct tst_test test = {
>>   	.all_filesystems = 1,
>>   	.skip_filesystems = (const char *const []){
>>   		"fuse",
>> +		"ntfs",
> 
> Shouldn't "ntfs" *replace* "fuse"?
Can't replace fuse.

> 
> Testing on SLES kernel 5.3 (heavily patched) which is without CONFIG_NTFS_FS:
> ...
> tst_supported_fs_types.c:51: TINFO: mkfs.vfat does exist
> ...
> Summary:
> passed   21
> failed   0
> broken   0
> skipped  0
> warnings 0
If there is no CONFIG_NTFS_FS, the test of the ntfs file system will be
ignored. Because there is fuse in skip_filesystems, the test can pass.
> 
> Testing Debian kernel 4.9.0-11-amd64 which is with CONFIG_NTFS_FS:
> tst_supported_fs_types.c:148: TINFO: Skipping ntfs as requested by the test
> ...
> Summary:
> passed   15
> failed   0
> broken   0
> skipped  0
> warnings 0
>
CONFIG_NTFS_FS is configured, are you sure there is no ntfs
in skip_filesystems? Why does it output "Skipping ntfs as requested by
the test"?
There should be no mount.ntfs command provided by ntfs-3g in your
system.

Testing Ubuntu kernel 5.8.0-50-generic:

ub-PC$ cat /boot/config-5.8.0-50-generic | grep -E "EXFAT_FS|NTFS_FS"
CONFIG_EXFAT_FS=m
CONFIG_NTFS_FS=m

tst_supported_fs_types.c:89: TINFO: Kernel supports ntfs
tst_supported_fs_types.c:51: TINFO: mkfs.ntfs does exist
...
tst_test.c:1379: TINFO: Testing on ntfs
tst_test.c:888: TINFO: Formatting /dev/loop10 with ntfs opts='' extra 
opts=''
tst_test.c:899: TINFO: Trying FUSE...
tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s
sync_file_range02.c:73: TFAIL: Sync equals write: Synced 0, expected 
33554432
sync_file_range02.c:73: TFAIL: Sync inside of write: Synced 0, expected 
16777216
sync_file_range02.c:73: TFAIL: Sync overlaps with write: Synced 0, 
expected 8388608
Summary:
passed   15
failed   3
broken   0
skipped  0
warnings 0



