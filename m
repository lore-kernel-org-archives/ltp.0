From: Ian Kent <raven@themaw.net>
Date: Tue, 12 Nov 2019 16:39:50 +0800
Subject: [LTP] [xfs] 73e5fff98b: kmsg.dev/zero:Can't_open_blockdev
In-Reply-To: <20191111010022.GH29418@shao2-debian>
References: <20191111010022.GH29418@shao2-debian>
Message-ID: <3fb8b1b04dd7808b45caf5262ee629c09c71e0b6.camel@themaw.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2019-11-11 at 09:00 +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 73e5fff98b6446de1490a8d7809121b0108d49f4 ("xfs: switch to use
> the new mount-api")
> https://git.kernel.org/cgit/fs/xfs/xfs-linux.git xfs-5.5-merge
> 
> in testcase: ltp
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: xfs
> 	test: fs-03
> 
> test-description: The LTP testsuite contains a collection of tools
> for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp
> 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> [  135.976643] LTP: starting fs_fill
> [  135.993912] /dev/zero: Can't open blockdev

I've looked at the github source but I don't see how to find out what
command was used when this error occurred so I don't know even how to
start to work out what might have caused this.

Can you help me to find the test script source please.

> [  136.020327] raid6: sse2x4   gen() 14769 MB/s
> [  136.037281] raid6: sse2x4   xor()  8927 MB/s
> [  136.054236] raid6: sse2x2   gen() 12445 MB/s
> [  136.071397] raid6: sse2x2   xor()  7441 MB/s
> [  136.089313] raid6: sse2x1   gen() 10089 MB/s
> [  136.107334] raid6: sse2x1   xor()  7201 MB/s
> [  136.108198] raid6: using algorithm sse2x4 gen() 14769 MB/s
> [  136.109320] raid6: .... xor() 8927 MB/s, rmw enabled
> [  136.111966] raid6: using ssse3x2 recovery algorithm
> [  136.122740] xor: automatically using best checksumming
> function   avx       
> [  136.187956] Btrfs loaded, crc32c=crc32c-intel
> [  136.216946] fuse: init (API version 7.31)
> [  136.327654] EXT4-fs (loop0): mounting ext2 file system using the
> ext4 subsystem
> [  136.334974] EXT4-fs (loop0): mounted filesystem without journal.
> Opts: (null)
> [  136.338933] Mounted ext2 file system at /tmp/ltp-
> bl4kncm4Ti/g2oJfj/mntpoint supports timestamps until 2038
> (0x7fffffff)
> [  137.897422] EXT4-fs (loop0): mounting ext3 file system using the
> ext4 subsystem
> [  137.908242] EXT4-fs (loop0): mounted filesystem with ordered data
> mode. Opts: (null)
> [  137.910111] Mounted ext3 file system at /tmp/ltp-
> bl4kncm4Ti/g2oJfj/mntpoint supports timestamps until 2038
> (0x7fffffff)
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.4.0-rc3-00117-g73e5fff98b644 .config
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare
> modules_prepare bzImage modules
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 INSTALL_MOD_PATH=<mod-
> install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-
> script is attached in this email
> 
> 
> 
> Thanks,
> Rong Chen
> 

