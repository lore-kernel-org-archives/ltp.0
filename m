From: Mel Gorman <mgorman@techsingularity.net>
Date: Wed, 3 Apr 2019 08:09:29 +0100
Subject: [LTP] [mm, compaction] e332f741a8: BUG:unable_to_handle_kernel
In-Reply-To: <20190403064200.GI20952@shao2-debian>
References: <20190403064200.GI20952@shao2-debian>
Message-ID: <20190403070929.GR3189@techsingularity.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 03, 2019 at 02:42:00PM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: e332f741a8dd1ec9a6dc8aa997296ecbfe64323e ("mm, compaction: be selective about what pageblocks to clear skip hints")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: ltp
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: xfs
> 	test: syscalls_part4
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 

There are fixes queued in Andrew's tree that should cover this.

-- 
Mel Gorman
SUSE Labs
