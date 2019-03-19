From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Mar 2019 20:11:24 +0800
Subject: [LTP] [PATCH RFC] lib: invoke do_cleanup if failed to kill test
	processes
In-Reply-To: <20190318122851.GC10187@rei>
References: <20190315061733.24938-1-liwang@redhat.com>
 <20190318122851.GC10187@rei>
Message-ID: <CAEemH2e0+U1AMZcFAy2G42M07Mx=y5WzyjpJpxvNZNsZNGN2-Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 18, 2019 at 8:29 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > LTP liabary should invoke do_cleanup function promptly when killing
> > test process doesn't work, especially useful to testcase do mount or
> > format devices in their setup phase. Otherwise, that abnormal broken
> > will effect the testcase which LTP is preparing to execute in next.
>
> Actually this code should be executed only if the test process got stuck
> in the kernel and in such case I doubt that there is a value in doing
> the cleanup as the cleanup code will likely get stuck there as well.
>
> The rationale is that if process that uses particular mount point is
> stuck in the kernel the umount() will likely get stuck there as well and
> there is no point in doing anything else than rebooting the machine.
>

I think your analysis is reasonable. But I hit a strange situation in the
LTP automation task. Things like that readahead02 failed to kill its
children processes and exit abnormally, system maybe get stuck there a bit
time and then recover, so that readahead02 abort without invoke do_cleanup
leads to the remaining tests cann't mount/format correctly, so we get a lot
of same failures in next. More test logs in below, if anything I was wrong
please correct me. Thanks!

----SYSTEM DMESG LOG-----
[ 1740.404393] LTP: starting readahead02
[ 1742.927684] EXT4-fs (loop0): mounting ext2 file system using the ext4
subsystem
[ 1743.350353] EXT4-fs (loop0): mounted filesystem without journal. Opts:
(null)
[ 1746.433393] readahead02 (27927): drop_caches: 1
[ 1771.274691] restraintd[4152]: *** Current Time: Thu Mar 14 14:41:50 2019
Localwatchdog at: Thu Mar 14 19:15:49 2019
[ 1790.819807] readahead02 (27927): drop_caches: 1
[ 1830.514187] restraintd[4152]: *** Current Time: Thu Mar 14 14:42:49 2019
Localwatchdog at: Thu Mar 14 19:15:49 2019
[ 1849.500644] readahead02 (27927): drop_caches: 1
[ 1865.206921] readahead02 (27927): drop_caches: 1
[ 1891.885486] restraintd[4152]: *** Current Time: Thu Mar 14 14:43:50 2019
Localwatchdog at: Thu Mar 14 19:15:49 2019
[ 1898.643303] readahead02 (27927): drop_caches: 1
[ 1952.598108] restraintd[4152]: *** Current Time: Thu Mar 14 14:44:51 2019
Localwatchdog at: Thu Mar 14 19:15:49 2019
[-- MARK -- Thu Mar 14 18:45:00 2019]
[ 1996.672750] readahead02 (27927): drop_caches: 1
[ 2011.717543] restraintd[4152]: *** Current Time: Thu Mar 14 14:45:50 2019
Localwatchdog at: Thu Mar 14 19:15:49 2019
[ 2073.364241] restraintd[4152]: *** Current Time: Thu Mar 14 14:46:52 2019
Localwatchdog at: Thu Mar 14 19:15:49 2019
[ 2093.992180] LTP: starting readdir01
[ 2096.539432] LTP: starting readdir02
[ 2096.868280] LTP: starting readdir21
[ 2096.995509] LTP: starting readlink01A (symlink01 -T readlink01)
---------------------------


------LTP TEST LOG----------
<<<test_output>>>
tst_device.c:230: INFO: Using test device LTP_DEV='/dev/loop0'
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.44.3 (10-July-2018)
tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
readahead02.c:414: INFO: readahead length: 2097152
<...snip...>
readahead02.c:191: PASS: offset is still at 0 as expected
readahead02.c:295: INFO: read_testfile(0) took: 97472667 usec
readahead02.c:296: INFO: read_testfile(1) took: 40059201 usec
readahead02.c:298: INFO: read_testfile(0) read: 67108864 bytes
readahead02.c:300: INFO: read_testfile(1) read: 0 bytes
readahead02.c:303: PASS: readahead saved some I/O
readahead02.c:311: INFO: cache can hold at least: 3173632 kB
readahead02.c:312: INFO: read_testfile(0) used cache: 132352 kB
readahead02.c:313: INFO: read_testfile(1) used cache: 65280 kB
readahead02.c:321: PASS: using cache as expected
readahead02.c:231: INFO: Test #3: POSIX_FADV_WILLNEED on overlayfs file
readahead02.c:136: INFO: creating test file of size: 67108864
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Test timeouted, sending SIGKILL!
Cannot kill test processes!
Congratulation, likely test hit a kernel bug.
Exitting uncleanly...

<...snip...>

mke2fs 1.44.3 (10-July-2018)
/dev/loop0 is mounted; will not make a filesystem here!
renameat01    0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
renameat01    0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra
opts=''
renameat01    1  TBROK  :  tst_mkfs.c:101: mkfs.ext2:1: renameat01.c failed
with 185
renameat01 2 TBROK : tst_mkfs.c:101: Remaining cases broken

<...snip...>

<<<test_output>>>
tst_device.c:230: INFO: Using test device LTP_DEV='/dev/loop0'
tst_supported_fs_types.c:72: INFO: Kernel supports ext2
tst_supported_fs_types.c:56: INFO: mkfs.ext2 does exist
tst_supported_fs_types.c:72: INFO: Kernel supports ext3
tst_supported_fs_types.c:56: INFO: mkfs.ext3 does exist
tst_supported_fs_types.c:72: INFO: Kernel supports ext4
tst_supported_fs_types.c:56: INFO: mkfs.ext4 does exist
tst_supported_fs_types.c:72: INFO: Kernel supports xfs
tst_supported_fs_types.c:56: INFO: mkfs.xfs does exist
tst_supported_fs_types.c:95: INFO: Filesystem btrfs is not supported
tst_supported_fs_types.c:72: INFO: Kernel supports vfat
tst_supported_fs_types.c:52: INFO: mkfs.vfat does not exist
tst_supported_fs_types.c:95: INFO: Filesystem exfat is not supported
tst_supported_fs_types.c:95: INFO: Filesystem ntfs is not supported
tst_test.c:1146: INFO: Testing on ext2
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.44.3 (10-July-2018)
/dev/loop0 is mounted; will not make a filesystem here!
tst_mkfs.c:101: BROK: mkfs.ext2:1: tst_test.c failed with 749
<...snip...>

tag=umount01 stime=1552589616
cmdline="umount01"
contacts=""
analysis=exit
<<<test_output>>>
tst_device.c:230: INFO: Using test device LTP_DEV='/dev/loop0'
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.44.3 (10-July-2018)
/dev/loop0 is mounted; will not make a filesystem here!
tst_mkfs.c:101: BROK: mkfs.ext2:1: tst_test.c failed with 749
----------------------------------------

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190319/0987ba6b/attachment-0001.html>
