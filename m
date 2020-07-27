From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 27 Jul 2020 23:14:16 +0800
Subject: [LTP] [blk] 6e6fcbc27e: ltp.fs_fill.fail
In-Reply-To: <20200727093156.GA29739@dell5510>
References: <20200726075511.GI1850@shao2-debian>
 <20200727093156.GA29739@dell5510>
Message-ID: <20200727151416.GA1298062@T590>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 27, 2020 at 11:31:56AM +0200, Petr Vorel wrote:
> Hi,
> 
> > FYI, we noticed the following commit (built with gcc-9):
> 
> > commit: 6e6fcbc27e7788af54139c53537395d95560f2ef ("blk-mq: support batching dispatch in case of io")
> > https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-5.9/drivers
> 
> 
> > in testcase: ltp
> > with following parameters:
> 
> > 	disk: 1HDD
> > 	fs: ext4
> > 	test: fs-03
> 
> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> > test-url: http://linux-test-project.github.io/
> 
> 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> ...
> > tst_test.c:1308: INFO: Testing on vfat
> > tst_mkfs.c:90: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> > tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> > fs_fill.c:103: INFO: Running 10 writer threads
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> The only "error" I found is that fs_fill test timeouted on vfat. That might
> indicate some problems. Note, for slow machines, there is LTP_TIMEOUT_MUL
> https://github.com/linux-test-project/ltp/wiki/User-Guidelines#1-library-environment-variables

I have run fs_fill test for a while, and can't reproduce it, and I am
sure vfat is covered.



Thanks,
Ming

