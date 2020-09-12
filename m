From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Sat, 12 Sep 2020 09:32:36 +0000
Subject: [LTP] Error with fs_fill
Message-ID: <BMXPR01MB23445019F67B128E04B26612EE250@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i am running fs_fill but the test getting failed with following error ,the strange thing is sometime its getting passed and sometime is getting failed

Gnu C                  gcc (GCC) 8.3.0
Clang
Gnu make               4.2.1
util-linux             2.34
mount                  linux 2.34 (libmount 2.34.0: btrfs, namespaces, assert, debug)
modutils               26
e2fsprogs              1.45.4
Linux C Library        > libc.2.30
Dynamic linker (ldd)   2.30
Linux C++ Library      6.0.25
Procps                 3.3.15
iproute2               iproute2-ss190924
iputils                'V'
ethtool                5.3
Kbd                    2.2.0
Sh-utils               8.31
Modules Loaded         btrfs blake2b_generic libcrc32c xor zstd_decompress zstd_compress xxhash lzo_compress zlib_deflate raid6_pq fuse ofpart cmdlinepart spi_nor

free reports:
              total        used        free      shared  buff/cache   available
Mem:        8167360       59740     8021268        9764       86352     8018456
Swap:             0           0           0

cpuinfo:
Architecture:        riscv64
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  4
Core(s) per socket:  1
Socket(s):           1
L1d cache:           32 KiB
L1i cache:           32 KiB
L2 cache:            2 MiB

AppArmor disabled

SELinux mode: unknown
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /opt/ltp/bin/ltp-pan   -e -S   -a 506     -n 506 -p -f /tmp/ltp-VepGwU5U7h/alltests -l /opt/ltp/results/LTP_RUN_ON-2020_09_12-09h_22m_43s.log  -C /opt/ltp/output/LTP_RUN_ON-2020_09_12-09h_22m_43s.failed -T /opt/ltp/output/LTP_RUN_ON-2020_09_12-09h_22m_43s.tconf
INFO: Restricted to fs_fill
LOG File: /opt/ltp/results/LTP_RUN_ON-2020_09_12-09h_22m_43s.log
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2020_09_12-09h_22m_43s.failed
TCONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-2020_09_12-09h_22m_43s.tconf
Running tests.......
<<<test_start>>>
tag=fs_fill stime=1599902564
cmdline="fs_fill"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
tst_device.c:89: INFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:60: INFO: Kernel supports ext2
tst_supported_fs_types.c:44: INFO: mkfs.ext2 does exist
tst_supported_fs_types.c:60: INFO: Kernel supports ext3
tst_supported_fs_types.c:44: INFO: mkfs.ext3 does exist
tst_supported_fs_types.c:60: INFO: Kernel supports ext4
tst_supported_fs_types.c:44: INFO: mkfs.ext4 does exist
tst_supported_fs_types.c:83: INFO: Filesystem xfs is not supported
tst_supported_fs_types.c:60: INFO: Kernel supports btrfs
tst_supported_fs_types.c:44: INFO: mkfs.btrfs does exist
tst_supported_fs_types.c:60: INFO: Kernel supports vfat
tst_supported_fs_types.c:40: INFO: mkfs.vfat does not exist
tst_supported_fs_types.c:83: INFO: Filesystem exfat is not supported
tst_supported_fs_types.c:83: INFO: Filesystem ntfs is not supported
tst_test.c:1316: INFO: Testing on ext2
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.45.4 (23-Sep-2019)
tst_test.c:1250: INFO: Timeout per run is 0h 05m 00s
fs_fill.c:103: INFO: Running 6 writer threads
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file1
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file1
fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file1
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file1
fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file1
fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file1
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file1
fs_fill.c:87: PASS: Got 7 ENOSPC runtime 2545ms
tst_test.c:1316: INFO: Testing on ext3
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.45.4 (23-Sep-2019)
tst_test.c:1250: INFO: Timeout per run is 0h 05m 00s
fs_fill.c:103: INFO: Running 6 writer threads
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file0
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file0
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file0
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file0
fs_fill.c:87: PASS: Got 6 ENOSPC runtime 3280ms
tst_test.c:1316: INFO: Testing on ext4
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.45.4 (23-Sep-2019)
tst_test.c:1250: INFO: Timeout per run is 0h 05m 00s
fs_fill.c:103: INFO: Running 6 writer threads
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file1
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file1
fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file1
fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file1
fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file0
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file1
fs_fill.c:87: PASS: Got 6 ENOSPC runtime 1969ms
tst_test.c:1316: INFO: Testing on btrfs
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
tst_test.c:1250: INFO: Timeout per run is 0h 05m 00s
fs_fill.c:103: INFO: Running 6 writer threads
     tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file0
fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file0
fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file0
safe_macros.c:366: BROK: fs_fill.c:55: unlink(mntpoint/thread4/file0) failed: ENOSPC (28)

Summary:
passed   3
failed   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=136 termination_type=exited termination_id=2 corefile=no
cutime=23 cstime=3275
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20200515-267-g9677c5573

       ###############################################################

            Done executing testcases.
            LTP Version:  20200515-267-g9677c5573
       ###############################################################

Can someone help me out why this  may haappen,what may be the possible reason of failure ?

Thanks!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200912/d782fb40/attachment.htm>
