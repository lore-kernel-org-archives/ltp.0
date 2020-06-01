From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 1 Jun 2020 19:25:30 +0530
Subject: [LTP] i386: fanotify01.c:115: BROK: fanotify_mark () failed: EFAULT
 (14)
Message-ID: <CA+G9fYvU3g1HqOT8UbNBzXCjCD7Ot1pAFjv-8PGee9ObdbYksg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have recently enabled CONFIG_FANOTIFY=y in our testing builds and
i386 kernel running on x86_64 machine testing LTP 20200515 test runs reported
fanotify{01,02,04..15} failures on linux mainline 5.7.0-rc6
Where as these tests pass on x86_64, arm and arm64.

Is this a known issue on i386 ?
As you know, these tests cases were skipped before enabling CONFIG_FANOTIFY.

The file system mounted on NFS and the LTP tests using a external mounted
SSD drive. LTP tests running as

Steps to reproduce:
-------------------
./runltp -d /scratch -f syscalls

and easily reproducible on qemu_i386 also which is mounting local rootfs.img

configs:
-----------
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set --> not set of x86_64 and i386.


Test output log:
-----------------
tst_device.c:262: INFO: Using test device LTP_DEV='/dev/loop0'
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.43.8 (1-Jan-2018)
[  391.914376] EXT4-fs (loop0): mounting ext2 file system using the
ext4 subsystem
[  391.962316] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
[  391.969684] ext2 filesystem being mounted at
/scratch/ltp-86JZJboUf9/Sl4t1D/fs_mnt supports timestamps until 2038
(0x7fffffff)
tst_test.c:1246: INFO: Timeout per run is 0h 15m 00s
fanotify01.c:89: INFO: Test #0: inode mark events
fanotify01.c:115: BROK: fanotify_mark (6, FAN_MARK_ADD, FAN_ACCESS |
FAN_MARK_INODE | FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD,
fs_mnt/tfile_19115) failed: EFAULT (14)

fanotify02.c:57: BROK: fanotify_mark (6, FAN_MARK_ADD, FAN_ACCESS |
FAN_MODIFY | FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD | FAN_ONDIR,
AT_FDCWD, '.') failed: EFAULT (14)

fanotify03.c:236: CONF: CONFIG_FANOTIFY_ACCESS_PERMISSIONS not
configured in kernel?: EINVAL (22)

fanotify04.c:66: FAIL: fanotify_mark (6, FAN_MARK_ADD |
FAN_MARK_ONLYDIR, FAN_OPEN, AT_FDCWD, '.') failed
fanotify04.c:71: PASS: fanotify_mark (6, FAN_MARK_ADD |
FAN_MARK_ONLYDIR, FAN_OPEN, AT_FDCWD, 'fname_19127') failed
fanotify04.c:66: FAIL: fanotify_mark (6, FAN_MARK_ADD |
FAN_MARK_DONT_FOLLOW, FAN_OPEN, AT_FDCWD, 'symlink_19127') failed
fanotify04.c:66: FAIL: fanotify_mark (6, FAN_MARK_ADD | 0, FAN_OPEN,
AT_FDCWD, 'symlink_19127') failed
fanotify04.c:198: BROK: fanotify_mark (6, FAN_MARK_ADD, FAN_OPEN,
AT_FDCWD, 'fname_19127') failed: EFAULT (14)

fanotify05.c:115: BROK: fanotify_mark (6, FAN_MARK_MOUNT |
FAN_MARK_ADD, FAN_OPEN, AT_FDCWD, \".\") failed: EFAULT (14)

fanotify06.c:98: BROK: fanotify_mark(6, FAN_MARK_ADD | FAN_MARK_MOUNT,
FAN_MODIFY, AT_FDCWD, mntpoint/tfile_19139) failed: EFAULT (14)

fanotify07.c:112: CONF: CONFIG_FANOTIFY_ACCESS_PERMISSIONS not
configured in kernel?: EINVAL (22)

fanotify09.c:108: BROK: fanotify_mark(6, FAN_MARK_ADD |
FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD, '.') failed: EFAULT (14)

fanotify10.c:239: BROK: fanotify_mark(6, FAN_MARK_ADD |
FAN_MARK_MOUNT,FAN_OPEN, AT_FDCWD, fs_mnt) failed: EFAULT (14)

fanotify11.c:82: BROK: fanotify_mark FAN_MARK_ADD fail ret=-1

fanotify12.c:160: BROK: fanotify_mark(6, FAN_MARK_ADD |
FAN_MARK_INODE, 20, AT_FDCWD, fname_19160) failed: EFAULT (14)

fanotify13.c:300: BROK: fanotify_mark(6, FAN_MARK_ADD,
FAN_CLOSE_WRITE, AT_FDCWD, mntpoint/file_one) failed: EFAULT (14)

fanotify15.c:101: BROK: fanotify_mark(6, FAN_MARK_ADD |
FAN_MARK_FILESYSTEM, FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_MODIFY |
FAN_ONDIR | 0x400, AT_FDCWD, mntpoint/test_dir) failed: EFAULT (14)

full test log link,
i386 kernel running on x86_64 machine
https://lkft.validation.linaro.org/scheduler/job/1446082#L8947
https://lkft.validation.linaro.org/scheduler/job/1457258#L8946

qemu_i386 test log link,
https://lkft.validation.linaro.org/scheduler/job/1446103
https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-rc6-100-g444565650a5f/testrun/1446103/

Test results comparison:
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tests/fanotify01
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tests/fanotify15

-- 
Linaro LKFT
https://lkft.linaro.org
