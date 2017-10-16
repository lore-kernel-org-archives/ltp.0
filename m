From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 16 Oct 2017 09:50:08 +0200
Subject: [LTP] [lkp-robot] [x86/topology] 379a4bb988:
 dmesg.WARNING:at_arch/x86/events/intel/uncore.c:#uncore_change_type_ctx
In-Reply-To: <20171012064439.GN26196@yexl-desktop>
References: <1506430406-26121-3-git-send-email-prarit@redhat.com>
 <20171012064439.GN26196@yexl-desktop>
Message-ID: <20171016075008.n4v5z3qsxpcg6g3c@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


* kernel test robot <xiaolong.ye@intel.com> wrote:

> 
> FYI, we noticed the following commit (built with gcc-6):
> 
> commit: 379a4bb9880608931642e1b4208380468d347b84 ("x86/topology: Avoid wasting 128k for package id array")
> url: https://github.com/0day-ci/linux/commits/Prarit-Bhargava/x86-smpboot-Cleanup-logical-package-ID/20170929-202113
> 
> 
> in testcase: ltp
> with following parameters:
> 
> 	test: cpuhotplug
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> kern  :warn  : [  119.686133] ------------[ cut here ]------------
> kern  :warn  : [  119.692171] WARNING: CPU: 0 PID: 13 at arch/x86/events/intel/uncore.c:1058 uncore_change_type_ctx+0xf0/0x100

If this warning is caused by these patches then the warning should be fixed too, 
before we can apply the patches.

Thanks,

	Ingo
