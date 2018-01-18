From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 18 Jan 2018 04:04:36 -0500 (EST)
Subject: [LTP] fallocate04: failing on ntfs
In-Reply-To: <1020192057.1228114.1516266135166.JavaMail.zimbra@redhat.com>
References: <003201d3903a$c6a129b0$53e37d10$@toshiba.co.jp>
 <1020192057.1228114.1516266135166.JavaMail.zimbra@redhat.com>
Message-ID: <1506733331.1228496.1516266276673.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> 
> ----- Original Message -----
> > Hi,
> > 
> > I run fallocate04 from the git sources and found problems with the ntfs
> > check
> > (see below).
> > The system is using Debian jessie on a x86_64 PC.
> > If I move mkfs.ntfs out of the path then the test passes.
> > 
> > I have tried with two kernels (3.16 and 4.4 stable), with
> > CONFIG_NTFS_FS=m
> > CONFIG_NTFS_RW=y
> > 
> > Not sure if this is a bug or some misconfiguration from my side. Any help
> > would be much appreciated.
> 
> Hi, what is your LTP version? Does it have this commit?
>   https://github.com/linux-test-project/ltp/commit/28507e514c81c1d78b0125e20a63f23e69cdcf49

Sorry, just found it: 20170929-273-gfdefef3.
Can you please retry with current HEAD? Patch above should address that failure.

