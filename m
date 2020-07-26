From: Ming Lei <ming.lei@redhat.com>
Date: Sun, 26 Jul 2020 16:42:09 +0800
Subject: [LTP] [blk] 6e6fcbc27e: ltp.fs_fill.fail
In-Reply-To: <20200726075511.GI1850@shao2-debian>
References: <20200726075511.GI1850@shao2-debian>
Message-ID: <20200726084209.GA1110104@T590>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, Jul 26, 2020 at 03:55:11PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 6e6fcbc27e7788af54139c53537395d95560f2ef ("blk-mq: support batching dispatch in case of io")
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-5.9/drivers
> 
> 
> in testcase: ltp
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: ext4
> 	test: fs-03
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> 
> <<<test_start>>>
> tag=fs_fill stime=1595659069
> cmdline="fs_fill"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_device.c:89: INFO: Found free device 0 '/dev/loop0'
> tst_supported_fs_types.c:60: INFO: Kernel supports ext2
> tst_supported_fs_types.c:44: INFO: mkfs.ext2 does exist
> tst_supported_fs_types.c:60: INFO: Kernel supports ext3
> tst_supported_fs_types.c:44: INFO: mkfs.ext3 does exist
> tst_supported_fs_types.c:60: INFO: Kernel supports ext4
> tst_supported_fs_types.c:44: INFO: mkfs.ext4 does exist
> tst_supported_fs_types.c:60: INFO: Kernel supports xfs
> tst_supported_fs_types.c:44: INFO: mkfs.xfs does exist
> tst_supported_fs_types.c:60: INFO: Kernel supports btrfs
> tst_supported_fs_types.c:44: INFO: mkfs.btrfs does exist
> tst_supported_fs_types.c:60: INFO: Kernel supports vfat
> tst_supported_fs_types.c:44: INFO: mkfs.vfat does exist
> tst_supported_fs_types.c:83: INFO: Filesystem exfat is not supported
> tst_supported_fs_types.c:92: INFO: FUSE does support ntfs
> tst_supported_fs_types.c:44: INFO: mkfs.ntfs does exist
> tst_test.c:1308: INFO: Testing on ext2
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.44.5 (15-Dec-2018)
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> fs_fill.c:103: INFO: Running 10 writer threads
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread7/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file0
> fs_fill.c:87: PASS: Got 10 ENOSPC runtime 1194ms
> tst_test.c:1308: INFO: Testing on ext3
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> mke2fs 1.44.5 (15-Dec-2018)
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> fs_fill.c:103: INFO: Running 10 writer threads
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread7/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread7/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file4
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file4
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file4
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file4
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file4
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file14
> fs_fill.c:87: PASS: Got 17 ENOSPC runtime 1000ms
> tst_test.c:1308: INFO: Testing on ext4
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> mke2fs 1.44.5 (15-Dec-2018)
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> fs_fill.c:103: INFO: Running 10 writer threads
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file1
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file1
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file4
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread7/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file4
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread7/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file3
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file4
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread7/file4
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file6
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file6
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file4
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file1
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file6
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread7/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file1
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file6
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file4
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file3
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file3
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread7/file3
> fs_fill.c:87: PASS: Got 73 ENOSPC runtime 1000ms
> tst_test.c:1308: INFO: Testing on xfs
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> fs_fill.c:103: INFO: Running 10 writer threads
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file0
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file0
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file0
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread7/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file2
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread7/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file1
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file1
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file0
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file1
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file2
> fs_fill.c:87: PASS: Got 111 ENOSPC runtime 566ms
> tst_test.c:1308: INFO: Testing on btrfs
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> fs_fill.c:103: INFO: Running 10 writer threads
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread7/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread10/file0
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread3/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread9/file0
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file0
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread8/file0
> fs_fill.c:87: PASS: Got 10 ENOSPC runtime 9454ms
> tst_test.c:1308: INFO: Testing on vfat
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> fs_fill.c:103: INFO: Running 10 writer threads
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Test timeouted, sending SIGKILL!
> Cannot kill test processes!
> Congratulation, likely test hit a kernel bug.
> Exitting uncleanly...
> <<<execution_status>>>
> initiation_status="ok"
> duration=385 termination_type=exited termination_id=1 corefile=no
> cutime=53 cstime=1400
> <<<test_end>>>
> 
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.8.0-rc2-00057-g6e6fcbc27e7788 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

Can you share what the exact ltp test fails?

Also I don't see any failure log in dmesg.xz.

Thanks,
Ming

