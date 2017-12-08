From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 8 Dec 2017 16:09:48 +0800
Subject: [LTP] [lkp-robot] [sctp] ecca8f88da:
	ltp.test_sctp_sendrecvmsg.fail
In-Reply-To: <20171208052627.GP21779@yexl-desktop>
References: <20171208052627.GP21779@yexl-desktop>
Message-ID: <CADvbK_czg+Q4k0Wn9=PvQbCW_Ay4tfVzXHxoZ2V1kUBHVK6iOA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Dec 8, 2017 at 1:26 PM, kernel test robot <xiaolong.ye@intel.com> wrote:
>
> FYI, we noticed the following commit (built with gcc-6):
>
> commit: ecca8f88da5c4260cc2bccfefd2a24976704c366 ("sctp: set frag_point in sctp_setsockopt_maxseg correctly")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: ltp
> with following parameters:
>
>         test: net.sctp
>
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
>
>
> on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> <<<test_start>>>
> tag=test_sctp_sendrecvmsg stime=1512621556
> cmdline="test_sctp_sendrecvmsg"
> contacts=""
> analysis=exit
> <<<test_output>>>
> test_sctp_sendrecvmsg.c    1  TBROK  :  /tmp/build-ltp/ltp/utils/sctp/func_tests/../testlib/sctputil.h:258: setsockopt(13): Invalid argument
> test_sctp_sendrecvmsg.c    2  TBROK  :  /tmp/build-ltp/ltp/utils/sctp/func_tests/../testlib/sctputil.h:258: Remaining cases broken
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=2 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> <<<test_start>>>
> tag=test_sctp_sendrecvmsg_v6 stime=1512621556
> cmdline="test_sctp_sendrecvmsg_v6"
> contacts=""
> analysis=exit
> <<<test_output>>>
> test_sctp_sendrecvmsg.c    1  TBROK  :  /tmp/build-ltp/ltp/utils/sctp/func_tests/../testlib/sctputil.h:258: setsockopt(13): Invalid argument
> test_sctp_sendrecvmsg.c    2  TBROK  :  /tmp/build-ltp/ltp/utils/sctp/func_tests/../testlib/sctputil.h:258: Remaining cases broken
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=2 corefile=no
> cutime=1 cstime=0
> <<<test_end>>>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
Hi, please update the sctp case according to:

https://github.com/sctp/lksctp-tools/commit/723993d3e33100fa96245d2ed46611eb9cba5236

Thanks.