> 
> Regards,
> Jan
> 
> > 
> > Thanks,
> > Daniel
> > 
> > 
> > # ./runltp -f syscalls -s fallocate04
> > < skipped>
> > tst_device.c:230: INFO: Using test device LTP_DEV='/dev/loop0'
> > tst_supported_fs_types.c:72: INFO: Kernel supports ext2
> > tst_supported_fs_types.c:56: INFO: mkfs.ext2 does exist
> > tst_supported_fs_types.c:72: INFO: Kernel supports ext3
> > tst_supported_fs_types.c:56: INFO: mkfs.ext3 does exist
> > tst_supported_fs_types.c:72: INFO: Kernel supports ext4
> > tst_supported_fs_types.c:56: INFO: mkfs.ext4 does exist
> > tst_supported_fs_types.c:72: INFO: Kernel supports xfs
> > tst_supported_fs_types.c:56: INFO: mkfs.xfs does exist
> > tst_supported_fs_types.c:72: INFO: Kernel supports btrfs
> > tst_supported_fs_types.c:52: INFO: mkfs.btrfs does not exist
> > tst_supported_fs_types.c:72: INFO: Kernel supports vfat
> > tst_supported_fs_types.c:56: INFO: mkfs.vfat does exist
> > tst_supported_fs_types.c:95: INFO: Filesystem exfat is not supported
> > tst_supported_fs_types.c:72: INFO: Kernel supports ntfs
> > tst_supported_fs_types.c:56: INFO: mkfs.ntfs does exist
> > tst_mkfs.c:83: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> > mke2fs 1.42.12 (29-Aug-2014)
> > tst_test.c:977: INFO: Timeout per run is 0h 05m 00s
> > fallocate04.c:96: INFO: allocate '3072' bytes
> > fallocate04.c:100: CONF: fallocate() not supported
> > tst_mkfs.c:83: INFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> > mke2fs 1.42.12 (29-Aug-2014)
> > tst_test.c:977: INFO: Timeout per run is 0h 05m 00s
> > fallocate04.c:96: INFO: allocate '3072' bytes
> > fallocate04.c:100: CONF: fallocate() not supported
> > tst_mkfs.c:83: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> > mke2fs 1.42.12 (29-Aug-2014)
> > tst_test.c:977: INFO: Timeout per run is 0h 05m 00s
> > fallocate04.c:96: INFO: allocate '3072' bytes
> > fallocate04.c:110: PASS: test-case succeeded
> > fallocate04.c:117: INFO: read allocated file size '3072'
> > fallocate04.c:118: INFO: make a hole with FALLOC_FL_PUNCH_HOLE
> > fallocate04.c:134: INFO: check that file has a hole with lseek(,,SEEK_HOLE)
> > fallocate04.c:151: INFO: found a hole at '1024' offset
> > fallocate04.c:157: INFO: allocated file size before '3072' and after '2048'
> > fallocate04.c:80: INFO: reading the file, compare with expected buffer
> > fallocate04.c:168: PASS: test-case succeeded
> > fallocate04.c:173: INFO: zeroing file space with FALLOC_FL_ZERO_RANGE
> > fallocate04.c:182: INFO: read current allocated file size '2048'
> > fallocate04.c:199: INFO: allocated file size before '2048' and after '3072'
> > fallocate04.c:80: INFO: reading the file, compare with expected buffer
> > fallocate04.c:210: PASS: test-case succeeded
> > fallocate04.c:215: INFO: collapsing file space with
> > FALLOC_FL_COLLAPSE_RANGE
> > fallocate04.c:219: INFO: read current allocated file size '3072'
> > fallocate04.c:233: INFO: allocated file size before '3072' and after '2048'
> > fallocate04.c:80: INFO: reading the file, compare with expected buffer
> > fallocate04.c:250: PASS: test-case succeeded
> > fallocate04.c:255: INFO: inserting space with FALLOC_FL_INSERT_RANGE
> > fallocate04.c:259: INFO: read current allocated file size '2048'
> > fallocate04.c:277: INFO: allocated file size before '2048' and after '3072'
> > fallocate04.c:80: INFO: reading the file, compare with expected buffer
> > fallocate04.c:288: PASS: test-case succeeded
> > tst_mkfs.c:83: INFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> > tst_test.c:977: INFO: Timeout per run is 0h 05m 00s
> > fallocate04.c:96: INFO: allocate '12288' bytes
> > fallocate04.c:110: PASS: test-case succeeded
> > fallocate04.c:117: INFO: read allocated file size '12288'
> > fallocate04.c:118: INFO: make a hole with FALLOC_FL_PUNCH_HOLE
> > fallocate04.c:134: INFO: check that file has a hole with lseek(,,SEEK_HOLE)
> > fallocate04.c:151: INFO: found a hole at '4096' offset
> > fallocate04.c:157: INFO: allocated file size before '12288' and after
> > '8192'
> > fallocate04.c:80: INFO: reading the file, compare with expected buffer
> > fallocate04.c:168: PASS: test-case succeeded
> > fallocate04.c:173: INFO: zeroing file space with FALLOC_FL_ZERO_RANGE
> > fallocate04.c:182: INFO: read current allocated file size '8192'
> > fallocate04.c:199: INFO: allocated file size before '8192' and after
> > '12288'
> > fallocate04.c:80: INFO: reading the file, compare with expected buffer
> > fallocate04.c:210: PASS: test-case succeeded
> > fallocate04.c:215: INFO: collapsing file space with
> > FALLOC_FL_COLLAPSE_RANGE
> > fallocate04.c:219: INFO: read current allocated file size '12288'
> > fallocate04.c:233: INFO: allocated file size before '12288' and after
> > '8192'
> > fallocate04.c:80: INFO: reading the file, compare with expected buffer
> > fallocate04.c:250: PASS: test-case succeeded
> > fallocate04.c:255: INFO: inserting space with FALLOC_FL_INSERT_RANGE
> > fallocate04.c:259: INFO: read current allocated file size '8192'
> > fallocate04.c:277: INFO: allocated file size before '8192' and after
> > '12288'
> > fallocate04.c:80: INFO: reading the file, compare with expected buffer
> > fallocate04.c:288: PASS: test-case succeeded
> > tst_mkfs.c:83: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> > tst_test.c:977: INFO: Timeout per run is 0h 05m 00s
> > fallocate04.c:96: INFO: allocate '12288' bytes
> > fallocate04.c:100: CONF: fallocate() not supported
> > tst_mkfs.c:83: INFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
> > The partition start sector was not specified for /dev/loop0 and it could
> > not
> > be obtained automatically.  It has been set to 0.
> > The number of sectors per track was not specified for /dev/loop0 and it
> > could
> > not be obtained automatically.  It has been set to 0.
> > The number of heads was not specified for /dev/loop0 and it could not be
> > obtained automatically.  It has been set to 0.
> > To boot from a device, Windows needs the 'partition start sector', the
> > 'sectors per track' and the 'number of heads' to be set.
> > Windows will not be able to boot from this device.
> > tst_test.c:977: INFO: Timeout per run is 0h 05m 00s
> > safe_macros.c:225: BROK: fallocate04.c:302:
> > open(fallocate/fallocate.txt,66,0700) failed: EROFS
> > 
> > Summary:
> > passed   10
> > failed   0
> > skipped  3
> > warnings 0
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=9 termination_type=exited termination_id=2 corefile=no
> > cutime=2 cstime=91
> > <<<test_end>>>
> > INFO: ltp-pan reported some tests FAIL
> > LTP Version: 20170929-273-gfdefef3
> > 
> >        ###############################################################
> > 
> >             Done executing testcases.
> >             LTP Version:  20170929-273-gfdefef3
> >        ###############################################################
> > 
> > 
> > 
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> > 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
